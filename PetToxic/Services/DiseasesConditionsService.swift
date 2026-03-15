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
                alternateNames: ["lepto", "leptospira", "weil's disease", "rat urine disease"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Leptospirosis is a bacterial disease caused by Leptospira species that can affect dogs and other mammals, including humans. It is spread through contact with infected urine or contaminated water, soil, or food. It is a significant zoonotic disease.",
                toxicityInfo: "Leptospira bacteria enter through mucous membranes or broken skin, then spread through the bloodstream to the kidneys and liver. The bacteria cause damage to these organs through direct invasion and inflammatory responses. Severity ranges from subclinical infection to fatal organ failure. Risk increases with exposure to standing water, wildlife, and livestock.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 2-12 days. Early signs include fever, lethargy, loss of appetite, and muscle stiffness.",
                    delayed: "Kidney and/or liver failure may develop 1-2 weeks after infection. Some dogs develop chronic kidney disease after recovery."
                ),
                symptoms: [
                    "Fever and muscle pain",
                    "Vomiting and diarrhea",
                    "Loss of appetite and lethargy",
                    "Increased thirst and urination (progressing to decreased urination)",
                    "Jaundice (yellowing of skin, gums, eyes)",
                    "Difficulty breathing",
                    "Bleeding disorders (severe cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are the most commonly affected domestic species. Risk is highest for dogs with outdoor exposure, especially near standing water or wildlife. Vaccination is available and recommended for at-risk dogs. Without treatment, mortality is significant.")
                ],
                preventionTips: [
                    "Vaccinate at-risk dogs — discuss the leptospirosis vaccine with your veterinarian",
                    "Avoid letting dogs drink from or swim in stagnant water, ponds, or puddles",
                    "Control rodent populations around your property",
                    "Wear gloves when handling potentially contaminated water or soil",
                    "This disease can spread to humans — seek medical attention if you suspect exposure"
                ],
                sources: [
                    "AVMA - Leptospirosis",
                    "CDC - Leptospirosis",
                    "Merck Veterinary Manual - Leptospirosis"
                ],
                relatedEntries: nil
            ),

            // MARK: - Myxomatosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000007")!,
                name: "Myxomatosis",
                alternateNames: ["myxo", "myxoma virus", "rabbit myxomatosis"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Myxomatosis is a severe and usually fatal viral disease of rabbits caused by the Myxoma virus. It is spread by biting insects (mosquitoes, fleas) and direct contact with infected rabbits. It is endemic in wild rabbit populations in many regions.",
                toxicityInfo: "The Myxoma virus causes severe swelling of the mucous membranes, skin, and internal organs. It suppresses the immune system, leading to secondary bacterial infections that often cause death. Mortality in domestic rabbits is extremely high (over 99% in naive populations). The virus is primarily transmitted by fleas, mosquitoes, and other biting insects, though direct contact and fomites can also spread it.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 1-14 days (typically 5-6 days). Early signs include puffy, swollen eyelids, lethargy, fever, and loss of appetite.",
                    delayed: "Severe swelling of head, ears, and genitals develops over days. Secondary infections lead to pneumonia. Most rabbits die within 10-14 days of symptom onset."
                ),
                symptoms: [
                    "Swollen, puffy eyelids (often the first sign)",
                    "Discharge from eyes and nose",
                    "Swelling of ears, nose, lips, and genitals",
                    "High fever",
                    "Lethargy and loss of appetite",
                    "Difficulty breathing",
                    "Skin lumps and nodules"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Affects rabbits almost exclusively. Mortality in pet rabbits is extremely high (over 99%). Vaccination is available in some countries (UK, Europe, Australia) but NOT currently approved in the US. Prevention focuses on insect control and limiting outdoor exposure.")
                ],
                preventionTips: [
                    "Use insect screens on outdoor rabbit enclosures to prevent mosquito and fly bites",
                    "Apply rabbit-safe flea prevention (consult your veterinarian — many flea products are toxic to rabbits)",
                    "Vaccinate where available (UK, Europe, Australia — not currently available in the US)",
                    "Avoid contact with wild rabbits",
                    "Bring outdoor rabbits inside during peak mosquito hours (dawn and dusk)"
                ],
                sources: [
                    "Rabbit Welfare Association & Fund",
                    "Merck Veterinary Manual - Myxomatosis",
                    "House Rabbit Society"
                ],
                relatedEntries: nil
            ),

            // MARK: - Kennel Cough (Canine Infectious Respiratory Disease Complex)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000008")!,
                name: "Kennel Cough",
                alternateNames: ["canine infectious tracheobronchitis", "Bordetella", "CIRDC", "dog cough", "canine cough"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Kennel cough is a highly contagious respiratory disease complex caused by multiple bacteria and viruses, most commonly Bordetella bronchiseptica and canine parainfluenza virus. It is spread through airborne droplets, direct contact, or contaminated surfaces, and commonly occurs where dogs are in close quarters.",
                toxicityInfo: "Kennel cough involves inflammation of the upper airways (trachea and bronchi). Multiple pathogens can be involved simultaneously. While usually self-limiting in healthy adult dogs, it can progress to pneumonia in puppies, elderly dogs, or immunocompromised animals. The characteristic 'honking' cough is caused by tracheal inflammation.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 2-14 days. A persistent dry, honking cough develops first, often triggered by excitement or pulling on a leash.",
                    delayed: "Most cases resolve within 1-3 weeks. Complicated cases (pneumonia) may develop 1-2 weeks after initial signs, especially in young or immunocompromised dogs."
                ),
                symptoms: [
                    "Persistent dry, honking cough",
                    "Retching or gagging after coughing",
                    "Nasal discharge (clear to mucoid)",
                    "Mild lethargy",
                    "Decreased appetite (mild cases)",
                    "Fever (if secondary infection develops)",
                    "Difficulty breathing (severe/complicated cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Very common in dogs exposed to boarding facilities, dog parks, grooming salons, and shelters. Usually self-limiting in healthy adults (1-3 weeks). Puppies and senior dogs are at higher risk for complications like pneumonia. Vaccination (Bordetella) reduces severity but does not prevent all cases.")
                ],
                preventionTips: [
                    "Vaccinate dogs that will be boarded, groomed, or attend dog parks or daycare",
                    "Ensure boarding facilities require proof of vaccination",
                    "Avoid dog parks and communal areas if outbreaks are reported in your area",
                    "If your dog develops a cough, isolate from other dogs and contact your veterinarian",
                    "Maintain good nutrition and overall health to support immune function"
                ],
                sources: [
                    "AVMA - Kennel Cough",
                    "Merck Veterinary Manual - Canine Infectious Tracheobronchitis",
                    "AKC - Kennel Cough in Dogs"
                ],
                relatedEntries: nil
            ),
        ]
    }
}
