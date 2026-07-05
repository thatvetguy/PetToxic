#!/usr/bin/env python3
"""
PetToxic content validator.

Validates Content/toxins.json and Content/diseases.json against the finalized
schema (ClaudeCode_Session164_AndroidJSONSchema.md) and the content rules in
PetToxic_Database_Audit_Rules.md and CLAUDE.md.

ERRORS (exit 1) are structural/format problems that will break or misrender
the apps: schema violations, bad UUIDs, invalid enum values, markdown list
syntax in text fields, dangling cross-references, duplicates.

WARNINGS (exit 0 unless --strict) are editorial/policy flags that need
veterinary judgment: dosage/LD50 language, prognosis statements, missing
italicized scientific names, cross-reference case mismatches.

Note on nullable fields: the schema marks every field "required", but the
extraction script omits keys whose value is null (e.g. entrySeverity on
informational entries). Absent keys are therefore accepted as null for
nullable fields, matching what both apps consume.

Usage:
  python3 Scripts/validate_content.py               # validate Content/
  python3 Scripts/validate_content.py --strict      # warnings also fail
  python3 Scripts/validate_content.py --self-test   # run built-in test suite
"""

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

UUID_RE = re.compile(r"^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$")
UUID_ANYCASE_RE = re.compile(
    r"^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"
)
ITALIC_GENUS_RE = re.compile(r"\*[A-Z][a-z]+")
# Bullet line following a SINGLE \n: AttributedString(markdown:) swallows the
# newline and items run together. Bullets after \n\n render as separate
# paragraphs and are accepted style (several audited entries use them).
MD_LIST_RE = re.compile(r"(^|(?<!\n)\n)[ \t]*(- |\* |• )")

SEVERITIES = {"low", "lowModerate", "moderate", "high", "severe"}
CATEGORIES = {
    "foods", "plants", "medications", "cleaningProducts", "garageGarden",
    "recreationalSubstances", "holidayHazards", "householdItems",
    "outdoorHazards", "informational",
}
# Species profile: pet edition. Add an equine profile here once the equine
# repos get their JSON extraction (their speciesRisks use a different set).
SPECIES = {"dog", "cat", "smallMammal", "bird", "reptile"}
ENTRY_TYPES = {"infectious", "husbandry", "medical"}

TOXIN_KEYS = {
    "id", "name", "alternateNames", "categories", "imageAsset", "description",
    "toxicityInfo", "onsetTime", "symptoms", "entrySeverity", "speciesRisks",
    "preventionTips", "sources", "relatedEntries",
}
DISEASE_KEYS = (TOXIN_KEYS - {"categories", "entrySeverity"}) | {"entryType"}
SPECIES_RISK_KEYS = {"species", "severity", "notes"}
ONSET_KEYS = {"early", "delayed"}

# Editorial policy patterns (PetToxic_Database_Audit_Rules.md, "Content to REMOVE").
# All are warnings — flagged for veterinary review, never auto-blocked. Per Cris
# (July 2026): the app informs and educates, never advises — dosing/prognosis
# language is restricted primarily so the app cannot be seen as giving medical
# advice, and secondarily so no owner reads it as "my pet is safe" and skips care.
# The ONLY advice the app ever gives: practical, commonly accepted first aid,
# and "seek veterinary care / contact poison control".
POLICY_PATTERNS = [
    (re.compile(r"\b(?:mg|mcg|µg|ug|g)\s*(?:/|per)\s*kg\b", re.I), "dosage threshold (per-kg dose)"),
    (re.compile(r"\bLD-?50\b", re.I), "LD50 data"),
    (re.compile(r"safe (?:amount|dose|level|quantity)", re.I), '"safe amount/dose" language'),
    (re.compile(r"(generally|very) well tolerated", re.I), '"well tolerated" language'),
    (re.compile(r"prognosis is", re.I), "prognosis statement"),
]


class Report:
    def __init__(self):
        self.errors = []
        self.warnings = []

    def error(self, where, msg):
        self.errors.append(f"{where}: {msg}")

    def warn(self, where, msg):
        self.warnings.append(f"{where}: {msg}")


def is_str(v):
    return isinstance(v, str) and v.strip() != ""


def check_str_list(entry, field, where, report, allow_null=False, allow_empty_items=False):
    v = entry.get(field)
    if v is None:
        if not allow_null:
            report.error(where, f"missing required field '{field}'")
        return
    ok_item = (lambda x: isinstance(x, str)) if allow_empty_items else is_str
    if not isinstance(v, list) or any(not ok_item(x) for x in v):
        report.error(where, f"'{field}' must be a list of "
                            f"{'strings' if allow_empty_items else 'non-empty strings'}")


def text_fields(entry):
    """Yield (field_name, text) for every free-text field of an entry."""
    for f in ("description", "toxicityInfo"):
        if is_str(entry.get(f)):
            yield f, entry[f]
    ot = entry.get("onsetTime") or {}
    if isinstance(ot, dict):
        for k in ONSET_KEYS:
            if is_str(ot.get(k)):
                yield f"onsetTime.{k}", ot[k]
    for i, sr in enumerate(entry.get("speciesRisks") or []):
        if isinstance(sr, dict) and is_str(sr.get("notes")):
            yield f"speciesRisks[{i}].notes", sr["notes"]
    for f in ("symptoms", "preventionTips"):
        for i, s in enumerate(entry.get(f) or []):
            if is_str(s):
                yield f"{f}[{i}]", s


def check_entry(entry, kind, filename, report):
    """kind: 'toxin' or 'disease'"""
    name = entry.get("name") if is_str(entry.get("name")) else entry.get("id", "<unnamed>")
    where = f"{filename} · {name}"

    allowed = TOXIN_KEYS if kind == "toxin" else DISEASE_KEYS
    for k in set(entry) - allowed:
        report.error(where, f"unknown field '{k}' (typo, or schema doc needs updating)")

    # id
    eid = entry.get("id")
    if not is_str(eid):
        report.error(where, "missing required field 'id'")
    elif not UUID_RE.match(eid):
        if UUID_ANYCASE_RE.match(eid):
            report.error(where, f"id '{eid}' must be uppercase hex")
        else:
            report.error(where, f"id '{eid}' is not a valid UUID (hex chars 0-9 A-F only)")

    if not is_str(entry.get("name")):
        report.error(where, "missing required field 'name'")

    for f in ("description", "toxicityInfo"):
        if not is_str(entry.get(f)):
            report.error(where, f"missing required field '{f}'")

    check_str_list(entry, "alternateNames", where, report)
    # symptoms may contain "" — intentional spacer rows before section headers
    # like "PROGRESSIVE SIGNS:" in the app's symptom list UI
    check_str_list(entry, "symptoms", where, report, allow_empty_items=True)
    check_str_list(entry, "preventionTips", where, report, allow_null=True)

    sources = entry.get("sources")
    # The severity-ratings explainer is app UI content, not clinical — the one
    # entry allowed to have no sources. All others need 3+ (audit rules).
    SEVERITY_EXPLAINER_ID = "B3F1A2D4-E5C6-47F8-9A0B-1C2D3E4F5A6B"
    sources_ok = isinstance(sources, list) and all(is_str(s) for s in sources) and (
        len(sources) >= 3 or entry.get("id") == SEVERITY_EXPLAINER_ID
    )
    if not sources_ok:
        report.error(where, "'sources' must list 3+ publicly accessible sources (audit rules)")
    # VIN monographs are subscription-only and prohibited; Veterinary Partner
    # (VIN's public site) is approved source #6 and stays.
    for s in sources if isinstance(sources, list) else []:
        if not is_str(s):
            continue
        if (re.search(r"\bVIN\b", s, re.I) or re.search(r"veterinary information network", s, re.I)) \
                and not re.search(r"veterinary partner", s, re.I):
            report.error(where, f"source '{s}' is a VIN monograph (subscription-only, "
                                "prohibited); Veterinary Partner citations are fine")

    ia = entry.get("imageAsset")
    if ia is not None and not is_str(ia):
        report.error(where, "'imageAsset' must be a string or null")

    # categories / entrySeverity / entryType per kind
    if kind == "toxin":
        cats = entry.get("categories")
        if not isinstance(cats, list) or len(cats) == 0:
            report.error(where, "'categories' must be a non-empty list")
            cats = []
        for c in cats:
            if c == "diseasesAndConditions":
                report.error(where, "'diseasesAndConditions' is never stored in toxins.json")
            elif c not in CATEGORIES:
                report.error(where, f"unknown category '{c}'")
        sev = entry.get("entrySeverity")
        if sev is not None and sev not in SEVERITIES:
            report.error(where, f"unknown entrySeverity '{sev}'")
        if "informational" in cats and sev is not None:
            report.error(where, "informational-category entry must have null entrySeverity")
        if sev is None and cats and "informational" not in cats:
            report.error(where, "null entrySeverity requires the 'informational' category")
    else:
        for f in ("categories", "entrySeverity"):
            if f in entry:
                report.error(where, f"'{f}' must not appear in diseases.json (added by loader)")
        et = entry.get("entryType")
        if et not in ENTRY_TYPES:
            report.error(where, f"entryType must be one of {sorted(ENTRY_TYPES)}, got '{et}'")

    # onsetTime
    ot = entry.get("onsetTime")
    if ot is not None:
        if not isinstance(ot, dict):
            report.error(where, "'onsetTime' must be an object or null")
        else:
            for k in set(ot) - ONSET_KEYS:
                report.error(where, f"unknown onsetTime field '{k}'")
            if not any(is_str(ot.get(k)) for k in ONSET_KEYS):
                report.error(where, "onsetTime present but both 'early' and 'delayed' are empty")

    # speciesRisks
    srs = entry.get("speciesRisks")
    if not isinstance(srs, list):
        report.error(where, "'speciesRisks' must be a list")
        srs = []
    listed = [sr.get("species") for sr in srs if isinstance(sr, dict)]
    if len(listed) != len(set(listed)):
        report.error(where, "duplicate species in speciesRisks")
    if kind == "toxin":
        # Audit rule: standard toxin entries cover all 5 species. Informational
        # entries may have none. Diseases list only susceptible species.
        covered = set(listed)
        if entry.get("entrySeverity") is not None and covered != SPECIES:
            missing = sorted(SPECIES - covered)
            report.error(where, f"non-informational entry must cover all 5 species; missing: {missing}")
        elif entry.get("entrySeverity") is None and covered and covered != SPECIES:
            report.error(where, "informational entry speciesRisks must be empty or cover all 5 species")
    for i, sr in enumerate(srs):
        if not isinstance(sr, dict):
            report.error(where, f"speciesRisks[{i}] must be an object")
            continue
        for k in set(sr) - SPECIES_RISK_KEYS:
            report.error(where, f"speciesRisks[{i}] unknown field '{k}'")
        if sr.get("species") not in SPECIES:
            report.error(where, f"speciesRisks[{i}] unknown species '{sr.get('species')}'")
        if sr.get("severity") not in SEVERITIES:
            report.error(where, f"speciesRisks[{i}] severity must be one of {sorted(SEVERITIES)}")
        if sr.get("notes") is not None and not is_str(sr.get("notes")):
            report.error(where, f"speciesRisks[{i}] 'notes' must be a string or null")

    # relatedEntries format (resolution is checked cross-file later)
    rel = entry.get("relatedEntries")
    if rel is not None:
        if not isinstance(rel, list):
            report.error(where, "'relatedEntries' must be a list of UUIDs or null")
        else:
            for r in rel:
                if not (is_str(r) and UUID_ANYCASE_RE.match(r)):
                    report.error(where, f"relatedEntries value '{r}' is not a valid UUID")

    # Text formatting rules (CLAUDE.md: Content Formatting Gotchas).
    # The [content:HASH] suffix ties a baselined error to the exact field text:
    # ANY change to a broken field (including a new regression inside it)
    # changes the hash, invalidating the baseline entry so it fails as new.
    for f in ("description", "toxicityInfo"):
        txt = entry.get(f)
        if not is_str(txt):
            continue
        digest = hashlib.sha256(txt.encode("utf-8")).hexdigest()[:8]
        if MD_LIST_RE.search(txt):
            report.error(
                where,
                f"'{f}' contains markdown list syntax ('- ' line) — renders with no "
                "separation in the app; use \\n\\n paragraphs with bold headers instead "
                f"[content:{digest}]",
            )
        if txt.count("*") % 2 == 1:
            report.error(where, f"'{f}' has an odd number of '*' — unbalanced markdown "
                                f"emphasis [content:{digest}]")

    # Editorial policy warnings (veterinary judgment required — never blocking)
    for fname, txt in text_fields(entry):
        for pat, label in POLICY_PATTERNS:
            if pat.search(txt):
                report.warn(where, f"{fname} contains {label} — context-dependent; "
                                   "OK only if it can't be read as reassurance to skip vet care")
                break  # one policy warning per field is enough

    # Scientific-name italics convention (plants/foods; warning — some entries
    # like Salt or Alcohol legitimately have no scientific name)
    if kind == "toxin":
        cats = entry.get("categories") or []
        if ("plants" in cats or "foods" in cats) and isinstance(cats, list):
            desc = entry.get("description", "") or ""
            tox = entry.get("toxicityInfo", "") or ""
            if not ITALIC_GENUS_RE.search(desc) and not ITALIC_GENUS_RE.search(tox):
                report.warn(where, "plant/food entry has no italicized scientific name "
                                   "(*Genus species*) in description or toxicityInfo")


def check_file_root(data, filename, report):
    if not isinstance(data, dict):
        report.error(filename, "root must be an object with 'version' and 'entries'")
        return []
    if not isinstance(data.get("version"), int):
        report.error(filename, "'version' must be an integer")
    entries = data.get("entries")
    if not isinstance(entries, list):
        report.error(filename, "'entries' must be a list")
        return []
    return entries


def validate(toxins_data, diseases_data, report):
    toxins = check_file_root(toxins_data, "toxins.json", report)
    diseases = check_file_root(diseases_data, "diseases.json", report)

    for e in toxins:
        if isinstance(e, dict):
            check_entry(e, "toxin", "toxins.json", report)
        else:
            report.error("toxins.json", "entry is not an object")
    for e in diseases:
        if isinstance(e, dict):
            check_entry(e, "disease", "diseases.json", report)
        else:
            report.error("diseases.json", "entry is not an object")

    # Cross-file checks
    all_entries = [("toxins.json", e) for e in toxins if isinstance(e, dict)] + \
                  [("diseases.json", e) for e in diseases if isinstance(e, dict)]

    seen_ids = {}
    for fn, e in all_entries:
        eid = e.get("id")
        if not is_str(eid):
            continue
        key = eid.upper()
        if key in seen_ids:
            report.error(f"{fn} · {e.get('name')}", f"duplicate id {eid} (also used by {seen_ids[key]})")
        else:
            seen_ids[key] = f"{fn} · {e.get('name')}"

    for fn, entries in (("toxins.json", toxins), ("diseases.json", diseases)):
        seen_names = {}
        for e in entries:
            nm = e.get("name") if isinstance(e, dict) else None
            if not is_str(nm):
                continue
            if nm.lower() in seen_names:
                report.error(f"{fn} · {nm}", "duplicate entry name")
            seen_names[nm.lower()] = True

    # Cross-reference resolution: UUIDs may reference entries in either file.
    # Swift resolves UUIDs case-insensitively; a plain string comparison would
    # not, so case mismatches are warned (Android portability hazard).
    exact_ids = {e.get("id") for _, e in all_entries if is_str(e.get("id"))}
    for fn, e in all_entries:
        where = f"{fn} · {e.get('name')}"
        for r in e.get("relatedEntries") or []:
            if not (is_str(r) and UUID_ANYCASE_RE.match(r)):
                continue  # format error already reported
            if r.upper() not in seen_ids:
                report.error(where, f"relatedEntries UUID {r} does not exist in either file")
            elif r not in exact_ids:
                report.warn(where, f"relatedEntries UUID {r} resolves only case-insensitively "
                                   "(stored lowercase, ids are uppercase)")
            if is_str(e.get("id")) and r.upper() == e["id"].upper():
                report.warn(where, "entry references itself in relatedEntries")


def apply_baseline(errors, baseline_lines):
    """Split errors into (new, known, stale_baseline_entries).

    The baseline holds pre-existing errors accepted until the JSON
    source-of-truth migration fixes them in the Swift source. Only NEW errors
    fail the run; stale entries (fixed but still listed) are reported so the
    baseline file shrinks over time. Delete the file once it's empty.
    """
    baseline = {ln.strip() for ln in baseline_lines if ln.strip() and not ln.startswith("#")}
    new = [e for e in errors if e not in baseline]
    known = [e for e in errors if e in baseline]
    stale = sorted(baseline - set(errors))
    return new, known, stale


def run(content_dir, strict, quiet, baseline_path):
    report = Report()
    files = {}
    for name in ("toxins.json", "diseases.json"):
        path = Path(content_dir) / name
        if not path.exists():
            report.error(name, f"file not found at {path}")
            files[name] = {}
            continue
        try:
            files[name] = json.loads(path.read_text(encoding="utf-8"))
        except json.JSONDecodeError as ex:
            report.error(name, f"invalid JSON: {ex}")
            files[name] = {}

    if not report.errors:
        validate(files["toxins.json"], files["diseases.json"], report)

    n_tox = len(files["toxins.json"].get("entries", [])) if isinstance(files["toxins.json"], dict) else 0
    n_dis = len(files["diseases.json"].get("entries", [])) if isinstance(files["diseases.json"], dict) else 0

    known, stale = [], []
    new_errors = report.errors
    if baseline_path and Path(baseline_path).exists():
        new_errors, known, stale = apply_baseline(
            report.errors, Path(baseline_path).read_text(encoding="utf-8").splitlines()
        )

    if new_errors:
        print(f"❌ {len(new_errors)} NEW error(s):")
        for e in new_errors:
            print(f"  ERROR   {e}")
    if known:
        print(f"ℹ️  {len(known)} known baselined error(s) (fix planned in the JSON "
              "source-of-truth migration; see Scripts/known_content_errors.txt)")
    if stale:
        print(f"🧹 {len(stale)} stale baseline entr{'y' if len(stale)==1 else 'ies'} "
              "(fixed — remove from Scripts/known_content_errors.txt):")
        for s in stale:
            print(f"  STALE   {s}")
    if report.warnings and not quiet:
        print(f"⚠️  {len(report.warnings)} warning(s) (editorial review, non-blocking):")
        for w in report.warnings:
            print(f"  WARN    {w}")
    status = "FAIL" if new_errors or (strict and report.warnings) else "OK"
    print(f"{status}: {n_tox} toxin entries, {n_dis} disease entries · "
          f"{len(new_errors)} new errors, {len(known)} baselined, "
          f"{len(report.warnings)} warnings")
    return 1 if status == "FAIL" else 0


# ---------------------------------------------------------------------------
# Self-test: every rule must fire on a deliberately broken entry and stay
# silent on a valid one. Run with --self-test after any change to this script.
# ---------------------------------------------------------------------------

def _valid_toxin(**over):
    e = {
        "id": "A1B2C3D4-0000-4000-8000-000000000001",
        "name": "Testium",
        "alternateNames": ["testo"],
        "categories": ["plants"],
        "imageAsset": None,
        "description": "A plant (*Testium vulgaris*) used only for testing.",
        "toxicityInfo": "Contains testine, which is not real.",
        "onsetTime": {"early": "Soon.", "delayed": None},
        "symptoms": ["Vomiting"],
        "entrySeverity": "moderate",
        "speciesRisks": [
            {"species": s, "severity": "high", "notes": None}
            for s in ("dog", "cat", "smallMammal", "bird", "reptile")
        ],
        "preventionTips": ["Keep out of reach"],
        "sources": ["ASPCA Animal Poison Control Center", "Pet Poison Helpline",
                    "Merck Veterinary Manual"],
        "relatedEntries": None,
    }
    e.update(over)
    return e


def _valid_disease(**over):
    e = {
        "id": "A1B2C3D4-0000-4000-8000-000000000002",
        "name": "Testosis",
        "entryType": "infectious",
        "alternateNames": [],
        "imageAsset": None,
        "description": "A fake disease.",
        "toxicityInfo": "**How It Harms the Body**\n\nIt does not.",
        "onsetTime": None,
        "symptoms": ["Lethargy"],
        "speciesRisks": [{"species": "cat", "severity": "low", "notes": "Rare."}],
        "preventionTips": None,
        "sources": ["Merck Veterinary Manual", "Veterinary Partner",
                    "Cornell University College of Veterinary Medicine"],
        "relatedEntries": None,
    }
    e.update(over)
    return e


def self_test():
    def run_case(toxins, diseases):
        r = Report()
        validate({"version": 1, "entries": toxins}, {"version": 1, "entries": diseases}, r)
        return r

    failures = []

    def expect(label, msgs, substr, should_fire=True):
        fired = any(substr in m for m in msgs)
        if fired != should_fire:
            failures.append(f"{label}: expected {'HIT' if should_fire else 'no hit'} for '{substr}'; got {msgs}")

    # 1. valid content produces no errors and no warnings
    r = run_case([_valid_toxin()], [_valid_disease()])
    if r.errors or r.warnings:
        failures.append(f"valid case not clean: {r.errors + r.warnings}")

    # accepted patterns must NOT fire
    r = run_case([_valid_toxin(symptoms=["Early signs", "", "LATE SIGNS:", "Collapse"])], [_valid_disease()])
    expect("symptom spacers ok", r.errors, "'symptoms'", should_fire=False)
    r = run_case([_valid_toxin(toxicityInfo="Key differences:\n\n- single seed\n\n- no tendrils")], [_valid_disease()])
    expect("double-newline bullets ok", r.errors, "markdown list", should_fire=False)
    r = run_case([_valid_toxin(categories=["informational"], entrySeverity=None, speciesRisks=[])], [_valid_disease()])
    expect("informational empty species ok", r.errors, "species", should_fire=False)
    r = run_case([_valid_toxin(sources=["Veterinary Partner (VIN): Chocolate", "A", "B"])], [_valid_disease()])
    expect("Veterinary Partner ok", r.errors, "VIN monograph", should_fire=False)
    r = run_case([_valid_toxin(sources=["veterinary partner (vin): Chocolate", "A", "B"])], [_valid_disease()])
    expect("veterinary partner lowercase ok", r.errors, "VIN monograph", should_fire=False)

    cases = [
        ("bad uuid", [_valid_toxin(id="GYMNOCLA-DUS0-0000-0000-000000000001")], [], "not a valid UUID"),
        ("lowercase uuid", [_valid_toxin(id="a1b2c3d4-0000-4000-8000-000000000001")], [], "must be uppercase"),
        ("unknown key", [_valid_toxin(severityLevel="high")], [], "unknown field 'severityLevel'"),
        ("missing name", [{k: v for k, v in _valid_toxin().items() if k != "name"}], [], "missing required field 'name'"),
        ("bad category", [_valid_toxin(categories=["plnts"])], [], "unknown category 'plnts'"),
        ("dAndC in toxins", [_valid_toxin(categories=["diseasesAndConditions"])], [], "never stored in toxins.json"),
        ("bad severity", [_valid_toxin(entrySeverity="extreme")], [], "unknown entrySeverity"),
        ("bad species", [_valid_toxin(speciesRisks=[{"species": "horse", "severity": "high", "notes": None}])], [], "unknown species 'horse'"),
        ("md list", [_valid_toxin(toxicityInfo="Signs:\n- vomiting\n- drooling")], [], "markdown list syntax"),
        ("odd asterisks", [_valid_toxin(description="Bad *italic here")], [], "odd number of '*'"),
        ("empty onset", [_valid_toxin(onsetTime={"early": None, "delayed": None})], [], "both 'early' and 'delayed' are empty"),
        ("empty sources", [_valid_toxin(sources=[])], [], "must list 3+"),
        ("two sources", [_valid_toxin(sources=["A", "B"])], [], "must list 3+"),
        ("VIN monograph", [_valid_toxin(sources=["VIN: Chocolate Toxicosis", "A", "B"])], [], "VIN monograph"),
        ("VIN lowercase", [_valid_toxin(sources=["vin: Chocolate Toxicosis", "A", "B"])], [], "VIN monograph"),
        ("VIN spelled out", [_valid_toxin(sources=["veterinary information network — Grapes", "A", "B"])], [], "VIN monograph"),
        ("missing species", [_valid_toxin(speciesRisks=[{"species": "dog", "severity": "high", "notes": None}])], [], "must cover all 5 species"),
        ("dup species", [_valid_toxin(speciesRisks=_valid_toxin()["speciesRisks"] + [{"species": "dog", "severity": "low", "notes": None}])], [], "duplicate species"),
        ("dangling ref", [_valid_toxin(relatedEntries=["11111111-2222-4333-8444-555555555555"])], [], "does not exist in either file"),
        ("info cat with sev", [_valid_toxin(categories=["informational"], entrySeverity="low")], [], "informational-category entry must have null entrySeverity"),
        ("null sev not info", [_valid_toxin(entrySeverity=None)], [], "requires the 'informational' category"),
        ("disease with sev key", [], [_valid_disease(entrySeverity=None)], "must not appear in diseases.json"),
        ("bad entryType", [], [_valid_disease(entryType="viral")], "entryType must be one of"),
    ]
    for label, toxins, diseases, substr in cases:
        r = run_case(toxins, diseases or [_valid_disease()])
        expect(label, r.errors, substr)

    # duplicate id across files
    r = run_case([_valid_toxin()], [_valid_disease(id=_valid_toxin()["id"])])
    expect("dup id", r.errors, "duplicate id")

    # warnings — one probe per policy pattern
    for label, text in [
        ("mg/kg warn", "Doses above 2 mg/kg are dangerous."),
        ("g/kg warn", "Toxic at 1 g/kg body weight."),
        ("mcg/kg warn", "Signs at 30 mcg/kg."),
        ("mg per kg warn", "About 20 mg per kg causes signs."),
    ]:
        r = run_case([_valid_toxin(toxicityInfo=text)], [_valid_disease()])
        expect(label, r.warnings, "dosage threshold")
    for label, text, sub in [
        ("LD50 warn", "The LD50 in rats is high.", "LD50 data"),
        ("safe dose warn", "There is no safe dose for cats.", "safe amount/dose"),
        ("well tolerated warn", "Generally well tolerated in dogs.", "well tolerated"),
        ("prognosis warn", "The prognosis is excellent.", "prognosis statement"),
    ]:
        r = run_case([_valid_toxin(toxicityInfo=text)], [_valid_disease()])
        expect(label, r.warnings, sub)

    # content hash makes formatting errors content-specific (baseline can't
    # mask a second regression in an already-baselined field)
    e1 = run_case([_valid_toxin(toxicityInfo="Signs:\n- vomiting")], [_valid_disease()]).errors
    e2 = run_case([_valid_toxin(toxicityInfo="Signs:\n- vomiting\n- drooling")], [_valid_disease()]).errors
    if e1 == e2:
        failures.append("md-list errors for different content should differ (hash suffix)")
    r = run_case([_valid_toxin(description="A plant with no scientific name.")], [_valid_disease()])
    expect("italics warn", r.warnings, "no italicized scientific name")
    tox2 = _valid_toxin(id="B1B2C3D4-0000-4000-8000-000000000009")
    r = run_case([_valid_toxin(relatedEntries=[tox2["id"].lower()]), tox2], [_valid_disease()])
    expect("case-mismatch warn", r.warnings, "resolves only case-insensitively")
    r = run_case([_valid_toxin(relatedEntries=[_valid_toxin()["id"]])], [_valid_disease()])
    expect("self-ref warn", r.warnings, "references itself")

    # baseline partitioning
    new, known, stale = apply_baseline(
        ["errA", "errB"], ["# comment", "errB", "errGone", ""]
    )
    if new != ["errA"] or known != ["errB"] or stale != ["errGone"]:
        failures.append(f"baseline partition wrong: {new} {known} {stale}")

    if failures:
        print("❌ self-test FAILED:")
        for f in failures:
            print("  " + f)
        return 1
    print("✅ self-test passed (all cases)")
    return 0


def main():
    ap = argparse.ArgumentParser(description="Validate PetToxic content JSON files")
    default_dir = Path(__file__).resolve().parent.parent / "Content"
    ap.add_argument("--content-dir", default=str(default_dir))
    ap.add_argument("--strict", action="store_true", help="warnings also cause failure (for CI)")
    ap.add_argument("--quiet", action="store_true", help="suppress warning listing")
    ap.add_argument("--self-test", action="store_true", help="run the built-in test suite")
    ap.add_argument("--baseline", default=str(Path(__file__).resolve().parent / "known_content_errors.txt"),
                    help="file of accepted pre-existing errors (only NEW errors fail)")
    ap.add_argument("--no-baseline", action="store_true", help="ignore the baseline file")
    args = ap.parse_args()
    if args.self_test:
        sys.exit(self_test())
    sys.exit(run(args.content_dir, args.strict, args.quiet,
                 None if args.no_baseline else args.baseline))


if __name__ == "__main__":
    main()
