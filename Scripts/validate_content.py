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
# (July 2026): dosing/prognosis language is context-dependent, mostly prohibited.
# The test: could a lay owner read it as "my pet will be safe" and skip vet care?
POLICY_PATTERNS = [
    (re.compile(r"mg/kg", re.I), "dosage threshold (mg/kg)"),
    (re.compile(r"\bLD-?50\b", re.I), "LD50 data"),
    (re.compile(r"safe amount", re.I), '"safe amount" language'),
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
    # entry allowed to have no sources.
    SEVERITY_EXPLAINER_ID = "B3F1A2D4-E5C6-47F8-9A0B-1C2D3E4F5A6B"
    sources_ok = isinstance(sources, list) and all(is_str(s) for s in sources) and (
        len(sources) > 0 or entry.get("id") == SEVERITY_EXPLAINER_ID
    )
    if not sources_ok:
        report.error(where, "'sources' must be a non-empty list of strings")

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

    # Text formatting rules (CLAUDE.md: Content Formatting Gotchas)
    for f in ("description", "toxicityInfo"):
        txt = entry.get(f)
        if not is_str(txt):
            continue
        if MD_LIST_RE.search(txt):
            report.error(
                where,
                f"'{f}' contains markdown list syntax ('- ' line) — renders with no "
                "separation in the app; use \\n\\n paragraphs with bold headers instead",
            )
        if txt.count("*") % 2 == 1:
            report.error(where, f"'{f}' has an odd number of '*' — unbalanced markdown emphasis")

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


def run(content_dir, strict, quiet):
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

    if report.errors:
        print(f"❌ {len(report.errors)} error(s):")
        for e in report.errors:
            print(f"  ERROR   {e}")
    if report.warnings and not quiet:
        print(f"⚠️  {len(report.warnings)} warning(s) (editorial review, non-blocking):")
        for w in report.warnings:
            print(f"  WARN    {w}")
    status = "FAIL" if report.errors or (strict and report.warnings) else "OK"
    print(f"{status}: {n_tox} toxin entries, {n_dis} disease entries · "
          f"{len(report.errors)} errors, {len(report.warnings)} warnings")
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
        "speciesRisks": [{"species": "dog", "severity": "high", "notes": None}],
        "preventionTips": ["Keep out of reach"],
        "sources": ["ASPCA Animal Poison Control Center"],
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
        "sources": ["Merck Veterinary Manual"],
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
        ("empty sources", [_valid_toxin(sources=[])], [], "'sources' must be a non-empty list"),
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

    # warnings
    r = run_case([_valid_toxin(toxicityInfo="Doses above 2 mg/kg are dangerous.")], [_valid_disease()])
    expect("mg/kg warn", r.warnings, "dosage threshold")
    r = run_case([_valid_toxin(description="A plant with no scientific name.")], [_valid_disease()])
    expect("italics warn", r.warnings, "no italicized scientific name")
    tox2 = _valid_toxin(id="B1B2C3D4-0000-4000-8000-000000000009")
    r = run_case([_valid_toxin(relatedEntries=[tox2["id"].lower()]), tox2], [_valid_disease()])
    expect("case-mismatch warn", r.warnings, "resolves only case-insensitively")
    r = run_case([_valid_toxin(relatedEntries=[_valid_toxin()["id"]])], [_valid_disease()])
    expect("self-ref warn", r.warnings, "references itself")

    if failures:
        print("❌ self-test FAILED:")
        for f in failures:
            print("  " + f)
        return 1
    print(f"✅ self-test passed ({1 + len(cases) + 5} cases)")
    return 0


def main():
    ap = argparse.ArgumentParser(description="Validate PetToxic content JSON files")
    default_dir = Path(__file__).resolve().parent.parent / "Content"
    ap.add_argument("--content-dir", default=str(default_dir))
    ap.add_argument("--strict", action="store_true", help="warnings also cause failure (for CI)")
    ap.add_argument("--quiet", action="store_true", help="suppress warning listing")
    ap.add_argument("--self-test", action="store_true", help="run the built-in test suite")
    args = ap.parse_args()
    if args.self_test:
        sys.exit(self_test())
    sys.exit(run(args.content_dir, args.strict, args.quiet))


if __name__ == "__main__":
    main()
