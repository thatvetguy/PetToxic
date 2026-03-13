# PetToxic Audit Rules (Condensed)

Quick-reference for batch editing sessions. See `PetToxic_Database_Audit_Rules.md` for full details.

## Checklist per Entry

- [ ] All 5 species: `.dog`, `.cat`, `.smallMammal`, `.bird`, `.reptile`
- [ ] No VIN sources; 3+ public sources remain
- [ ] No dosage/mg/kg, LD50, "safe amount", prognosis, treatment protocols
- [ ] Cross-references are bidirectional
- [ ] Plain language for medical terms: "term (explanation)"
- [ ] Informational/mechanical entries: `entrySeverity: nil`, include `.informational` category

## Remove

VIN sources | Dosage thresholds (mg/kg) | LD50 data | "Safe amount" language | "Generally well tolerated" | Prognosis statements | Treatment protocols | Specific doctor names

## Keep/Add

Practical examples | Plain language explanations | Observable symptoms | Species-specific warnings | Common exposure scenarios | Misspellings in alternateNames | Seasonal context | Product identification tips

## Permitted First Aid

Bathing/rinsing | Eye rinsing | Remove from exposure | Karo syrup (for hypoglycemia)

## Preferred Sources (ranked)

1. ASPCA Animal Poison Control Center
2. Pet Poison Helpline
3. Merck Veterinary Manual
4. Peer-reviewed journals (JAVMA, JVIM, JVECC)
5. Vet school websites (UC Davis, Cornell, Purdue)
6. Veterinary Partner
7. VCA Animal Hospitals, PetMD

## Field Order (new entries)

`id, name, alternateNames, categories, imageAsset, description, toxicityInfo, onsetTime, symptoms, entrySeverity, speciesRisks, preventionTips, sources, relatedEntries`

## Do NOT Edit

`id` (UUID) | `name` | `imageAsset` / `thumbnailURL`
