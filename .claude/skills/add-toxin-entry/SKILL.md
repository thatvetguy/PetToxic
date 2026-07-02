---
name: add-toxin-entry
description: Add or edit a toxin (or disease) entry in the PetToxic databases the right way. Use this whenever you're adding or substantially editing clinical reference content in PetToxic or PetToxic Equine — "add a new toxin", "add xylitol to the database", "audit the chocolate entry", "add a disease/condition", "update the species risks for X". It encodes the non-negotiable PetToxic content rules that are easy to violate and expensive to get wrong: the app is a liability-bounded owner-facing reference (NO medical advice / dosages / "safe amount" language), the content source of truth is Swift (NOT the generated JSON), and the data reaches Android only after a regenerate-and-copy step that's easy to forget. Use it even when the ask sounds trivial — "just add one toxin" is exactly where the source-of-truth, the regenerate step, and the language boundary get missed.
---

# Add / Edit a PetToxic Toxin or Disease Entry

PetToxic is an **owner-facing** toxin reference used in emergencies by people with no medical training. That framing sets a hard liability boundary: the app *describes* hazards; it never *prescribes*. A dosage, an LD50, a "safe amount," or a treatment protocol isn't a nice-to-have — it's a boundary violation that can hurt an animal and expose the publisher. This skill captures the rules and the exact data pipeline so a content change lands correct, safe, and on both platforms.

## 1. The authoritative content rules live in one doc — read it first

**`PetToxic_Database_Audit_Rules.md`** (repo root) is the source of truth for what an entry may and may not contain: severity levels, the five required species, the sources policy, content to remove vs. keep, permitted first aid, language guidelines, categories, cross-reference rules, and the field order. Read the relevant sections before writing. This skill operationalizes that doc — it does not replace it. For *content* questions the audit-rules doc wins; for *how you make and verify the edit* this skill wins.

## 2. ⚠ The source of truth is SWIFT, not the JSON — edit the right file

This is the most consequential thing to get right. Content is **hardcoded in Swift**, and the `Content/*.json` files are **generated artifacts**:

- **Toxins:** edit `PetToxic/Services/DatabaseService.swift` (~198 `ToxicItem(...)` initializers).
- **Diseases / conditions:** edit `PetToxic/Services/DiseasesConditionsService.swift` (Pro-locked content).

**Never hand-edit `Content/toxins.json` or `Content/diseases.json`.** They are regenerated from the Swift by `Scripts/extract_content.swift` (§6), so any manual edit there is silently clobbered on the next extract. If you see a diff in `Content/*.json`, it should be the *output* of a Swift edit you just made, not a hand edit.

(There's a `Documentation/JSON_SourceOfTruth_MigrationPlan.md` to eventually flip the source of truth to JSON, but its status is **"Future — revisit if app gains traction."** Until that migration actually lands, Swift is the source. If it lands, this section is the first thing to update.)

## 3. The non-negotiables (distilled from the audit rules)

The ones easy to violate and highest-consequence:

- **No medical advice.** No dosage calculations, mg/kg thresholds, LD50 data, treatment protocols, prognosis statements, or medication recommendations. They imply a safe quantity exists or substitute for a vet. Describe the hazard and the observable signs; stop there.
- **Never imply a safe amount.** No "safe amount," "generally well tolerated," or "small amounts are fine" — it discourages seeking care. Err toward urgency; never dismiss risk.
- **All five species, every entry.** `dog`, `cat`, `smallMammal`, `bird`, `reptile` — each with a severity and notes. Sensitivities vary (research rabbits/rodents, small/large birds, snakes/chelonians separately as needed). A missing species reads as "no risk," which is unsafe.
- **3+ publicly accessible sources; no VIN.** Remove "Veterinary Information Network (VIN)" / VIN monograph sources (subscription-only). "Veterinary Partner" (VIN's public site) is fine. Prefer ASPCA APCC, Pet Poison Helpline, Merck Vet Manual, peer-reviewed journals, vet-school sites. Organization names, not individual doctor/author names.
- **Bidirectional cross-references.** If entry A lists B in `relatedEntries`, B must list A. One-directional links are a bug.
- **Plain language.** Owners, not clinicians: `technical term (plain-language explanation)`. Say "animal poison control," not a specific hotline name (numbers are listed separately in-app).
- **Permitted first aid only.** Bathing/rinsing, eye rinsing, remove-from-exposure, Karo syrup for expected hypoglycemia. Nothing beyond that list.

## 4. Verify sources before writing — never fabricate

Every risk claim, severity, onset, and symptom must trace to a real, publicly accessible source you have actually checked. Do **not** assert a source's content, an author, a year, or a clinical fact from memory — that's how wrong information reaches an owner mid-emergency. Fetch/confirm the claim, then write it. If you can't verify something, leave it out and flag the gap; a documented gap is fine, a confident fabrication is not.

## 5. Field discipline (editing the Swift)

A `ToxicItem(...)` initializer's fields must appear in this exact order (per the audit rules doc):

```
id, name, alternateNames, categories, imageAsset, description, toxicityInfo,
onsetTime, symptoms, entrySeverity, speciesRisks, preventionTips, sources, relatedEntries
```

- **`id`** — a UUID. Generate a **new** one for a new entry (`uuidgen`). **Never change an existing entry's `id`** — it severs saved state and cross-references.
- **`name` / `imageAsset`** — don't change these on an existing entry without coordinating (they drive search/navigation and link to bundled image assets). A **new** entry needs an `imageAsset`; if the image doesn't exist yet, flag it for the user rather than pointing at a missing asset.
- **`entrySeverity`** — `.severe | .high | .moderate | .low`, or `nil` for informational/umbrella/mechanical-hazard entries (which also carry the `.informational` category).
- **`alternateNames`** — add synonyms, brand names, and common **misspellings** (e.g. "choclate"); they power search and are a feature, not sloppiness.
- **No markdown list syntax in `description` or `toxicityInfo`.** Lines starting with `- ` render run-together (the styled-text renderer swallows single `\n`). Use `\n\n`-separated paragraphs with bold headers (`**EARS:**`) or inline prose instead. The `symptoms` and `preventionTips` arrays are unaffected — they render as list rows.

## 6. Regenerate the JSON and sync to Android — the step everyone forgets

After editing the Swift, the JSON isn't updated until you regenerate it, and Android isn't updated until you copy it. Run this from the repo root (it compiles the content sources + the extractor, runs it, then copies both files to the Android repo).

⚠ **These paths are PetToxic-specific — confirm which app you're in before running.** The command below copies to `~/Desktop/PetToxicAndroid`. If you're working on **PetToxic Equine**, do NOT run this block verbatim: it would push equine content into the small-animal Android project. Use the Equine repo's own Swift services and `~/Desktop/PetToxicEquineAndroid` instead (see §8), or confirm the correct source repo + Android target with the user first.

```bash
swiftc -framework SwiftUI \
  PetToxic/Models/Enums.swift \
  PetToxic/Models/ToxicItem.swift \
  PetToxic/Models/SpeciesRisk.swift \
  PetToxic/Services/DatabaseService.swift \
  PetToxic/Services/DiseasesConditionsService.swift \
  Scripts/extract_content.swift \
  -o Scripts/extract_content
./Scripts/extract_content
# then copy the regenerated JSON into the Android project:
cp Content/toxins.json Content/diseases.json ~/Desktop/PetToxicAndroid/app/src/main/assets/
```

If the `swiftc` compile fails, your Swift edit has an error — fix it there; a broken content source means neither platform builds. (Check `PetToxic/Services/` for the current command if the file list drifts; `CLAUDE.md` documents it too.)

## 7. Verify before declaring done

- **The Swift compiles** (the `swiftc` extract step above succeeds) and the extractor runs cleanly.
- **The JSON regenerated** — `Content/toxins.json` / `diseases.json` reflect your change (parse-check: `python3 -m json.tool Content/toxins.json >/dev/null`).
- **Android got the copy** — after the `cp`, `diff Content/toxins.json ~/Desktop/PetToxicAndroid/app/src/main/assets/toxins.json` prints nothing (same for `diseases.json`). A drift here means the two platforms ship different clinical content.
- **The entry passes the audit checklist** — 5 species present, VIN removed / 3+ sources, no "safe amount" language, cross-references bidirectional, nothing that reads as medical advice.
- **If feasible, build/run the iOS app** so a runtime schema/rendering issue surfaces before commit.

## 8. Scope notes

- **Diseases/conditions** are Pro-locked and live in `DiseasesConditionsService.swift`; same content boundary, same regenerate-and-sync pipeline.
- **PetToxic Equine** (`~/Desktop/PetToxicEquine` + `~/Desktop/PetToxicEquineAndroid`) follows this same Swift-source → extract → copy *discipline*, but every concrete path in this skill is for the small-animal app and must be re-pointed: edit the Equine repo's own Swift services, and the final `cp` must target `~/Desktop/PetToxicEquineAndroid/app/src/main/assets/`, NOT `~/Desktop/PetToxicAndroid`. Confirm the Equine repo's exact service filenames + extract command (they may differ) and read that app's own rules doc for equine species scope before running anything. When in doubt, treat this as a PetToxic-only skill and adapt deliberately.
- Follow the repo's multi-AI workflow (see `CLAUDE.md` / the SASI `MultiAI_Workflow_Convention.md`): a content change of any size is a natural Codex-review checkpoint.

## Quick checklist

```
[ ] Read the relevant PetToxic_Database_Audit_Rules.md sections
[ ] Edited the SWIFT source (DatabaseService.swift / DiseasesConditionsService.swift),
    NOT Content/*.json
[ ] Sources verified (no fabrication); 3+ publicly accessible; VIN removed
[ ] No medical advice: no dosage/LD50/"safe amount"/treatment/prognosis
[ ] All 5 species present with severity + notes
[ ] Cross-references bidirectional
[ ] New entry: fresh UUID; imageAsset exists (or flagged); initializer field order
[ ] Existing entry: id / name / imageAsset unchanged
[ ] No markdown "- " lists in description/toxicityInfo
[ ] Ran the swiftc extract → regenerated Content/*.json → cp'd to Android
[ ] iOS & Android JSON are byte-identical (diff empty); Swift compiles
```
