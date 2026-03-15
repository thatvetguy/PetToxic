import Foundation

class DiseasesConditionsService {
    static let shared = DiseasesConditionsService()

    let entries: [ToxicItem]

    private init() {
        entries = Self.loadEntries()
    }

    /// Returns entries that apply to the given species
    func entries(for species: Species) -> [ToxicItem] {
        entries.filter { item in
            item.speciesRisks.contains { $0.species == species }
        }
    }

    // MARK: - Disease Data

    private static func loadEntries() -> [ToxicItem] {
        [
            // MARK: - Rabies
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000001")!,
                name: "Rabies",
                alternateNames: ["hydrophobia", "rabies virus", "lyssavirus"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Rabies is a fatal viral disease that affects the central nervous system of all mammals. It is transmitted through the saliva of infected animals, most commonly via bites. Rabies is almost always fatal once clinical signs appear.",
                toxicityInfo: "Rabies virus (Lyssavirus) travels from the bite wound along peripheral nerves to the brain. The incubation period varies widely — typically 2 weeks to several months. Once the virus reaches the brain, it causes progressive encephalitis. There is no treatment once symptoms develop. Vaccination is the only effective prevention.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is typically 2-8 weeks but can range from days to months depending on bite location and viral load.",
                    delayed: "Progressive neurological signs develop over 3-7 days once symptoms appear: behavioral changes, paralysis, and death."
                ),
                symptoms: [
                    "Behavioral changes (aggression or unusual tameness)",
                    "Excessive drooling or difficulty swallowing",
                    "Paralysis of jaw or limbs",
                    "Disorientation and seizures",
                    "Sensitivity to light and sound",
                    "Self-mutilation at bite site"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are a primary vector for rabies worldwide. Vaccination is required by law in most jurisdictions. Unvaccinated dogs exposed to rabies may face mandatory quarantine or euthanasia."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are the most commonly reported domestic animal with rabies in the US. Indoor/outdoor cats are at high risk. Vaccination is strongly recommended or required by law."),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Ferrets are susceptible and should be vaccinated. Rabbits and rodents are rarely infected but exposure should be taken seriously.")
                ],
                preventionTips: [
                    "Keep rabies vaccinations current for all dogs, cats, and ferrets",
                    "Avoid contact with wildlife, especially bats, raccoons, skunks, and foxes",
                    "Report any animal bites to local animal control",
                    "Supervise pets outdoors to minimize wildlife encounters",
                    "If your pet is bitten by a wild animal, contact your veterinarian immediately"
                ],
                sources: [
                    "CDC - Rabies Information",
                    "AVMA - Rabies Resources",
                    "Merck Veterinary Manual - Rabies",
                    "World Organisation for Animal Health (WOAH)"
                ],
                relatedEntries: nil
            ),

            // MARK: - Canine Parvovirus
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000002")!,
                name: "Canine Parvovirus (Parvo)",
                alternateNames: [
                    "parvo",
                    "parvovirus",
                    "CPV",
                    "CPV-2",
                    "canine parvo",
                    "puppy parvo",
                    "parvoviral enteritis",
                    "canine parvoviral enteritis"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "canine_parvo_thumb",
                description: """
                Canine parvovirus — commonly called "parvo" — is a highly contagious and \
                potentially life-threatening viral disease that primarily affects dogs. It is \
                an acute illness, meaning it develops rapidly and can progress to death within \
                days without treatment. The virus attacks rapidly dividing cells in the body, \
                particularly in the intestinal lining, bone marrow, and lymphoid tissue.

                Parvo is vaccine-preventable, and vaccination is one of the most important \
                things a dog owner can do to protect their pet. Despite this, it remains one \
                of the most common serious infectious diseases seen in veterinary practice, \
                particularly in unvaccinated puppies and young dogs. Puppies between 6 weeks \
                and 6 months of age are most vulnerable. Certain breeds — including \
                Rottweilers, Doberman Pinschers, American Pit Bull Terriers, and German \
                Shepherds — may be at higher risk of severe disease even when vaccinated.
                """,
                toxicityInfo: """
                **How It Harms the Body**
                Parvovirus targets cells that divide rapidly — which is why the intestinal \
                lining, bone marrow, and immune tissue are hit hardest. In the gut, the virus \
                destroys the cells lining the intestines, stripping away the protective barrier \
                that absorbs nutrients and keeps bacteria contained within the digestive tract. \
                This leads to severe hemorrhagic (bloody) diarrhea, protein loss, and \
                life-threatening dehydration. At the same time, the virus attacks the bone \
                marrow, suppressing the immune system by impairing the production of white \
                blood cells. With a weakened immune system and a damaged intestinal barrier, \
                bacteria can enter the bloodstream — leading to sepsis (a life-threatening \
                whole-body infection) that significantly worsens outcomes.

                **Transmission & Spread**
                Parvovirus spreads through direct contact with an infected dog or — more \
                commonly — through contact with contaminated feces, environments, or objects \
                such as bowls, leashes, clothing, and shoes. The virus is extraordinarily \
                resilient: it can survive on surfaces and in soil for months to years, and it \
                is resistant to most common household disinfectants. This means an environment \
                where an infected dog has been can remain a source of infection long after the \
                animal has recovered or been removed. High-risk settings include kennels, \
                shelters, dog parks, pet stores, and any area frequented by unvaccinated dogs. \
                Recovered dogs can continue to shed the virus in their feces for up to 6 weeks \
                after recovery.

                **Treatment Goals**
                Parvo has no cure — treatment is supportive, and the goal is to keep the dog \
                alive long enough for their immune system to fight off the virus. Veterinary \
                treatment focuses on restoring and maintaining hydration, controlling nausea \
                and vomiting, and preventing or aggressively treating secondary bacterial \
                infections (sepsis). Most dogs that receive prompt, aggressive veterinary care \
                survive — but outcomes worsen significantly with any delay in treatment. A \
                monoclonal antibody treatment has become available in recent years that directly \
                targets the parvovirus and can improve outcomes — this option is most effective \
                when administered early in the disease course, which is another reason why \
                immediate veterinary evaluation is critical.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 3–7 days. Initial signs include lethargy, loss of appetite, and fever — often appearing before gastrointestinal signs develop.",
                    delayed: "Severe vomiting and bloody diarrhea typically develop within 24–48 hours of initial signs. The condition can deteriorate rapidly — prompt veterinary care is critical."
                ),
                symptoms: [
                    "Lethargy and sudden loss of energy",
                    "Loss of appetite",
                    "Fever (or in severe cases, abnormally low body temperature)",
                    "Persistent vomiting",
                    "Severe diarrhea, often bloody",
                    "Rapid and severe dehydration",
                    "Abdominal pain or bloating",
                    "Collapse (severe cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Puppies between 6 weeks and 6 months are most vulnerable. Certain breeds including Rottweilers, Doberman Pinschers, Pit Bulls, and German Shepherds may be at higher risk of severe disease. Life-threatening without prompt veterinary care — do not delay seeking treatment."
                    )
                ],
                preventionTips: [
                    "Vaccination is the most effective protection — follow your veterinarian's recommended schedule; puppies require a series of vaccines starting at 6–8 weeks of age",
                    "Keep unvaccinated puppies away from public areas, dog parks, pet stores, and any environments where unknown dogs have been",
                    "The virus survives on surfaces for months to years — disinfect with a diluted bleach solution (1 part bleach to 32 parts water), one of the few agents effective against parvovirus",
                    "If a dog in your household is diagnosed with parvo, isolate them immediately and for at least 2 weeks after full recovery",
                    "Recovered dogs can shed the virus in their feces for up to 6 weeks — continue hygiene precautions during this period",
                    "Wash hands thoroughly after contact with any dog of unknown vaccination status"
                ],
                sources: [
                    "Veterinary Partner — Parvovirus in Dogs",
                    "Merck Veterinary Manual — Canine Parvovirus",
                    "Cornell University College of Veterinary Medicine — Canine Parvovirus",
                    "AAHA Canine Vaccination Guidelines"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000003"  // Feline Panleukopenia — related parvovirus family
                ]
            ),

            // MARK: - Feline Panleukopenia
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000003")!,
                name: "Feline Panleukopenia (Feline Distemper)",
                alternateNames: [
                    "feline distemper",
                    "panleukopenia",
                    "feline parvo",
                    "FPV",
                    "feline parvovirus",
                    "feline infectious enteritis",
                    "cat distemper",
                    "panleukopenia virus",
                    "FPL"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "panleukopenia_thumb",
                description: """
                Feline panleukopenia — sometimes called feline distemper, though it is \
                unrelated to canine distemper — is a highly contagious and life-threatening \
                viral disease caused by feline parvovirus. It is one of the most serious \
                infectious diseases affecting cats, and despite its alternate name, it belongs \
                to the same parvovirus family as canine parvovirus. Like its canine counterpart, \
                it is an acute illness that can progress to death within days.

                The name "panleukopenia" describes one of the disease's hallmarks: a severe \
                drop in all white blood cells (pan = all, leuko = white blood cells, \
                penia = deficiency), which devastates the immune system. The disease is \
                vaccine-preventable, and vaccination is among the most important steps a cat \
                owner can take. Unvaccinated kittens under 6 months are most vulnerable, \
                though unvaccinated cats of any age are at risk. Ferrets are also susceptible.

                Feline panleukopenia carries a more guarded outlook than canine parvovirus — \
                even with prompt, aggressive veterinary care, many cats do not survive. This \
                makes immediate veterinary evaluation critical; every hour matters.
                """,
                toxicityInfo: """
                **How It Harms the Body**
                Feline parvovirus attacks rapidly dividing cells throughout the body. In the \
                intestinal tract, it destroys the cells lining the gut, causing severe vomiting, \
                hemorrhagic (bloody) diarrhea, and life-threatening dehydration. Simultaneously, \
                the virus devastates the bone marrow — the body's blood cell factory — causing \
                a catastrophic drop in white blood cells (panleukopenia). With virtually no \
                immune defenses remaining, the body becomes unable to fight off bacterial \
                infections, and sepsis (a life-threatening whole-body infection) rapidly follows.

                In pregnant cats, the virus can cross the placenta and infect developing kittens. \
                Kittens infected in the womb or shortly after birth may develop cerebellar \
                hypoplasia — a condition where the cerebellum (the part of the brain responsible \
                for balance and coordination) does not develop properly. Affected kittens often \
                survive but are left with permanent neurological signs including tremors and an \
                unsteady gait.

                **Transmission & Spread**
                Feline panleukopenia spreads through direct contact with an infected cat, or \
                through contact with contaminated feces, urine, bedding, food bowls, or other \
                objects. The virus is highly resilient and can survive in the environment for \
                up to a year. Humans can unknowingly carry the virus on hands, clothing, or \
                shoes and introduce it to unexposed cats. High-risk environments include \
                shelters, catteries, multi-cat households, and any setting with unvaccinated \
                cats. Recovered cats can shed the virus for several weeks after recovery.

                **Treatment Goals**
                There is no cure for feline panleukopenia — treatment is intensive supportive \
                care aimed at keeping the cat alive while their immune system recovers. \
                Veterinary treatment focuses on restoring and maintaining hydration, controlling \
                vomiting and nausea, and aggressively preventing or treating secondary bacterial \
                infections (sepsis). Even with prompt, aggressive treatment, outcomes are often \
                poor. Do not delay seeking veterinary care — early intervention gives the best \
                possible chance of survival.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 2–10 days. Initial signs include sudden lethargy, loss of appetite, and fever — gastrointestinal signs typically follow within 24 hours.",
                    delayed: "Vomiting and severe, often bloody diarrhea develop rapidly. Affected cats can deteriorate and die within 24–48 hours of symptom onset. Immediate veterinary care is critical."
                ),
                symptoms: [
                    "Sudden, severe lethargy",
                    "Complete loss of appetite",
                    "High fever (or low body temperature in severe cases)",
                    "Persistent vomiting",
                    "Severe diarrhea, often bloody",
                    "Rapid and severe dehydration",
                    "Hanging head over water bowl without drinking (a classic sign)",
                    "Abdominal pain",
                    "Neurological signs in kittens born to infected mothers (unsteady gait, tremors)",
                    "Collapse (severe cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Unvaccinated kittens under 6 months are most vulnerable, but unvaccinated cats of any age are at serious risk. Even with aggressive veterinary treatment, many cats do not survive. Immediate veterinary care is essential."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Ferrets are susceptible to feline parvovirus and can develop a similar life-threatening illness. Other small mammals are not considered at significant risk."
                    )
                ],
                preventionTips: [
                    "Vaccination is the most effective protection — follow your veterinarian's recommended schedule; kittens require a series of vaccines beginning at 6–8 weeks of age",
                    "Keep unvaccinated kittens strictly indoors and away from unknown cats or environments where cats have been",
                    "The virus survives in the environment for up to a year — disinfect with diluted bleach (1 part bleach to 32 parts water), one of the few agents effective against parvovirus",
                    "Isolate any cat showing signs of illness immediately — the virus spreads easily to other cats in the household",
                    "Recovered cats may shed the virus for several weeks — maintain hygiene precautions during this period",
                    "Wash hands and change clothing after handling unknown cats before contact with your own unvaccinated pets",
                    "Ferrets are susceptible — consult your veterinarian regarding appropriate vaccination protocols for ferrets"
                ],
                sources: [
                    "Veterinary Partner — Feline Panleukopenia",
                    "Merck Veterinary Manual — Feline Panleukopenia",
                    "Cornell University College of Veterinary Medicine — Feline Panleukopenia",
                    "AAFP Feline Vaccination Advisory Panel Guidelines"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000002"  // Canine Parvovirus — related parvovirus family
                ]
            ),

            // MARK: - Psittacosis (Parrot Fever)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000004")!,
                name: "Psittacosis (Parrot Fever)",
                alternateNames: ["parrot fever", "chlamydiosis", "avian chlamydiosis", "ornithosis", "chlamydia psittaci"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Psittacosis is a bacterial disease caused by Chlamydia psittaci that primarily affects birds but can also be transmitted to humans (zoonotic). It is most common in parrots, parakeets, cockatiels, and macaws but can affect any bird species.",
                toxicityInfo: "Chlamydia psittaci is spread through inhaling dried droppings, feather dust, or respiratory secretions from infected birds. Infected birds may carry the bacteria without showing symptoms, shedding it intermittently especially during stress. The bacteria attacks the respiratory system, liver, and spleen. This is a reportable disease in many jurisdictions due to its zoonotic potential.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period varies from days to weeks. Stress (new environment, breeding, overcrowding) often triggers clinical disease in carrier birds.",
                    delayed: "Chronic carriers may show intermittent signs over months. Without treatment, the disease can progress to severe systemic illness."
                ),
                symptoms: [
                    "Nasal discharge and sneezing",
                    "Difficulty breathing",
                    "Watery or lime-green droppings",
                    "Lethargy and ruffled feathers",
                    "Loss of appetite and weight loss",
                    "Eye inflammation (conjunctivitis)",
                    "Tremors (severe cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(species: .bird, severity: .high, notes: "Psittacines (parrots, cockatiels, budgies) are most commonly affected. Mortality can be high without treatment, but the disease responds well to antibiotics (typically doxycycline for 45 days). Carrier birds may shed bacteria without symptoms.")
                ],
                preventionTips: [
                    "Quarantine new birds for at least 30-45 days before introducing to other birds",
                    "Maintain good ventilation in bird housing areas",
                    "Clean cages regularly to prevent accumulation of dried droppings",
                    "Minimize stress factors like overcrowding and temperature extremes",
                    "Have new birds tested by an avian veterinarian",
                    "Wash hands after handling birds — this disease can spread to humans"
                ],
                sources: [
                    "Association of Avian Veterinarians",
                    "CDC - Psittacosis",
                    "Merck Veterinary Manual - Chlamydiosis in Birds"
                ],
                relatedEntries: nil
            ),

            // MARK: - Metabolic Bone Disease (MBD)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000005")!,
                name: "Metabolic Bone Disease (MBD)",
                alternateNames: ["MBD", "nutritional secondary hyperparathyroidism", "calcium deficiency", "metabolic bone disease reptile"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Metabolic Bone Disease is a common and serious condition in captive reptiles caused by inadequate calcium, improper calcium-to-phosphorus ratios, or insufficient UVB lighting. While not infectious, it is one of the most prevalent health conditions in pet reptiles and is entirely preventable with proper husbandry.",
                toxicityInfo: "MBD occurs when reptiles cannot properly metabolize calcium due to dietary deficiency, improper calcium:phosphorus ratio (should be 2:1), or lack of UVB light needed to produce vitamin D3. Without adequate calcium, the body draws it from bones, causing progressive skeletal weakening. Early stages are reversible with proper husbandry corrections, but advanced cases cause permanent deformity.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Early signs may appear within weeks to months of improper husbandry: lethargy, decreased appetite, and muscle twitching.",
                    delayed: "Without correction, progressive bone softening, deformities, pathological fractures, and organ damage develop over months."
                ),
                symptoms: [
                    "Lethargy and weakness",
                    "Muscle tremors and twitching",
                    "Soft or rubbery jaw",
                    "Swollen limbs or joints",
                    "Difficulty walking or climbing",
                    "Bowed legs or spinal deformities",
                    "Decreased appetite",
                    "Constipation"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Most common in bearded dragons, leopard geckos, chameleons, iguanas, and turtles/tortoises. Juveniles and rapidly growing reptiles are most vulnerable. Early-stage MBD is fully reversible. Advanced cases may cause permanent skeletal deformities or be fatal.")
                ],
                preventionTips: [
                    "Provide appropriate UVB lighting (replace bulbs every 6-12 months as UV output diminishes)",
                    "Dust feeder insects with calcium powder at every feeding for juveniles, every other feeding for adults",
                    "Maintain proper calcium:phosphorus ratio (2:1) in the diet",
                    "Offer dark leafy greens high in calcium (collard greens, mustard greens) for herbivorous species",
                    "Use calcium supplements with vitamin D3 if UVB access is limited",
                    "Have an annual veterinary checkup that includes evaluation for MBD"
                ],
                sources: [
                    "Association of Reptilian and Amphibian Veterinarians",
                    "Merck Veterinary Manual - Metabolic Bone Disease in Reptiles",
                    "Reptile Medicine and Surgery (Mader, 2nd Edition)"
                ],
                relatedEntries: nil
            ),

            // MARK: - Leptospirosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000006")!,
                name: "Leptospirosis",
                alternateNames: [
                    "lepto", "leptospira", "Weil's disease", "leptospiral infection",
                    "lepto infection", "leptospirosis in dogs", "field fever", "mud fever"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "leptospirosis_thumb",
                description: """
                Leptospirosis is a serious bacterial disease caused by spiral-shaped bacteria \
                of the genus Leptospira. It affects a wide range of mammals — including dogs, \
                wildlife, and humans — and is one of the most widespread zoonotic diseases in \
                the world, meaning it can be transmitted from animals to people.

                In dogs, leptospirosis primarily targets the kidneys and liver and can cause \
                life-threatening organ failure without prompt veterinary care. The disease can \
                progress rapidly — some dogs deteriorate quickly with little warning, while \
                others show a more gradual onset of illness. Outcomes are significantly better \
                with early veterinary intervention.

                Leptospirosis is spread through contact with water, soil, or mud contaminated \
                by the urine of infected animals. Rats and other wildlife are the primary \
                reservoir hosts — they carry and shed the bacteria continuously without becoming \
                ill themselves. Dogs that spend time outdoors, near bodies of water, in rural \
                areas, or in regions with high wildlife activity are at elevated risk, \
                particularly after flooding or heavy rainfall when bacteria are more widely \
                dispersed.

                The disease is found worldwide but is more common in warm, wet climates and \
                tropical regions. In North America, cases occur year-round but peak in late \
                summer and fall. Urban dogs are not immune — contact with rat urine in city \
                environments is a well-documented exposure route.

                Perhaps the most striking recent example of leptospirosis' reach: in the summer \
                of 2025, a record-breaking outbreak struck California sea lions along the central \
                and northern coast, with over 400 animals stranding sick between June and October \
                — the largest outbreak ever recorded. The bacteria spread among sea lions \
                congregating on beaches through urine-contaminated sand, and authorities warned \
                dog owners to keep pets leashed and at least 150 feet from any marine mammals. \
                A dog that sniffs, licks, or rolls near an infected sea lion or contaminated sand \
                can be exposed. The outbreak was a vivid reminder that leptospirosis is not just \
                a rural or wildlife disease — it can appear anywhere animals gather.

                A vaccine is available for dogs and is strongly recommended for those with \
                outdoor exposure, waterside activity, or wildlife contact. The vaccine targets \
                the most common serovars (strains) but does not provide complete protection \
                against all strains — vaccinated dogs can still be infected by uncommon serovars.
                """,
                toxicityInfo: """
                **How It Harms the Body**
                After entering the body — typically through mucous membranes, cuts in the skin, \
                or ingestion of contaminated water — Leptospira bacteria spread through the \
                bloodstream to the kidneys and liver, where they cause inflammation and direct \
                cellular damage. In the kidneys, this leads to acute kidney injury (sudden loss \
                of kidney function), which can become severe enough to require dialysis-level \
                supportive care. Liver damage causes jaundice (yellowing of the skin, eyes, and \
                gums) and disrupts the liver's ability to manage toxins and produce essential \
                proteins.

                In severe cases, leptospirosis can cause systemic bleeding disorders — the \
                bacteria trigger widespread inflammation that disrupts the normal clotting \
                process, leading to bleeding into the lungs, gut, or other tissues. Pulmonary \
                hemorrhage syndrome (severe bleeding into the lungs) is a particularly dangerous \
                complication and can develop rapidly.

                The severity of disease depends on which serovar (strain) of Leptospira is \
                involved, the size and health of the dog, and how quickly treatment is initiated.

                **Transmission & Spread**
                The primary source of infection is urine from infected animals — most commonly \
                rats, mice, raccoons, skunks, opossums, and other wildlife that serve as \
                long-term reservoir hosts without becoming ill themselves. Bacteria are shed into \
                the environment through urine and can survive for weeks to months in warm, moist \
                soil and standing water.

                Dogs most commonly become infected by swimming in, drinking from, or wading \
                through contaminated water (lakes, ponds, puddles, flooded areas), contact with \
                contaminated soil or mud, direct contact with an infected animal or its urine, \
                or hunting and scavenging infected wildlife.

                Cats can be exposed and may test seropositive (showing evidence of past \
                exposure), but they rarely develop significant clinical disease. They are not \
                considered a major clinical risk but owners of infected cats should still \
                exercise hygiene precautions.

                Leptospirosis is zoonotic — it can be transmitted from infected animals to \
                humans. People most commonly become infected through contact with the urine of \
                an infected animal or urine-contaminated water, soil, or surfaces. If your pet \
                has been diagnosed with leptospirosis, take precautions when handling them — \
                particularly when handling their urine or cleaning up after them — and contact \
                your own physician if you have concerns about your own exposure. Individuals who \
                are immunocompromised, pregnant, elderly, or very young may be at greater risk \
                and should take extra precautions.

                **Treatment Goals**
                Veterinary treatment focuses on controlling the bacterial infection, supporting \
                kidney and liver function, maintaining hydration and electrolyte balance, and \
                managing any complications such as bleeding disorders or respiratory involvement. \
                Early hospitalization significantly improves outcomes — dogs that receive prompt, \
                aggressive supportive care have a much better chance of recovery than those where \
                treatment is delayed. Even after apparent recovery, some dogs may have residual \
                kidney damage that requires long-term management.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "2–12 days after exposure (typically 5–7 days)",
                    delayed: "Kidney or liver failure may develop days after initial signs appear; some dogs progress rapidly without obvious early illness"
                ),
                symptoms: [
                    "Sudden lethargy and weakness",
                    "Loss of appetite",
                    "Vomiting",
                    "Increased thirst and urination — or conversely, reduced or absent urination (sign of kidney failure)",
                    "Abdominal pain — dog may be reluctant to move or adopt a hunched posture",
                    "Jaundice — yellowing of the gums, whites of the eyes, or skin",
                    "Fever",
                    "Muscle pain or stiffness — dog may be reluctant to move",
                    "Diarrhea (sometimes bloody)",
                    "Bleeding from the nose or mouth, or blood in urine — sign of clotting disorder; seek emergency care immediately",
                    "Difficulty breathing — sign of lung involvement; seek emergency care immediately"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Primary companion animal species affected. Can cause life-threatening acute kidney injury and liver failure. Rapid progression possible in some cases. Vaccine available but serovar-specific — does not protect against all strains."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Rats and mice are natural reservoir hosts — they carry and shed Leptospira chronically without becoming ill. Guinea pigs and hamsters are susceptible to clinical disease. Ferrets can be infected; limited but documented case reports. Rabbits can be exposed; clinical disease less commonly reported."
                    )
                ],
                preventionTips: [
                    "Vaccination is the most important preventive measure for dogs with outdoor exposure. The leptospirosis vaccine is recommended for dogs that spend time near water, in rural or wooded areas, or in regions with high wildlife activity. Ask your veterinarian whether the vaccine is appropriate for your dog.",
                    "The vaccine targets the most common serovars (strains) of Leptospira but does not protect against all strains. Vaccinated dogs can still be infected by less common serovars — vaccination reduces risk but does not eliminate it entirely.",
                    "Prevent dogs from drinking from, swimming in, or wading through stagnant water, ponds, puddles, or flooded areas — especially after heavy rain when bacteria are more widely dispersed.",
                    "Discourage contact with wildlife and control rodent populations around your home. Rats and mice are the primary reservoir hosts and shed bacteria continuously through their urine.",
                    "If visiting beaches where sea lions or other marine mammals are present, keep dogs leashed and maintain at least 150 feet of distance from any marine mammal — alive or dead. Urine-contaminated sand near haul-out areas is a known exposure risk, as highlighted by the record 2025 California sea lion outbreak.",
                    "Leptospirosis is a zoonotic disease — it can be transmitted from infected animals to humans. If your pet is diagnosed with leptospirosis, wear gloves when handling them or cleaning up their urine, wash hands thoroughly afterward, and contact your physician if you have concerns about your own exposure.",
                    "Be aware that urban dogs are not immune — contact with rat urine in city environments is a well-documented exposure route, particularly in areas with high rodent activity.",
                    "Leptospirosis is a reportable disease in many jurisdictions. Your veterinarian will advise on any reporting requirements and on precautions to take within your household."
                ],
                sources: [
                    "Merck Veterinary Manual — Leptospirosis",
                    "Veterinary Partner — Leptospirosis in Dogs",
                    "Cornell University College of Veterinary Medicine — Leptospirosis",
                    "Centers for Disease Control and Prevention (CDC) — Leptospirosis",
                    "American Animal Hospital Association (AAHA) — Canine Vaccination Guidelines"
                ],
                relatedEntries: nil
            ),

            // MARK: - Myxomatosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000007")!,
                name: "Myxomatosis",
                alternateNames: [
                    "myxoma", "myxoma virus", "rabbit myxomatosis", "myxomatosis virus",
                    "myxo", "rabbit plague"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "myxomatosis_thumb",
                description: """
                Myxomatosis is a severe and often fatal viral disease caused by the Myxoma virus, \
                a poxvirus that affects domestic and wild European rabbits. The disease causes \
                widespread swelling of the skin, eyes, and mucous membranes, and rapidly progresses \
                to systemic illness affecting multiple organ systems.

                In unvaccinated rabbits, myxomatosis carries a grave prognosis — most unvaccinated \
                rabbits who develop the full-blown disease do not survive, even with intensive \
                veterinary care. Rabbits that do survive face a prolonged and difficult recovery.

                The disease is widespread in the United Kingdom, Europe, and Australia, where it \
                was deliberately introduced in the 1950s to control wild rabbit populations. In \
                North America, myxomatosis occurs in wild brush rabbits and cottontails in parts \
                of the western United States and Canada, but domestic rabbits in North America \
                remain at risk, particularly those with outdoor access. The disease is not found \
                in all regions — rabbit owners should consult their veterinarian about local risk.

                A vaccine is available in the UK and Europe and is strongly recommended for all \
                pet rabbits in affected regions. No myxomatosis vaccine is currently licensed for \
                use in the United States or Canada.

                Myxomatosis affects rabbits only. Dogs, cats, birds, reptiles, and other small \
                mammals are not susceptible.
                """,
                toxicityInfo: """
                **How It Harms the Body**
                The Myxoma virus spreads through the body after initial infection, targeting cells \
                throughout the skin, mucous membranes, and immune system. The virus causes the \
                formation of mucinous tumors (myxomas) — soft, jelly-like swellings — that appear \
                first at the site of infection and then spread across the face, eyes, ears, nose, \
                and genitals. Severe swelling around the eyes can cause the rabbit to become \
                completely unable to see.

                As infection progresses, the virus suppresses the immune system, leaving the rabbit \
                unable to mount an effective defense against the virus itself or against secondary \
                bacterial infections. Respiratory involvement — congestion, labored breathing, and \
                pneumonia — is common in the later stages and is frequently the cause of death. The \
                combination of immune suppression, secondary infection, and multi-organ involvement \
                makes recovery without aggressive veterinary intervention extremely unlikely in \
                unvaccinated rabbits.

                A less common respiratory (atypical) form of myxomatosis exists in which skin \
                lesions are mild or absent, but respiratory signs and immune suppression are still \
                severe. This form can be harder to recognize and carries an equally grave prognosis.

                **Transmission & Spread**
                Myxomatosis is transmitted primarily by biting insects — most commonly rabbit fleas \
                and mosquitoes — that carry the virus from infected wild or domestic rabbits to \
                healthy ones. Direct contact with an infected rabbit, or contact with contaminated \
                bedding, hutches, or equipment, can also spread the disease. The virus can persist \
                in the environment for a period of time, and hutches or equipment used by infected \
                rabbits should be thoroughly disinfected before introducing a new rabbit.

                Outdoor rabbits are at the greatest risk because of exposure to mosquitoes, fleas, \
                and contact with wild rabbits. However, indoor rabbits are not entirely protected \
                — mosquitoes can enter homes, and fleas can be introduced by other pets. In regions \
                where myxomatosis is endemic, even well-cared-for indoor rabbits can be at risk.

                Myxomatosis does not spread from rabbits to humans or to other pet species.

                **Treatment Goals**
                There is no antiviral treatment that directly targets the Myxoma virus. Veterinary \
                care focuses on providing supportive care to keep the rabbit as comfortable as \
                possible, managing secondary bacterial infections, maintaining nutrition and \
                hydration, and controlling pain. In mild or early-stage cases in otherwise healthy \
                rabbits, intensive supportive care can occasionally result in recovery, but outcomes \
                in unvaccinated rabbits with full systemic disease are very poor even with treatment. \
                Euthanasia may be the most humane option in severe cases — this is a decision made \
                in consultation with a veterinarian based on the individual rabbit's condition.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "1–6 days (initial skin nodule and eye swelling)",
                    delayed: "Full systemic disease develops within 1–2 weeks; death can occur within 10–14 days in unvaccinated rabbits"
                ),
                symptoms: [
                    "Soft, raised skin swellings or nodules — often appearing first around the face, eyes, or genitals",
                    "Swollen, puffy eyelids — can progress to eyes swelling completely shut",
                    "Thick discharge from the eyes and nose",
                    "Swelling around the ears, lips, nose, and genital area",
                    "Lethargy and loss of appetite",
                    "Labored or noisy breathing",
                    "High fever",
                    "Hunched posture",
                    "Inability to see due to severe eye swelling",
                    "In the atypical (respiratory) form: breathing difficulty may appear without obvious skin swellings"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Affects domestic and wild European rabbits only. Other small mammals including guinea pigs, hamsters, rats, mice, ferrets, and chinchillas are not susceptible. Unvaccinated rabbits that develop systemic disease have a very poor chance of survival even with intensive veterinary care."
                    )
                ],
                preventionTips: [
                    "In the UK and Europe, vaccination is the single most effective preventive measure and is strongly recommended for all pet rabbits. Follow your veterinarian's recommended vaccination schedule.",
                    "No myxomatosis vaccine is currently licensed in the United States or Canada. Rabbit owners in North America should focus on reducing insect exposure and contact with wild rabbits.",
                    "Minimize mosquito and flea exposure. Use veterinarian-approved flea prevention on household dogs and cats that may bring fleas indoors. Mosquito netting over outdoor hutches can help reduce exposure.",
                    "Keep rabbits away from wild rabbits, which can carry the virus without showing obvious signs of illness.",
                    "Outdoor rabbits are at significantly higher risk than indoor rabbits. Consider housing rabbits indoors or providing screened outdoor enclosures, particularly during peak mosquito season.",
                    "If a rabbit has been diagnosed with myxomatosis, disinfect all hutches, bedding, bowls, and equipment thoroughly before housing another rabbit in the same space.",
                    "Any rabbit showing facial swelling, eye discharge, or skin nodules should be evaluated by a veterinarian immediately — early intervention gives the best chance of survival."
                ],
                sources: [
                    "Merck Veterinary Manual — Myxomatosis",
                    "Veterinary Partner — Myxomatosis in Rabbits",
                    "House Rabbit Society — Myxomatosis",
                    "RSPCA (UK) — Myxomatosis in Rabbits"
                ],
                relatedEntries: nil
            ),

            // MARK: - Kennel Cough (CIRDC)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000008")!,
                name: "Kennel Cough (CIRDC)",
                alternateNames: [
                    "kennel cough", "CIRDC", "canine infectious respiratory disease complex",
                    "canine infectious tracheobronchitis", "Bordetella", "bordetellosis",
                    "kennel hack", "dog cough", "ITB"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "cirdc_thumb",
                description: """
                Kennel Cough — now more accurately called Canine Infectious Respiratory Disease \
                Complex (CIRDC) — is a highly contagious respiratory illness in dogs caused not \
                by a single pathogen, but by a combination of viruses and bacteria acting together. \
                The most well-known agent is Bordetella bronchiseptica, but canine parainfluenza \
                virus, canine adenovirus type 2, and several other pathogens are frequently involved \
                simultaneously.

                In otherwise healthy adult dogs, CIRDC is typically a self-limiting illness — \
                uncomfortable, but not life-threatening. However, it can progress to serious \
                pneumonia in puppies, senior dogs, immunocompromised animals, and brachycephalic \
                breeds (flat-faced breeds such as Bulldogs and Pugs). Dogs in high-density \
                environments — boarding kennels, shelters, dog parks, grooming facilities, and \
                training classes — are at greatest risk of exposure.

                Vaccines targeting several CIRDC pathogens are available, but because the complex \
                involves multiple agents, vaccination reduces severity and spread rather than \
                guaranteeing complete protection. Any dog showing respiratory signs warrants \
                veterinary evaluation, as even apparently mild cases can progress — and high-risk \
                dogs can deteriorate quickly.
                """,
                toxicityInfo: """
                **How It Harms the Body**
                CIRDC pathogens target the ciliated respiratory epithelium — the protective lining \
                of the airways made up of cells with tiny hair-like projections that continuously \
                sweep debris and pathogens out of the respiratory tract. When these cells are \
                damaged or destroyed, the airways lose a critical layer of defense, creating an \
                opening for secondary bacterial infections to take hold. The result is inflammation \
                and irritation throughout the trachea (windpipe) and bronchi (the airways leading \
                into the lungs), producing the characteristic harsh, persistent cough.

                In most healthy adult dogs, the immune system mounts an effective response and \
                recovery occurs within 1–3 weeks. In vulnerable animals — puppies with immature \
                immune systems, senior dogs, immunocompromised individuals, and brachycephalic \
                breeds whose airway anatomy already limits respiratory reserve — the infection can \
                spread deeper into the lungs and cause pneumonia (infection of the lung tissue \
                itself). Pneumonia is a serious complication that can become life-threatening \
                without prompt veterinary care.

                **Transmission & Spread**
                CIRDC spreads efficiently through direct contact with infected dogs, airborne \
                respiratory droplets from coughing or sneezing, and contact with contaminated \
                surfaces such as shared water bowls, food dishes, bedding, leashes, and handlers' \
                hands. Pathogens can survive on surfaces for hours to days depending on conditions.

                Infected dogs can begin shedding pathogens and spreading the disease before they \
                show any visible signs of illness — making containment in group settings difficult. \
                After recovery, dogs may continue to shed Bordetella bronchiseptica for up to 3 \
                months. High-risk settings include boarding kennels, animal shelters, dog parks, \
                grooming facilities, training classes, and veterinary clinics where multiple dogs \
                are present.

                Bordetella bronchiseptica can also infect cats (particularly in shelter \
                environments) and small mammals such as rabbits and guinea pigs. Notably, \
                guinea pigs can carry and shed Bordetella bronchiseptica without showing any \
                signs of illness themselves — meaning a healthy-appearing guinea pig in the \
                home can be a source of infection for dogs in the same household.

                **Treatment Goals**
                For mild cases in healthy adult dogs, veterinary care focuses on rest, monitoring, \
                and supportive management to keep the dog comfortable while the immune system clears \
                the infection. For moderate to severe cases — or any case involving a high-risk dog \
                — treatment goals expand to managing airway inflammation, addressing secondary \
                bacterial infections, and supporting respiratory function. Dogs developing signs of \
                pneumonia require prompt, more intensive intervention. Even dogs that initially \
                appear mildly affected should be evaluated by a veterinarian, as severity can \
                escalate and the appropriate course of care varies depending on the individual animal.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "2–14 days after exposure (typically 3–7 days)",
                    delayed: "Pneumonia may develop days after initial symptom onset, especially in high-risk individuals"
                ),
                symptoms: [
                    "Forceful, persistent cough — often described as a goose-honk sound",
                    "Retching or gagging after coughing episodes",
                    "Nasal discharge (clear, white, or yellow)",
                    "Sneezing",
                    "Eye discharge",
                    "Mild lethargy",
                    "Reduced appetite",
                    "Fever (more common with severe disease or pneumonia)",
                    "Rapid or labored breathing — sign of possible pneumonia; seek emergency care immediately"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Primary species. Typically self-limiting and managed outpatient in healthy adult dogs. Puppies, senior dogs, immunocompromised animals, and brachycephalic breeds are at higher risk of progression to pneumonia."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .low,
                        notes: "Bordetella bronchiseptica can cause upper respiratory illness in cats, particularly in shelter or multi-cat environments. Generally less severe than in dogs."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Rabbits and guinea pigs are susceptible to Bordetella bronchiseptica and can develop serious respiratory disease. Guinea pigs can also carry and shed the bacteria asymptomatically — a healthy-appearing guinea pig in the home can be a source of infection for dogs."
                    )
                ],
                preventionTips: [
                    "Vaccination is the most important preventive measure. Vaccines against several CIRDC pathogens — including Bordetella, parainfluenza, and adenovirus type 2 — are available in intranasal, oral, and injectable forms. Ask your veterinarian which is most appropriate for your dog.",
                    "Because CIRDC involves multiple pathogens, vaccination reduces severity and spread but does not guarantee complete protection. Vaccinated dogs can still contract the illness.",
                    "The Bordetella vaccine is especially important for dogs that frequently visit kennels, groomers, dog parks, training classes, or other high-contact environments. Many facilities require it.",
                    "Avoid exposing unvaccinated puppies, senior dogs, or immunocompromised dogs to high-density environments where respiratory disease risk is elevated.",
                    "Isolate any dog showing signs of coughing, nasal discharge, or other respiratory illness from other household pets and avoid dog parks or group settings until cleared by a veterinarian.",
                    "Disinfect shared items including water bowls, food dishes, bedding, and leashes. Most common household disinfectants are effective against CIRDC pathogens.",
                    "Recovered dogs may continue to shed Bordetella for up to 3 months after symptoms resolve — keep this in mind before reintroducing a recently ill dog to other animals."
                ],
                sources: [
                    "Merck Veterinary Manual — Infectious Tracheobronchitis (Kennel Cough)",
                    "Veterinary Partner — Kennel Cough",
                    "Cornell University College of Veterinary Medicine — Kennel Cough",
                    "American Animal Hospital Association (AAHA) — Canine Vaccination Guidelines"
                ],
                relatedEntries: nil
            ),
        ]
    }
}
