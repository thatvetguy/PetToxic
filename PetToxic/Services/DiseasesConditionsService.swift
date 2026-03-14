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
                entrySeverity: .severe,
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
                alternateNames: ["parvo", "parvovirus", "CPV", "CPV-2", "canine parvo"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Canine parvovirus is a highly contagious viral disease that attacks rapidly dividing cells, particularly in the intestinal lining, bone marrow, and lymph nodes. It is one of the most serious diseases affecting unvaccinated puppies and dogs.",
                toxicityInfo: "Parvovirus is extremely resilient in the environment, surviving on surfaces for months to years. It spreads through direct contact with infected dogs or contaminated feces, environments, or objects. The virus destroys the intestinal lining, causing severe bloody diarrhea, vomiting, and dehydration. It also suppresses the immune system by attacking bone marrow, making secondary infections common and often fatal.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 3-7 days. Initial signs include lethargy, loss of appetite, and fever.",
                    delayed: "Severe vomiting and bloody diarrhea develop within 24-48 hours of initial signs. Without treatment, death can occur within 48-72 hours."
                ),
                symptoms: [
                    "Severe, often bloody diarrhea",
                    "Persistent vomiting",
                    "Lethargy and depression",
                    "Loss of appetite",
                    "Fever or subnormal temperature",
                    "Rapid dehydration",
                    "Abdominal pain"
                ],
                entrySeverity: .severe,
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Puppies between 6 weeks and 6 months are most vulnerable. Certain breeds (Rottweilers, Dobermans, Pit Bulls, German Shepherds) may be at higher risk. Mortality rate is 90% without treatment, reduced to 10-20% with aggressive veterinary care.")
                ],
                preventionTips: [
                    "Follow your veterinarian's recommended vaccination schedule — puppies need a series of vaccines",
                    "Avoid exposing unvaccinated puppies to public areas, dog parks, or unknown dogs",
                    "Clean contaminated areas with diluted bleach (1:32 ratio) — one of the few disinfectants effective against parvo",
                    "Isolate infected dogs immediately and for at least 2 weeks after recovery",
                    "Recovered dogs can shed the virus for up to 6 weeks"
                ],
                sources: [
                    "AVMA - Canine Parvovirus",
                    "Merck Veterinary Manual - Canine Parvovirus",
                    "Cornell University College of Veterinary Medicine"
                ],
                relatedEntries: nil
            ),

            // MARK: - Feline Panleukopenia
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000003")!,
                name: "Feline Panleukopenia (Feline Distemper)",
                alternateNames: ["feline distemper", "feline parvo", "FPV", "panleukopenia", "cat distemper"],
                categories: [.diseasesAndConditions],
                imageAsset: nil,
                description: "Feline panleukopenia is a highly contagious and often fatal viral disease in cats caused by feline parvovirus (FPV). It attacks rapidly dividing cells in the bone marrow, intestines, and developing fetuses. It is one of the core vaccines for all cats.",
                toxicityInfo: "FPV is extremely hardy in the environment, surviving for over a year on contaminated surfaces. The virus causes severe depletion of white blood cells (panleukopenia), destroying the immune system's ability to fight infection. It also damages the intestinal lining, causing severe diarrhea and dehydration. In pregnant cats, it can cause cerebellar hypoplasia in kittens.",
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is 2-7 days. Early signs include fever (up to 105°F), depression, and loss of appetite.",
                    delayed: "Severe vomiting and diarrhea develop 1-2 days after initial signs. Kittens can deteriorate rapidly and die within 12 hours."
                ),
                symptoms: [
                    "Severe vomiting",
                    "Watery or bloody diarrhea",
                    "High fever followed by subnormal temperature",
                    "Severe dehydration",
                    "Complete loss of appetite",
                    "Depression and lethargy",
                    "Tucked abdomen from pain"
                ],
                entrySeverity: .severe,
                speciesRisks: [
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Kittens 3-5 months old are most severely affected, with mortality rates up to 90% in unvaccinated kittens. Adult cats may have milder disease. Vaccination is highly effective and considered a core vaccine for all cats.")
                ],
                preventionTips: [
                    "Vaccinate all cats — FVRCP is a core vaccine that protects against panleukopenia",
                    "Keep unvaccinated kittens indoors and away from other cats until fully vaccinated",
                    "Disinfect with diluted bleach (1:32) — the virus is resistant to most common disinfectants",
                    "Quarantine new cats for at least 2 weeks before introducing to resident cats",
                    "Recovered cats can shed virus for up to 6 weeks"
                ],
                sources: [
                    "Cornell Feline Health Center - Feline Panleukopenia",
                    "AVMA - Feline Panleukopenia",
                    "Merck Veterinary Manual - Feline Panleukopenia"
                ],
                relatedEntries: nil
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
                entrySeverity: .high,
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
                entrySeverity: .high,
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
                entrySeverity: .severe,
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
                entrySeverity: .severe,
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
                entrySeverity: .moderate,
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
