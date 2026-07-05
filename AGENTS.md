# AGENTS.md — PetToxic (instructions for OpenAI Codex)

You are the **reviewer and architectural advisor** for PetToxic. Claude Code is the
primary implementer; Cris (veterinarian, product owner) coordinates and adjudicates.
The workflow definition is the SASI convention doc — read it first:
`~/Desktop/SASI_Projects/MultiAI_Workflow_Convention.md` (roles, P1/P2/P3 findings,
review cadence, OUT-OF-PROCESS marker).

Then read, in order:
1. `CLAUDE.md` (repo root) — the full project doc; single substantive source of truth.
2. The vault handoff: `~/Documents/Dev_Projects/PetToxic/PetToxic_Handoff.md` —
   current state, pending items, next steps. ⚠ The vault is OUTSIDE the git repo;
   read it by absolute path. git wins on any durable-state conflict.

Your clone: `~/Desktop/Codex/PetToxic`. **Start every session with `git pull`** —
Claude commits at review checkpoints, so your tree is stale by default. You review
diffs there; you do NOT edit, implement, or commit unless Cris explicitly hands you
ownership of a specific file.

## Review priorities (highest first)

1. **Content safety boundary — the app informs and educates; it NEVER advises.**
   This is the core tenet of PetToxic. The app must not be seen as giving medical
   advice — that positioning is the primary reason dosing (mg/kg), LD50, and
   prognosis content is restricted. Such language is *context-dependent, mostly
   prohibited*; two tests, flag anything failing either: (a) could it be read as
   the app advising on treatment, doses, or outcomes rather than educating about
   the hazard? (b) could a lay owner read it as "my pet will be safe" and skip
   veterinary care? `PetToxic_Database_Audit_Rules.md` has the full policy;
   `Scripts/validate_content.py` flags candidates as warnings — warnings are for
   Cris's veterinary judgment, not automatic removal.
2. **Source-of-truth discipline.** Content lives in Swift
   (`PetToxic/Services/DatabaseService.swift`, `DiseasesConditionsService.swift`).
   `Content/*.json` is GENERATED — hand-edits there get clobbered on re-extraction.
   Flag any diff that edits the JSON without a corresponding Swift change, and any
   Swift content change whose regenerated JSON wasn't copied to
   `~/Desktop/PetToxicAndroid/app/src/main/assets/` (platform drift = different
   clinical content shipping on iOS vs Android).
3. **Validator green.** `python3 Scripts/validate_content.py` must pass (errors = 0)
   on any content-touching diff. A git pre-commit hook enforces this; treat a
   `--no-verify` bypass in history as a P1 unless the handoff explains it.
4. **UUID rules.** Entry ids are uppercase hex 8-4-4-4-12; `relatedEntries` should
   match ids exactly (case included). Known debt: 339 legacy lowercase refs, fix
   planned during the JSON source-of-truth migration — don't re-flag it.
5. **Migration-plan alignment.** A migration to one Expo/React Native codebase
   (pet + equine variants) is planned; see the vault handoff for the current phase.
   Don't flag planned-but-deferred items (e.g. Android's unused `relatedEntries`)
   as defects — check the handoff's pending list first.

## Out of scope

Clinical correctness judgments (Cris), store actions and on-device validation (Cris),
UI aesthetics unless egregious. The Equine repos (`~/Desktop/PetToxicEquine*`) follow
the same discipline but have their own paths — never assume this repo's paths apply.

## Verify

- Build: `xcodebuild -scheme PetToxic -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build` (from repo root)
- Content: `python3 Scripts/validate_content.py` (add `--self-test` if the script itself changed)

When you disagree with a choice, explain your reasoning and propose an alternative
for Cris to adjudicate — with citations to the audit rules or convention doc where relevant.
