import Foundation

class DiseasesConditionsService {
    static let shared = DiseasesConditionsService()

    let entries: [ToxicItem]

    private init() {
        entries = Self.loadEntries()
    }

    /// Returns entries that apply to the given species.
    /// Excludes entries where the species risk severity is .low to reduce clutter —
    /// those entries are still accessible via other species groups where the risk is higher.
    func entries(for species: Species) -> [ToxicItem] {
        entries.filter { item in
            item.speciesRisks.contains { $0.species == species && $0.severity != .low }
        }
    }

    // MARK: - Entry Type Classification

    /// UUIDs of non-infectious entries (Type 2: Husbandry, Type 3: Medical/Metabolic)
    private static let nonInfectiousEntryIDs: Set<String> = [
        "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
        "1D000001-0000-0000-0000-000000000009",  // Thermal Burns
        "1D000001-0000-0000-0000-000000000010",  // Dysecdysis (Abnormal Shedding)
        "1D000001-0000-0000-0000-000000000038",  // GI Stasis in Rabbits
        "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
        "1D000001-0000-0000-0000-000000000040",  // Shell Rot
        "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
        "1D000001-0000-0000-0000-000000000043",  // Reptile Husbandry Guide
        "1D000001-0000-0000-0000-000000000044",  // Bird Husbandry Guide
        "1D000001-0000-0000-0000-000000000045",  // Small Mammal Husbandry Guide
    ]

    /// Whether an entry is an infectious disease (Type 1)
    func isInfectious(_ item: ToxicItem) -> Bool {
        !Self.nonInfectiousEntryIDs.contains(item.id.uuidString)
    }

    // MARK: - Disease Data

    private static func loadEntries() -> [ToxicItem] {
        [
            // MARK: - Rabies
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000001")!,
                name: "Rabies",
                alternateNames: [
                    "rabies virus", "lyssavirus", "hydrophobia", "lyssa", "rabid",
                    "rabies infection", "rabies exposure", "furious rabies",
                    "dumb rabies", "paralytic rabies"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "rabies_thumb",
                description: """
                Rabies is a viral disease of the central nervous system caused by the \
                Lyssavirus — a virus that specifically targets the brain and spinal cord. \
                It is one of the oldest and most feared infectious diseases in the world. \
                Once clinical signs appear in any mammal, survival is virtually unknown. \
                There are fewer than a dozen documented survivors of clinical rabies in \
                recorded medical history.

                Rabies is vaccine-preventable, and vaccination is the single most important \
                protection available for your pet. This disease is also zoonotic — it can be \
                transmitted from infected animals to humans.

                In North America, the primary wildlife reservoirs are bats, raccoons, skunks, \
                and foxes. Among domestic animals, cats are the most commonly reported rabid \
                domestic animal in the United States — a fact that surprises many pet owners. \
                Ferrets are susceptible and have an approved rabies vaccine available.

                Rabies is a legally reportable disease in most jurisdictions. If your pet has \
                been bitten by a wild animal or an animal of unknown vaccination status, \
                contact a veterinarian immediately — quarantine and observation protocols may \
                be legally required, regardless of your pet's vaccination status.

                Many countries — including the United Kingdom, Australia, Japan, and New \
                Zealand — are considered rabies-free or have eliminated the classical dog \
                rabies virus strain. North America, much of Europe, Asia, Africa, and Latin \
                America remain endemic.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                The rabies virus is neurotropic — meaning it specifically targets nervous \
                tissue. After entering the body through a bite wound (or, rarely, through \
                mucous membrane contact with infected saliva), the virus binds to nerve \
                endings at the wound site and begins traveling along peripheral nerves toward \
                the brain. It does not travel through the bloodstream, which is part of what \
                makes it so difficult to detect or treat once infection is established.

                Once the virus reaches the brain, it causes rapidly progressive encephalitis \
                (severe inflammation of the brain), disrupting the functions that control \
                behavior, coordination, swallowing, and eventually all basic life functions.

                Two clinical forms are recognized. The furious form is more commonly depicted \
                in media — characterized by extreme aggression, agitation, and erratic \
                behavior. The paralytic (dumb) form is less dramatic but equally deadly — \
                animals become progressively weak, lose the ability to swallow, and develop \
                ascending paralysis (paralysis that moves up the body from the limbs toward \
                the chest and head). Both forms are fatal. Individual animals may show signs \
                of one, the other, or both.

                **Transmission & Spread**

                Rabies is almost exclusively transmitted through the saliva of an infected \
                animal — typically through a bite wound that breaks the skin. Transmission \
                through intact skin is not considered a risk; however, contact between \
                infected saliva and mucous membranes (eyes, nose, mouth) or open wounds \
                does carry risk.

                The incubation period — the time from exposure to the appearance of clinical \
                signs — is highly variable. In most pets, signs develop within 2 weeks to 3 \
                months, but cases with incubation periods as short as a few days or as long \
                as a year have been documented. The length of incubation depends on the \
                location of the bite (bites closer to the brain progress faster), the amount \
                of virus introduced, and the species affected.

                Major wildlife reservoirs in North America include bats (the #1 source of \
                human rabies exposure in the US — bat bites can be extremely small and may \
                go unnoticed), raccoons (most common in the eastern US), skunks (most common \
                in the central US and California), foxes (more common in Alaska and parts of \
                the southwest), and coyotes (lower risk but documented). Stray, unvaccinated \
                domestic dogs remain the primary global source of human rabies deaths \
                worldwide, particularly in parts of Asia and Africa.

                Any direct contact with a bat — including finding a bat in a room where a \
                person was sleeping — warrants evaluation for both the people and any pets \
                in the home.

                **Treatment Goals**

                There is no effective treatment for rabies once clinical signs appear in any \
                species. Once the virus reaches the brain and symptoms develop, the disease \
                is virtually always fatal. Veterinary care at that stage is focused on humane \
                management.

                The critical window is before clinical signs develop. Post-exposure protocols \
                exist for dogs and cats, but their application depends on vaccination history, \
                local regulations, and the nature of the exposure — this must be determined \
                by a veterinarian immediately after any potential exposure.

                If your pet has been bitten by a wild animal or animal of unknown status, \
                contact a veterinarian immediately. Do not wait for symptoms to appear.

                **Zoonotic Risk**

                Rabies is one of the most serious zoonotic diseases known. The virus can be \
                transmitted to humans through the saliva of an infected animal — most commonly \
                through a bite, but also through mucous membrane exposure. Rabies in humans is \
                virtually always fatal once symptoms develop.

                If your pet has had potential exposure to a rabid or unknown animal, take \
                precautions when handling them and contact your veterinarian immediately. If \
                you have been bitten or had saliva contact with a potentially rabid animal, \
                contact your own physician or emergency services without delay — post-exposure \
                treatment for humans must be initiated promptly to be effective.

                Rabies is a legally reportable disease. Suspected cases may involve public \
                health authorities, and your veterinarian is required to report confirmed or \
                suspected cases in most jurisdictions.

                **Myths vs. Facts**

                Myth: "You can always tell a rabid animal — they'll be foaming at the mouth \
                and acting aggressive."
                Fact: Foaming at the mouth is a late-stage sign caused by an inability to \
                swallow. Early rabies often looks like subtle behavioral changes — an outdoor \
                cat suddenly becoming unusually friendly, a normally sociable dog becoming \
                withdrawn, or a normally nocturnal wild animal appearing during the day. The \
                paralytic form involves quiet weakness and deterioration, not aggression.

                Myth: "Indoor cats don't need rabies vaccines."
                Fact: Rabies vaccination is legally required for cats in most US states — \
                regardless of whether the cat ever goes outdoors. Bats can and do enter homes, \
                and indoor cats have contracted rabies from bat encounters inside the house.

                Myth: "Only wild animals get rabies."
                Fact: Cats are the most commonly reported rabid domestic animal in the United \
                States. Unvaccinated outdoor cats that encounter wildlife are at significant \
                risk.

                Myth: "The bat flew away fine, so it probably wasn't rabid."
                Fact: The behavior of the bat after the encounter tells you nothing about its \
                rabies status. Bats infected with rabies do not always appear sick. Any direct \
                contact with a bat warrants evaluation for both people and pets involved.

                Myth: "If my pet was vaccinated once as a puppy, they're protected for life."
                Fact: Rabies vaccines require boosters — typically every 1 or 3 years \
                depending on the vaccine and local regulations. A lapsed booster may not \
                provide full legal or medical protection.

                Myth: "Rabbits and guinea pigs can give you rabies."
                Fact: Small rodents and rabbits are almost never found to be infected with \
                rabies under natural conditions. However, any bite wound from a wild or \
                unknown animal should still prompt veterinary evaluation.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is typically 2 weeks to 3 months after exposure, but can range from a few days to over a year. Early signs include subtle behavioral changes, restlessness, fever, and unusual sensitivity to light, sound, or touch.",
                    delayed: "As the virus reaches the brain, signs escalate rapidly — progressing to aggression or paralysis, loss of coordination, inability to swallow, seizures, and death. The total course of illness from first signs to death is typically 2–10 days. There is no effective treatment once clinical signs appear."
                ),
                symptoms: [
                    "Sudden change in behavior (friendly animal becoming withdrawn, or timid animal becoming aggressive)",
                    "Unusual vocalizations or unprovoked barking, howling, or crying",
                    "Restlessness, agitation, or anxiety",
                    "Sensitivity to light, sound, or touch",
                    "Apparent discomfort or itching at a previous bite site",
                    "Loss of appetite",
                    "Hiding or seeking isolation",
                    "Weakness or stumbling, particularly in the hindlimbs (paralytic form)",
                    "Drooping jaw or facial muscles; difficulty swallowing",
                    "Excessive drooling or foaming at the mouth",
                    "Snapping or biting at the air",
                    "Dilated pupils or a glassy, unfocused stare",
                    "Seizures or uncontrolled muscle tremors",
                    "Progressive paralysis"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "All dogs are susceptible. Unvaccinated dogs, dogs that spend time outdoors, and working or hunting dogs have higher exposure risk. Bites from bats, raccoons, skunks, or foxes are the most common exposure routes. Rabies vaccination is legally required in most US states and many countries. If your dog is bitten by a wild animal, seek veterinary care immediately regardless of vaccination status — quarantine or observation protocols may be legally required."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Cats are the most commonly reported rabid domestic animal in the United States. Outdoor and indoor/outdoor cats are at significant risk from wildlife encounters. Rabies vaccination is legally required for cats in most US states. Bats entering the home are a documented source of rabies exposure for indoor cats. Vaccination is strongly recommended for all cats regardless of lifestyle."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Ferrets are susceptible to rabies, and a USDA-approved rabies vaccine is available for ferrets — discuss this with your exotic veterinarian. Ferrets that bite a person may be subject to quarantine or testing requirements by local authorities. Rabbits and small rodents (guinea pigs, hamsters, gerbils, rats, mice, chinchillas) are almost never found to be infected with rabies under natural conditions, and are not known to transmit rabies to humans. However, any bite wound from a wild or unknown animal should still prompt veterinary evaluation."
                    )
                ],
                preventionTips: [
                    "Vaccinate your dogs and cats against rabies — it is legally required in most US states and many countries, and is the single most effective protection available",
                    "Ferrets can and should receive a USDA-approved rabies vaccine — ask your veterinarian",
                    "Keep pets away from wild animals, especially bats, raccoons, skunks, and foxes — even a brief encounter can result in exposure",
                    "Never handle bats, dead wildlife, or stray animals with bare hands",
                    "If your pet is bitten or scratched by a wild animal or an animal of unknown vaccination status, contact a veterinarian immediately — do not wait for symptoms, as the critical window is before signs develop",
                    "If a bat is found inside your home, do not release it — contact your local animal control or public health department; the bat may need to be tested, and anyone in the home (including pets) may need evaluation",
                    "Keep your pet's rabies vaccination records current and accessible — you may need to provide proof of vaccination if your pet bites someone or is exposed to a potentially rabid animal",
                    "If you are bitten by any animal, wash the wound immediately with soap and water and contact your physician or emergency services — post-exposure treatment for humans must be started promptly to be effective",
                    "Rabies is a reportable disease — suspected cases must be reported to local public health or animal control authorities; veterinarians are required by law to report them in most jurisdictions"
                ],
                sources: [
                    "American Veterinary Medical Association (AVMA) — Rabies",
                    "Centers for Disease Control and Prevention (CDC) — Rabies",
                    "Merck Veterinary Manual — Rabies",
                    "Cornell University College of Veterinary Medicine — Rabies",
                    "World Organisation for Animal Health (WOAH) — Rabies"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000006"  // Leptospirosis
                ]
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
                    "1D000001-0000-0000-0000-000000000003",  // Feline Panleukopenia — related parvovirus family
                    "1D000001-0000-0000-0000-000000000012"   // Canine Distemper
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
                    "1D000001-0000-0000-0000-000000000002",  // Canine Parvovirus — related parvovirus family
                    "1D000001-0000-0000-0000-000000000046"   // Feline Calicivirus (FCV)
                ]
            ),

            // MARK: - Psittacosis (Parrot Fever)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000004")!,
                name: "Psittacosis (Parrot Fever)",
                alternateNames: [
                    "parrot fever", "chlamydiosis", "chlamydophilosis",
                    "avian chlamydiosis", "ornithosis", "Chlamydia psittaci",
                    "chlamydophila psittaci", "psittacosis infection", "parrot disease",
                    "bird keeper's disease", "bird handler's disease"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "psittacosis_thumb",
                description: """
                Psittacosis — commonly called parrot fever — is an infectious \
                disease caused by Chlamydia psittaci, a specialized bacterium \
                that lives and reproduces inside the cells of its host. It \
                primarily affects birds but can also infect cats, and it is a \
                significant zoonotic disease — meaning it can be transmitted \
                from infected animals to humans.

                Here is the detail that surprises almost every bird owner: an \
                infected bird may look completely healthy. Chlamydia psittaci \
                is notorious for producing subclinical carriers — birds that \
                harbor and shed the bacteria for months or years without any \
                visible signs of illness. Stress, overcrowding, or concurrent \
                illness can trigger an apparently healthy bird to begin \
                actively shedding the organism. This makes psittacosis one of \
                the more challenging infectious diseases in avian medicine to \
                detect and control.

                The disease affects all types of pet birds, but parrots, \
                cockatiels, budgerigars (budgies), macaws, and pigeons are \
                among the most commonly involved species. Cats can also \
                contract C. psittaci, typically through hunting or close \
                contact with infected birds.

                Psittacosis is a reportable disease in many US jurisdictions \
                and internationally, meaning suspected cases must be reported \
                to public health authorities. If your bird is diagnosed, your \
                veterinarian may be legally required to notify local health \
                officials.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Chlamydia psittaci is an obligate intracellular pathogen — it \
                cannot replicate outside of a living host cell. After entering \
                the body (typically through inhalation of contaminated \
                particles), the bacteria invade cells lining the respiratory \
                tract and spread via the bloodstream to multiple organ systems.

                In birds, the primary targets are the liver, spleen, and \
                respiratory system. The bacteria trigger an inflammatory \
                response that can lead to hepatitis (liver inflammation), \
                splenomegaly (enlargement of the spleen), pneumonia, and \
                systemic illness. Because the organism lives inside cells, it \
                is shielded from many components of the immune system — which \
                is part of why some birds remain chronically infected without \
                clearing the infection on their own.

                In cats, C. psittaci typically causes respiratory signs and \
                conjunctivitis (eye inflammation), though systemic illness is \
                possible. Cats that hunt wild birds or have close contact with \
                infected pet birds are at greatest risk.

                The disease ranges from mild and self-limiting to severe and \
                life-threatening, depending on the species affected, the \
                strain of bacteria, the animal's immune status, and how \
                quickly treatment is started.

                **Transmission & Spread**

                Chlamydia psittaci is shed in the feces, respiratory \
                secretions, and feather dust of infected birds. Transmission \
                occurs most commonly through inhalation of dried fecal \
                particles, feather dust, or respiratory secretions — the most \
                common route for both animals and humans. Direct contact with \
                an infected bird's secretions or tissues also carries risk, as \
                do bite wounds (less common but documented).

                The bacteria can survive in dried droppings and feather debris \
                in the environment for several weeks, meaning an enclosure or \
                room that housed an infected bird can remain a source of \
                exposure after the bird is removed.

                High-risk settings include pet stores, aviaries, bird shows, \
                rescue organizations, and multi-bird households. New birds \
                introduced to an existing flock — especially birds sourced \
                from pet stores, markets, or breeding facilities — represent a \
                significant introduction risk, as stressed birds are more \
                likely to begin actively shedding the organism.

                A historically significant note: the 1929–1930 psittacosis \
                pandemic swept through Europe and North America after a wave \
                of imported parrots from South America. Hundreds of people \
                became seriously ill, dozens died, and the outbreak triggered \
                international regulations on parrot importation that persist \
                in modified form today. It remains one of the most significant \
                zoonotic disease events of the 20th century — caused entirely \
                by pet birds.

                **Treatment Goals**

                Psittacosis in birds is treatable when identified early. \
                Veterinary treatment focuses on eliminating the bacterial \
                infection, supporting affected organ systems (particularly the \
                liver), and preventing spread to other birds or people in the \
                household.

                Treatment typically requires an extended course — weeks rather \
                than days — because the organism's intracellular nature makes \
                it more difficult to clear than many other bacterial \
                infections. All birds in the same household or aviary should \
                be evaluated, as subclinical carriers may be present alongside \
                visibly sick birds.

                For cats, treatment focuses on resolving respiratory signs and \
                eliminating infection. Early veterinary intervention \
                significantly improves outcomes for both birds and cats.

                Isolation of suspected cases is important — both to protect \
                other animals and to reduce the risk of human exposure while \
                diagnosis and treatment are underway.

                **Zoonotic Risk**

                Psittacosis is a genuine and well-documented human health \
                risk. People most commonly become infected through inhalation \
                of contaminated dust or dried droppings from infected birds. \
                Those at highest risk include bird owners, veterinary staff, \
                pet store workers, and anyone who handles birds regularly.

                Human psittacosis typically presents as a flu-like respiratory \
                illness and responds well to treatment when diagnosed — but it \
                is sometimes missed because clinicians may not immediately \
                consider a bird-associated illness. Informing your doctor that \
                you own birds is important if you become ill.

                Immunocompromised individuals, pregnant women, the elderly, \
                and very young children are at greater risk of severe illness \
                and should take extra precautions around birds with suspected \
                or confirmed psittacosis.

                If your bird has been diagnosed with psittacosis, take \
                precautions when cleaning the enclosure and handling the bird, \
                and contact your own physician if you have concerns about your \
                own exposure. Psittacosis in humans is a reportable condition \
                in most US states.

                **Hooks & Interesting Facts**

                The name "psittacosis" comes from Psittacus — the Latin word \
                for parrot — even though the disease affects many bird species \
                beyond parrots, including pigeons, doves, and poultry. When \
                the disease is contracted from non-parrot birds, it is \
                sometimes called ornithosis — but it is the same organism.

                A bird can carry and shed C. psittaci for months or years \
                without ever appearing sick. Stress — such as being moved to a \
                new home, overcrowding, or the arrival of a new animal — can \
                trigger active shedding in an otherwise asymptomatic carrier.

                The 1929–1930 pandemic: imported parrots from Argentina and \
                Brazil triggered an international outbreak that killed dozens \
                of people and prompted some of the earliest modern zoonotic \
                disease control regulations. The parrot trade was temporarily \
                banned in several countries as a result.

                Psittacosis is reportable in most US states — a confirmed \
                diagnosis in your bird will likely be reported to public \
                health authorities by your veterinarian. This is standard \
                disease surveillance, not cause for alarm.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period in birds is typically 3–10 days but can extend to several weeks. Early signs include lethargy, ruffled feathers, reduced appetite, and nasal or eye discharge.",
                    delayed: "As the disease progresses, birds may develop severe respiratory distress, greenish diarrhea, and significant weight loss. Liver and spleen enlargement may occur. Untreated birds can deteriorate rapidly — contact an avian veterinarian at the first signs of illness."
                ),
                symptoms: [
                    "Lethargy or unusual quietness",
                    "Ruffled or fluffed feathers (a sign a bird is unwell)",
                    "Reduced appetite or weight loss",
                    "Watery or discolored droppings (greenish or yellowish)",
                    "Nasal discharge or sneezing",
                    "Eye discharge or conjunctivitis (red, watery, or swollen eyes)",
                    "Labored or rapid breathing",
                    "Tail bobbing with each breath (a sign of respiratory effort in birds)",
                    "Swollen or tender abdomen (from liver or spleen enlargement)",
                    "Sudden death in severe cases with no prior obvious signs",
                    "In cats: sneezing, nasal discharge, conjunctivitis, and lethargy"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .bird,
                        severity: .severe,
                        notes: "All pet bird species are susceptible. Parrots (including cockatiels, budgerigars, macaws, African grey parrots, conures, and lovebirds), pigeons, and doves are most commonly affected. Birds acquired from pet stores, bird fairs, aviaries, or rescue organizations carry higher risk — stress of transport and new environments can trigger shedding in subclinical carriers. New birds should be quarantined from existing birds for at least 30 days and evaluated by an avian veterinarian. Psittacosis is a reportable disease — a confirmed diagnosis must be reported to public health authorities in most jurisdictions."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .low,
                        notes: "Cats can contract Chlamydia psittaci, typically through hunting wild birds or close contact with infected pet birds. Clinical signs most commonly involve the upper respiratory tract and eyes (conjunctivitis). While systemic illness is possible, most cats present with milder signs than affected birds. Cats in households with infected or suspected birds should be evaluated by a veterinarian. Indoor cats with no bird contact are at very low risk."
                    )
                ],
                preventionTips: [
                    "Have new birds evaluated by an avian veterinarian before introducing them to your home or existing flock — and quarantine them from other birds for at least 30 days",
                    "Purchase birds from reputable sources that can provide health documentation; avoid birds from high-density or unknown-origin environments where psittacosis is more likely to circulate",
                    "Clean bird enclosures regularly and thoroughly — C. psittaci survives in dried droppings and feather dust for weeks",
                    "When cleaning cages, wear a mask and dampen droppings before sweeping or wiping to reduce inhalable dust — this applies to healthy birds as well as sick ones",
                    "Minimize stress in your birds — stress is a known trigger for active shedding in subclinical carriers; avoid overcrowding, sudden environmental changes, and unnecessary disturbances",
                    "If a bird appears unwell — lethargy, ruffled feathers, changed droppings — contact an avian veterinarian promptly; do not wait to see if it improves on its own",
                    "Isolate any bird showing signs of illness from other birds immediately",
                    "Psittacosis is a reportable disease — if your bird is diagnosed, follow your veterinarian's guidance on reporting requirements and precautions for your household",
                    "If you own birds and develop a respiratory illness, inform your physician — psittacosis in humans can be missed if your doctor does not know you have birds",
                    "Immunocompromised individuals, pregnant women, the elderly, and very young children should take extra precautions around birds with suspected or confirmed psittacosis and consult their own physician about their personal risk"
                ],
                sources: [
                    "American Veterinary Medical Association (AVMA) — Psittacosis",
                    "Centers for Disease Control and Prevention (CDC) — Psittacosis",
                    "Merck Veterinary Manual — Chlamydiosis in Birds",
                    "Association of Avian Veterinarians (AAV) — Psittacosis",
                    "Cornell University College of Veterinary Medicine — Avian Chlamydiosis"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000030",  // PBFD
                    "1D000001-0000-0000-0000-000000000035",  // Air Sac Mites (Sternostoma tracheacolum)
                    "1D000001-0000-0000-0000-000000000036",  // PDD (Proventricular Dilatation Disease)
                    "1D000001-0000-0000-0000-000000000044"   // Bird Husbandry Guide
                ]
            ),

            // MARK: - Metabolic Bone Disease (MBD)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000005")!,
                name: "Metabolic Bone Disease (MBD)",
                alternateNames: [
                    "MBD", "metabolic bone disease", "nutritional secondary hyperparathyroidism",
                    "NSHP", "fibrous osteodystrophy", "calcium deficiency",
                    "vitamin D deficiency", "soft bone disease", "rubber jaw",
                    "rickets", "osteomalacia"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "mbd_thumb",
                description: """
                Metabolic bone disease (MBD) is one of the most common — and most \
                preventable — conditions seen in reptiles, birds, and some small mammals \
                kept as pets. It develops when the body cannot maintain adequate calcium \
                levels in bone tissue, leading to progressive weakening, deformity, and \
                eventual fracture of the skeleton.

                MBD is a chronic condition that develops gradually over weeks to months. \
                Early signs are often subtle, and many owners do not notice a problem \
                until the disease is already advanced. Despite the slow onset, MBD can \
                become life-threatening if left untreated — in severe cases, calcium \
                depletion affects muscle function and the nervous system, leading to \
                seizures and collapse.

                MBD is not an infectious disease and cannot be spread between animals. \
                It is caused almost entirely by preventable husbandry failures: inadequate \
                UVB lighting, incorrect calcium-to-phosphorus ratios in the diet, or \
                insufficient vitamin D3. With the right environment and nutrition, MBD is \
                largely avoidable.

                Reptiles — particularly bearded dragons, iguanas, chameleons, and \
                tortoises — are the most commonly affected animals. Birds (especially \
                African grey parrots) and small mammals such as rabbits and guinea pigs \
                can also be affected. Dogs and cats are rarely affected by MBD under \
                normal circumstances.
                """,
                toxicityInfo: """
                **How It Harms the Body**
                Bone is living tissue that is constantly being built up and broken down. \
                This process depends on calcium — and calcium metabolism depends on two \
                things working together: adequate dietary calcium relative to phosphorus, \
                and vitamin D3 to absorb and regulate it.

                When calcium is insufficient or vitamin D3 is deficient, the body draws \
                calcium directly from bone to maintain blood calcium levels. Over time, \
                this demineralization (loss of calcium from bone tissue) causes bones to \
                become soft, porous, and prone to fracture. In reptiles, this is sometimes \
                called "rubber jaw" or "soft bones" — the jaw and limb bones may literally \
                bend under the animal's own weight.

                Vitamin D3 plays a critical role that is often misunderstood. Most reptiles \
                cannot absorb calcium from food without adequate vitamin D3 — and most \
                reptiles cannot synthesize vitamin D3 without ultraviolet B (UVB) light. \
                Without UVB, even a calcium-rich diet will not prevent MBD. Oral vitamin D3 \
                supplementation can partially compensate but rarely fully replaces proper \
                UVB exposure.

                As MBD progresses, the consequences extend beyond the skeleton. Severely \
                low calcium levels (hypocalcemia) affect muscle function and the nervous \
                system, causing tremors, muscle twitching, paralysis, and seizures. At \
                this stage, MBD has become a systemic emergency.

                The connection between UVB light and reptile health was not well understood \
                until the 1980s and 1990s — before then, MBD was documented in zoo reptile \
                collections worldwide with no clear explanation. Once the role of UVB in \
                vitamin D3 synthesis was established, the design of reptile enclosures \
                changed fundamentally. It is a reminder of how much species-specific \
                husbandry knowledge still matters, even for animals that have been kept in \
                captivity for generations.

                **Causes & Risk Factors**
                MBD is almost always the result of one or more of the following husbandry \
                failures:

                Inadequate UVB lighting is the most common cause in reptiles. UVB output \
                from bulbs degrades over time even when the bulb still appears to emit \
                visible light — bulbs should be replaced on a schedule, not just when they \
                burn out. The distance between the bulb and the animal, the presence of \
                glass or plastic between the two, and the number of hours per day the light \
                is on all affect UVB exposure. Reptiles housed in enclosures with no UVB \
                source at all are at extremely high risk.

                Incorrect calcium-to-phosphorus ratio in the diet is a major contributor, \
                particularly in reptiles fed primarily insects. Many feeder insects \
                (crickets, mealworms) have an inverted calcium-to-phosphorus ratio that \
                actively competes with calcium absorption. Gut-loading feeder insects and \
                dusting them with calcium powder before feeding are standard practices for \
                this reason.

                All-seed diets in birds are a common underlying cause — seeds are high in \
                phosphorus and fat, and chronically low in calcium and vitamin D3. African \
                grey parrots are particularly vulnerable due to a species-specific \
                predisposition to hypocalcemia (abnormally low blood calcium) that is not \
                yet fully understood, even on diets considered adequate for other parrot \
                species. They remain one of the most commonly affected bird species and a \
                model for why species-specific nutrition research matters.

                In small mammals such as rabbits and guinea pigs, MBD is typically \
                diet-driven — insufficient hay, excessive pellets, and lack of leafy greens \
                disrupt the calcium balance needed for healthy bone.

                Young, rapidly growing animals are most vulnerable because their skeletons \
                are developing quickly and have high calcium demands. Animals that have been \
                kept in suboptimal conditions for months or years are also at high risk, as \
                damage accumulates silently over time.

                Metabolic bone disease has been called "almost entirely a disease of \
                inadequate husbandry" — meaning that in the vast majority of cases, it did \
                not have to happen. The knowledge needed to prevent it is straightforward \
                and accessible. That makes early recognition and husbandry correction among \
                the most powerful tools an exotic pet owner can have.

                **Treatment Goals**
                Veterinary treatment focuses on correcting the underlying calcium and \
                vitamin D3 deficiency, providing supportive care for pain and fractures, \
                and addressing any neurological signs such as tremors or seizures. \
                Husbandry correction — fixing the UVB setup and diet — is an essential \
                part of treatment, not just prevention.

                Outcomes are significantly better with early veterinary intervention. \
                Animals diagnosed with mild to moderate MBD and placed in a corrected \
                environment with appropriate veterinary support can achieve meaningful \
                improvement. Advanced MBD with severe deformity or neurological involvement \
                carries a much more guarded outlook — another reason why early detection \
                matters.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Develops gradually over weeks to months. Early signs are often subtle — slight lethargy, reduced activity, or mild changes in posture or gait that are easy to miss or attribute to other causes.",
                    delayed: "As the condition progresses, bones become visibly soft or deformed. In advanced cases, spontaneous fractures, paralysis, and seizures can occur. At this stage, MBD has become a systemic emergency requiring immediate veterinary care."
                ),
                symptoms: [
                    "Lethargy or reduced activity",
                    "Trembling, twitching, or muscle spasms",
                    "Soft, rubbery, or visibly deformed jaw or limb bones",
                    "Swollen or thickened limbs",
                    "Abnormal posture — hunched back, bowed limbs, or inability to hold normal position",
                    "Difficulty walking, climbing, or gripping (reptiles and birds)",
                    "Spontaneous fractures with minimal or no trauma",
                    "Loss of appetite",
                    "Paralysis or weakness of the hind limbs",
                    "Seizures or collapse (advanced disease)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Reptiles are the most commonly affected species. Bearded dragons, iguanas, chameleons, and tortoises are at particularly high risk. UVB deficiency is the primary driver in this group — without adequate UVB, even a calcium-rich diet will not prevent MBD. Young, rapidly growing reptiles are most vulnerable."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .high,
                        notes: "African grey parrots have a species-specific predisposition to hypocalcemia and are among the most commonly affected bird species. All-seed diets are a major risk factor across all parrot species. Egg-laying hens of any species are at increased risk due to the high calcium demands of egg production."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Rabbits and guinea pigs can develop MBD, typically from calcium-deficient diets — insufficient hay and leafy greens, excessive pellets or seeds. Ferrets are rarely affected. Young, growing animals are most vulnerable."
                    )
                ],
                preventionTips: [
                    "Provide appropriate UVB-B lighting for all reptiles — consult your exotic veterinarian for species-specific requirements. Replace UVB bulbs on schedule (typically every 6–12 months) even if they still emit visible light.",
                    "Ensure UVB bulbs are the correct distance from your reptile and are not blocked by glass, plastic, or mesh, which can filter out UVB rays.",
                    "Dust feeder insects (crickets, mealworms, etc.) with a calcium supplement before feeding, and gut-load insects with nutritious food 24–48 hours prior.",
                    "Feed reptiles a species-appropriate diet with a correct calcium-to-phosphorus ratio. Avoid feeding primarily high-phosphorus insects without calcium supplementation.",
                    "Avoid all-seed diets for birds. Seeds are high in fat and phosphorus and low in calcium and vitamin D3. A varied diet including leafy greens, vegetables, and a formulated pellet is strongly recommended.",
                    "African grey parrots have a higher-than-average calcium requirement and should be monitored closely. Consult an avian veterinarian about species-appropriate supplementation.",
                    "For rabbits and guinea pigs, ensure unlimited access to grass hay, which is the foundation of a calcium-balanced diet. Leafy greens are also beneficial.",
                    "Schedule regular wellness exams with a veterinarian experienced in exotic animals. Routine bloodwork can detect calcium imbalances before clinical signs appear.",
                    "If you notice any bone softness, deformity, trembling, or changes in your pet's movement or posture, contact a veterinarian promptly — early intervention significantly improves outcomes."
                ],
                sources: [
                    "Merck Veterinary Manual — Metabolic Bone Disease in Reptiles",
                    "Merck Veterinary Manual — Nutritional Diseases of Pet Birds",
                    "Veterinary Partner — Metabolic Bone Disease",
                    "Journal of Exotic Pet Medicine — Calcium and Vitamin D3 Metabolism in Reptiles",
                    "UC Davis School of Veterinary Medicine — Reptile Husbandry Guidelines"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000040",  // Shell Rot
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
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
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000001",  // Rabies
                    "1D000001-0000-0000-0000-000000000022"   // Tick-Borne Diseases
                ]
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
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000028",  // Fleas
                    "1D000001-0000-0000-0000-000000000032"   // RHDV2 (Rabbit Hemorrhagic Disease)
                ]
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
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000011",  // Canine Influenza
                    "1D000001-0000-0000-0000-000000000021"   // FHV-1
                ]
            ),

            // MARK: - Thermal Burns
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000009")!,
                name: "Thermal Burns",
                alternateNames: [
                    "burns", "heat burns", "contact burns", "heat rock burn",
                    "thermal injury", "burn wound", "scalding", "reptile burns"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "thermal_burns_thumb",
                description: """
                Thermal burns are tissue injuries caused by direct or prolonged \
                contact with an excessively hot surface, open flame, or intense \
                radiant heat source. Burns are an acute injury — damage to the \
                skin and underlying tissues occurs rapidly, and the full extent \
                of the wound may not be visible for 24 to 72 hours after \
                exposure as tissue continues to break down.

                Burns can range from superficial (affecting only the outermost \
                skin layers) to deep and life-threatening (destroying muscle, \
                bone, or underlying structures). Even injuries that look minor \
                on the surface can involve significant damage beneath — \
                particularly in reptiles, where scale coverage can mask the \
                true extent of the wound.

                This is not a contagious condition. Thermal burns result from \
                accidental contact or a husbandry failure, not from a pathogen.

                All companion animal species can suffer thermal burns. Reptiles \
                are at the highest risk due to a critical biological difference: \
                as ectotherms, they rely entirely on external heat to regulate \
                their body temperature. This drive is so powerful that a reptile \
                will press against a dangerously hot surface for hours without \
                retreating — and many reptiles show few outward signs of \
                distress while a serious burn is forming beneath the surface. \
                Dogs and cats can also develop burns from heating pads, hot \
                pavement, campfires, space heaters, and accidental contact with \
                stoves. Birds are at risk from proximity to heat lamps and \
                ceramic heat emitters. Small mammals can be burned by \
                improperly used heating accessories placed beneath or inside \
                their enclosures.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Heat damages tissue by denaturing — breaking down — the \
                proteins that form skin cells, blood vessels, and underlying \
                structures. Superficial burns affect only the outermost layers, \
                causing redness, swelling, and pain. Deeper burns destroy the \
                full thickness of the skin and may extend into muscle, tendon, \
                or bone.

                One of the most dangerous features of thermal burns, especially \
                in reptiles, is burn wound progression — the injury continues \
                to expand and deepen for hours to days after the heat source is \
                removed. What appears to be a minor surface blemish during \
                initial assessment may reveal itself as a deep, full-thickness \
                wound over the following days.

                Burns also destroy the skin's barrier function, leaving the \
                underlying tissue vulnerable to bacterial invasion. Secondary \
                infection is a major and potentially life-threatening \
                complication. In reptiles, this risk is compounded by the fact \
                that immune function is closely tied to environmental \
                temperature — a reptile housed at suboptimal temperatures after \
                a burn is immunocompromised at exactly the moment a strong \
                immune response is most needed.

                The ectotherm thermoregulatory drive deserves particular \
                attention. Reptiles are neurologically programmed to seek heat \
                — it is not a preference but a survival imperative. This means \
                a snake or lizard will press its abdomen against a heat rock \
                for hours, even as the surface temperature climbs to levels \
                that cause full-thickness burns, without retreating. Unlike a \
                mammal that typically flinches and moves away from a painful \
                stimulus, a reptile may remain completely still on a burning \
                surface until the damage is severe. This is not stubbornness \
                — it is biology working against the animal in a poorly designed \
                enclosure.

                **Causes & Risk Factors**

                Heat rocks are the single most frequently cited cause of \
                reptile thermal burns in veterinary medicine. They heat \
                unevenly, can malfunction and reach dramatically unsafe \
                temperatures, and cannot be reliably regulated without an \
                external thermostat. Despite remaining widely available in pet \
                stores, heat rocks are considered obsolete and dangerous by \
                most reptile veterinarians and experienced herpetoculturists.

                Other common causes include under-tank heaters or heat tape \
                running without a thermostat, allowing surface temperatures to \
                rise unchecked; heat lamps positioned too close to the basking \
                area, enabling direct contact with the bulb or fixture; ceramic \
                heat emitters and radiant heat sources without protective \
                guards; heating pads intended for human use placed under small \
                mammal cages or used directly with pets; hot pavement, asphalt, \
                and sand during summer months (a common cause of paw pad burns \
                in dogs); accidental contact with stoves, campfires, \
                fireplaces, and space heaters in dogs and cats; and thermostat \
                malfunction — a single failure in temperature control equipment \
                can turn a well-designed enclosure into a lethal one overnight.

                Young, debilitated, sedated, or neurologically impaired animals \
                are at elevated risk because they are less able to move away \
                from a dangerous heat source.

                There is one cause that owners often do not anticipate: heating \
                accessories themselves can become a source of injury through \
                ingestion. Flexible heating mats, adhesive heat tape, and \
                similar products left accessible inside an enclosure have been \
                documented as ingested foreign bodies — snakes in particular \
                may constrict, chew, or swallow heating accessories, and \
                surgical removal may be required. Heating equipment should \
                always be secured or kept outside the animal's accessible space.

                **Treatment Goals**

                Thermal burns are a veterinary emergency. Even burns that \
                appear superficial warrant prompt evaluation — the full depth \
                of a burn wound cannot be reliably assessed by appearance \
                alone, particularly in reptiles where wound progression may \
                still be actively occurring.

                Veterinary goals for burn management include accurately \
                assessing the depth and extent of the injury, preventing or \
                treating secondary infection, managing pain, and supporting \
                wound healing. Deep or extensive burns may require surgical \
                debridement (removal of dead tissue), wound reconstruction, or \
                prolonged intensive wound care. Animals that stop eating due to \
                pain or stress may also require nutritional support.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Burns occur at the moment of contact; visible skin changes may appear within minutes to hours of heat exposure",
                    delayed: "The full extent of tissue damage may not be apparent for 24 to 72 hours as burn wound progression continues beneath the surface"
                ),
                symptoms: [
                    "Redness, discoloration, or unusual color change of skin or scales",
                    "Blistering or fluid-filled swellings at the injury site",
                    "Peeling, sloughing, or shedding skin or scales — especially on the belly or underside",
                    "Open wound or raw, weeping area on the skin",
                    "Blackened or necrotic (dead-appearing) tissue",
                    "Reluctance to move; unusual stillness or altered posture",
                    "Lethargy or sudden decrease in activity",
                    "Loss of appetite",
                    "Swelling, discharge, or odor at a wound site — signs of secondary infection",
                    "Vocalization, flinching, or visible pain response when touched (more common in mammals)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Highest risk due to ectotherm thermoregulatory drive; will press against overheated surfaces without retreating; burns often masked by scales; secondary infection risk compounded by temperature-dependent immunity"
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .high,
                        notes: "Risk from proximity to heat lamps and ceramic heat emitters; small body mass means burns can become critical rapidly"
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Heating pads placed under or inside enclosures are a frequent cause; young or debilitated animals especially vulnerable"
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Hot pavement and asphalt burns to paw pads in summer; accidental contact with stoves, campfires, and space heaters"
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Proximity to stoves, space heaters, and open fireplaces; less common than in reptiles but not rare"
                    )
                ],
                preventionTips: [
                    "Remove heat rocks from your reptile's enclosure — they are considered unsafe by most reptile veterinarians and are a leading cause of thermal burns in captive reptiles",
                    "Use under-tank heaters, heat tape, and ceramic heat emitters only with an external thermostat — never run heating elements at unregulated power",
                    "Verify temperatures regularly with an infrared temperature gun; check both the warm basking zone and the cool retreat zone of the enclosure",
                    "Provide a proper thermal gradient — a distinct warm end and a cooler end — so your reptile can move between zones and self-regulate body temperature",
                    "Secure all heating equipment so your pet cannot make direct contact with bulbs, emitters, or heating elements; use protective guards and barriers where needed",
                    "Keep heating accessories outside your pet's accessible space — flexible heating mats and heat tape have been ingested by reptiles and may require surgical removal",
                    "Keep birds a safe distance from heat lamps and radiant heat sources; ensure all heating equipment has appropriate protective guards",
                    "For small mammals: always place bedding or an insulating layer between your pet and any heating pad; never use human heating pads on high settings under or inside an enclosure without veterinary guidance",
                    "Before walking your dog on hot days, test pavement with your palm for several seconds — if it is too hot for your hand, it is too hot for your dog's paws",
                    "Inspect all heating and temperature control equipment regularly for wear, malfunction, or damage — a single thermostat failure can cause a dangerous temperature spike overnight"
                ],
                sources: [
                    "ASPCA Animal Poison Control Center — Reptile Husbandry and Thermal Injury",
                    "Merck Veterinary Manual — Burns and Scalding in Animals",
                    "LaFeber Vet — Thermal Burns in Exotic Companion Animals",
                    "VCA Animal Hospitals — Burns in Reptiles",
                    "Veterinary Partner — Reptile Husbandry and Common Medical Problems"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
            ),

            // MARK: - Dysecdysis (Abnormal Shedding)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000010")!,
                name: "Dysecdysis (Abnormal Shedding)",
                alternateNames: [
                    "dysecdysis", "abnormal shedding", "retained shed", "stuck shed",
                    "incomplete shed", "retained spectacle", "eye cap retention",
                    "retained eye caps", "shedding problems", "ecdysis problems"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "dysecdysis_thumb",
                description: """
                Dysecdysis is the medical term for abnormal or incomplete \
                shedding in reptiles. Healthy reptiles shed their skin — a \
                process called ecdysis — in a single, complete piece or in \
                large sections. When shedding goes wrong, patches of old skin \
                remain stuck to the body. This is called retained shed.

                Dysecdysis is a chronic and recurring problem rather than a \
                single acute event. In mild cases, retained patches cause \
                discomfort and may resolve with supportive care. In more \
                severe or neglected cases, retained shed on the toes, tail \
                tip, or around the eyes can constrict blood flow, causing \
                tissue damage, infection, and in some cases permanent injury \
                or loss of the affected structure.

                This is not a contagious condition. Dysecdysis results from \
                husbandry deficiencies or underlying health problems, not \
                from a pathogen.

                Dysecdysis is almost exclusively a reptile condition. Dogs, \
                cats, birds, and most small mammals do not shed skin in the \
                same way and are not affected. Among reptiles, snakes are \
                particularly prone to shedding problems — they shed the entire \
                skin at once, including a transparent scale covering each eye \
                called the spectacle (or eye cap). Retained spectacles are a \
                common and vision-threatening complication unique to snakes. \
                Lizards and chelonians (turtles and tortoises) shed in patches \
                and are also commonly affected, though complications tend to \
                be less dramatic than in snakes.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                During a normal shed, the reptile produces lymphatic fluid \
                between the old and new skin layers, allowing the old skin to \
                lift and separate cleanly. When this process is disrupted — \
                by low humidity, dehydration, rough handling during a shed, \
                or underlying illness — the old skin dries out and adheres to \
                the surface rather than releasing.

                Retained shed becomes progressively more dangerous the longer \
                it remains in place. Patches left on the body can dry, \
                tighten, and form a constricting band around toes, the tail \
                tip, or the limbs — cutting off circulation in the same way \
                a tight rubber band would. Without intervention, constriction \
                injury leads to tissue death and may require surgical \
                amputation of the affected structure.

                The spectacles of snakes deserve particular attention. These \
                transparent scales cover the eyes directly and are shed as \
                part of the normal skin cycle. When spectacles are retained, \
                they accumulate layer by layer with each subsequent shed, \
                clouding vision and creating a physical barrier against the \
                eye surface. Repeated retention without treatment can lead to \
                corneal damage and permanent vision impairment.

                A less obvious but equally serious risk is secondary \
                infection. Retained shed creates a warm, moist environment \
                between the old and new skin layers — ideal conditions for \
                bacterial and fungal growth. Skin infections (dermatitis) \
                can establish quickly in retained shed patches, particularly \
                in animals that are already immunocompromised.

                One fact that surprises many reptile owners: a snake's shed \
                skin comes off inside-out. As the snake pushes forward \
                through rough substrate or branches, the skin peels backward \
                from the nose, inverting as it goes — meaning the shed you \
                find in the enclosure is the reverse image of your snake's \
                surface. A healthy shed is thin, translucent, and complete. \
                A patchy, fragmented, or opaque shed is a signal that \
                something went wrong.

                **Causes & Risk Factors**

                Low humidity is the leading cause of dysecdysis. Each reptile \
                species has specific humidity requirements, and enclosures \
                that are too dry prevent the lymphatic fluid layer from \
                forming properly, causing the old skin to stick rather than \
                release. Desert species require less humidity than tropical \
                species, but even desert reptiles need elevated humidity \
                during the shed cycle.

                Dehydration compounds the humidity problem — a reptile that \
                is not drinking adequately cannot produce sufficient fluid to \
                separate the skin layers effectively. Access to fresh water \
                at all times, and a humid hide or soaking option during the \
                shed cycle, significantly reduces shedding problems.

                Other common causes and risk factors include mite infestations \
                — mites disrupt the skin surface and are a well-established \
                cause of chronic shedding problems, particularly in snakes; \
                malnutrition or vitamin A deficiency — Hypovitaminosis A \
                impairs normal skin and mucosal health and is a recognized \
                contributor to dysecdysis in reptiles; underlying illness — \
                systemic infections, parasitism, or organ disease can disrupt \
                the normal shed cycle; injuries or scarring — healed wounds \
                create abnormal skin texture that does not shed cleanly; \
                handling during an active shed — disturbing a reptile \
                mid-shed can cause the skin to tear and fragment rather than \
                release in one piece; and enclosures without appropriate \
                environmental enrichment — snakes and lizards rely on rough \
                surfaces, branches, and rocks to help strip the old skin; a \
                bare enclosure removes this mechanical aid.

                Shedding frequency varies significantly by species, age, and \
                growth rate. Young, rapidly growing reptiles shed more \
                frequently than adults. Any significant change in shedding \
                frequency or quality — more frequent sheds, very infrequent \
                sheds, or consistently incomplete sheds — is worth discussing \
                with a reptile-experienced veterinarian.

                **Treatment Goals**

                Mild retained shed can sometimes be addressed by providing a \
                warm soak and a humid environment to loosen and soften the \
                old skin. However, forcibly removing retained shed — \
                particularly retained spectacles — risks tearing the new skin \
                layer beneath and should never be attempted without veterinary \
                guidance.

                Veterinary goals for dysecdysis include identifying and \
                correcting the underlying husbandry cause, safely removing \
                retained shed where needed, evaluating for and treating \
                secondary infection, and assessing for constriction injury or \
                eye involvement. Retained spectacles in particular require \
                careful professional removal to avoid corneal damage. \
                Recurring dysecdysis despite corrected husbandry warrants \
                investigation for mites, nutritional deficiencies, or \
                underlying systemic illness.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Signs of an abnormal shed develop over the course of a shed cycle — typically days to weeks depending on species",
                    delayed: "Complications from retained shed (constriction injury, infection, vision impairment) develop gradually over subsequent shed cycles if the problem is not addressed"
                ),
                symptoms: [
                    "Patchy, fragmented, or incomplete shed — old skin remaining attached in pieces",
                    "Retained shed on toes or tail tip — may appear as a tight, dry ring of skin",
                    "Cloudy, dull, or bluish eye caps — may indicate retained spectacles in snakes",
                    "Abnormally long pre-shed phase — eyes that stay blue/opaque longer than expected",
                    "Discolored, thickened, or rough skin patches between shed cycles",
                    "Reluctance to move or unusual stillness, particularly affecting digits or tail",
                    "Swelling, redness, or discharge at a retained shed site — signs of secondary infection",
                    "Changes in behavior during shed — increased irritability, reduced appetite (normal during shed but prolonged is not)",
                    "Visible mites — tiny moving specks near eyes, nostrils, or skin folds"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .high,
                        notes: "Snakes at highest risk — shed full-body skin including spectacles; retained spectacles can cause permanent vision damage; constriction injury from retained toe or tail shed. Lizards and chelonians also commonly affected. Dogs, cats, birds, and small mammals do not shed skin in the same way and are not susceptible."
                    )
                ],
                preventionTips: [
                    "Research the specific humidity requirements for your species and maintain them consistently — this is the single most important factor in preventing shedding problems",
                    "Provide a humid hide during the shed cycle — a small enclosed hide lined with damp sphagnum moss gives your reptile a high-humidity retreat when needed",
                    "Ensure fresh water is always available; dehydration is a significant contributing factor to abnormal shedding",
                    "Offer appropriate environmental enrichment — rough surfaces, branches, rocks, and cork bark give your reptile the friction needed to strip old skin cleanly",
                    "Never handle your reptile during an active shed — disturbing the process can cause the skin to tear and fragment rather than release in one piece",
                    "Check for mites regularly, especially after acquiring a new reptile or after contact with other reptiles; mites are a well-established cause of chronic shedding problems",
                    "Examine each shed for completeness — a healthy shed is thin, translucent, and includes all structures; check for toe tips, tail tip, and (in snakes) eye caps",
                    "If retained shed is present after a shed cycle, consult a reptile-experienced veterinarian before attempting removal — particularly if the eyes are involved",
                    "Schedule regular veterinary checkups with a reptile-experienced vet; recurring shedding problems despite good husbandry may indicate a nutritional deficiency or underlying health condition"
                ],
                sources: [
                    "Merck Veterinary Manual — Dysecdysis in Reptiles",
                    "LaFeber Vet — Reptile Skin Disorders",
                    "VCA Animal Hospitals — Shedding in Snakes",
                    "Veterinary Partner — Common Reptile Husbandry Problems",
                    "UC Davis School of Veterinary Medicine — Reptile Husbandry Guidelines"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000033",  // Snake Mites (Ophionyssus natricis)
                    "1D000001-0000-0000-0000-000000000034",  // Inclusion Body Disease (IBD)
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000040",  // Shell Rot
                    "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
                    "1D000001-0000-0000-0000-000000000042",  // Reptile Respiratory Infections
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
            ),

            // MARK: - Canine Influenza
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000011")!,
                name: "Canine Influenza",
                alternateNames: [
                    "canine influenza", "dog flu", "canine flu", "CIV",
                    "canine influenza virus", "H3N2", "H3N8",
                    "canine influenza H3N2", "canine influenza H3N8",
                    "influenza virus dogs", "dog cold"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "influenza_thumb",
                description: """
                Canine influenza is a highly contagious respiratory infection \
                caused by the canine influenza virus (CIV). Two strains are \
                responsible for disease in dogs in the United States: H3N8, \
                which originated in horses and first transferred to dogs in \
                the early 2000s, and H3N2, which originated in birds and \
                emerged in the United States in 2015 following a large \
                outbreak in the Chicago area. H3N2 is now the dominant \
                circulating strain in the US.

                Canine influenza is an acute illness — symptoms develop \
                rapidly after exposure, typically within two to four days. \
                Most affected dogs experience a mild-to-moderate respiratory \
                illness and recover with supportive care. However, a \
                proportion of infected dogs develop complications including \
                secondary bacterial pneumonia, which can become \
                life-threatening.

                A vaccine is available for both H3N8 and H3N2 strains. \
                Vaccination does not always prevent infection entirely but \
                significantly reduces the severity of illness and the risk \
                of complications.

                Canine influenza affects dogs of all ages, breeds, and health \
                backgrounds. Because the virus is relatively new in the dog \
                population, dogs have little to no natural immunity — meaning \
                virtually any unvaccinated dog exposed to the virus is \
                susceptible. Dogs in high-contact environments such as \
                kennels, shelters, doggy daycares, dog parks, and boarding \
                facilities are at highest risk of exposure. H3N2 has also \
                been documented in cats, though feline infection is uncommon \
                and typically mild.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Canine influenza virus infects the cells lining the \
                respiratory tract — the nose, throat, trachea, and lungs. \
                The virus damages these cells directly, causing inflammation, \
                increased mucus production, and breakdown of the normal \
                protective barrier of the airway.

                In most dogs, infection remains confined to the upper \
                respiratory tract, producing the classic signs of coughing, \
                nasal discharge, and lethargy. In a smaller proportion of \
                dogs — particularly those that are young, elderly, \
                immunocompromised, or have underlying health conditions — \
                the virus progresses into the lower respiratory tract and \
                lungs. This leads to viral pneumonia, which impairs the \
                ability to oxygenate the blood. Viral pneumonia also opens \
                the door to secondary bacterial infection, which can rapidly \
                worsen the clinical picture and become life-threatening \
                without prompt treatment.

                One of the features that makes canine influenza particularly \
                disruptive when it enters a population is the near-universal \
                susceptibility of unvaccinated dogs. Unlike diseases that \
                have circulated in dog populations for decades, canine \
                influenza is a relatively recent pathogen — most dogs \
                encountered by the virus have no prior immunity, allowing \
                outbreaks to spread rapidly through kennels, shelters, and \
                social dog populations.

                **Transmission & Spread**

                Canine influenza spreads primarily through respiratory \
                secretions — coughing, sneezing, and direct nose-to-nose \
                contact are the main transmission routes. The virus can also \
                survive on surfaces, clothing, and hands for a short period, \
                making indirect transmission possible in high-traffic \
                environments.

                A critically important feature of canine influenza \
                transmission is that infected dogs begin shedding the virus \
                before clinical signs appear — during the incubation period \
                of approximately two to four days. This means a dog can \
                infect others before its owner is aware it is sick, making \
                outbreak control in group settings extremely difficult.

                The virus is most prevalent in areas with high dog population \
                density and movement — large cities, regions with active \
                shelter transfer programs, and areas surrounding major dog \
                shows or sporting events. Outbreaks have been documented \
                across the United States, with H3N2 responsible for most \
                recent activity. The virus does not currently pose a risk to \
                humans — canine influenza is not considered zoonotic.

                Infected dogs typically shed the virus for up to ten days \
                following the onset of clinical signs. Dogs with confirmed \
                or suspected canine influenza should be isolated from other \
                dogs during this period.

                **Treatment Goals**

                There is no antiviral treatment specifically approved for \
                canine influenza. Veterinary goals focus on supportive care \
                — managing symptoms, maintaining hydration and nutrition, \
                and preventing or treating secondary bacterial complications. \
                Dogs with mild illness may be managed at home under \
                veterinary guidance. Dogs with evidence of pneumonia, \
                significant breathing difficulty, or rapid deterioration \
                require hospitalization and intensive supportive care.

                Early veterinary evaluation is important — the clinical \
                signs of canine influenza overlap with other respiratory \
                diseases including Kennel Cough (CIRDC), and distinguishing \
                between them matters for treatment decisions and isolation \
                protocols.

                **Myths vs. Facts**

                **Myth:** Canine influenza is just a bad cold — it's not \
                serious.
                **Fact:** While many dogs recover without complications, \
                canine influenza can progress to bacterial pneumonia, which \
                is potentially life-threatening. The "just a cold" framing \
                leads owners to delay veterinary care, which can worsen \
                outcomes in dogs that do develop complications.

                **Myth:** My dog can't catch canine influenza because they \
                were vaccinated.
                **Fact:** Vaccination significantly reduces the severity of \
                illness and the risk of complications, but vaccinated dogs \
                can still become infected. The goal of the vaccine is to \
                reduce disease severity and viral shedding — not to provide \
                absolute protection. Vaccination remains strongly recommended \
                for dogs with regular exposure to other dogs.

                **Myth:** Canine influenza can spread from dogs to people.
                **Fact:** Canine influenza is not considered zoonotic — \
                there are no documented cases of canine influenza virus \
                transmitting from dogs to humans. Human influenza viruses \
                are distinct from canine influenza viruses.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Clinical signs typically appear within 2 to 4 days of exposure",
                    delayed: "Most dogs show improvement within 2 to 3 weeks; complications such as pneumonia can develop within the first week of illness"
                ),
                symptoms: [
                    "Persistent cough — may be soft and moist or dry and harsh",
                    "Nasal discharge — initially clear, may become thick or discolored with secondary infection",
                    "Sneezing",
                    "Lethargy and reduced energy",
                    "Reduced appetite",
                    "Fever",
                    "Eye discharge",
                    "Rapid or labored breathing — a sign of pneumonia requiring immediate veterinary attention",
                    "Difficulty breathing or open-mouth breathing — emergency sign"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .high,
                        notes: "Primary host; near-universal susceptibility in unvaccinated dogs; can progress to bacterial pneumonia; dogs in high-contact settings (kennels, shelters, dog parks) at greatest risk"
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .low,
                        notes: "H3N2 strain documented in cats, typically through close contact with infected dogs; usually mild respiratory signs; uncommon"
                    )
                ],
                preventionTips: [
                    "Discuss canine influenza vaccination with your veterinarian — it is particularly recommended for dogs that regularly visit kennels, dog parks, groomers, shelters, doggy daycares, or dog shows",
                    "Keep your dog away from dogs that are coughing, sneezing, or showing signs of respiratory illness",
                    "If your dog develops respiratory signs after contact with other dogs, contact your veterinarian promptly — early evaluation helps distinguish canine influenza from other respiratory infections and guides appropriate care",
                    "Isolate a dog with suspected or confirmed canine influenza from all other dogs for at least 10 days from the onset of signs to reduce the risk of spread",
                    "Wash hands and change clothing after handling a dog with suspected canine influenza before contacting other dogs — the virus can survive briefly on surfaces and fabrics",
                    "Inform kennels, groomers, and doggy daycares if your dog has recently recovered from a respiratory illness — responsible communication helps prevent outbreaks in group settings",
                    "Stay informed about local canine influenza activity — outbreaks are often reported through local veterinary clinics, shelters, and veterinary association alerts"
                ],
                sources: [
                    "AVMA (American Veterinary Medical Association) — Canine Influenza",
                    "Cornell University College of Veterinary Medicine — Canine Influenza",
                    "Merck Veterinary Manual — Canine Influenza",
                    "CDC (Centers for Disease Control and Prevention) — Canine Influenza",
                    "ASPCA Animal Poison Control Center — Canine Respiratory Disease"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000008"  // Kennel Cough (CIRDC)
                ]
            ),

            // MARK: - Canine Distemper
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000012")!,
                name: "Canine Distemper",
                alternateNames: [
                    "CDV",
                    "hard pad disease",
                    "distemper",
                    "canine distemper virus",
                    "old dog encephalitis",
                    "distempr"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "distemper_thumb",
                description: """
                Canine distemper is a highly contagious, potentially fatal viral \
                disease caused by canine distemper virus (CDV) — a paramyxovirus \
                closely related to the human measles virus. It is one of the most \
                serious infectious diseases in dogs and is entirely preventable \
                through vaccination.

                The virus attacks multiple body systems in sequence — beginning \
                with the immune system, then spreading to the respiratory and \
                gastrointestinal tracts, and in many cases ultimately reaching \
                the central nervous system. This multi-systemic progression makes \
                distemper one of the most complex and dangerous viral diseases in \
                veterinary medicine.

                Unvaccinated puppies and young dogs face the greatest risk, though \
                dogs of any age can be infected if their immunity is incomplete. A \
                full, properly timed vaccination series is essential — an incomplete \
                series can leave puppies vulnerable during the critical window \
                between their first and last puppy shots.

                Cats are not considered susceptible to CDV. Ferrets, however, are \
                extremely susceptible and face a nearly universally fatal outcome \
                without vaccination. CDV is not transmissible to humans.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Canine distemper virus first targets lymphoid tissue — the tonsils \
                and lymph nodes of the respiratory tract — where it replicates \
                rapidly and begins to suppress the immune system. This \
                immunosuppression is what makes distemper so dangerous: the dog's \
                defenses are actively weakened at the very moment the virus is \
                spreading through the body, leaving it vulnerable to secondary \
                bacterial infections on top of the primary viral attack.

                From the lymphoid system, the virus enters the bloodstream and \
                spreads to the respiratory, gastrointestinal, urinary, and central \
                nervous systems. This multi-phase progression explains why distemper \
                can present so differently from dog to dog — some appear to have a \
                respiratory illness, others a gastrointestinal illness, and some \
                progress to a neurological emergency.

                One of CDV's most significant effects is demyelination — stripping \
                the protective myelin sheath (the insulating layer around nerve \
                fibers) from the central nervous system, similar in mechanism to \
                multiple sclerosis. This is responsible for the muscle twitches, \
                seizures, and loss of coordination that can emerge during or after \
                the acute illness. Neurological damage, once it develops, may be \
                permanent even in dogs that survive.

                Puppies infected before their permanent teeth have fully erupted \
                can carry a visible reminder of the infection for life. The virus \
                attacks the cells responsible for forming tooth enamel, causing \
                enamel hypoplasia — teeth that are pitted, discolored, and \
                structurally weak. These "distemper teeth" may only become apparent \
                months after the dog has recovered.

                A rare long-term consequence called old dog encephalitis (ODE) can \
                emerge years after a CDV infection — a slow, progressive brain \
                inflammation driven by persistent viral remnants in the nervous \
                system. This is one of the most unusual long-term sequelae of any \
                viral disease in companion animals.

                **Transmission & Spread**

                CDV spreads primarily through respiratory droplets — coughing, \
                sneezing, or close contact with an infected animal is the most \
                common route. The virus is also shed in urine, feces, saliva, and \
                other bodily secretions. Infected dogs can shed the virus for weeks \
                to months after infection; those with neurological signs may shed \
                for longer.

                The virus does not persist well in the environment — CDV survives \
                less than a day at room temperature and is readily inactivated by \
                heat, sunlight, drying, and common disinfectants. Sustained contact \
                between animals, not contaminated surfaces, drives most transmission.

                High-risk settings include animal shelters, rescue facilities, \
                kennels, dog parks, pet stores, and breeding operations — any \
                environment where unvaccinated or incompletely vaccinated dogs \
                congregate. Wildlife also serves as a major reservoir: raccoons, \
                foxes, skunks, and coyotes can carry and spread CDV. A distemper \
                outbreak in local wildlife can elevate risk for unvaccinated pet \
                dogs in the area.

                The incubation period — the time from exposure to first symptoms — \
                is typically 1 to 4 weeks.

                **Treatment Goals**

                There is no specific antiviral drug approved for canine distemper. \
                Veterinary treatment focuses on providing supportive care to manage \
                dehydration and electrolyte imbalances, controlling secondary \
                bacterial infections, and addressing neurological signs such as \
                seizures. The goal is to stabilize the patient and support its own \
                immune response while limiting disease progression.

                Dogs with significant neurological signs require intensive \
                supportive care and close monitoring. Early veterinary intervention \
                offers the best chance of limiting long-term damage — contact a \
                veterinarian immediately if your dog shows any signs consistent \
                with distemper.

                **Ferrets and Canine Distemper**

                Among companion animals, ferrets are uniquely vulnerable to canine \
                distemper. CDV infection in ferrets is considered nearly universally \
                fatal, and no effective treatment exists once clinical signs appear. \
                A ferret can contract the virus through contact with an infected \
                dog, exposure to wildlife, or contact with contaminated materials. \
                The incubation period in ferrets is typically 7 to 10 days.

                Vaccination is available for ferrets, but only a ferret-approved \
                product should ever be used — standard canine CDV vaccines are not \
                safe for ferrets and carry a significant risk of serious adverse \
                reactions, including anaphylaxis. Because vaccine reactions are a \
                recognized risk even with approved products, monitoring by a \
                veterinarian after each dose is strongly recommended.

                **Myths vs. Facts**

                **Myth:** "My dog got one distemper shot as a puppy — it's protected."
                **Fact:** A single vaccine is not sufficient. Puppies require a \
                series of vaccines given every 3 to 4 weeks until 16 to 20 weeks \
                of age. Stopping the series early — even after one or two doses — \
                can leave a puppy vulnerable. Maternal antibodies passed from the \
                mother can also interfere with early vaccines, which is why the \
                series must continue until maternal immunity has fully waned.

                **Myth:** "Distemper is basically the same as kennel cough."
                **Fact:** They are entirely different diseases. Kennel cough \
                (CIRDC) is typically a mild, self-limiting respiratory illness. \
                Canine distemper is a multi-systemic disease with the potential \
                for irreversible neurological damage — far more serious in scope \
                and consequence.

                **Myth:** "My dog recovered from distemper — it's immune forever \
                and doesn't need vaccines anymore."
                **Fact:** Dogs that survive natural CDV infection do typically \
                develop strong immunity to distemper. However, continued \
                combination vaccine boosters are still recommended to maintain \
                protection against the other diseases in the vaccine — including \
                parvovirus and adenovirus.

                **The Measles Connection**

                Canine distemper virus belongs to the Morbillivirus genus — the \
                same viral family as human measles. The two viruses are closely \
                related enough that ferrets have been used as a scientific model \
                for studying measles, since CDV infection in ferrets produces a \
                disease course strikingly similar to measles in humans. CDV cannot \
                infect humans, but the shared biology between these viruses has \
                made distemper an important subject in comparative medicine and \
                vaccine research.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "1–4 weeks after exposure (fever, eye and nasal discharge, lethargy, loss of appetite)",
                    delayed: "Neurological signs may emerge weeks to months after the initial illness — or, rarely, years later as old dog encephalitis"
                ),
                symptoms: [
                    "Eye discharge (watery at first, becoming thick and yellow or green)",
                    "Nasal discharge",
                    "Fever (often missed in early stages)",
                    "Lethargy, low energy",
                    "Loss of appetite",
                    "Coughing, sneezing",
                    "Difficulty breathing",
                    "Vomiting",
                    "Diarrhea",
                    "Thickened or hardened nose or paw pads",
                    "Skin rash or pustules (especially in young puppies)",
                    "Muscle twitching or tremors",
                    "Repetitive jaw movements (\u{201C}chewing gum fits\u{201D})",
                    "Seizures",
                    "Loss of coordination, stumbling",
                    "Head tilt or circling",
                    "Behavioral changes, disorientation",
                    "Sensitivity to light"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .high,
                        notes: "Primary host. Severity ranges from subclinical to fatal depending on vaccination status, age, and viral strain. Unvaccinated puppies face the greatest risk of severe or fatal disease. Neurological complications may cause permanent damage. Core vaccination is highly effective at preventing infection."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Ferrets are extremely susceptible and CDV infection is considered nearly universally fatal in this species. Other small mammals (rabbits, guinea pigs, rodents) are not susceptible. Vaccination with a ferret-approved product is essential for any ferret with potential exposure to dogs or wildlife."
                    )
                ],
                preventionTips: [
                    "Vaccinate your dog with the core DAPP (or DA2PP) combination vaccine — CDV vaccination is recommended for every dog",
                    "Complete the full puppy vaccination series — doses are given every 3 to 4 weeks until 16 to 20 weeks of age; stopping early can leave your puppy unprotected",
                    "Keep your dog's booster vaccinations current as recommended by your veterinarian",
                    "If you own a ferret, discuss CDV vaccination with an exotic animal veterinarian — only ferret-approved vaccine products should be used, and monitoring after vaccination is recommended",
                    "Avoid dog parks, kennels, pet stores, and other areas where dogs congregate until your puppy's vaccine series is complete",
                    "Limit contact between your pets and unknown wildlife — raccoons, foxes, skunks, and coyotes can carry and spread CDV",
                    "Isolate any dog suspected of having distemper from other pets immediately and contact your veterinarian",
                    "Standard household disinfectants effectively inactivate CDV — routine cleaning of shared spaces is sufficient for environmental decontamination"
                ],
                sources: [
                    "American Veterinary Medical Association (AVMA) — Canine Distemper",
                    "Cornell University College of Veterinary Medicine — Canine Distemper Virus",
                    "Merck Veterinary Manual — Canine Distemper",
                    "UC Davis School of Veterinary Medicine — Canine Distemper",
                    "Texas A&M University College of Veterinary Medicine & Biomedical Sciences — Ferret Distemper"
                ],
                relatedEntries: ["1D000001-0000-0000-0000-000000000002"]
            ),

            // MARK: - Ringworm (Dermatophytosis)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000013")!,
                name: "Ringworm (Dermatophytosis)",
                alternateNames: [
                    "dermatophytosis",
                    "tinea",
                    "ringworm infection",
                    "fungal skin infection",
                    "Microsporum",
                    "Trichophyton",
                    "ringworm in cats",
                    "ringworm in dogs",
                    "ringworm in guinea pigs",
                    "ringworm in rabbits",
                    "dermatomycosis",
                    "ringwom"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "ringworm_thumb",
                description: """
                Despite its name, ringworm is not a worm — it is a fungal \
                infection of the skin, hair, and occasionally nails. The name \
                comes from the circular, raised rash it can produce in people. \
                In animals, the classic ring-shaped lesion is less consistent, \
                but the infection is just as contagious.

                Ringworm is caused by a group of fungi called dermatophytes — \
                organisms that feed on keratin, the structural protein that makes \
                up skin, hair, and nails. The most common species in dogs and \
                cats is Microsporum canis; rabbits, guinea pigs, and other small \
                mammals are most often affected by Trichophyton species.

                This is a zoonotic disease — it can spread between animals and \
                people. It is one of the more commonly transmitted infections \
                between pets and their owners, particularly in households with \
                children, elderly individuals, or people with weakened immune \
                systems.

                Ringworm is rarely life-threatening in otherwise healthy animals \
                and is generally a treatable condition — but it can be persistent, \
                spread readily through a home, and cause significant discomfort. \
                Prompt veterinary evaluation is important both to treat the \
                affected animal and to reduce the risk of transmission to other \
                pets and people in the household.

                Cats, particularly young kittens and longhaired breeds, are a \
                major reservoir and can carry the infection with no visible skin \
                lesions at all. Guinea pigs and rabbits are similarly common \
                silent carriers. An animal that looks completely healthy can \
                still be contagious.

                Reptiles are not susceptible to dermatophytosis and are not \
                included in the species risk section.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Dermatophytes are uniquely adapted to colonize keratin-rich \
                tissue — the outermost layer of skin, the hair shaft, and the \
                nail surface. Unlike most pathogens, they cannot penetrate \
                living, healthy cells; instead, they grow within the non-living, \
                keratinized layers, breaking down keratin as a nutrient source.

                The body's immune response to this invasion is what produces the \
                visible signs of infection. As the immune system recognizes the \
                fungal intrusion, it triggers inflammation in the surrounding \
                tissue — causing the characteristic hair loss (alopecia), \
                redness, scaling, and crusting associated with ringworm. In \
                healthy adult animals, the infection tends to stay superficial \
                and self-limiting. In young, elderly, or immunocompromised \
                animals, it can spread more extensively and become more \
                difficult to resolve.

                The fungi also produce enzymes called keratinases that actively \
                degrade the structural integrity of the hair shaft, which is why \
                infected hairs break off easily — producing the patchy, \
                moth-eaten appearance often seen in cats and small mammals.

                Environmental contamination is a key part of the disease cycle. \
                Fungal spores shed from infected animals can survive on bedding, \
                carpet, grooming tools, and other surfaces for months to years, \
                making household decontamination an essential part of managing \
                an active infection.

                **Transmission & Spread**

                Ringworm spreads through three main routes: direct contact with \
                an infected animal, contact with contaminated objects (fomites) \
                such as bedding, combs, collars, and grooming equipment, and \
                less commonly from contaminated soil. Transmission does not \
                always result in active infection — a critical spore load, \
                minor skin trauma, and a susceptible immune state all contribute \
                to whether exposure leads to disease.

                Cats are considered the primary source of Microsporum canis \
                infections in both other animals and people. Longhaired cats — \
                particularly Persians and related breeds — are significantly \
                overrepresented as carriers and may show no outward signs of \
                infection. Guinea pigs are among the most common sources of \
                ringworm transmitted to people from small mammals, again often \
                with no visible lesions in the animal itself.

                High-risk settings include animal shelters, multi-cat households, \
                rescue environments, pet stores, and breeding facilities. Newly \
                acquired animals — especially kittens, puppies, or small mammals \
                recently obtained from a pet store or shelter — should be \
                monitored closely for early signs of infection.

                The incubation period is typically 1 to 2 weeks, though \
                asymptomatic carriers may never show signs at all.

                **Treatment Goals**

                In otherwise healthy adult animals, ringworm can resolve on its \
                own — but treatment is always recommended to shorten the course \
                of infection, prevent spread to other animals and people in the \
                household, and reduce environmental contamination. Treatment \
                typically combines topical therapy applied to the skin and coat \
                with systemic treatment to address infection within hair \
                follicles that topical products cannot reach alone.

                Full resolution typically takes 6 to 12 weeks. All animals in \
                the household should be evaluated, as asymptomatic carriers will \
                continue to re-infect treated animals if left unaddressed. \
                Environmental decontamination — regular cleaning of surfaces, \
                bedding, and grooming tools — is an essential part of treatment.

                Early veterinary evaluation means faster resolution and a lower \
                risk of transmission to people in the home.

                **Zoonotic Risk**

                Ringworm is one of the most commonly transmitted infections \
                between pets and people. People can become infected through \
                direct contact with an infected animal or through contact with \
                contaminated bedding, furniture, or grooming equipment. In \
                people, ringworm typically causes itchy, circular, red skin \
                lesions that are treatable but uncomfortable.

                Children, elderly individuals, and people who are \
                immunocompromised are at greatest risk. If your pet has been \
                diagnosed with ringworm, take precautions when handling them \
                and contact your own physician if you develop any skin lesions.

                **Myths vs. Facts**

                **Myth:** "Ringworm is caused by a worm."
                **Fact:** Ringworm has nothing to do with worms. It is a fungal \
                infection — the name comes from the circular, ring-shaped rash \
                it can cause on human skin. In animals, the classic ring shape \
                is often absent entirely.

                **Myth:** "If my cat has ringworm, I'll be able to see it."
                **Fact:** Cats — especially longhaired breeds and young kittens \
                — are well-known for carrying ringworm with no visible signs. A \
                completely normal-looking cat can be actively shedding infectious \
                spores and spreading the infection to other pets and people in \
                the home.

                **Myth:** "My pet's ringworm cleared up on its own, so it's gone."
                **Fact:** Apparent resolution of visible lesions does not mean \
                the infection has been eliminated. Fungal culture or PCR testing \
                is the only reliable way to confirm that an animal is no longer \
                infectious. Stopping treatment early is one of the most common \
                reasons ringworm persists in a household for months.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "1–2 weeks after exposure (patchy hair loss, redness, scaling — often beginning around the face, ears, and legs)",
                    delayed: "Without treatment, infection can spread to cover larger areas of the body; environmental spores can cause ongoing reinfection for months"
                ),
                symptoms: [
                    "Patchy hair loss (often circular or irregular)",
                    "Red, scaly, or crusted skin at the edges of hair loss patches",
                    "Itching (variable — may be mild or absent)",
                    "Broken or brittle hairs around affected areas",
                    "Skin redness or inflammation",
                    "Thickened or discolored nail beds (less common)",
                    "No visible symptoms at all (asymptomatic carriers — especially cats and guinea pigs)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Most significant reservoir species for Microsporum canis. Longhaired breeds (Persian, Himalayan) and young kittens are overrepresented. Asymptomatic carriage is common — cats can be infectious with no visible lesions. Persian cats may develop nodular lesions."
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Affected but typically less severely than cats. Lesions most often appear on the face, ears, feet, and tail. Yorkshire Terriers and Jack Russell Terriers are overrepresented. Working and hunting dogs may develop kerion lesions — inflamed, nodular, draining skin masses."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Rabbits and guinea pigs are commonly affected; guinea pigs are among the most significant sources of human ringworm from small mammals, often without showing any symptoms themselves. Chinchillas, rats, and mice are less commonly affected; ferrets occasionally via contact with infected cats."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Rarely affected. Dermatophytes primarily target mammalian keratin; bird feather structure differs significantly. Occasional cases reported in immunocompromised individuals. Consult an avian veterinarian if unusual skin or feather changes are observed."
                    )
                ],
                preventionTips: [
                    "If a new pet develops patchy hair loss, skin crusting, or scaling — particularly within the first few weeks of joining the household — consult your veterinarian promptly",
                    "Newly acquired kittens, puppies, or small mammals (especially guinea pigs and rabbits) from shelters or pet stores should be monitored closely; consider a veterinary exam before introducing them to other pets",
                    "Wear gloves when handling an animal with suspected or confirmed ringworm, and wash hands thoroughly afterward",
                    "Avoid allowing infected animals on furniture, carpets, or bedding until cleared by your veterinarian — ringworm spores can persist in the environment for months",
                    "Launder bedding, blankets, and soft toys from the infected animal's environment regularly",
                    "Disinfect hard surfaces and grooming tools — diluted bleach (1:10 dilution with water) is effective against dermatophyte spores on non-porous surfaces; discard porous items (wood, rope toys) that cannot be disinfected",
                    "All animals in the household should be evaluated when one is diagnosed — asymptomatic carriers will undermine treatment of other pets if left unaddressed",
                    "If any person in the household develops circular, itchy, red skin lesions, contact your own physician and mention that your pet has been diagnosed with ringworm",
                    "Individuals who are immunocompromised, pregnant, elderly, or very young should take extra precautions when handling an animal with ringworm or suspected exposure"
                ],
                sources: [
                    "Merck Veterinary Manual — Dermatophytosis in Dogs and Cats",
                    "Cornell University College of Veterinary Medicine — Ringworm",
                    "ASPCA Animal Poison Control Center",
                    "LafeberVet — Dermatophytosis in Small Mammals",
                    "World Association for Veterinary Dermatology — Consensus Guidelines on Dermatophytosis in Dogs and Cats"
                ],
                relatedEntries: nil
            ),

            // MARK: - Aspergillosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000014")!,
                name: "Aspergillosis",
                alternateNames: [
                    "Aspergillus infection",
                    "fungal pneumonia",
                    "nasal aspergillosis",
                    "sinonasal aspergillosis",
                    "disseminated aspergillosis",
                    "brooder pneumonia",
                    "fungal rhinitis",
                    "aspergilloma",
                    "asper",
                    "Aspergillus fumigatus",
                    "aspergillosis in birds",
                    "aspergillosis in dogs"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "aspergillosis_thumb",
                description: """
                Aspergillosis is a fungal disease caused by Aspergillus — a \
                genus of mold found virtually everywhere in the environment: in \
                soil, decaying plant matter, compost, dust, moldy feed, and \
                household air. Almost every animal (and person) inhales \
                Aspergillus spores daily without any consequence. Disease \
                develops only when the immune system is compromised, when the \
                animal is exposed to an overwhelming spore load, or — in some \
                dogs — through mechanisms not yet fully understood.

                What makes aspergillosis unusual among infectious diseases is \
                that the same fungus causes completely different clinical \
                syndromes depending on the species affected. In dogs, it most \
                often targets the nasal cavity. In cats, it tends to invade the \
                tissues around the eye, sometimes causing dramatic facial \
                swelling and eye changes. In birds, it is primarily a \
                respiratory disease that attacks the lungs and air sacs — and \
                it is one of the most serious and common infections in pet birds.

                Aspergillosis is not contagious between animals, and direct \
                transmission from a pet to a person does not occur — both \
                people and animals acquire the infection independently from the \
                environment.

                The clinical outlook varies significantly by species and form. \
                The nasal form in dogs is generally manageable with treatment. \
                The disseminated form in dogs, and respiratory aspergillosis in \
                birds, carries a much more serious outlook — particularly when \
                diagnosis is delayed.

                Small mammals and reptiles are not considered significantly \
                susceptible and are not included in the species section.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Aspergillus spores are inhaled, and in a healthy animal with \
                an intact immune system, they are simply cleared. When the \
                immune defenses fail — whether due to immune suppression, \
                unusually high spore exposure, or localized immune dysfunction \
                — the spores germinate and grow into thread-like fungal \
                filaments called hyphae (HY-fee). These hyphae invade tissue, \
                destroying it as they expand.

                In dogs, the fungus typically colonizes the nasal cavity and \
                sinuses, forming dense fungal plaques and sometimes a compacted \
                mass of fungal growth called an aspergilloma (fungal ball). The \
                infection produces enzymes that destroy the delicate turbinate \
                bones — the thin, scroll-like bones inside the nose — and the \
                sinus lining. This bone destruction drives the three hallmark \
                signs of canine nasal aspergillosis: persistent bloody nasal \
                discharge, ulceration and depigmentation (loss of color) of \
                the nostril, and facial pain or discomfort.

                In cats, Aspergillus more often invades the tissues surrounding \
                the eye — a form called sino-orbital aspergillosis. The \
                infection can cause the eye to bulge outward, compress the \
                optic nerve, and in severe cases destroy orbital bone or extend \
                toward the brain. Aspergillus felis — a relatively recently \
                identified fungal species — is responsible for many feline \
                cases and is notoriously difficult to treat.

                The most dangerous canine form — disseminated aspergillosis — \
                occurs when the fungus escapes the respiratory tract and seeds \
                through the bloodstream to distant organs, most often the \
                spine, kidneys, lymph nodes, and eyes. This form is strongly \
                associated with German Shepherd Dogs, particularly middle-aged \
                females, suggesting a breed-specific immune vulnerability.

                In birds, the fungus lodges in the lungs and air sacs — \
                thin-walled extensions of the respiratory system that connect \
                to the hollow bones throughout the body. The poor blood supply \
                to air sac tissue limits the immune response there, giving the \
                fungus an opportunity to form plaques, nodules, and granulomas \
                largely unchallenged. By the time obvious signs of respiratory \
                distress appear in a pet bird, the disease is often already \
                extensive.

                **Transmission & Spread**

                Aspergillosis is not transmitted from animal to animal or from \
                a pet to a person. Every animal acquires infection directly \
                from the environment. The fungus is found in soil, compost, \
                decaying organic matter, hay, straw, dusty bedding, moldy \
                feed, and even ordinary household air. It exists on every \
                continent except Antarctica.

                For pet birds, the most common sources of exposure are \
                contaminated or poorly stored seed and feed, moldy or dusty \
                cage litter, and poor ventilation that allows spore \
                concentrations to build indoors. Stress is a major risk factor \
                — capture, transport, other illness, malnutrition, or prolonged \
                antibiotic use can all suppress the immune response enough to \
                allow an established Aspergillus spore load to take hold. \
                Birds fed all-seed diets are at particular risk because seeds \
                are deficient in vitamin A, a nutrient essential to the health \
                of the respiratory tract lining and to immune function.

                In dogs, the nasal form can affect animals with apparently \
                normal immune systems. The disseminated form, however, is \
                generally believed to require an underlying immune defect, \
                though one is not always identified.

                The incubation period is variable and not well defined — \
                disease develops gradually as fungal growth accumulates over \
                weeks to months.

                **Treatment Goals**

                Treatment of aspergillosis is challenging and must be tailored \
                to the form of the disease, the species affected, and how far \
                the infection has progressed.

                For nasal aspergillosis in dogs, treatment focuses on \
                eliminating the infection from the nasal cavity and sinuses. \
                Full resolution takes time and a single treatment course may \
                need to be repeated. For cats with sino-orbital disease and \
                dogs with disseminated disease, extended systemic antifungal \
                treatment is required.

                For birds, treatment goals include reducing the fungal burden \
                in the respiratory tract, supporting immune function, and \
                managing secondary infections. Treatment is intensive and \
                requires prolonged care under the supervision of an avian \
                veterinarian. Outcome depends heavily on how early the disease \
                is identified — birds that are diagnosed before severe \
                respiratory compromise develops have a better chance of \
                responding to treatment.

                Contact a veterinarian promptly if your pet shows signs \
                consistent with aspergillosis — particularly chronic nasal \
                discharge in dogs or any respiratory changes, voice change, or \
                unexplained lethargy in a pet bird.

                **The Name and the Priest**

                The fungus gets its name from an unusual source. In 1729, an \
                Italian priest and biologist named Pier Antonio Micheli was \
                examining mold under a microscope and noticed that the \
                spore-forming structure of the fungus bore a striking \
                resemblance to an aspergillum — the perforated, mace-like \
                implement Catholic priests use to sprinkle holy water during \
                liturgical ceremonies. He named the genus Aspergillus \
                accordingly. The name has endured for nearly 300 years, making \
                this one of the few diseases whose name traces back to a piece \
                of church equipment.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Nasal form in dogs: chronic discharge developing over weeks to months; bird respiratory form: subtle changes in breathing, activity, or voice may be the first signs",
                    delayed: "Disseminated disease in dogs and advanced respiratory aspergillosis in birds can develop silently over weeks to months; by the time obvious illness is apparent, significant tissue damage may already be present"
                ),
                symptoms: [
                    "Chronic nasal discharge — often from one nostril first, may become bloody or foul-smelling (dogs)",
                    "Sneezing and nasal congestion (dogs, cats)",
                    "Nosebleeds (dogs)",
                    "Loss of color (depigmentation) or ulceration of the nostril (dogs)",
                    "Facial pain or rubbing of the face (dogs)",
                    "Bulging or protruding eye, or elevation of the third eyelid (cats — orbital form)",
                    "Facial swelling (cats — orbital form)",
                    "Labored or rapid breathing, open-mouth breathing (birds)",
                    "Change in voice or loss of vocalization (birds)",
                    "Tail bobbing with each breath (birds)",
                    "Decreased activity, fluffed feathers, sleeping more than usual (birds)",
                    "Weight loss, loss of appetite",
                    "Lameness or spinal pain, difficulty rising (dogs — disseminated form)",
                    "Loss of coordination (dogs — disseminated form; birds — if nervous system involved)",
                    "Eye redness, cloudiness, or vision changes"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .bird,
                        severity: .high,
                        notes: "Most susceptible companion animal species. Aspergillus fumigatus is the primary pathogen. African grey parrots, Amazon parrots, and raptors are especially susceptible; all pet bird species are at risk. Disease is primarily respiratory, targeting the lungs and air sacs. Often diagnosed late due to birds' instinct to mask illness. Vitamin A deficiency and stress are major risk factors."
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Two distinct forms: sinonasal aspergillosis (common; long-nosed breeds preferentially affected) and disseminated aspergillosis (rare; strongly associated with German Shepherd Dogs, particularly middle-aged females). These are caused by different Aspergillus species and are clinically distinct — sinonasal disease does not progress to disseminated disease."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Less common than in dogs but can be severe. Brachycephalic breeds (Persian, Himalayan) are overrepresented. Sino-orbital disease — where infection extends to the tissues around the eye — is characteristic in cats and can cause eye bulging, facial swelling, and orbital bone destruction. Aspergillus felis is an emerging pathogen in cats that is difficult to treat."
                    )
                ],
                preventionTips: [
                    "For pet birds: provide fresh, high-quality feed and discard any seed or food that appears damp, discolored, or smells musty — moldy feed is a major source of Aspergillus spore exposure",
                    "Feed pet birds a nutritionally complete diet; all-seed diets are deficient in vitamin A, which is essential for respiratory tract health and immune function",
                    "Maintain good ventilation in bird enclosures — poor airflow allows spore concentrations to build indoors; avoid housing birds in dusty, damp, or poorly ventilated areas",
                    "Clean bird cages and enclosures regularly; do not allow droppings, feathers, or old food to accumulate",
                    "Minimize sources of stress in pet birds — capture, transport, overcrowding, prolonged illness, and extended antibiotic use are all risk factors for the immune suppression that allows aspergillosis to develop",
                    "For dogs: promptly evaluate any chronic or bloody nasal discharge with a veterinarian — earlier diagnosis of nasal aspergillosis allows for more effective treatment",
                    "Do not delay veterinary evaluation for a pet bird showing any signs of breathing difficulty, voice change, or unexplained lethargy — aspergillosis is often advanced by the time respiratory signs are obvious"
                ],
                sources: [
                    "Merck Veterinary Manual — Aspergillosis in Animals",
                    "Cornell University College of Veterinary Medicine — Aspergillosis",
                    "VCA Animal Hospitals — Aspergillosis in Dogs; Aspergillosis in Birds",
                    "Cornell Wildlife Health Lab — Aspergillosis",
                    "Veterinary Partner — Aspergillosis in Birds"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000015",  // Cryptococcosis
                    "1D000001-0000-0000-0000-000000000016",  // Coccidioidomycosis (Valley Fever)
                    "1D000001-0000-0000-0000-000000000017",  // Pythiosis
                    "1D000001-0000-0000-0000-000000000035",  // Air Sac Mites (Sternostoma tracheacolum)
                    "1D000001-0000-0000-0000-000000000042",  // Reptile Respiratory Infections
                    "1D000001-0000-0000-0000-000000000043",  // Reptile Husbandry Guide
                    "1D000001-0000-0000-0000-000000000044"   // Bird Husbandry Guide
                ]
            ),

            // MARK: - Cryptococcosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000015")!,
                name: "Cryptococcosis",
                alternateNames: [
                    "Cryptococcal disease",
                    "Cryptococcal meningitis",
                    "Cryptococcal infection",
                    "Cryptococcus neoformans infection",
                    "Cryptococcus gattii infection",
                    "C. neoformans",
                    "C. gattii",
                    "cryptoccocosis",
                    "cyptococcosis",
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "cryptococcosis_thumb",
                description: """
                Cryptococcosis is a potentially serious fungal infection caused by \
                Cryptococcus neoformans and Cryptococcus gattii — two closely related \
                encapsulated yeasts found widely in the environment. The name comes from \
                the Ancient Greek kryptos (\u{201C}hidden\u{201D}) and kokkos \
                (\u{201C}berry\u{201D}) — a fitting description for an organism that \
                conceals its yeast cells beneath a thick protective capsule designed \
                to evade the immune system.

                The disease can develop gradually over weeks to months, and in some \
                animals may not be recognized until it has already spread beyond its \
                initial site of infection. Cats are the most commonly affected \
                companion animal and can develop four clinical forms: nasal (most \
                common), central nervous system (CNS), cutaneous (skin), and systemic. \
                Dogs are less commonly affected but are more likely to present with \
                disseminated disease involving the brain and eyes.

                Cryptococcosis is not contagious between animals or from pets to people \
                through direct contact — infection occurs from environmental exposure, \
                not from an infected pet. No vaccine is currently available. Both indoor \
                and outdoor pets are susceptible. Animals with weakened immune systems \
                may be at higher risk for severe disease.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                The defining feature of Cryptococcus is its thick polysaccharide \
                (complex sugar) capsule — but here is what makes it extraordinary: \
                that capsule is not a permanent feature. In the environment, the \
                organism carries only a minimal coat. When it detects the internal \
                conditions of a mammalian host — lower glucose, elevated carbon dioxide, \
                low iron — it activates full capsule production. The capsule is \
                essentially a triggered weapon, switched on by the body it is about \
                to infect.

                Once inside, the capsule shields the organism from immune recognition \
                and can continue to expand within host tissue. The organism is also \
                capable of surviving inside macrophages — the immune cells specifically \
                tasked with destroying it — and escaping without killing them, a process \
                called vomocytosis. This allows the infection to spread stealthily \
                through the body while appearing, at least initially, to be contained. \
                Cryptococcus neoformans was the first pathogen in which vomocytosis \
                was observed.

                Most infections begin in the nasal cavity after a pet inhales fungal \
                spores. From there, the organism can cross the cribriform plate — the \
                thin bony shelf separating the nasal cavity from the brain — and enter \
                the central nervous system directly. It can also spread through the \
                bloodstream to the skin, eyes, lungs, and other organs. In dogs, more \
                than half of affected animals have CNS or ocular involvement at the \
                time of diagnosis. In cats, the nasal form is most common, though CNS \
                spread can follow.

                **Transmission & Spread**

                Cryptococcus neoformans has worldwide distribution and is closely \
                associated with pigeon and other bird droppings, where the organism \
                thrives in a nitrogen-rich environment. Viable organisms can persist \
                in dried pigeon droppings for up to two years. Spores and desiccated \
                yeast cells are also found in soil, decaying wood, and leaf litter. \
                When this material is disturbed — by wind, construction, or soil \
                disruption — infectious particles become airborne and can be inhaled.

                The animal most associated with spreading Cryptococcus neoformans — \
                the pigeon — rarely develops clinical disease from it. The organism \
                passes harmlessly through the pigeon\u{2019}s gut and is shed in \
                large quantities in droppings. When that material dries and becomes \
                airborne, it reaches susceptible hosts nearby. A pigeon roosting on \
                a balcony or in an attic represents an environmental risk that is \
                easy to overlook.

                Cryptococcus gattii was historically considered restricted to tropical \
                and subtropical regions. This changed in 1999, when C. gattii emerged \
                on Vancouver Island, British Columbia — a temperate climate where no \
                tropical pathogen had been expected. The outbreak strain was later \
                identified as a novel genotype produced by an unusual same-sex mating \
                event. The organism spread to mainland British Columbia by 2004 and \
                to Washington and Oregon by 2006, establishing an endemic zone across \
                the Pacific Northwest. Pet owners along the Pacific coast — particularly \
                in California, Oregon, Washington, and British Columbia — face elevated \
                environmental exposure compared to other regions of North America.

                Infection requires inhalation of spores from the environment. Direct \
                transmission between animals, or from an infected pet to a person, \
                does not occur.

                **Treatment Goals**

                Because the organism can spread significantly before symptoms become \
                obvious, prompt diagnosis is important. Veterinary evaluation — \
                including antigen detection testing on blood or other body fluids and \
                potentially imaging — helps determine the extent of disease. Treatment \
                requires extended antifungal therapy lasting many months, with regular \
                monitoring for medication tolerance and disease response. Antigen levels \
                in the blood can be tracked over time to assess treatment progress. \
                Animals with CNS or disseminated disease require more intensive \
                management. Even after apparent resolution, ongoing monitoring for \
                relapse is recommended, as recurrence is documented.

                **Zoonotic Risk**

                Cryptococcosis is not considered a direct zoonotic disease — a sick \
                cat or dog cannot pass the infection to you through normal contact. \
                Both animals and humans acquire infection from the same environmental \
                sources: contaminated soil, bird droppings, and decaying organic \
                material.

                Immunocompromised individuals — including transplant recipients, those \
                on immunosuppressive medications, or people with HIV — face genuine \
                risk from environmental Cryptococcus exposure. Rare cases of infection \
                linked to exposure to infected pet bird droppings have been documented \
                in medical literature. Pets with cryptococcosis may serve as sentinels \
                alerting owners to the presence of the organism in their shared \
                environment. If you or a household member is immunocompromised and \
                your pet has been diagnosed with cryptococcosis, contact your physician \
                to discuss appropriate precautions.

                **The Hidden Berry**

                The name Cryptococcus — \u{201C}hidden berry\u{201D} — was originally \
                chosen because early microscopists struggled to see the organism clearly. \
                The species name neoformans (\u{201C}new shaping\u{201D}) was given by \
                Italian researcher Francesco Sanfelice in 1895, after isolating it from \
                fermented peach juice. The genus was formally described in 1901 by \
                French mycologist Jean-Paul Vuillemin, after he realized the organism \
                did not behave like the yeast it was originally mistaken for.

                The leading theory for why this soil fungus evolved the ability to \
                evade mammalian immune systems involves amoebae. For millions of years, \
                Cryptococcus lived in soil where amoebae — single-celled organisms that \
                engulf and digest microbes — posed the primary threat. Amoebae attack \
                cells the same way mammalian macrophages do. The fungus developed its \
                immune evasion and intracellular survival tools to defeat amoebae, and \
                those same tools happen to work against mammalian immune cells. \
                Mammals are, in a sense, collateral damage. Researchers call this \
                concept \u{201C}accidental virulence.\u{201D}

                **The Chernobyl Fungus**

                In one of the more unexpected footnotes in mycology, colonies of \
                Cryptococcus neoformans were found growing inside the ruins of the \
                Chernobyl Nuclear Power Plant — one of the most radioactively \
                contaminated environments on Earth. Studies have suggested these \
                colonies may be able to metabolize ionizing radiation as an energy \
                source, in a process analogous to photosynthesis. The same melanin \
                pigment that helps Cryptococcus survive inside macrophages appears to \
                be involved. Whether this represents a meaningful survival advantage \
                in clinical infection is still being studied.

                **Myths vs. Facts**

                **Myth:** If my indoor cat never goes outside, they are safe from \
                cryptococcosis.
                **Fact:** Indoor cats can still be exposed. Spores can be tracked \
                indoors on shoes or on the paws of other pets that go outside. Both \
                indoor and outdoor cats have been diagnosed with the disease.

                **Myth:** If my cat has cryptococcosis, I can catch it from them.
                **Fact:** Cryptococcosis is not transmitted directly from pet to \
                person. A sick cat is not contagious to you. However, you and your \
                pet may have been exposed to the same environmental source — the real \
                risk comes from the environment, not the animal.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Weeks to months after exposure: chronic nasal discharge, sneezing, facial swelling, skin nodules",
                    delayed: "Months to years: central nervous system signs including sudden blindness, seizures, behavioral changes, and loss of balance may develop as disease progresses or spreads"
                ),
                symptoms: [
                    "Chronic nasal discharge (thick; may be bloody, yellow, or green)",
                    "Frequent sneezing",
                    "Loud or labored breathing",
                    "Swelling over the bridge of the nose",
                    "Visible masses or growths in or around the nostrils",
                    "Skin nodules — firm, non-painful lumps, especially around the head, face, and neck",
                    "Sudden blindness or dilated, unresponsive pupils",
                    "Seizures",
                    "Behavioral changes, confusion, or disorientation",
                    "Head tilt, loss of balance, or difficulty walking",
                    "Weight loss and loss of appetite",
                    "Lethargy",
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .high,
                        notes: "Most commonly affected companion animal; both indoor and outdoor cats at risk; nasal form most common; CNS, skin, and systemic forms possible; cats with FIV may experience more severe disease or poorer treatment response"
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Less common than cats; however, more than half of affected dogs have CNS or ocular involvement at diagnosis; neurological and eye signs often predominate over nasal signs"
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .low,
                        notes: "Ferrets are the most commonly affected small mammal; documented in the Vancouver Island C. gattii outbreak; cases in guinea pigs and rodents reported rarely; immunocompromised individuals at higher risk"
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Pet birds can harbor the organism in droppings without developing clinical disease; rare clinical infections documented (notably in cockatoos); pigeons are the primary environmental reservoir but rarely develop disease themselves"
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Documented in literature but very rare; any chronic respiratory illness in reptiles warrants veterinary evaluation"
                    ),
                ],
                preventionTips: [
                    "Keep cats indoors where possible, particularly in endemic regions (Pacific coast of North America, parts of Europe and Australia)",
                    "Avoid areas with heavy accumulations of pigeon or bird droppings; clean them up promptly and wear a mask when doing so",
                    "Limit your pet\u{2019}s access to areas with disturbed soil, decaying wood, or leaf litter accumulations, especially in endemic regions",
                    "No vaccine is currently available for cryptococcosis",
                    "Pets with weakened immune systems — including those on long-term immunosuppressive therapy — may be at higher risk; discuss this with your veterinarian",
                    "Even indoor cats can be exposed; spores can be carried inside on shoes or the paws of other pets",
                    "If you are immunocompromised and your pet is diagnosed with cryptococcosis, consult your physician about appropriate precautions",
                ],
                sources: [
                    "Merck Veterinary Manual — Cryptococcosis in Animals (merckvetmanual.com, revised 2024)",
                    "Cornell University College of Veterinary Medicine — Cryptococcosis (vet.cornell.edu)",
                    "Texas A&M School of Veterinary Medicine — Cryptococcal Fungal Infections (vetmed.tamu.edu, 2024)",
                    "ABCD Guidelines — Cryptococcosis in Cats (abcdcatsvets.org, revised 2025)",
                    "CDC MMWR — Emergence of Cryptococcus gattii, Pacific Northwest, 2004\u{2013}2010 (cdc.gov)",
                    "Wikipedia — Cryptococcus neoformans (en.wikipedia.org, citing peer-reviewed sources for Chernobyl and vomocytosis data)",
                    "PetMD — Cryptococcosis in Cats (petmd.com)",
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000016",  // Coccidioidomycosis (Valley Fever)
                    "1D000001-0000-0000-0000-000000000017"   // Pythiosis
                ]
            ),

            // MARK: - Coccidioidomycosis (Valley Fever)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000016")!,
                name: "Coccidioidomycosis (Valley Fever)",
                alternateNames: [
                    "Valley Fever",
                    "San Joaquin Valley Fever",
                    "Desert Fever",
                    "Desert Rheumatism",
                    "Cocci",
                    "Coccidioides",
                    "coccidiomycosis",
                    "coccidiodomycosis",
                    "Coccidioidomycoses"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "valley_fever_thumb",
                description: """
                Coccidioidomycosis — commonly known as Valley Fever — is a serious \
                fungal infection caused by Coccidioides immitis or Coccidioides \
                posadasii, microscopic fungi that live in the dry soil of arid and \
                semi-arid regions. Dogs are by far the most commonly and severely \
                affected companion animals; cats can develop infection but far less \
                frequently and typically with a milder course.

                The disease begins when a pet inhales fungal spores — called \
                arthroconidia — released into the air by disturbed soil. In many \
                animals, the immune system contains the infection to the lungs. In \
                others, particularly dogs, the fungus can disseminate through the \
                bloodstream to other organ systems including bones, joints, skin, eyes, \
                and the brain and spinal cord. Disseminated Valley Fever can be \
                life-threatening and may require months of treatment.

                There is currently no approved vaccine for Valley Fever in dogs or \
                cats. Pets living in or traveling through endemic areas — particularly \
                the southwestern United States — are at ongoing risk of exposure.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Coccidioides fungi exist in the environment as a mold, producing hardy \
                barrel-shaped spores called arthroconidia. When inhaled, these spores \
                transform inside the body into a completely different structure: a \
                large, thick-walled sphere called a spherule, which fills with hundreds \
                of internal daughter cells called endospores. When the spherule ruptures, \
                it releases those endospores into surrounding lung tissue — each capable \
                of forming a new spherule. This explosive reproductive cycle drives \
                intense inflammation.

                **The Shape-Shifter**
                This dual-form (dimorphic) life cycle — mold in the environment, \
                spherule inside the body — is what makes Coccidioides so difficult for \
                the immune system to clear. The spherule form is largely resistant to \
                the initial immune response, and each rupturing spherule releases a new \
                wave of organisms that the body must fight again from the start.

                In most animals with healthy immune systems, infection remains confined \
                to the lungs (pulmonary coccidioidomycosis), causing respiratory \
                symptoms that may resolve — or persist — without treatment. In dogs \
                especially, the fungus can escape pulmonary containment and travel \
                through the bloodstream to distant sites. Disseminated disease most \
                commonly affects bones and joints (causing pain and lameness), skin \
                (causing draining wounds or nodules), eyes (causing inflammation or \
                vision changes), lymph nodes, and the brain and spinal cord. \
                Neurological involvement — including seizures and sudden behavioral \
                changes — is considered one of the most serious and \
                rapidly-progressing complications.

                **Transmission & Spread**

                Valley Fever is not contagious between animals, or from animals to \
                humans through direct contact. All infection originates from inhaling \
                spores from the environment.

                Coccidioides fungi live exclusively in the soil of specific geographic \
                regions — primarily the Lower Sonoran Life Zone: the desert Southwest \
                of the United States (Arizona, California's San Joaquin Valley, New \
                Mexico, and Texas), and parts of Mexico, Central America, and South \
                America. Two species are recognized: Coccidioides immitis is found \
                primarily in California and South America; Coccidioides posadasii \
                dominates in Arizona, Texas, New Mexico, and northern Mexico.

                **The Expanding Desert**
                Historically confined to the classic desert Southwest, the endemic zone \
                for Valley Fever has been expanding. Studies have documented Coccidioides \
                in previously unaffected regions further north and east — a trend linked \
                to drought conditions, warming temperatures, and shifting precipitation \
                patterns. Veterinarians outside the traditional endemic zone are \
                increasingly seeing Valley Fever cases, including in pets that have \
                never left their home region.

                **The Great Digger Problem**
                Dogs are dramatically overrepresented in Valley Fever cases compared to \
                cats — and behavior likely plays a significant role. Dogs dig, nose \
                through soil, and sniff ground-level disturbed earth constantly, \
                increasing their inhalation exposure to spores. Digging activities in \
                endemic areas — particularly in dry, dusty conditions or after rain has \
                loosened and dried the soil surface — represent some of the \
                highest-risk exposure scenarios.

                The incubation period — the time from spore inhalation to the \
                appearance of signs — typically ranges from one to three weeks. \
                Disseminated disease may not become apparent until weeks to months \
                after the initial exposure.

                **Treatment Goals**

                Treatment for Valley Fever is aimed at suppressing fungal replication, \
                controlling inflammation, and preventing or limiting further \
                dissemination. Treatment courses are typically prolonged — often \
                several months to over a year, and sometimes indefinitely in animals \
                with severe or disseminated disease. Animals with bone, joint, or \
                neurological involvement require close veterinary monitoring throughout \
                treatment. Some animals experience relapses after treatment is \
                discontinued, making long-term follow-up important.

                **Zoonotic Risk**

                Valley Fever is zoonotic, but the route of transmission to humans is \
                the same as it is for pets: inhalation of spores from contaminated \
                soil. Coccidioidomycosis cannot be transmitted from an infected pet to \
                a human through direct contact, handling, bites, or bodily secretions.

                The practical implication for pet owners is that if your pet has been \
                diagnosed with Valley Fever, you and your pet were most likely exposed \
                to the same environment. Humans who have spent time in endemic areas — \
                particularly those who are immunocompromised, pregnant, elderly, or \
                very young — should consult their own physician if they develop \
                unexplained respiratory illness after potential soil exposure. If your \
                pet is suspected or confirmed to have Valley Fever, take standard \
                hygienic precautions when handling any draining skin wounds, and \
                contact your physician if you have concerns about your own exposure.

                **Myths vs. Facts**

                **Myth:** I can catch Valley Fever directly from my dog.
                **Fact:** Coccidioidomycosis is not transmitted animal-to-animal or \
                animal-to-human through contact. Both you and your pet contract it \
                independently from the same contaminated environment.

                **Myth:** Valley Fever only affects pets in Arizona or California.
                **Fact:** While the disease is most common in the classic desert \
                Southwest, the endemic zone is expanding. Pets that have traveled to \
                endemic areas — even briefly — can develop Valley Fever after returning \
                home, and cases are increasingly documented outside the traditional \
                geographic range.

                **Myth:** A dog that recovered from Valley Fever is permanently immune.
                **Fact:** Recovery may confer partial immunity, but reinfection and \
                reactivation of dormant infection are both possible, particularly in \
                immunocompromised or older animals.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Signs typically appear 1–3 weeks after spore inhalation. Initial signs are most often respiratory — cough, lethargy, and reduced appetite.",
                    delayed: "Disseminated disease — spread to bones, joints, skin, eyes, or the nervous system — may develop weeks to months after initial infection and represents a significant escalation in severity."
                ),
                symptoms: [
                    "Persistent or worsening cough (often the first sign)",
                    "Lethargy and reduced energy",
                    "Decreased appetite",
                    "Fever",
                    "Weight loss",
                    "Labored or rapid breathing",
                    "Lameness or reluctance to bear weight",
                    "Swollen or painful joints",
                    "Draining skin wounds or firm nodules under the skin",
                    "Eye redness, cloudiness, or apparent vision changes",
                    "Swollen lymph nodes",
                    "Seizures or sudden incoordination (neurological involvement)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Most commonly and severely affected species. Digging and soil-sniffing behavior increases spore inhalation exposure. Dissemination to bones, joints, skin, eyes, and the nervous system is well-documented and can be life-threatening."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Can develop Valley Fever but significantly less often than dogs. Clinical disease tends to be milder; respiratory and skin forms predominate. Disseminated disease is less common in cats."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .low,
                        notes: "Wild rodents serve as environmental reservoir hosts in endemic areas but rarely develop clinical disease. Documented clinical cases in pet small mammals are limited."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Most avian species are considered resistant to Coccidioides infection. Rare case reports exist, but clinical disease in pet birds is not well established."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Coccidioidomycosis has been documented in wild lizards in endemic regions. Clinical cases in pet reptiles are uncommon and published data are limited."
                    )
                ],
                preventionTips: [
                    "Restrict digging and ground-rooting activities in endemic areas, particularly in dry or dusty conditions and after soil disturbance",
                    "Keep pets away from construction sites, excavation zones, and heavily disturbed soil in the southwestern United States",
                    "Pets traveling to endemic areas (Arizona, California's San Joaquin Valley, New Mexico, Texas) should be monitored for signs of illness for several weeks after return",
                    "No approved vaccine is currently available for Valley Fever in dogs or cats",
                    "Seek prompt veterinary evaluation if a pet in or from an endemic area develops a persistent cough, unexplained lethargy, or lameness",
                    "Wash hands thoroughly after handling draining skin wounds on a Valley Fever-positive pet and follow your veterinarian's hygiene guidance",
                    "If your pet is diagnosed with Valley Fever, consult your own physician about shared environmental exposure — particularly if you are immunocompromised, pregnant, elderly, or very young",
                    "Always inform your veterinarian about travel to endemic areas when presenting a pet with respiratory or musculoskeletal signs"
                ],
                sources: [
                    "Merck Veterinary Manual — Coccidioidomycosis: merckvetmanual.com",
                    "University of Arizona Valley Fever Center for Excellence: vfce.arizona.edu",
                    "Centers for Disease Control and Prevention (CDC) — Valley Fever: cdc.gov/valley-fever",
                    "Cornell University College of Veterinary Medicine: vet.cornell.edu",
                    "VCA Animal Hospitals — Valley Fever in Dogs: vcahospitals.com",
                    "Wikipedia — Coccidioides (geographic range, dimorphic mechanism, species distribution): en.wikipedia.org/wiki/Coccidioides"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000015",  // Cryptococcosis
                    "1D000001-0000-0000-0000-000000000017"   // Pythiosis
                ]
            ),

            // MARK: - Pythiosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000017")!,
                name: "Pythiosis",
                alternateNames: [
                    "Swamp cancer",
                    "Bursatti",
                    "Leeches",
                    "Gulf Coast fungus",
                    "Pythium insidiosum",
                    "aquatic mold infection",
                    "pythiosis insidiosi",
                    "phythiosis",
                    "pythosis"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "pythiosis_thumb",
                description: """
                Pythiosis is a severe and progressive disease caused by Pythium \
                insidiosum — an organism that resembles a fungus but is not one. \
                Pythium insidiosum belongs to a group called oomycetes, which are \
                more closely related to algae and diatoms than to true fungi. This \
                distinction is clinically critical: oomycetes do not respond to most \
                standard antifungal medications, making Pythiosis far more difficult \
                to treat than superficially similar fungal infections.

                Dogs are the most commonly affected companion animals, developing \
                either a severe gastrointestinal form — with progressive intestinal \
                lesions that can mimic cancer — or a cutaneous form affecting the \
                skin and underlying tissues, particularly on the limbs and tail base. \
                Cats are rarely affected. Aquatic and semi-aquatic reptiles may have \
                some exposure risk given their habitat overlap with the organism.

                Pythiosis is associated with exposure to warm, stagnant, or slow-moving \
                fresh water — swamps, ponds, ditches, and flooded fields — in subtropical \
                and tropical regions. In the United States, the Gulf Coast states are \
                the primary endemic zone. The disease is life-threatening and carries a \
                guarded to grave prognosis without prompt, aggressive veterinary \
                intervention.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Pythium insidiosum produces motile, flagellated spores called zoospores \
                that are attracted to damaged or compromised tissue — including skin \
                wounds, mucous membranes, and the gastrointestinal lining. When zoospores \
                contact susceptible tissue, they penetrate and begin to grow, forming \
                branching thread-like structures (hyphae) that invade and destroy \
                surrounding tissue. The body mounts a strong inflammatory response, \
                but this response drives additional tissue destruction rather than \
                effectively clearing the infection.

                **Not a Fungus — and Why That Matters**
                Despite causing disease that looks clinically similar to invasive fungal \
                infections, Pythium insidiosum is fundamentally different at the \
                biochemical level. True fungal cell walls contain ergosterol — the \
                target of most antifungal drugs. Oomycete cell walls do not. This means \
                that the antifungal medications routinely used to treat Aspergillosis, \
                Cryptococcosis, and Valley Fever are largely ineffective against \
                Pythiosis. This treatment gap is one of the primary reasons Pythiosis \
                carries such a serious outlook — by the time it is diagnosed, standard \
                antifungal therapy has often already failed or been ruled out.

                Two main disease forms occur in dogs. The **gastrointestinal form** \
                produces thick, fibrous masses in the stomach or small intestine that \
                obstruct the gut, cause protein loss, and progressively destroy the \
                bowel wall. It can closely resemble intestinal cancer on imaging, \
                delaying diagnosis. The **cutaneous form** causes rapidly expanding, \
                non-healing wounds — often with a characteristic appearance of \
                necrotic (dying) tissue surrounded by swollen, thickened skin. Draining \
                tracts are common. Limbs, the tail base, and the face are most \
                frequently affected, often at points of prior skin trauma or water \
                contact.

                **Transmission & Spread**

                Pythiosis is not contagious between animals or from animals to humans. \
                Infection occurs when a susceptible animal comes into contact with \
                water or wet soil containing zoospores — the infectious, free-swimming \
                form of Pythium insidiosum.

                The organism thrives in warm (above 25°C / 77°F), stagnant or \
                slow-moving fresh water: swamps, bayous, rice paddies, irrigation \
                ditches, flooded fields, and ponds with abundant aquatic vegetation. \
                In the United States, Pythiosis is most prevalent in the Gulf Coast \
                states — Louisiana, Texas, Florida, Alabama, Mississippi, and Georgia \
                — where warm temperatures and standing water are present for extended \
                periods. Cases have also been documented in the Midwest following \
                flooding events, and internationally throughout Southeast Asia, \
                Australia, and South America.

                **The Gulf Coast Retriever Problem**
                Dogs that swim or wade regularly in warm, stagnant water bodies in \
                endemic regions face the highest exposure risk. Retrievers and sporting \
                breeds with high water drive are significantly overrepresented in \
                case reports. Exposure typically occurs in late summer and fall when \
                water temperatures peak. Skin wounds or abrasions at the time of \
                water contact are thought to increase the risk of infection by providing \
                Pythium zoospores with a portal of entry.

                The incubation period — the time from exposure to onset of signs — \
                is not well established but is generally thought to range from weeks \
                to a few months. The GI form in particular may be advanced by the \
                time signs are recognized, as early symptoms can be vague.

                **Treatment Goals**

                Pythiosis is treated with a combination of surgical removal of affected \
                tissue and targeted medical therapy. Because standard antifungal drugs \
                are largely ineffective, treatment requires specialized approaches that \
                your veterinarian will determine based on the form and extent of the \
                disease. In the GI form, surgical resection of the affected intestinal \
                segment is often attempted, but complete removal is frequently not \
                possible due to the extent of tissue involvement. In the cutaneous \
                form, wide surgical excision — including amputation of affected limbs \
                in some cases — offers the best chance of clearing infection. \
                Immunotherapy protocols have been explored as adjunctive treatment \
                and are used at some referral centers. Early veterinary intervention \
                significantly improves the likelihood of successful surgical clearance.

                **Zoonotic Risk**

                Human pythiosis is documented but rare, occurring primarily in \
                individuals with underlying conditions affecting immune function or \
                red blood cell health. Transmission to humans occurs through the same \
                route as in animals — direct contact with contaminated water or \
                wet soil — not through contact with an infected pet. An infected dog \
                does not pose a direct transmission risk to household members.

                If your pet has been diagnosed with Pythiosis and you have concerns \
                about your own exposure to the same water source, consult your \
                physician — particularly if you are immunocompromised or have an \
                underlying blood disorder.

                **Myths vs. Facts**

                **Myth:** Pythiosis is a fungal infection.
                **Fact:** Despite being treated similarly in some respects, Pythium \
                insidiosum is an oomycete — more closely related to algae than to \
                fungi. This is why standard antifungal medications typically do not \
                work against it.

                **Myth:** My dog can only get Pythiosis if we live on the Gulf Coast.
                **Fact:** While the Gulf Coast states are the primary endemic zone in \
                the US, Pythiosis has been documented in other regions following \
                flooding, and is prevalent throughout subtropical and tropical areas \
                worldwide. Dogs with travel history to any warm, wet subtropical \
                region should be considered at risk.

                **Myth:** A non-healing wound after swimming is probably just a minor \
                skin infection.
                **Fact:** Rapidly expanding, non-healing wounds — especially on the \
                limbs or tail base following water exposure in endemic areas — should \
                be evaluated by a veterinarian promptly. Early diagnosis of the \
                cutaneous form offers the best surgical options.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation is not precisely established but typically weeks to a few months after exposure. Early GI signs include vomiting, diarrhea, and weight loss; early cutaneous signs include a non-healing wound or swelling at the exposure site.",
                    delayed: "Both forms progress aggressively without treatment. The GI form can produce large obstructive intestinal masses; the cutaneous form can invade deeply into underlying tissue, potentially requiring limb amputation."
                ),
                symptoms: [
                    "Chronic vomiting (GI form)",
                    "Chronic diarrhea, often with blood or mucus (GI form)",
                    "Progressive weight loss",
                    "Reduced appetite",
                    "Visible or palpable abdominal mass (GI form)",
                    "Non-healing wound or ulcer, especially on limbs or tail base (cutaneous form)",
                    "Rapidly expanding skin lesion with necrotic (dying) tissue",
                    "Draining tracts from skin lesions",
                    "Swelling and thickening of skin around a wound (cutaneous form)",
                    "Lethargy",
                    "Swollen lymph nodes near affected area"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Primary species affected. Two distinct forms: gastrointestinal (intestinal mass, weight loss, vomiting) and cutaneous (rapidly expanding non-healing wounds). Both forms are life-threatening. Retrievers and sporting breeds with water access in endemic areas are at highest risk."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .low,
                        notes: "Rarely affected. Occasional case reports exist, primarily the GI form. Significantly less common and less well characterized than in dogs."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .low,
                        notes: "Clinical cases in pet small mammals are not well documented. Susceptibility is considered low; included as a precautionary note for pets with access to warm standing water in endemic regions."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Aquatic and semi-aquatic reptiles (turtles, water dragons) have theoretical exposure risk given habitat overlap with Pythium insidiosum. Clinical cases in pet reptiles are not well documented but biological plausibility exists."
                    )
                ],
                preventionTips: [
                    "Restrict access to warm, stagnant, or slow-moving water bodies — swamps, ponds, ditches, and flooded fields — in Gulf Coast states and other subtropical regions",
                    "Avoid allowing dogs with open skin wounds or abrasions to swim or wade in potentially contaminated water",
                    "Dry pets thoroughly after any water exposure and inspect skin — especially limbs, tail base, and face — for any early wounds or swellings",
                    "Seek prompt veterinary evaluation for any non-healing wound, rapidly expanding skin lesion, or chronic GI signs in a dog with a history of water exposure in endemic areas",
                    "Inform your veterinarian about recent water exposure history and travel to subtropical or tropical regions when presenting with relevant signs — this is critical for early diagnosis",
                    "Pythiosis is not contagious between pets or from pets to people; standard hygiene precautions are sufficient when caring for an affected animal",
                    "If you have concerns about your own exposure to a contaminated water source, consult your physician — particularly if you are immunocompromised or have an underlying blood disorder"
                ],
                sources: [
                    "Merck Veterinary Manual — Pythiosis: merckvetmanual.com",
                    "Louisiana State University School of Veterinary Medicine — Pythiosis Research: lsu.edu",
                    "ASPCA Animal Poison Control Center: aspca.org/pet-care/animal-poison-control",
                    "VCA Animal Hospitals — Pythiosis in Dogs: vcahospitals.com",
                    "Cornell University College of Veterinary Medicine: vet.cornell.edu",
                    "Wikipedia — Pythium insidiosum (oomycete classification, geographic distribution, treatment resistance): en.wikipedia.org/wiki/Pythium_insidiosum"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000015",  // Cryptococcosis
                    "1D000001-0000-0000-0000-000000000016"   // Coccidioidomycosis (Valley Fever)
                ]
            ),

            // MARK: - Feline Infectious Peritonitis (FIP)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000018")!,
                name: "Feline Infectious Peritonitis (FIP)",
                alternateNames: [
                    "FIP",
                    "Feline Coronavirus Disease",
                    "FIPV",
                    "Feline Infectious Peritonitus",
                    "Wet FIP",
                    "Dry FIP",
                    "Effusive FIP",
                    "Non-Effusive FIP",
                    "feline peritonitis",
                    "feline corona virus"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "fip_thumb",
                description: """
                Feline Infectious Peritonitis (FIP) is a severe, progressive viral \
                disease of cats — and one of the most feared diagnoses in feline \
                medicine. For decades, it was considered universally and inevitably \
                fatal. A diagnosis of FIP was effectively a death sentence: there was \
                no treatment, and cats typically declined rapidly, surviving days to \
                weeks at most. That has changed dramatically in recent years with the \
                development of antiviral medications that target the virus directly. \
                While these drugs are not yet fully approved for veterinary use in all \
                regions (regulatory approval is pending or in process in several \
                countries), they are increasingly available through veterinarians and \
                have transformed FIP from a terminal diagnosis into a manageable — and \
                in many cases curable — disease. Any cat suspected of having FIP should \
                be evaluated for antiviral treatment as early as possible.

                What makes FIP unusual is that it is not caused by an outside pathogen \
                entering the body — it is caused by a transformation of one already \
                there. Feline enteric coronavirus (FCoV) is a common, usually harmless \
                gut virus found in a large proportion of cats worldwide. In a small \
                number of cats, FCoV mutates spontaneously within the individual animal \
                into a dangerous, immune-evading form — feline infectious peritonitis \
                virus (FIPV) — that escapes the gut and spreads through the body. \
                Crucially, this mutation happens inside the individual cat. FIP itself \
                is not transmitted from cat to cat; what spreads between cats is \
                ordinary FCoV, which most carriers never develop into FIP.

                FIP presents in two primary forms. The \u{201C}wet\u{201D} (effusive) \
                form causes fluid to accumulate in the abdomen or chest cavity, and \
                progresses rapidly. The \u{201C}dry\u{201D} (non-effusive) form is \
                slower and more insidious, often affecting the nervous system, eyes, \
                kidneys, and liver. Some cats develop features of both forms. In either \
                case, the disease is life-threatening and requires urgent veterinary \
                evaluation.

                Compounding the challenge of FIP is how notoriously difficult it is to \
                diagnose in a living animal. There is no single test that confirms FIP. \
                Diagnosis requires a combination of clinical signs, bloodwork patterns, \
                imaging, and — when fluid is present — fluid analysis. Even then, \
                certainty is often elusive, and many veterinarians describe a working \
                diagnosis as highly consistent with FIP rather than definitively \
                confirmed. Historically, tissue examination after death was the only \
                way to confirm the diagnosis with certainty.

                Young cats are at greatest risk — the majority of cases are diagnosed \
                in cats under two years of age — though older cats can develop FIP as \
                well. Cats living in multi-cat households, catteries, breeding \
                facilities, and shelters carry higher risk due to greater FCoV exposure. \
                Purebred cats and male cats appear to be overrepresented for reasons \
                that are not fully understood. FIP affects cats only; no other \
                companion animal species are susceptible. No vaccine against FIP is \
                currently widely recommended.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                FIP begins with a mutation: ordinary feline enteric coronavirus, \
                typically confined to the gut, undergoes genetic changes that allow it \
                to infect and replicate inside monocytes and macrophages — the very \
                white blood cells the immune system sends to fight infections. Rather \
                than being destroyed, the mutated virus hijacks these immune cells and \
                uses them to travel throughout the body.

                The result is an abnormal, overwhelming inflammatory response. In the \
                wet (effusive) form, inflammation causes blood vessel walls to become \
                leaky, allowing fluid to pour into the abdominal or chest cavity. In \
                the dry (non-effusive) form, the immune response generates dense \
                clusters of inflammatory cells (pyogranulomas) that form in organs — \
                including the liver, kidneys, eyes, and brain. Both forms destroy \
                normal tissue function. Neurological involvement, when it occurs, \
                indicates the virus has reached the central nervous system and signals \
                an advanced stage of disease.

                **Transmission & Spread**

                FCoV — the harmless gut virus from which FIPV derives — is highly \
                contagious between cats. It spreads primarily through feces, shared \
                litter boxes, contaminated surfaces, grooming, and saliva. Multi-cat \
                environments such as catteries, shelters, and breeding facilities have \
                high FCoV prevalence. FCoV can persist in the environment for days to \
                weeks and is inactivated by standard disinfectants including dilute \
                bleach.

                FIP itself, however, is not meaningfully transmissible between cats. \
                The FIPV mutation occurs independently within each affected individual. \
                Studies have confirmed that cats with FIP are not infectious to healthy \
                cats via normal exposure routes. This is a critical point that is \
                frequently misunderstood: isolating a cat with FIP is not necessary to \
                prevent FIP in housemates — though routine hygiene measures to limit \
                FCoV spread remain worthwhile.

                **Treatment Goals**

                Before effective antivirals became available, treatment of FIP was \
                purely palliative — managing symptoms such as draining accumulated \
                fluid, supporting nutrition, and keeping the cat comfortable until the \
                disease progressed beyond what the animal could tolerate. Without \
                specific antiviral treatment, FIP is nearly always fatal.

                Antiviral medications are now available and have dramatically changed \
                outcomes for cats with FIP. These medications are not yet fully \
                approved in all regions — regulatory approval is pending or in process \
                in several countries — but they are increasingly accessible through \
                veterinarians and have transformed FIP from a death sentence into a \
                condition that many cats survive. The goal of treatment is to suppress \
                viral replication, allow the immune system to regain control, and \
                achieve clinical remission. Treatment courses are typically measured in \
                weeks to months, and close veterinary monitoring is essential \
                throughout.

                If FIP is suspected, do not wait. Early initiation of antiviral therapy \
                is associated with better outcomes. Cats with advanced neurological or \
                ocular FIP can still respond to treatment, but the window for \
                meaningful response narrows as the disease progresses. Owners should \
                raise the question of antiviral treatment explicitly with their \
                veterinarian at the first suspicion of FIP.

                **A Death Sentence Reversed**

                For most of the history of veterinary medicine, a diagnosis of FIP was \
                delivered with the same weight as a terminal cancer prognosis. \
                Veterinarians had nothing to offer but time and comfort. The disease \
                was studied extensively, but treatment remained out of reach — antiviral \
                compounds tested over the decades either failed in clinical use or \
                caused unacceptable side effects.

                The development of antiviral medications effective against FIP — \
                emerging in part from broader coronavirus and antiviral research — \
                changed the landscape entirely. By the late 2010s and into the 2020s, \
                these drugs were demonstrating remarkable efficacy in research settings \
                and in client-owned cats. Legal veterinary access followed in several \
                countries, and more recently in the United States. Though regulatory \
                approval remains pending or in process in many regions, access through \
                veterinary channels has expanded substantially.

                FIP is still a serious disease requiring prompt, expert veterinary \
                management. But the era in which a diagnosis meant certain death is over.

                **The Mutation Within**

                What makes FIP scientifically unusual is that no cat \u{201C}catches\u{201D} \
                FIP from another cat. A cat catches FCoV — the common, harmless gut \
                coronavirus — and then, in a small fraction of cases, the virus mutates \
                inside that individual cat into something dangerous. The trigger for \
                this mutation is not fully understood. Viral genetics, the dose of \
                initial infection, the cat's immune status, age, stress, and possibly \
                genetic predisposition all appear to play roles.

                Because the mutation is unpredictable and individual, most cats that \
                carry FCoV — which in high-density environments can be the majority — \
                never develop FIP at all. The same household may have ten cats with \
                FCoV antibodies and only one develops FIP. There is currently no test \
                that predicts which cat carrying FCoV will undergo the mutation.

                **A Diagnosis Without a Test**

                FIP is one of the hardest diseases to confirm in a living animal. No \
                single test is definitive. Antibody tests detect exposure to FCoV — \
                not FIP — and most seropositive cats are perfectly healthy. PCR tests \
                detect coronavirus RNA but cannot reliably distinguish harmless FCoV \
                from the disease-causing mutated form. Even supportive findings must be \
                interpreted as part of a larger clinical picture.

                A working FIP diagnosis is typically built from a constellation of \
                findings: the right patient profile (young, purebred, or shelter-origin \
                cat), persistent fever unresponsive to antibiotics, weight loss, \
                abnormal bloodwork patterns, characteristic fluid when present, and \
                imaging findings. In cats with effusion, fluid analysis showing high \
                protein content with low cell counts is strongly supportive. In dry \
                FIP, the picture is murkier and the diagnostic path longer.

                Historically, the only way to confirm FIP with certainty was tissue \
                examination after death. Today, with effective antivirals available, \
                veterinarians sometimes make the clinical decision to begin antiviral \
                treatment in a cat with a high-suspicion diagnosis — a trial of \
                treatment that, if effective, provides additional evidence that FIP was \
                the correct diagnosis.

                **Myths vs. Facts**

                **Myth:** FIP is contagious — if one cat in my household has FIP, the \
                others will get it.
                **Fact:** FIP is not transmitted between cats. Ordinary feline \
                coronavirus (FCoV) is contagious, but the mutation that causes FIP \
                happens independently within each individual cat. Housemates of a cat \
                with FIP are not at risk of catching FIP from that cat.

                **Myth:** FIP is always fatal.
                **Fact:** This was true for most of veterinary history. It is no longer \
                true. Antiviral medications have fundamentally changed outcomes for cats \
                with FIP. Many cats treated early achieve full clinical remission.

                **Myth:** A positive coronavirus test means my cat has FIP.
                **Fact:** FCoV exposure is extremely common in cats, especially those \
                from multi-cat environments. A positive antibody or PCR test reflects \
                exposure to the common gut form of the virus — not FIP. Most cats with \
                positive coronavirus tests never develop FIP.

                **Myth:** Only kittens get FIP.
                **Fact:** Young cats are at highest risk, and the majority of cases are \
                diagnosed in cats under two years of age. However, FIP can occur at any \
                age, including in older cats.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "FCoV infection itself often causes no symptoms, or brief mild diarrhea in kittens. The mutation to FIP-causing virus can occur weeks to months after initial FCoV infection and often appears without obvious warning.",
                    delayed: "Wet (effusive) FIP typically progresses rapidly once signs appear, with cats declining over days to weeks. Dry (non-effusive) FIP may develop gradually over weeks to months with subtle, intermittent signs that are easy to miss early."
                ),
                symptoms: [
                    "Loss of appetite",
                    "Unexplained weight loss or failure to gain weight",
                    "Persistent lethargy",
                    "Pot-bellied or distended abdomen (fluid accumulation)",
                    "Difficulty breathing or rapid, shallow breathing (fluid in chest)",
                    "Fever that does not respond to standard treatment",
                    "Yellowing of the skin, gums, or whites of the eyes (jaundice)",
                    "Cloudy, red, or visibly changed eyes",
                    "Wobbling, loss of coordination, or difficulty walking",
                    "Seizures or sudden behavioral changes",
                    "Neurological signs: head tilt, circling, or abnormal eye movements"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Cats are the only species affected by FIP. Young cats under two years of age and those from multi-cat environments, catteries, or shelters carry the greatest risk. Purebred cats and male cats appear to be overrepresented. Older cats may also develop FIP, though less commonly."
                    )
                ],
                preventionTips: [
                    "If FIP is suspected, seek veterinary evaluation immediately — do not wait for symptoms to worsen. Antiviral treatment is most effective when started early.",
                    "Ask your veterinarian explicitly about antiviral treatment options if FIP is suspected or diagnosed. These medications are increasingly available and have transformed outcomes for many cats.",
                    "Reduce FCoV transmission in multi-cat households: clean litter boxes frequently, keep litter areas away from food and water, and avoid crowded living conditions.",
                    "Quarantine and test new cats before introducing them to an existing multi-cat household to limit FCoV spread.",
                    "Minimize stress in your cat's environment — stress is recognized as a potential factor in disease progression from FCoV to FIP.",
                    "Ask your veterinarian about FCoV screening if your cat comes from a high-risk environment such as a cattery or shelter.",
                    "No vaccine against FIP is currently widely recommended by major veterinary organizations."
                ],
                sources: [
                    "Cornell Feline Health Center — Feline Infectious Peritonitis",
                    "Merck Veterinary Manual — Feline Infectious Peritonitis",
                    "UC Davis School of Veterinary Medicine — Feline Coronavirus & FIP",
                    "International Cat Care (iCatCare) — Feline Infectious Peritonitis",
                    "Wikipedia — Feline Infectious Peritonitis",
                    "MDPI Veterinary Sciences — From Challenge to Cure: FIP and Emerging Treatment Strategies (2025)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000019",  // FeLV
                    "1D000001-0000-0000-0000-000000000020",  // FIV
                    "1D000001-0000-0000-0000-000000000021"   // FHV-1
                ]
            ),

            // MARK: - Feline Leukemia Virus (FeLV)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000019")!,
                name: "Feline Leukemia Virus (FeLV)",
                alternateNames: [
                    "FeLV",
                    "Feline Leukemia",
                    "Feline Leukaemia Virus",
                    "Feline Leukemia Virus Disease",
                    "feline leukemia",
                    "felv positive",
                    "FeLV positive",
                    "retrovirus cat",
                    "cat leukemia"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "felv_thumb",
                description: """
                Feline Leukemia Virus (FeLV) is one of the most significant infectious \
                diseases affecting cats worldwide — and historically, the leading \
                infectious cause of cancer-related death in the species. It is caused \
                by a retrovirus that invades the cat's immune system and blood-forming \
                tissues, progressively dismantling the body's ability to defend itself. \
                Depending on how a cat's immune system responds to infection, the \
                outcome can range from complete clearance to lifelong progressive \
                disease. In its most serious form, FeLV causes immunosuppression, \
                life-threatening cancers, and severe blood disorders. There is no cure.

                FeLV is a vaccine-preventable disease. Vaccination has dramatically \
                reduced its prevalence over the past three decades, and widespread \
                testing and prevention efforts have made FeLV far less common than it \
                once was. Despite this progress, it remains a serious and widespread \
                threat — particularly for cats with outdoor access, those living in \
                multi-cat households, and kittens. All cats should be tested for FeLV, \
                and all cats at risk of exposure should be vaccinated.

                The virus spreads between cats through close social contact — primarily \
                through saliva, but also through nasal secretions, urine, feces, and \
                milk. Mutual grooming, shared food and water dishes, shared litter \
                boxes, bite wounds, and mother-to-kitten transmission (both in the womb \
                and through nursing) are all established routes. Kittens are \
                significantly more susceptible than adults and are at the greatest risk \
                of developing progressive, life-threatening infection if exposed. FeLV \
                does not survive long outside the cat's body — typically only a matter \
                of hours under normal household conditions — and is readily destroyed \
                by standard disinfectants.

                FeLV affects domestic cats and some wild felids, including lions, \
                cheetahs, and Florida panthers. It is not transmissible to dogs, other \
                companion animals, or humans, and is not considered a zoonotic disease.

                When a cat is exposed to FeLV, one of three outcomes occurs. In some \
                cats — particularly healthy adults — the immune system successfully \
                clears the virus (abortive infection), and the cat shows no signs of \
                disease and cannot infect others. In others, the virus becomes dormant \
                in the bone marrow (regressive infection) — these cats are typically \
                healthy but may reactivate the virus if they become immunosuppressed \
                later in life. In the most serious outcome (progressive infection), the \
                virus replicates continuously in the bone marrow, the cat sheds virus \
                to other cats, and the risk of FeLV-associated disease is high. Kittens \
                are far more likely than adults to develop progressive infection.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                FeLV is a retrovirus — a category of virus that works by inserting \
                copies of its own genetic material into the DNA of the host's cells. \
                Once inside a cat, FeLV initially replicates in the lymphoid tissue of \
                the throat before spreading via infected white blood cells to the bone \
                marrow. The bone marrow is the body's blood cell factory, and its \
                infection is the central catastrophe of FeLV. From there, the virus \
                can spread to the salivary glands, lymph nodes, and throughout the body.

                The consequences of progressive FeLV infection fall into three \
                overlapping categories. First, immunosuppression: FeLV cripples the \
                immune system, leaving affected cats vulnerable to infections that a \
                healthy cat would easily fight off. Bacteria, viruses, fungi, and \
                parasites that are harmless in normal cats can cause life-threatening \
                illness in FeLV-positive cats. Second, cancer: FeLV is the most common \
                infectious cause of cancer in cats. It promotes tumor development by \
                disrupting the genetic machinery that regulates cell growth. Lymphoma \
                and leukemia are the most common cancers associated with progressive \
                FeLV infection. Third, blood disorders: FeLV can directly suppress red \
                blood cell production, causing severe non-regenerative anemia, or \
                disrupt platelet function, leading to bleeding problems.

                Neurological disease can also occur, either as a result of lymphoma \
                pressing on the brain or spinal cord, or through a direct toxic effect \
                of the virus itself on nerve tissue.

                **Transmission & Spread**

                FeLV spreads almost exclusively between cats through close social \
                contact. The virus is present in highest concentrations in saliva — \
                mutual grooming and shared food and water dishes are among the most \
                common transmission routes. Bite wounds, while less frequent, are an \
                efficient route due to the high viral load in saliva. Nasal secretions, \
                urine, feces, and milk can also carry virus, and infected queens \
                routinely transmit FeLV to kittens in the womb and through nursing.

                FeLV does not persist in the environment. Outside a cat's body, the \
                virus survives only hours under normal household conditions and is \
                destroyed by most standard disinfectants. This means that a home where \
                an FeLV-positive cat has lived can be safely introduced to a new, \
                healthy cat within days of the infected cat's departure.

                Because FeLV is shed primarily in saliva, cats that do not engage in \
                close social contact with other cats carry very low risk of exposure. \
                Indoor-only cats with no contact with unknown cats are at minimal risk. \
                Outdoor cats, cats in shelters or multi-cat households, and cats from \
                unknown histories carry the greatest risk.

                **Treatment Goals**

                There is no treatment that eliminates FeLV from a cat's body. \
                Management of FeLV-positive cats focuses on supporting quality of life, \
                monitoring closely for complications, and treating secondary infections \
                and FeLV-associated diseases as they arise. Secondary infections — \
                which occur because the immune system can no longer defend the cat \
                effectively — may be treatable even when the underlying FeLV infection \
                is not.

                FeLV-positive cats with progressive infection require more frequent \
                veterinary monitoring than healthy cats — at minimum every six months, \
                and promptly at any sign of new illness. Per the 2020 AAFP Feline Retrovirus Guidelines, FeLV-positive cats \
                should live separately from FeLV-negative cats, or only with other \
                FeLV-positive cats — household transmission of FeLV carries a \
                meaningfully higher risk than FIV. Keeping FeLV-positive cats strictly \
                indoors protects them from additional infectious exposures and prevents \
                transmission to cats in the broader community. All FeLV-positive cats \
                should be neutered.

                Cats with regressive infection often live normal, healthy lifespans \
                with no signs of disease, though monitoring for reactivation is \
                appropriate.

                **Vaccination: The Most Important Prevention Tool**

                FeLV is one of the most effectively vaccine-preventable diseases in \
                cats. The vaccine is recommended for all kittens and for any adult cat \
                with outdoor access or exposure to cats of unknown FeLV status. The \
                standard protocol involves an initial series of two vaccinations \
                followed by a booster. Vaccination has been directly credited with the \
                significant reduction in FeLV prevalence observed over the past three \
                decades.

                All cats should be tested for FeLV before vaccination — vaccinating a \
                cat that is already infected provides no benefit and does not alter the \
                course of disease. A negative test before vaccination confirms that the \
                vaccine has something to protect against.

                **The Most Common Infectious Cancer Cause**

                FeLV holds a grim distinction: it is the most common infectious cause \
                of cancer in cats. In the 1980s, FeLV was associated with the majority \
                of feline lymphoma cases. Decades of vaccination and testing programs \
                have shifted this dramatically — today, most cats diagnosed with \
                lymphoma test negative for FeLV antigen. This transformation is a \
                direct result of widespread vaccination, and one of the clearest \
                examples in veterinary medicine of how a vaccine can reshape the \
                disease landscape of a species.

                **Myths vs. Facts**

                **Myth:** An FeLV-positive cat will definitely get sick and die soon.
                **Fact:** Outcome depends entirely on infection type. Cats with \
                regressive infection often live normal, healthy lives. Even cats with \
                progressive infection may remain well for months to years with \
                attentive veterinary care. An FeLV-positive result is not a sentence — \
                it is information that changes how the cat should be managed and \
                monitored.

                **Myth:** FeLV can spread to my dog or to people in the household.
                **Fact:** FeLV is specific to the cat family. It cannot infect dogs, \
                rabbits, other pets, or humans. No human case of FeLV infection has \
                ever been documented.

                **Myth:** FeLV can survive in my home for a long time after an \
                infected cat was there.
                **Fact:** FeLV is fragile outside a cat's body and typically survives \
                only a few hours under normal household conditions. Standard \
                disinfectants destroy it. A home where an FeLV-positive cat lived can \
                safely house a new cat within days.

                **Myth:** My indoor cat doesn't need FeLV vaccination.
                **Fact:** Indoor status significantly reduces risk, but vaccination is \
                still recommended for all kittens regardless of lifestyle, because \
                circumstances change and kittens are highly susceptible. Discuss your \
                cat's individual risk with your veterinarian.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Early FeLV infection typically causes no visible signs. Some cats develop brief mild illness — fever, lethargy, swollen lymph nodes — shortly after exposure, which then resolves. This can be followed by months to years without symptoms even in progressive infection.",
                    delayed: "In progressive infection, health may deteriorate gradually over months to years, with recurrent cycles of illness and apparent recovery. Signs of FeLV-associated disease — including cancer, anemia, and recurring infections — may not appear until long after the initial infection."
                ),
                symptoms: [
                    "Persistent lethargy or low energy",
                    "Loss of appetite or gradual weight loss",
                    "Pale or white gums (anemia)",
                    "Recurring infections that don't resolve or keep returning (skin, eyes, respiratory, urinary)",
                    "Enlarged lymph nodes, especially early in infection",
                    "Difficulty breathing",
                    "Diarrhea or vomiting that persists or recurs",
                    "Poor coat condition",
                    "Mouth sores or progressive dental disease",
                    "Uneven pupil size",
                    "Weakness in the limbs or difficulty walking",
                    "Seizures or sudden behavioral changes"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Cats are the only companion animal species susceptible to FeLV. Kittens are at far greater risk of progressive infection than adults. Outdoor cats, cats in multi-cat households, and cats from shelters or catteries carry the highest risk of exposure. Indoor-only cats with no contact with unknown cats are at minimal risk."
                    )
                ],
                preventionTips: [
                    "Vaccinate all kittens against FeLV — this is one of the most effective preventive steps available. Discuss a booster schedule for adult cats with outdoor access with your veterinarian.",
                    "Test all cats for FeLV before vaccination and before introducing a new cat to a household with existing cats.",
                    "Per the 2020 AAFP Feline Retrovirus Guidelines, FeLV-positive cats should live separately from FeLV-negative cats, or only with other FeLV-positive cats. FeLV carries a higher risk of household transmission than FIV. Keeping FeLV-positive cats strictly indoors also protects them from new infections and prevents spread to cats in the community.",
                    "Test and quarantine any new cat before introducing them to existing household cats — FeLV-positive cats can appear completely healthy.",
                    "Do not allow cats of unknown FeLV status to share food dishes, water bowls, or litter boxes with your cats.",
                    "Have FeLV-positive cats examined by a veterinarian at least every six months, and promptly at any sign of illness.",
                    "Neuter all FeLV-positive cats — neutering reduces roaming and bite wound risk, and is part of responsible management.",
                    "If a cat in a multi-cat household tests positive, have all other cats in the household tested."
                ],
                sources: [
                    "Cornell Feline Health Center — Feline Leukemia Virus",
                    "Merck Veterinary Manual — Feline Leukemia Virus Disease",
                    "VCA Animal Hospitals — Feline Leukemia Virus Disease Complex",
                    "Veterinary Partner (VIN) — Feline Leukemia Virus",
                    "Wikipedia — Feline Leukemia Virus",
                    "PMC / NIH — Feline Leukemia Virus Infection (peer-reviewed review)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000018",  // FIP
                    "1D000001-0000-0000-0000-000000000020",  // FIV
                    "1D000001-0000-0000-0000-000000000021"   // FHV-1
                ]
            ),

            // MARK: - Feline Immunodeficiency Virus (FIV)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000020")!,
                name: "Feline Immunodeficiency Virus (FIV)",
                alternateNames: [
                    "FIV",
                    "Feline AIDS",
                    "Feline Immunodeficiency",
                    "FIV positive",
                    "feline immunodeficiency",
                    "feline HIV",
                    "cat AIDS",
                    "feline T-lymphotropic lentivirus",
                    "FTLV"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "fiv_thumb",
                description: """
                Feline Immunodeficiency Virus (FIV) is a lentivirus that infects \
                cats worldwide, progressively weakening the immune system over \
                time. It belongs to the same family of viruses as HIV — the virus \
                responsible for AIDS in humans — and causes a strikingly similar \
                disease process in cats. Despite this parallel, FIV infects only \
                cats. It cannot be transmitted to humans, dogs, or any other \
                companion animal species.

                FIV is transmitted almost exclusively through bite wounds. Unlike \
                feline leukemia virus (FeLV), which spreads more easily through \
                casual contact such as grooming or shared food dishes, FIV \
                requires the direct inoculation of infected saliva into another \
                cat's tissue during a fight. Outdoor intact male cats — who fight \
                frequently — carry by far the highest risk of infection.

                One of the most important things to understand about FIV is that \
                a positive test result is not a death sentence, and FIV-positive \
                is not the same as having feline AIDS. FIV is a slow-moving virus. \
                Many infected cats remain clinically healthy for years — sometimes \
                for their entire lives — before any signs of immune compromise \
                appear. The long, often silent period between infection and \
                clinical illness is a hallmark of lentiviruses.

                There is no cure for FIV, and no vaccine is currently available \
                in the United States or Canada. Management focuses on protecting \
                the immune system, preventing secondary infections, and monitoring \
                the cat closely for signs of decline. With attentive care, many \
                FIV-positive cats live comfortable, good-quality lives for years \
                after diagnosis.

                Outdoor cats — particularly unneutered males with a history of \
                fighting — are at greatest risk. Indoor-only cats with no bite \
                wound exposure are at minimal risk. FIV is found worldwide in \
                domestic cats and also infects several wild felid species, \
                including lions, pumas, and cheetahs.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                FIV is a retrovirus — specifically a lentivirus, meaning it causes \
                disease slowly and establishes a lifelong persistent infection that \
                the immune system cannot clear. Once a cat is infected, the virus \
                integrates into the DNA of immune cells and remains there for life. \
                The primary targets are CD4+ T-helper lymphocytes — the same class \
                of immune cells destroyed by HIV in humans. As these cells are \
                progressively depleted and exhausted over time, the cat's immune \
                system loses its ability to coordinate defenses against infection.

                The result is not illness caused directly by FIV itself — in most \
                cases the virus causes relatively little direct tissue damage. \
                Rather, it is the immune collapse that follows that becomes \
                life-threatening. Bacteria, viruses, fungi, and parasites that a \
                healthy cat's immune system would handle without difficulty become \
                persistent, difficult-to-treat problems. This is the same mechanism \
                seen in HIV-induced AIDS in humans, and is why severe FIV disease \
                is sometimes referred to as feline AIDS.

                FIV can also directly affect the nervous system, infecting cells \
                in the brain and spinal cord and causing neurological signs in \
                some cats.

                **Transmission & Spread**

                Bite wounds are the primary route of FIV transmission. The virus \
                is present in saliva at sufficient concentrations to establish \
                infection when inoculated directly into another cat's tissue \
                during a fight. This is why the typical FIV-positive cat is an \
                outdoor, unneutered male with a history of fighting — the \
                infection pattern follows the pattern of cat combat.

                Casual contact carries very low transmission risk. Shared food and \
                water dishes, mutual grooming, shared litter boxes, and close \
                proximity without fighting are not considered efficient routes of \
                transmission. Per the 2020 AAFP Feline Retrovirus Guidelines, \
                FIV-positive cats that are neutered or spayed and live peacefully \
                with FIV-negative cats pose a very low transmission risk in stable \
                households where fighting does not occur.

                Mother-to-kitten transmission can occur — in the womb or through \
                nursing — but appears to be relatively uncommon under natural \
                conditions. The virus does not survive long outside a cat's body \
                and is readily destroyed by common disinfectants.

                **Treatment Goals**

                There is no treatment that eliminates FIV from a cat's body. \
                Management is focused on preserving quality and length of life. \
                The goals of care for an FIV-positive cat are to minimize exposure \
                to secondary infections, monitor closely for early signs of new \
                illness, and treat complications promptly and aggressively when \
                they arise. Secondary infections — which are the primary source of \
                illness in FIV-positive cats — may respond well to treatment even \
                when the underlying FIV infection cannot be resolved.

                Per the 2020 AAFP Feline Retrovirus Guidelines, FIV-positive cats \
                that are neutered or spayed can safely cohabit with FIV-negative \
                cats in stable, peaceful households where fighting does not occur, \
                with very little risk of transmission. If fighting occurs at any \
                time, separation is essential. Discuss housing arrangements with \
                your veterinarian. Keeping FIV-positive cats strictly indoors \
                protects them from new pathogens that their compromised immune \
                system may struggle to fight, and eliminates the risk of bite \
                wound transmission to outdoor cats. Regular veterinary checkups — \
                at least twice yearly — allow early detection of problems. Any \
                sign of illness in an FIV-positive cat warrants prompt veterinary \
                evaluation, as infections that a healthy cat would shake off can \
                become serious quickly in an immunocompromised animal.

                **The Lentivirus Connection**

                FIV's membership in the lentivirus family places it in \
                distinguished and sobering company. Lentiviruses — named for the \
                slow, persistent nature of the diseases they cause — include not \
                only FIV and HIV, but also viruses responsible for immunodeficiency \
                in primates, sheep, goats, horses, and cattle. The discovery of \
                FIV in 1986 at UC Davis was significant not only for feline \
                medicine but for biomedical research broadly: FIV-infected cats \
                became a valuable natural model for the study of HIV, contributing \
                to research into antiviral strategies that benefit both species.

                Despite the close biological kinship between FIV and HIV, the \
                viruses are strictly species-specific. FIV cannot infect humans, \
                and HIV cannot infect cats. This point is frequently misunderstood \
                and causes unnecessary anxiety in owners of FIV-positive cats.

                **FIV-Positive Is Not Feline AIDS**

                FIV-positive means a cat has been infected with the virus. Feline \
                AIDS — the clinical syndrome of profound immune failure — is the \
                end stage of FIV disease, and many FIV-positive cats never reach \
                it. The long, often asymptomatic period between infection and \
                illness is a defining characteristic of lentiviruses. Some cats \
                remain clinically healthy for the remainder of their natural lives. \
                Others develop immune compromise over years. The trajectory depends \
                on the strain of virus, the individual cat's immune response, \
                co-infections, and other factors that are not fully predictable.

                An FIV-positive diagnosis is information — information that changes \
                how a cat should be managed, monitored, and protected. It is not, \
                by itself, a reason for euthanasia.

                **Myths vs. Facts**

                **Myth:** My FIV-positive cat will infect my other cats just by \
                living with them.
                **Fact:** FIV spreads almost exclusively through bite wounds — not \
                through grooming, shared food bowls, or close contact. Per the \
                2020 AAFP Feline Retrovirus Guidelines, neutered or spayed \
                FIV-positive cats living peacefully with FIV-negative cats in \
                stable households pose very low transmission risk. If any fighting \
                occurs, separation is necessary — consult your veterinarian about \
                your specific situation.

                **Myth:** FIV can spread to the people in my household.
                **Fact:** FIV is strictly species-specific to cats. It cannot \
                infect humans, dogs, or any other companion animal. No human case \
                of FIV infection has ever been documented.

                **Myth:** An FIV-positive cat needs to be euthanized.
                **Fact:** Many FIV-positive cats live normal, healthy, \
                good-quality lives for years after diagnosis. A positive result \
                is not a terminal sentence — it is a reason to change how the \
                cat is managed and monitored.

                **Myth:** My indoor cat can't have FIV.
                **Fact:** Indoor cats are at very low risk, but FIV can be \
                acquired from any bite wound, including from an unfamiliar cat \
                encountered briefly outdoors. Any cat with a history of bite \
                wounds or unknown background should be tested.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Initial infection may cause brief mild illness — low-grade fever, swollen lymph nodes, lethargy — that resolves on its own within a few weeks and is often not noticed. The cat then typically enters a long asymptomatic period.",
                    delayed: "The asymptomatic period following FIV infection can last months to years, or a cat's entire lifetime. When immune compromise eventually develops, it typically appears as recurring or non-resolving infections, weight loss, and progressive decline."
                ),
                symptoms: [
                    "Recurring or non-resolving infections (mouth, eyes, skin, respiratory, urinary)",
                    "Chronic or severe gum inflammation or mouth sores (gingivostomatitis)",
                    "Weight loss or failure to maintain body condition",
                    "Persistent lethargy or reduced activity",
                    "Swollen lymph nodes, especially early in infection",
                    "Chronic eye inflammation or discharge",
                    "Diarrhea that recurs or does not resolve",
                    "Poor coat condition",
                    "Persistent nasal discharge or chronic upper respiratory signs",
                    "Uneven pupil size",
                    "Neurological signs: behavioral changes, disorientation, or seizures"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Cats are the only companion animal species susceptible to FIV. Outdoor unneutered males with a history of fighting carry the greatest risk of infection. Indoor-only cats with no bite wound exposure are at minimal risk. FIV is found worldwide and also infects wild felids including lions, pumas, and cheetahs."
                    )
                ],
                preventionTips: [
                    "Keep cats indoors — this is the single most effective way to prevent FIV, which spreads almost exclusively through bite wounds during fighting.",
                    "Neuter all cats. Unneutered males roam widely and fight frequently, placing them at the highest risk of FIV exposure.",
                    "Test all cats for FIV before introducing a new cat to a household with existing cats, after any known bite wound from a cat of unknown health status, and whenever a cat shows signs of illness.",
                    "Any cat bitten by a cat of unknown health status should be tested for FIV approximately two months after the bite — antibodies may take up to two months to develop and become detectable.",
                    "Per the 2020 AAFP Feline Retrovirus Guidelines, FIV-positive cats that are neutered or spayed can safely cohabit with FIV-negative cats in stable, peaceful households where fighting does not occur. If fighting occurs, separation is essential. Discuss your specific household situation with your veterinarian.",
                    "FIV-positive cats should be kept strictly indoors — this protects them from new infections their immune system may struggle to fight, and eliminates the risk of bite wound transmission to other cats.",
                    "Have FIV-positive cats examined by a veterinarian at least every six months, and promptly at any sign of illness — early treatment of secondary infections is the cornerstone of FIV management.",
                    "No FIV vaccine is currently available in the United States or Canada."
                ],
                sources: [
                    "Cornell Feline Health Center — Feline Immunodeficiency Virus",
                    "Merck Veterinary Manual — Feline Immunodeficiency Virus",
                    "VCA Animal Hospitals — Feline Immunodeficiency Virus Infection",
                    "International Cat Care (iCatCare) — Feline Immunodeficiency Virus",
                    "Wikipedia — Feline Immunodeficiency Virus",
                    "AAFP — 2020 Feline Retrovirus Testing and Management Guidelines",
                    "PMC / NIH — Feline Immunodeficiency Virus Infection (peer-reviewed review)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000018",  // FIP
                    "1D000001-0000-0000-0000-000000000019",  // FeLV
                    "1D000001-0000-0000-0000-000000000021"   // FHV-1
                ]
            ),

            // MARK: - Feline Herpesvirus-1 (FHV-1)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000021")!,
                name: "Feline Herpesvirus-1 (FHV-1)",
                alternateNames: [
                    "FHV-1",
                    "Feline Viral Rhinotracheitis",
                    "FVR",
                    "Cat Herpes",
                    "Feline Herpes",
                    "Feline Herpesvirus",
                    "Cat Flu",
                    "Feline Upper Respiratory Infection",
                    "Feline URI",
                    "cat cold",
                    "feline rhinotracheitis",
                    "herpes virus cat",
                    "FHV1"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "fhv_thumb",
                description: """
                Feline Herpesvirus-1 (FHV-1) is one of the most widespread viral \
                infections in domestic cats worldwide and the most common infectious \
                cause of conjunctivitis in the species. It is a highly contagious \
                alphaherpesvirus — the same biological family as the viruses that \
                cause chickenpox, shingles, and cold sores in humans — and shares \
                one of the defining characteristics of all herpesviruses: once a \
                cat is infected, the virus never fully leaves. It establishes a \
                permanent, lifelong latent infection in nerve tissue and can \
                reactivate at any time, particularly during periods of stress or \
                illness.

                FHV-1 is strictly a cat virus. It does not infect humans, dogs, or \
                other companion animals. However, it spreads very easily between \
                cats through direct contact with nasal, ocular, and oral secretions. \
                Shelters, catteries, breeding facilities, and any environment where \
                cats are housed in groups carry high transmission risk. Many cats are \
                exposed as kittens — often from their own mothers during early life.

                FHV-1 disease has two distinct phases that owners may encounter at \
                different points in a cat's life. The first is acute primary \
                infection, typically seen in kittens and unvaccinated cats, which \
                causes upper respiratory disease — sneezing, nasal discharge, fever, \
                and eye involvement — that can range from mild to severe. Severe \
                primary infection in young kittens can cause permanent damage to the \
                nasal passages and eyes. The second phase is recurrent reactivation \
                disease in adult carriers, which usually presents as intermittent \
                conjunctivitis, eye discharge, and sometimes corneal ulcers, often \
                triggered by stress.

                FHV-1 is vaccine-preventable in the sense that vaccination \
                significantly reduces the severity of infection and disease. However, \
                vaccination does not fully prevent infection, does not eliminate \
                latency in already-infected cats, and does not prevent future \
                flare-ups. Despite this limitation, vaccination remains an important \
                tool in reducing the severity and spread of FHV-1 disease.

                Young kittens, unvaccinated cats, immunocompromised cats, and cats \
                in multi-cat or shelter environments are at greatest risk of severe \
                disease. Stress is the most important trigger for reactivation in \
                latently infected cats.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                FHV-1 is an alphaherpesvirus — a group of viruses characterized by \
                their ability to infect and destroy epithelial cells (the lining \
                cells of the respiratory tract and eye surfaces), and then retreat \
                into nerve tissue where they remain permanently beyond the reach of \
                the immune system. This dual behavior — acute destruction followed \
                by permanent latency — defines the entire clinical course of FHV-1.

                During active infection, FHV-1 directly kills the epithelial cells \
                lining the nose, throat, conjunctiva (the membrane surrounding the \
                eye), and cornea (the transparent outer surface of the eye). The \
                result is the characteristic picture of feline upper respiratory \
                disease: sneezing, nasal congestion, eye inflammation, and \
                discharge. In severe cases, particularly in young kittens, the \
                virus can invade the bones of the nasal cavity, causing permanent \
                structural damage that leaves affected cats prone to chronic \
                bacterial nasal infections for life.

                The eye is frequently the most severely affected organ. FHV-1 can \
                cause corneal ulcers — open sores on the surface of the eye — that \
                are painful, potentially sight-threatening, and require prompt \
                treatment. In the most severe cases, the conjunctiva can scar and \
                adhere permanently to the cornea (symblepharon), causing chronic \
                discomfort and vision impairment. Branching, tree-like corneal \
                ulcers called dendritic ulcers are considered a hallmark sign of \
                FHV-1 ocular infection.

                After the acute phase resolves, the virus travels up the facial \
                nerve and establishes permanent latency in the trigeminal ganglion — \
                a nerve cluster at the base of the skull — where it persists \
                indefinitely, silently, beyond immune detection.

                **Transmission & Spread**

                FHV-1 is highly contagious between cats. The virus is shed in nasal, \
                ocular, and oral secretions, and transmission occurs through direct \
                contact with an infected or actively shedding cat, or through \
                contact with contaminated surfaces, bedding, food bowls, and hands. \
                An acutely infected cat sheds virus for up to three weeks after \
                symptoms begin. Latently infected cats — which represents the \
                majority of the adult cat population — shed the virus intermittently, \
                most commonly during or after stress, with or without visible \
                symptoms.

                FHV-1 does not survive long in the environment — typically less than \
                18 hours — and is readily destroyed by common household disinfectants \
                including dilute bleach.

                **Treatment Goals**

                There is no cure for FHV-1 and no treatment that eliminates latent \
                infection. For acute primary infection, the focus is on supportive \
                care — managing nasal congestion, maintaining nutrition and \
                hydration, and preventing secondary bacterial infections, which are \
                common and can significantly worsen the clinical picture. Corneal \
                ulcers require prompt veterinary attention to prevent permanent eye \
                damage; antiviral eye medications are used in severe ocular cases.

                For recurrent reactivation episodes in adult cats, management \
                centers on identifying and minimizing stress triggers, supporting \
                the immune system, and treating active eye disease early to prevent \
                progression to corneal scarring.

                Stress management is central to long-term FHV-1 control in carrier \
                cats. Known reactivation triggers include rehoming, introduction of \
                new animals, illness, surgery, hospitalization, and changes in \
                routine. When a known stressor is upcoming, proactive veterinary \
                management may reduce the severity of a flare-up.

                **The Virus That Never Leaves: Latency in the Trigeminal Ganglion**

                What makes FHV-1 — and all herpesviruses — biologically remarkable \
                is their relationship with the nervous system. After causing acute \
                infection, FHV-1 travels along sensory nerve fibers to the \
                trigeminal ganglion, a cluster of nerve cells that controls \
                sensation across the face, nose, and eyes. There, the virus enters \
                a dormant state: its genetic material persists inside nerve cells \
                indefinitely, not replicating, not triggering immune recognition, \
                essentially invisible.

                This latency strategy is the same one used by the human herpes \
                simplex virus (the cause of cold sores) and the varicella-zoster \
                virus (the cause of chickenpox and shingles). In each case, the \
                virus exploits the immune privilege of nerve tissue — a location \
                where the immune system's surveillance is limited — to establish a \
                permanent reservoir. Reactivation occurs when immune surveillance \
                weakens — most commonly due to stress, illness, or \
                immunosuppression — allowing the virus to travel back down the nerve \
                to the eye and nose surfaces and cause disease again.

                This is why stress management is not just a wellness nicety for \
                FHV-1-positive cats — it is a direct and meaningful medical \
                intervention.

                **A Note on L-Lysine**

                L-lysine supplements — available over the counter as treats, \
                powders, and pastes — have been widely recommended and used for \
                FHV-1-positive cats for many years. The original rationale was \
                plausible: herpesviruses require arginine to replicate, and lysine \
                was thought to competitively block arginine. In laboratory settings, \
                some early studies suggested a modest benefit.

                However, clinical evidence in cats has not supported this. A \
                systematic review of all available studies found no evidence that \
                lysine supplementation prevents or reduces FHV-1 infection in cats. \
                Several studies found no difference between supplemented and \
                unsupplemented cats, and some found that supplemented cats \
                experienced more frequent or more severe infections. The ABCD \
                (Advisory Board on Cat Diseases) guidelines explicitly state that \
                L-lysine supplementation is not recommended due to lack of efficacy. \
                An additional concern is that high-dose lysine supplementation may \
                interfere with arginine availability — and cats cannot synthesize \
                arginine on their own, making arginine deficiency a meaningful risk.

                If you have been giving your cat L-lysine, discuss with your \
                veterinarian whether to continue. Do not start supplementation \
                without veterinary guidance.

                **Myths vs. Facts**

                **Myth:** My cat had herpesvirus as a kitten but recovered — it's \
                gone now.
                **Fact:** Once a cat is infected with FHV-1, the virus remains for \
                life. The cat may appear completely healthy for months or years \
                between episodes, but the virus is dormant in nerve tissue and can \
                reactivate at any time — especially during stressful events.

                **Myth:** My cat's eye problem keeps coming back — it must be a new \
                infection each time.
                **Fact:** Recurrent conjunctivitis and corneal disease in cats is \
                most commonly caused by reactivation of existing latent FHV-1 \
                infection, not new exposures. The same virus that infected the cat \
                originally reactivates under stress.

                **Myth:** FHV-1 vaccination will fully protect my cat from \
                herpesvirus.
                **Fact:** The FHV-1 vaccine reduces the severity of infection and \
                disease but does not completely prevent infection, and it does not \
                eliminate latent virus in cats already infected. Vaccination is \
                still strongly recommended — it significantly reduces the clinical \
                impact of the disease.

                **Myth:** My cat's herpesvirus can spread to me or my dog.
                **Fact:** FHV-1 is strictly species-specific to cats. It cannot \
                infect humans, dogs, or any other companion animal.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period after exposure is typically 2 to 6 days. Acute signs — sneezing, eye discharge, nasal discharge — appear suddenly and progress rapidly, particularly in kittens.",
                    delayed: "In latently infected adult cats, recurrent episodes may appear weeks, months, or years after the initial infection, typically triggered by stress, illness, or immunosuppression. Between episodes, affected cats often appear completely normal."
                ),
                symptoms: [
                    "Sneezing — frequent and sometimes severe",
                    "Nasal discharge (clear to thick yellow-green)",
                    "Nasal congestion — audible breathing difficulty",
                    "Eye discharge (watery to thick and purulent)",
                    "Conjunctivitis — red, swollen, irritated eye membranes",
                    "Squinting or holding one or both eyes closed",
                    "Corneal ulcers — visible cloudiness or surface irregularity of the eye",
                    "Fever",
                    "Loss of appetite (often related to inability to smell food)",
                    "Lethargy",
                    "Drooling or mouth breathing in severe cases",
                    "Skin sores around the nose or mouth (less common; severe or recurrent infection)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Cats are the only companion animal species susceptible to FHV-1. Young kittens are at greatest risk of severe primary disease and permanent complications. Unvaccinated, immunocompromised, and stressed cats are at elevated risk of severe acute infection or reactivation. Most adult cats carry latent FHV-1 infection and may experience recurrent episodes throughout life."
                    )
                ],
                preventionTips: [
                    "Vaccinate all cats against FHV-1 — it is part of the standard core feline vaccine series. Vaccination significantly reduces the severity of infection and disease even though it does not fully prevent infection or eliminate latency.",
                    "Isolate any cat showing signs of upper respiratory infection — sneezing, eye discharge, nasal discharge — from other cats immediately to limit spread.",
                    "Minimize stress for latently infected cats — stress is the primary trigger for viral reactivation. Consistent routines, adequate space, and gradual introductions to new animals or environments all help reduce flare-up risk.",
                    "When a known stressor is unavoidable — rehoming, a new pet, surgery, boarding — consult your veterinarian in advance about supportive measures to reduce the likelihood or severity of an FHV-1 flare-up.",
                    "Disinfect shared surfaces, bedding, and food and water bowls frequently — FHV-1 is readily inactivated by dilute bleach and most common household disinfectants.",
                    "Any cat with recurring eye problems — conjunctivitis, discharge, squinting — should be evaluated by a veterinarian for FHV-1-associated ocular disease. Early treatment prevents permanent corneal scarring.",
                    "New cats introduced to a multi-cat household should be quarantined for at least two weeks, as apparently healthy cats can shed FHV-1 without visible symptoms.",
                    "L-lysine supplements are widely sold over the counter for FHV-1 but are not recommended by veterinary guidelines — clinical studies have not demonstrated benefit, and some have shown increased infection severity. Discuss with your veterinarian before starting any supplement."
                ],
                sources: [
                    "Cornell Feline Health Center — Feline Herpesvirus",
                    "Merck Veterinary Manual — Feline Herpesvirus",
                    "VCA Animal Hospitals — Feline Herpesvirus Infection (Feline Viral Rhinotracheitis)",
                    "International Cat Care (iCatCare) — Feline Herpesvirus",
                    "ABCD (Advisory Board on Cat Diseases) — Guideline for Feline Herpesvirus Infection",
                    "Wikipedia — Feline Herpesvirus-1",
                    "PMC / NIH — Feline Herpesvirus-1: Ocular Manifestations, Diagnosis and Treatment Options",
                    "PMC / NIH — Bol & Bunnik (2015): L-Lysine supplementation is not effective for FHV-1 (systematic review)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000018",  // FIP
                    "1D000001-0000-0000-0000-000000000019",  // FeLV
                    "1D000001-0000-0000-0000-000000000020",  // FIV
                    "1D000001-0000-0000-0000-000000000008",  // Kennel Cough (CIRDC)
                    "1D000001-0000-0000-0000-000000000046"   // Feline Calicivirus (FCV)
                ]
            ),

            // MARK: - Tick-Borne Diseases
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000022")!,
                name: "Tick-Borne Diseases",
                alternateNames: [
                    "Lyme disease",
                    "Lyme borreliosis",
                    "borreliosis",
                    "ehrlichiosis",
                    "canine ehrlichiosis",
                    "anaplasmosis",
                    "canine anaplasmosis",
                    "Rocky Mountain spotted fever",
                    "RMSF",
                    "babesiosis",
                    "cytauxzoonosis",
                    "tick fever",
                    "tick paralysis",
                    "tick-borne illness",
                    "tick disease",
                    "tick sickness",
                    "tick infestation anemia"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "tick_thumb",
                description: """
                Tick-borne diseases are a group of serious illnesses caused by \
                bacteria, parasites, and other pathogens transmitted through tick \
                bites. Rather than a single disease, this entry covers the major \
                tick-borne threats to companion animals: Lyme disease (Borrelia \
                burgdorferi), Ehrlichiosis, Anaplasmosis, Rocky Mountain Spotted \
                Fever (RMSF), Babesiosis, and Cytauxzoonosis in cats.

                These diseases are not contagious between animals or from pets \
                to people — the tick itself is the transmitter. However, several \
                tick-borne diseases are zoonotic, meaning the same ticks that bite \
                your pet can also bite and infect people.

                Disease severity ranges from mild to rapidly life-threatening \
                depending on the specific pathogen, the species affected, and how \
                quickly treatment is started. RMSF, Babesiosis, and Cytauxzoonosis \
                (in cats) can be fatal within days without treatment. Lyme disease \
                may not produce visible symptoms for weeks to months, while \
                Ehrlichiosis and Anaplasmosis typically cause illness within one \
                to two weeks of infection.

                Dogs are the most commonly and seriously affected companion \
                animals. Cats can develop Cytauxzoonosis — a severe, often rapidly \
                fatal disease primarily in the southeastern United States. Small \
                mammals, birds, and reptiles can carry ticks and serve as reservoir \
                hosts, though clinical illness is less commonly documented in \
                these species.

                Heavy tick infestations — even without disease transmission — can \
                cause significant blood-loss anemia, particularly in small, young, \
                or debilitated animals. In rabbits, guinea pigs, kittens, and \
                puppies, a large number of feeding ticks can rapidly deplete blood \
                volume and cause collapse.

                A Lyme vaccine is available for dogs and is recommended in endemic \
                areas. No vaccine is currently available for most other tick-borne \
                diseases in companion animals. Tick prevention is the cornerstone \
                of protection for all species.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Tick-borne pathogens use different mechanisms to cause disease, \
                which is why symptoms can vary significantly depending on which \
                pathogen is involved.

                Lyme disease is caused by the bacterium Borrelia burgdorferi, \
                transmitted primarily by Ixodes ticks (black-legged ticks, also \
                called deer ticks). The bacteria invade joint tissues and \
                connective structures, causing inflammation most visible as \
                shifting-leg lameness in dogs. In some cases, Lyme bacteria \
                reach the kidneys and trigger an immune-mediated response known \
                as Lyme nephropathy — a potentially fatal kidney complication seen \
                more often in certain breeds, including Labrador Retrievers, \
                Golden Retrievers, and Bernese Mountain Dogs.

                Ehrlichiosis is caused by Ehrlichia bacteria that invade white \
                blood cells, disrupting immune function and causing a dramatic \
                drop in platelets (the cells that help blood clot), which leads \
                to bruising and abnormal bleeding. Ehrlichiosis has three phases: \
                acute (1–4 weeks of active illness), subclinical (months to years \
                with no visible signs, while infection persists silently), and \
                chronic (severe, life-threatening bone marrow involvement). Dogs \
                in the subclinical phase can appear completely healthy while the \
                infection quietly damages their ability to produce blood cells.

                Anaplasmosis is caused by Anaplasma bacteria that infect \
                neutrophils — a type of white blood cell that forms a critical \
                part of the immune response. This impairs immune function and also \
                causes platelet depletion similar to Ehrlichiosis, leading to a \
                risk of abnormal bleeding.

                Rocky Mountain Spotted Fever (RMSF) is caused by Rickettsia \
                rickettsii, transmitted by several tick species including the \
                American dog tick, the brown dog tick, and the Lone Star tick. \
                The bacteria attack the cells lining blood vessels throughout \
                the body, causing widespread inflammation and vascular damage. \
                RMSF can affect virtually every organ system and progress to \
                multi-organ failure within days. Despite its name, RMSF occurs \
                across much of the United States — not only in the Rocky Mountain \
                region.

                Babesiosis is caused by Babesia parasites that directly invade \
                and destroy red blood cells, causing hemolytic anemia (anemia \
                from red blood cell destruction). The body's immune response to \
                infected cells can intensify this damage. Severe cases cause \
                weakness, pale or yellowish gums, dark urine, and collapse.

                Cytauxzoonosis is the cat-specific counterpart to Babesiosis, \
                caused by Cytauxzoon felis. It is transmitted primarily by the \
                Lone Star tick and American dog tick in the southeastern and \
                south-central United States. The parasite invades red blood cells \
                and macrophages (immune cells), causing severe anemia, systemic \
                inflammation, and organ failure. Cytauxzoonosis has historically \
                carried a very high case fatality rate in domestic cats, though \
                outcomes have improved with aggressive early veterinary care.

                **Tick Paralysis — A Non-Infectious Complication**

                Certain tick species produce a neurotoxin in their saliva that \
                causes progressive paralysis while the tick remains attached and \
                feeding. Tick paralysis is not an infection — it is a direct \
                effect of the toxin on the nervous system. Signs typically begin \
                in the hind limbs and ascend toward the head over hours to days. \
                Removing the tick promptly usually leads to rapid improvement, \
                but the condition can be fatal if the tick is not found and \
                removed in time.

                **The Anemia Risk of Heavy Tick Loads**

                Even without transmitting disease, a heavy tick infestation poses \
                a direct threat through blood loss. Ticks are blood-feeding \
                parasites; in large numbers, the volume of blood they consume can \
                cause significant anemia. This risk is most acute in small-bodied \
                animals — rabbits, guinea pigs, small birds — as well as young \
                animals such as kittens and puppies, and animals that are already \
                debilitated. A small animal overwhelmed by feeding ticks may show \
                pallor, weakness, rapid breathing, and collapse without any \
                infectious disease involvement.

                **Transmission & Spread**

                Tick-borne diseases are transmitted when an infected tick attaches \
                and feeds on a host animal. The tick typically must remain attached \
                for a period of time before the pathogen transfers — this window \
                varies by disease. Lyme disease generally requires 24–48 hours of \
                tick attachment for meaningful transmission to occur. RMSF and \
                some other pathogens can transmit more rapidly after attachment. \
                Prompt tick removal reduces but does not completely eliminate \
                transmission risk.

                Different tick species transmit different diseases, and tick \
                distribution varies by geography:

                Ixodes scapularis (black-legged tick, deer tick): primary vector \
                for Lyme disease and Anaplasmosis. Most prevalent in the Northeast \
                and upper Midwest United States; range is expanding.

                Dermacentor variabilis (American dog tick) and Amblyomma \
                americanum (Lone Star tick): primary vectors for RMSF and \
                Ehrlichiosis. Distributed broadly across the southern, eastern, \
                and south-central United States.

                Rhipicephalus sanguineus (brown dog tick): a major vector for \
                Ehrlichiosis and RMSF. Notably, this tick can complete its entire \
                life cycle indoors, which means dogs in heavily infested households \
                may be exposed even without outdoor access to wooded or grassy areas.

                Tick activity peaks in spring and summer but can persist year-round \
                in warmer climates. Animals with outdoor access — particularly in \
                wooded, brushy, or tall-grass environments — face the highest \
                exposure risk. Ticks can also be carried indoors on clothing, \
                hiking gear, or other animals.

                **The Poppy Seed Problem**

                Nymph-stage deer ticks — responsible for the majority of Lyme \
                disease transmission — are roughly the size of a poppy seed at \
                their most infectious life stage. They are easily overlooked even \
                during careful visual examination, particularly in animals with \
                thick or dark fur. Ticks prefer hidden attachment sites: between \
                toes, inside ear flaps, around the groin and tail base, under the \
                collar, and in the axillary (armpit) skin folds. A visual check \
                that misses these areas may miss the tick most likely to cause \
                disease.

                **Treatment Goals**

                Treatment of tick-borne diseases requires veterinary diagnosis, \
                which typically involves blood testing to identify the specific \
                pathogen involved. Treatment goals vary by disease:

                For bacterial tick-borne diseases (Lyme, Ehrlichiosis, \
                Anaplasmosis, RMSF), treatment focuses on eliminating the \
                infection, reducing inflammation, and supporting affected organ \
                systems during recovery. Early treatment is strongly associated \
                with better outcomes — particularly for RMSF, where delays in \
                treatment can significantly worsen the clinical course.

                For Babesiosis and Cytauxzoonosis, treatment targets the parasites \
                directly while supporting the animal through the effects of anemia \
                and systemic inflammation. Blood transfusions may be required in \
                severe cases.

                For tick paralysis, prompt removal of the tick is the primary \
                intervention. Supportive care may be needed while the animal \
                recovers from the effects of the neurotoxin.

                Long-term monitoring is often recommended following treatment, \
                particularly for Ehrlichiosis (which can relapse) and Lyme disease \
                (which may have persistent joint effects in some dogs).

                **The Fence Lizard\u{2019}s Secret**

                The Western fence lizard (Sceloporus occidentalis), common in the \
                western United States, has a remarkable relationship with Lyme- \
                carrying ticks. When Ixodes ticks feed on this lizard, proteins \
                in the lizard\u{2019}s blood actively destroy Borrelia burgdorferi — the \
                bacterium that causes Lyme disease — within the tick. Researchers \
                have estimated that the presence of these lizards may meaningfully \
                reduce the proportion of infected ticks within their range. This \
                natural resistance is specific to this species and is not shared \
                by most other reptiles.

                **Myths vs. Facts**

                **Myth:** My pet is safe because we don\u{2019}t live in the Northeast.
                **Fact:** While Lyme disease is most common in the Northeast and \
                upper Midwest, RMSF, Ehrlichiosis, Babesiosis, and Anaplasmosis \
                occur across a much broader geographic area — including the South, \
                Southeast, and central United States. Tick ranges are also \
                expanding as climate and land use change. Tick prevention is \
                appropriate nationwide.

                **Myth:** I checked my pet and didn\u{2019}t find a tick, so they can\u{2019}t \
                have a tick-borne disease.
                **Fact:** Nymph-stage ticks are extremely small and easily missed, \
                especially in animals with thick or dark fur. Visual checks alone \
                are not a reliable method for ruling out tick exposure. Blood tests \
                are the only reliable way to detect tick-borne infection.

                **Myth:** If the tick was only attached briefly, there\u{2019}s no risk.
                **Fact:** While longer attachment time increases transmission risk \
                for many pathogens — particularly Lyme disease — some diseases, \
                including RMSF, can transmit more rapidly. Prompt removal is always \
                recommended, but brief attachment does not guarantee safety.

                **Myth:** Cats don\u{2019}t get tick-borne diseases.
                **Fact:** Cats can develop Cytauxzoonosis, a severe and often \
                rapidly fatal tick-borne disease found in the southeastern United \
                States. Cats can also be infected with Anaplasmosis and Ehrlichiosis.

                **Zoonotic Risk**

                Several tick-borne diseases in this group — including Lyme disease, \
                RMSF, Ehrlichiosis, Anaplasmosis, and Babesiosis — are zoonotic, \
                meaning they can infect humans as well as animals. These diseases \
                are not transmitted directly from your pet to you. The risk comes \
                from the same infected ticks that bit your pet potentially biting \
                you or other household members.

                If your pet has been diagnosed with a tick-borne disease, it is a \
                signal that infected ticks are present in your environment. Check \
                yourself and family members for tick bites and contact your \
                physician if you have concerns about your own exposure. Individuals \
                who are immunocompromised, pregnant, elderly, or very young may be \
                at greater risk and should take extra precautions.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "RMSF and Cytauxzoonosis can cause visible illness within 2–5 days of a tick bite and may progress rapidly to life-threatening status. Ehrlichiosis and Anaplasmosis typically produce signs within 1–2 weeks of infection. Tick paralysis can develop within days of a tick attaching.",
                    delayed: "Lyme disease may produce no visible symptoms for weeks to months after infection and in some dogs is only discovered through routine bloodwork. Ehrlichiosis has a silent subclinical phase that can persist for months to years before progressing to the severe chronic form."
                ),
                symptoms: [
                    "Lethargy, weakness, or sudden collapse",
                    "Fever (animal feels warm to the touch; may shiver or shake)",
                    "Loss of appetite",
                    "Reluctance to move or bear weight on one or more legs",
                    "Swollen, painful joints",
                    "Swollen lymph nodes",
                    "Pale, white, or yellowish gums (sign of anemia)",
                    "Unexplained bruising or pinpoint red spots on skin or gums",
                    "Nosebleeds or unusual bleeding from any site",
                    "Vomiting or diarrhea",
                    "Increased thirst and urination",
                    "Dark, reddish-brown, or discolored urine",
                    "Rapid or labored breathing",
                    "Progressive weakness or paralysis beginning in the hind limbs",
                    "Neurological signs: incoordination, stumbling, head tilt, or seizures",
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Dogs are the companion animals most commonly and seriously affected by tick-borne diseases. All five major diseases covered here — Lyme disease, Ehrlichiosis, Anaplasmosis, RMSF, and Babesiosis — can cause serious or fatal illness in dogs. RMSF can be fatal within days without treatment; Babesiosis causes life-threatening destruction of red blood cells; Ehrlichiosis can silently progress to a severe chronic form affecting the bone marrow. Certain breeds including Bernese Mountain Dogs, Labrador Retrievers, and Golden Retrievers may have elevated susceptibility to Lyme nephropathy, a potentially fatal kidney complication. Heavy tick burdens also pose a direct anemia risk, particularly in young dogs. A Lyme vaccine is available and is recommended in endemic areas. Any dog with outdoor access in tick-endemic environments faces meaningful risk, with peak exposure in spring and summer."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cytauxzoonosis — caused by Cytauxzoon felis — is the most serious tick-borne threat to domestic cats. Transmitted primarily by the Lone Star tick and American dog tick, it is largely confined to the southeastern and south-central United States and has historically carried a very high case fatality rate. Affected cats develop rapidly progressive fever, weakness, difficulty breathing, and collapse. Anaplasmosis and Ehrlichiosis have also been documented in cats. Cats appear relatively resistant to clinical Lyme disease. Heavy tick loads pose a direct anemia risk, particularly in kittens and small-bodied cats."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Small mammals — including rabbits, guinea pigs, and rodents — are natural reservoir hosts for several tick-borne pathogens, particularly Borrelia burgdorferi (Lyme disease) and Anaplasma species. Wild rodents are the primary wildlife reservoir for Lyme disease in North America. Pet rabbits and guinea pigs with outdoor access or exposure to ticks can develop tick-borne illness; ferrets are also considered susceptible. The most acute risk for small mammals is blood-loss anemia: even moderate numbers of feeding ticks can represent a significant proportion of a small animal's total blood volume, causing rapid-onset weakness, pallor, and collapse. Young, small, or debilitated animals face the greatest risk from this direct effect even in the absence of disease transmission."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Pet birds and backyard poultry can harbor ticks and serve as reservoir hosts for some tick-borne pathogens, including those associated with RMSF. Birds with outdoor access may introduce infected ticks into home environments, increasing exposure risk for other pets and people in the household. Clinical tick-borne disease in companion and pet bird species is poorly documented and appears uncommon. Heavy tick burdens may cause localized irritation or mild anemia in smaller bird species. Regular examination of birds with outdoor access is recommended."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Reptiles commonly carry ticks — particularly species with outdoor access or outdoor enclosures — and can introduce ticks into the home. Clinical tick-borne disease in reptiles is not well-documented, and reptiles appear largely resistant to the infectious pathogens ticks transmit to mammals. However, heavy infestations can cause localized tissue damage, debilitation, and anemia. Ticks found on reptiles should be removed promptly using appropriate technique. The Western fence lizard (Sceloporus occidentalis) is notable for a natural resistance to Borrelia burgdorferi: proteins in its blood destroy the Lyme-causing bacterium within feeding ticks, and researchers believe this reduces Lyme prevalence in ticks within the lizard's range."
                    ),
                ],
                preventionTips: [
                    "Use a veterinarian-recommended tick prevention product consistently throughout the year — not only during peak tick season. Many tick preventatives also cover fleas and other external parasites. Ask your vet which option is appropriate for your pet\u{2019}s species and lifestyle.",
                    "Perform a thorough tick check after every outing in wooded, grassy, or brushy areas. Check carefully between toes, inside ear flaps, around the groin and tail base, under the collar, and in armpit skin folds — ticks actively seek hidden attachment sites.",
                    "If a tick is found, remove it promptly: use fine-tipped tweezers or a tick removal tool to grasp the tick as close to the skin as possible and pull upward with steady, even pressure. Do not twist, crush, jerk, or apply heat, petroleum jelly, or nail polish — these methods can increase the risk of pathogen transmission. Dispose of the tick by placing it in alcohol, sealing it in a bag, or flushing it.",
                    "Ask your veterinarian about the Lyme vaccine for dogs, particularly if you live in or travel to endemic regions (northeastern US, upper Midwest, parts of Canada or Europe). Vaccination does not replace tick prevention — both are needed.",
                    "Keep grass mowed short and remove leaf litter, brush piles, and dense groundcover from areas where your pets spend time. Ticks thrive in humid, shaded environments.",
                    "Talk to your veterinarian about routine tick-borne disease screening. Many clinics include Lyme disease, Ehrlichiosis, and Anaplasmosis on annual wellness blood panels for dogs — particularly in endemic areas.",
                    "For rabbits, guinea pigs, and other small mammals with any outdoor access, check for ticks regularly. Even a moderate number of feeding ticks can cause significant blood loss anemia in small animals.",
                    "If you find ticks on your pet, check yourself, your family members, and any other household pets as well. Infected ticks in your environment do not distinguish between animal and human hosts.",
                    "If you have concerns about your own tick exposure, contact your physician. Individuals who are immunocompromised, pregnant, elderly, or very young may face greater risk from tick-borne infection and should take extra precautions.",
                    "The brown dog tick can complete its entire life cycle indoors, meaning heavily infested dogs may be exposed to tick-borne pathogens even without outdoor access to grass or woods. If you suspect an indoor infestation, consult a pest control professional in addition to treating your pet."
                ],
                sources: [
                    "https://www.vet.cornell.edu/departments-centers-and-institutes/riney-canine-health-center/canine-health-information/lyme-disease",
                    "https://www.merckvetmanual.com/infectious-diseases/lyme-borreliosis/lyme-borreliosis-in-animals",
                    "https://www.merckvetmanual.com/infectious-diseases/rickettsial-diseases/rocky-mountain-spotted-fever-in-animals",
                    "https://www.merckvetmanual.com/infectious-diseases/rickettsial-diseases/ehrlichiosis-and-related-infections",
                    "https://www.avma.org/resources/pet-owners/petcare/tick-borne-diseases-dogs",
                    "https://vcahospitals.com/know-your-pet/lyme-disease-in-dogs",
                    "https://www.cdc.gov/ticks/index.html",
                    "https://en.wikipedia.org/wiki/Cytauxzoonosis"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000006",  // Leptospirosis
                    "1D000001-0000-0000-0000-000000000023",  // GI Parasites
                    "1D000001-0000-0000-0000-000000000026"   // Mange
                ]
            ),

            // MARK: - GI Parasites
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000023")!,
                name: "GI Parasites",
                alternateNames: [
                    "intestinal parasites",
                    "worms",
                    "roundworms",
                    "hookworms",
                    "tapeworms",
                    "whipworms",
                    "pinworms",
                    "Giardia",
                    "Coccidia",
                    "coccidiosis",
                    "Cryptosporidium",
                    "Toxocara",
                    "Toxocara canis",
                    "Toxocara cati",
                    "Ancylostoma",
                    "Dipylidium",
                    "Echinococcus",
                    "Taenia",
                    "Trichuris",
                    "deworming",
                    "intestinal worms",
                    "parasitic infection",
                    "fecal parasites",
                    "gastrointestinal parasites"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "gi_parasites_thumb",
                description: """
                Gastrointestinal (GI) parasites are among the most common infectious \
                conditions affecting pets of all species worldwide. This entry covers \
                the major intestinal parasites encountered in companion animals: \
                roundworms, hookworms, tapeworms (Dipylidium, Taenia, and \
                Echinococcus), whipworms, Giardia, Coccidia, and Cryptosporidium.

                Severity ranges from mild and easily treated to life-threatening — \
                particularly in young, elderly, or immunocompromised animals. Several \
                of these parasites are zoonotic, meaning they can infect humans, \
                making pet parasite control a public health priority as well as an \
                animal welfare concern.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Different parasites damage the body through distinct mechanisms. \
                Roundworms (Toxocara canis in dogs, T. cati in cats) compete with \
                the host for nutrients and migrate through the lungs during their \
                larval stage, sometimes causing coughing or respiratory signs before \
                settling in the intestines. Heavy infections cause pot-bellied \
                distension and failure to thrive, especially in young animals.

                **Born Infected: The Roundworm Lifecycle**

                Puppies and kittens can be infected with Toxocara before they are \
                even born. Dormant larvae in the mother\u{2019}s tissues reactivate during \
                pregnancy and pass to offspring transplacentally (across the placenta) \
                and transmammarily (through milk). This is why veterinarians recommend \
                deworming puppies starting as early as 2 weeks of age — they may be \
                carrying a worm burden from birth.

                Hookworms (Ancylostoma, Uncinaria) are blood-feeding parasites that \
                attach to the intestinal wall. Heavy infections cause life-threatening \
                iron-deficiency anemia, particularly in puppies and kittens. Pale \
                gums, profound weakness, and collapse are warning signs of severe \
                hookworm anemia requiring emergency veterinary care.

                Tapeworms cause intestinal irritation and compete for nutrients. \
                Dipylidium caninum causes perianal itching and scooting and sheds \
                rice-grain-sized segments visible near the tail or in feces. Taenia \
                species are acquired through prey animals or raw meat. Echinococcus \
                is the most dangerous tapeworm: its larvae form fluid-filled hydatid \
                cysts in the organs of intermediate hosts — including, rarely, humans.

                **The Flea-Tapeworm Connection**

                Dipylidium tapeworm eggs are not passed directly between pets — they \
                require a flea as an intermediate host. A pet becomes infected by \
                accidentally swallowing an infected flea during grooming. A \
                Dipylidium diagnosis is therefore a signal that the pet also had \
                fleas, and effective treatment must address both the tapeworm and the \
                flea infestation at the same time. Treating only the tapeworm without \
                eliminating fleas will result in rapid reinfection.

                Whipworms (Trichuris vulpis) embed their whip-like anterior end into \
                the wall of the large intestine. They primarily affect dogs and are \
                uncommon in cats. Infections cause large-bowel diarrhea — often with \
                mucus and fresh blood — and can be difficult to detect because \
                whipworm eggs are shed intermittently in feces.

                Giardia is a single-celled protozoan parasite (not a worm) that \
                colonizes the small intestine and disrupts its lining, impairing \
                absorption of water and nutrients. It causes watery, greasy, \
                foul-smelling diarrhea and spreads easily in kennels, shelters, and \
                multi-pet households due to environmental contamination.

                Coccidia (Isospora in dogs and cats; Eimeria and related genera in \
                rabbits, guinea pigs, birds, and reptiles) are protozoan parasites \
                that invade and destroy intestinal cells. Young animals are most \
                susceptible — in rabbits and guinea pigs, a heavy Eimeria infection \
                can progress rapidly to fatal hemorrhagic enteritis.

                Cryptosporidium is closely related to Coccidia. In most species it \
                causes diarrhea that resolves with supportive care, but in reptiles — \
                particularly snakes infected with Cryptosporidium serpentis — the \
                infection is often chronic, progressive, and incurable with currently \
                available treatments.

                **Transmission & Spread**

                Most GI parasites spread through the fecal-oral route: eggs or \
                oocysts shed in one animal\u{2019}s feces contaminate the environment, and \
                another animal ingests them through grooming, sniffing, or drinking \
                from contaminated water. Roundworm eggs are particularly resilient — \
                they can survive in soil for years and resist many common disinfectants.

                Tapeworms require intermediate hosts. Dipylidium spreads through \
                fleas; Taenia and Echinococcus spread through rodents, rabbits, or \
                other prey animals that have ingested tapeworm eggs and developed \
                larval cysts in their tissues. Giardia and Cryptosporidium also spread \
                through contaminated water — including standing puddles, streams, and \
                shared water bowls. Roundworms are additionally transmitted to \
                offspring through the placenta and mother\u{2019}s milk.

                **Treatment Goals**

                Treatment varies by parasite but generally involves antiparasitic \
                medications prescribed by a veterinarian, often given in multiple \
                rounds — most dewormers eliminate adult parasites but may not clear \
                all larval stages in a single dose. Giardia and Coccidia require \
                specific antiprotozoal medications rather than standard dewormers. \
                Cryptosporidium has no reliably curative treatment, particularly in \
                reptiles. Supportive care — fluids, nutritional support — is often \
                needed in severe cases.

                **Deworming Isn\u{2019}t Just a Puppy Thing**

                Many pet owners associate deworming only with puppies and kittens, \
                but adult animals can acquire new parasitic infections throughout \
                their lives — especially pets that go outdoors, hunt, or interact \
                with other animals. The Companion Animal Parasite Council (CAPC) \
                recommends year-round parasite prevention for dogs and cats, combined \
                with regular fecal examinations (at least once or twice yearly for \
                adults; quarterly for puppies and kittens). Environmental control — \
                prompt feces removal and daily litter box cleaning — significantly \
                reduces egg and oocyst burden and lowers reinfection risk.

                **Zoonotic Risk**

                Several GI parasites pose genuine health risks to humans:

                Roundworms (Toxocara): Humans, especially children, can accidentally \
                ingest Toxocara eggs from soil or sand contaminated with pet or \
                wildlife feces. Larvae cannot complete their lifecycle in humans but \
                migrate through tissues, causing visceral larva migrans (organ damage) \
                or ocular larva migrans (eye damage with potential vision loss). \
                Sandboxes and playgrounds are a well-documented source of exposure. \
                Toxocariasis is one of the most common parasitic infections in humans \
                worldwide.

                Hookworms: Larvae in contaminated soil can penetrate human skin — \
                usually bare feet — causing cutaneous larva migrans, an intensely \
                itchy, winding red rash that tracks the larva\u{2019}s migration path.

                Echinococcus: Humans can become accidental intermediate hosts by \
                ingesting Echinococcus eggs from the feces of an infected dog. \
                Larvae form large fluid-filled hydatid cysts in the liver, lungs, \
                or other organs — a serious condition (cystic echinococcosis) \
                requiring surgery or prolonged medication.

                Giardia: Zoonotic potential is debated — not all Giardia strains \
                infect both humans and animals — but handwashing after handling pets \
                or cleaning up feces is a reasonable precaution.

                Cryptosporidium: Immunocompromised individuals (those undergoing \
                chemotherapy, living with HIV/AIDS, or on immunosuppressive \
                medications) are at particular risk for severe illness. Standard \
                hand hygiene after handling reptiles or cleaning their enclosures \
                is essential.

                If you or a family member may have been exposed, contact a physician \
                promptly. For your pet, contact a veterinarian or animal poison \
                control immediately if you suspect GI parasitism.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Onset varies by parasite. Heavy hookworm infections can cause life-threatening anemia in puppies and kittens within days. Coccidia and Eimeria outbreaks in juvenile rabbits and guinea pigs can progress to fatal enteritis rapidly. Giardia typically causes signs within 1–2 weeks of infection.",
                    delayed: "Roundworm and tapeworm infections often cause no obvious signs for weeks to months. Cryptosporidium in reptiles typically presents as chronic, slowly progressive disease over weeks to months. Adult animals with low-burden infections may show no clinical signs at all."
                ),
                symptoms: [
                    "Diarrhea (may contain blood or mucus)",
                    "Vomiting",
                    "Weight loss or failure to thrive",
                    "Pot-bellied appearance (especially in young animals with heavy roundworm burden)",
                    "Pale gums (sign of blood-loss anemia — hookworms)",
                    "Lethargy and weakness",
                    "Poor coat or feather condition",
                    "Coughing or respiratory signs (roundworm larval migration through lungs)",
                    "Scooting or perianal irritation (tapeworms)",
                    "Visible rice-grain segments near the tail or in feces (Dipylidium tapeworm)",
                    "Visible worms in vomit or feces (roundworms)",
                    "Increased appetite with concurrent weight loss",
                    "Dehydration",
                    "Loss of appetite",
                    "Sudden collapse (severe hookworm anemia in puppies or kittens)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "All major GI parasites in this entry affect dogs. Most infections are manageable with appropriate deworming, but heavy hookworm burdens can cause life-threatening anemia in puppies — pale gums, lethargy, and collapse warrant emergency evaluation. Year-round parasite prevention is strongly recommended."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cats are susceptible to roundworms (Toxocara cati), hookworms, tapeworms, Giardia, and Coccidia. Whipworms are rare in cats. Heavy hookworm infections can be life-threatening in kittens. Year-round parasite prevention is recommended."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Coccidia (Eimeria species) can be rapidly fatal in rabbits and guinea pigs, particularly in juveniles stressed by weaning or environmental change — this is the worst-case driver for this species group. Small mammals also serve as intermediate hosts for Echinococcus tapeworms. Giardia and Cryptosporidium are documented in rabbits and guinea pigs. Prompt veterinary evaluation is essential."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .moderate,
                        notes: "Giardia is the primary concern in pet birds, particularly budgerigars and cockatiels — the worst-case driver for this species. Coccidia affects some avian species. Roundworms (Ascaridia) can be significant in certain birds. Overall parasite burden is generally lower than in mammals, but any suspected infection warrants veterinary evaluation."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .high,
                        notes: "Cryptosporidium is the worst-case pathogen for reptiles — particularly snakes infected with Cryptosporidium serpentis — often chronic and incurable with available treatments. Coccidia (Isospora and related genera) affect many reptile species. Oxyurid pinworms are common in herbivorous reptiles and are usually low pathogenicity. Any GI parasitism in a reptile warrants veterinary evaluation and may require long-term management."
                    )
                ],
                preventionTips: [
                    "Schedule regular fecal examinations — at least annually for adult pets; quarterly for puppies and kittens",
                    "Use year-round intestinal parasite prevention products as recommended by your veterinarian",
                    "Remove and dispose of feces promptly — daily removal from yards and litter boxes significantly reduces environmental contamination",
                    "Implement comprehensive flea control to prevent Dipylidium tapeworm infection",
                    "Prevent hunting and consumption of raw or undercooked meat (reduces Taenia and Echinococcus risk)",
                    "Provide fresh, clean water; avoid allowing pets to drink from stagnant puddles or streams",
                    "Wash hands thoroughly after handling pets, cleaning litter boxes, or working in soil",
                    "Keep children\u{2019}s sandboxes covered when not in use to reduce Toxocara exposure risk",
                    "Quarantine and test new animals before introducing them to established pets",
                    "Keep reptile enclosures clean and practice thorough hand hygiene after handling reptiles",
                    "Follow CAPC (Companion Animal Parasite Council) guidelines for parasite prevention in your region"
                ],
                sources: [
                    "Companion Animal Parasite Council (CAPC) — Guidelines: https://capcvet.org/guidelines/",
                    "Merck Veterinary Manual — Roundworms in Small Animals: https://www.merckvetmanual.com/digestive-system/gastrointestinal-parasites-of-small-animals/roundworms-in-small-animals",
                    "Merck Veterinary Manual — Hookworms in Small Animals: https://www.merckvetmanual.com/digestive-system/gastrointestinal-parasites-of-small-animals/hookworms-in-small-animals",
                    "Merck Veterinary Manual — Tapeworms in Small Animals: https://www.merckvetmanual.com/digestive-system/gastrointestinal-parasites-of-small-animals/tapeworms-in-small-animals",
                    "CDC — Toxocariasis (Toxocara Infection): https://www.cdc.gov/parasites/toxocariasis/",
                    "CDC — Hookworm: https://www.cdc.gov/parasites/hookworm/",
                    "CDC — Cryptosporidiosis: https://www.cdc.gov/parasites/crypto/",
                    "AVMA — Internal Parasites: https://www.avma.org/resources-tools/pet-owners/petcare/internal-parasites",
                    "LafeberVet — Giardia in Companion Birds: https://lafeber.com/vet/giardia-in-companion-birds/",
                    "Cornell University College of Veterinary Medicine — Giardia: https://www.vet.cornell.edu/animal-health-diagnostic-center/testing/protocols/giardia"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000022",  // Tick-Borne Diseases
                    "1D000001-0000-0000-0000-000000000024",  // Toxoplasma
                    "1D000001-0000-0000-0000-000000000027",  // Baylisascaris
                    "1D000001-0000-0000-0000-000000000028",  // Fleas
                    "1D000001-0000-0000-0000-000000000037"   // Coccidiosis & Cryptosporidiosis
                ]
            ),

            // MARK: - Toxoplasma
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000024")!,
                name: "Toxoplasma",
                alternateNames: [
                    "toxoplasmosis",
                    "Toxoplasma gondii",
                    "T. gondii",
                    "toxoplasma infection",
                    "toxoplasma parasite",
                    "cat parasite zoonotic",
                    "litter box disease",
                    "cat feces parasite",
                    "protozoan parasite cat",
                    "oocyst",
                    "tissue cyst",
                    "bradyzoite",
                    "tachyzoite"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "toxoplasma_thumb",
                description: """
                Toxoplasma gondii is a single-celled protozoan parasite that infects \
                virtually all warm-blooded animals — but cats hold a unique and \
                important role in its lifecycle. Cats are the only animals in which \
                Toxoplasma can complete its sexual reproductive cycle, making them \
                the definitive host and the primary source of environmentally \
                infectious oocysts (eggs).

                Most healthy adult cats infected with Toxoplasma show no clinical \
                signs at all. The same is true for most other species — including \
                humans. However, the infection carries serious risks for pregnant \
                animals and people, and for any individual whose immune system is \
                compromised. Understanding how Toxoplasma spreads and how to reduce \
                exposure risk is essential for any multi-pet or multi-person household.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Toxoplasma gondii is an obligate intracellular parasite — it can only \
                survive and reproduce inside the cells of a host. After ingestion, the \
                parasite invades intestinal cells and rapidly multiplies as tachyzoites \
                (fast-replicating forms), spreading through the bloodstream to muscles, \
                the brain, the eyes, and other organs. In healthy, immunocompetent \
                animals, the immune system contains the infection within weeks, and the \
                parasite transitions to slow-replicating bradyzoites enclosed in tissue \
                cysts — where they can remain dormant for the animal\u{2019}s lifetime.

                In immunocompromised animals or young kittens, this containment can \
                fail. Active tachyzoite replication causes severe inflammation wherever \
                the parasite establishes — most dangerously in the lungs (pneumonia), \
                liver (hepatitis), and brain and spinal cord (encephalitis, seizures, \
                blindness). These presentations can be life-threatening.

                **The Definitive Host: Why Cats Are Central**

                Cats are the only animals in which Toxoplasma undergoes sexual \
                reproduction, producing oocysts in the intestines that are then shed \
                in feces. A cat newly exposed to Toxoplasma (typically by hunting and \
                eating infected prey, or ingesting oocysts from the environment) will \
                shed millions of oocysts in its feces for approximately one to three \
                weeks. After this primary infection, the cat\u{2019}s immune system typically \
                stops oocyst shedding entirely — most cats shed oocysts only once in \
                their lifetime.

                Freshly shed oocysts are not immediately infectious. They must \
                sporulate in the environment — a process that takes one to five days \
                depending on temperature and humidity. This means that a litter box \
                cleaned daily before sporulation occurs dramatically reduces the risk \
                of environmental contamination. Cats that are kept exclusively indoors \
                and do not hunt or eat raw meat are at very low risk of ever acquiring \
                — and therefore shedding — Toxoplasma.

                **Transmission & Spread**

                Toxoplasma reaches new hosts through three main routes:

                Oocysts from cat feces: Sporulated oocysts in soil, sandboxes, water, \
                or unwashed produce are ingested by humans or animals. This is the \
                environmental contamination route most associated with cats.

                Tissue cysts in raw or undercooked meat: Animals raised for food \
                (sheep, pigs, venison) or hunted prey commonly harbor dormant tissue \
                cysts. Carnivores and omnivores that eat raw meat — or pets fed raw \
                diets — are at risk via this route.

                Transplacental transmission: In pregnant animals (and humans) \
                experiencing a primary infection, tachyzoites can cross the placenta \
                and infect developing offspring, causing severe congenital disease, \
                stillbirth, or abortion.

                **Treatment Goals**

                There is no treatment that eliminates Toxoplasma entirely — once \
                tissue cysts form, they persist for life. Treatment goals focus on \
                suppressing active tachyzoite replication during clinical disease. \
                Antiprotozoal and antibiotic combinations prescribed by a veterinarian \
                can reduce the severity of active infection and allow the immune system \
                to regain control. Animals with neurological signs may require \
                additional supportive medications. Immunocompromised pets may need \
                long-term or lifelong suppressive therapy.

                **Zoonotic Risk**

                Toxoplasma is one of the most widespread zoonotic parasites in the \
                world. The CDC estimates that more than 40 million people in the \
                United States carry a latent Toxoplasma infection — the vast majority \
                with no symptoms.

                The primary concern is for pregnant women and immunocompromised \
                individuals. In pregnant women experiencing a primary Toxoplasma \
                infection, the parasite can cross the placenta and cause congenital \
                toxoplasmosis in the fetus — potentially resulting in miscarriage, \
                stillbirth, or serious developmental problems including brain damage \
                and vision loss. Pregnant women are routinely advised to avoid \
                changing cat litter boxes for this reason.

                Immunocompromised individuals — those undergoing chemotherapy, \
                living with HIV/AIDS, or taking immunosuppressive medications — \
                are at risk of reactivation of a previously dormant infection, \
                which can cause life-threatening encephalitis.

                **Practical Risk Reduction at Home**

                Clean litter boxes daily — oocysts take 1–5 days to become \
                infectious, so daily removal breaks the transmission cycle.

                Pregnant women and immunocompromised individuals should delegate \
                litter box duty; if unavoidable, wear gloves and wash hands thoroughly.

                Keep cats indoors and avoid feeding raw or undercooked meat.

                Wear gloves when gardening (soil contamination from wildlife feces).

                Wash hands after handling cats and before preparing food.

                Wash fruits and vegetables thoroughly before eating.

                If you or a family member may have been exposed, or if your pet is \
                showing signs of illness, contact a veterinarian or physician promptly.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "In cats with active clinical disease, signs typically appear 2–4 weeks after initial infection during the tachyzoite replication phase. Most cats never show observable signs. Kittens and immunocompromised cats may deteriorate rapidly.",
                    delayed: "Tissue cysts persist for life without causing signs in healthy animals. Reactivation of dormant infection in immunocompromised animals can occur weeks to months after the primary infection appeared to resolve."
                ),
                symptoms: [
                    "Fever",
                    "Lethargy and loss of appetite",
                    "Difficulty breathing (pneumonia — especially in kittens)",
                    "Jaundice — yellowing of gums or whites of eyes (liver involvement)",
                    "Neurological signs: seizures, tremors, incoordination, head tilt",
                    "Vision changes or blindness (uveitis — inflammation inside the eye)",
                    "Muscle weakness or pain",
                    "Vomiting and diarrhea",
                    "Enlarged lymph nodes",
                    "Abortion or stillbirth (pregnant animals with primary infection)",
                    "Many infected animals show no clinical signs at all"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Dogs are intermediate hosts — they cannot shed oocysts. Most infections are subclinical. Clinical toxoplasmosis in dogs typically presents as neurological or muscle disease and is more common in immunocompromised animals. Dogs on immunosuppressive medications or with concurrent illness (e.g., distemper) are at higher risk. Contact a veterinarian if neurological signs or unexplained fever develop."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cats are the definitive host and the only animals that shed oocysts. Most adult cats are asymptomatic during and after infection. Severe clinical disease — pneumonia, hepatitis, encephalitis — occurs mainly in kittens or immunocompromised cats. Cats shed oocysts for only a brief window (1–3 weeks) after primary infection and typically do not shed again. Indoor cats with no raw meat exposure are at very low risk."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Small mammals — particularly rabbits, guinea pigs, and rodents — are classic intermediate hosts and can develop severe systemic disease including liver failure and neurological signs. Rodents serve as a major natural reservoir through the cat-prey-cat cycle. Any small mammal showing neurological signs or rapid deterioration warrants urgent veterinary evaluation."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .moderate,
                        notes: "Birds can be infected with Toxoplasma and serve as intermediate hosts. Canaries and pigeons are among the more susceptible species. Clinical disease may include respiratory signs, neurological signs, and sudden death in heavily infected birds. Avian toxoplasmosis is less commonly diagnosed than in mammals but should be considered in birds with unexplained illness."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Reptiles are not considered significant hosts for Toxoplasma. Documentation of clinical toxoplasmosis in reptiles is rare. The parasite\u{2019}s lifecycle and tropism are strongly oriented toward warm-blooded vertebrates. Exotic reptile veterinary consultation is warranted for any unexplained illness."
                    )
                ],
                preventionTips: [
                    "Clean litter boxes daily — oocysts require 1–5 days outside the body to become infectious; daily removal breaks the transmission cycle",
                    "Pregnant women and immunocompromised individuals should avoid changing litter boxes; if unavoidable, use gloves and wash hands thoroughly afterward",
                    "Keep cats indoors and prevent hunting — cats that do not eat prey or raw meat are at very low risk of acquiring or shedding Toxoplasma",
                    "Do not feed cats raw or undercooked meat",
                    "Wear gloves when gardening — outdoor soil may be contaminated with oocysts from wildlife feces",
                    "Wash hands thoroughly after handling cats or cleaning litter boxes",
                    "Wash all fruits and vegetables before eating",
                    "Cover children\u{2019}s sandboxes when not in use",
                    "Pregnant women should discuss Toxoplasma risk with their obstetrician at the start of pregnancy"
                ],
                sources: [
                    "CDC — Toxoplasmosis: https://www.cdc.gov/parasites/toxoplasmosis/",
                    "Merck Veterinary Manual — Toxoplasmosis: https://www.merckvetmanual.com/generalized-conditions/toxoplasmosis/toxoplasmosis-in-animals",
                    "Cornell University College of Veterinary Medicine — Toxoplasmosis: https://www.vet.cornell.edu/departments-centers-and-institutes/cornell-feline-health-center/health-information/feline-health-topics/toxoplasmosis-cats",
                    "AVMA — Toxoplasmosis: https://www.avma.org/resources-tools/pet-owners/petcare/toxoplasmosis",
                    "ASPCA Animal Poison Control Center — Toxoplasmosis overview",
                    "UC Davis School of Veterinary Medicine — Zoonotic Disease: Toxoplasmosis: https://www.vetmed.ucdavis.edu/hospital/small-animal/ccah/zoonoses"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000023",  // GI Parasites
                    "1D000001-0000-0000-0000-000000000029",  // E. cuniculi
                    "1D000001-0000-0000-0000-000000000037"   // Coccidiosis & Cryptosporidiosis
                ]
            ),

            // MARK: - Heartworms
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000025")!,
                name: "Heartworms",
                alternateNames: [
                    "heartworm disease",
                    "heartworm infection",
                    "Dirofilaria immitis",
                    "dirofilariasis",
                    "heartworm positive",
                    "HW positive",
                    "heartworm prevention",
                    "heartworm treatment",
                    "microfilaria",
                    "microfilariae",
                    "HARD",
                    "heartworm associated respiratory disease",
                    "caval syndrome",
                    "dog heartworm",
                    "cat heartworm",
                    "ferret heartworm",
                    "mosquito parasite dog",
                    "worms in heart",
                    "Wolbachia",
                    "doxycycline heartworm"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "heartworms_thumb",
                description: """
                Heartworm disease is caused by Dirofilaria immitis, a parasitic \
                roundworm transmitted exclusively through the bite of infected \
                mosquitoes. Adult worms take up residence in the heart and pulmonary \
                arteries — the major blood vessels leading from the heart to the lungs \
                — where they cause progressive, potentially fatal damage.

                Dogs are the natural definitive host, meaning worms mature, mate, and \
                reproduce in dogs, completing their lifecycle. Cats are an atypical \
                host — most worms die before reaching adulthood, but even a single \
                surviving worm causes serious disease. Heartworm disease is preventable \
                with medication but is difficult and expensive to treat once established \
                in dogs, and has no approved adulticide treatment at all in cats. \
                Prevention is the cornerstone of management for every species.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Heartworm transmission begins when a mosquito takes a blood meal from \
                an infected animal, ingesting immature larvae called microfilariae. \
                These develop inside the mosquito over 10–14 days into infective \
                larvae (L3 stage), which are then deposited on the skin of the next \
                animal the mosquito bites. The larvae migrate through the tissues, \
                developing through additional stages before reaching the heart and \
                pulmonary arteries — a process that takes approximately 6 months in dogs.

                Adult worms (which can reach 12 inches in length) living in the \
                pulmonary arteries trigger chronic inflammation of the vessel walls, \
                causing them to thicken and scar. Blood flow is progressively \
                obstructed. The right side of the heart — which pumps blood to the \
                lungs — must work harder against this resistance, eventually leading \
                to right-sided heart failure. Worm death, whether spontaneous or from \
                treatment, releases proteins that cause acute inflammatory reactions \
                and can trigger life-threatening pulmonary embolism (blockage of blood \
                vessels by worm fragments).

                **The Worm Within the Worm**

                Inside every Dirofilaria immitis worm lives a bacterium called \
                Wolbachia — an intracellular endosymbiont so deeply integrated into \
                the worm\u{2019}s biology that the worm cannot survive without it. This \
                relationship has a profound clinical consequence: when heartworms die \
                — whether from treatment or naturally — they release a flood of \
                Wolbachia proteins that trigger a severe inflammatory response in the \
                host\u{2019}s tissues. Much of the acute lung damage seen during heartworm \
                treatment, and the respiratory crises seen in cats when worms die \
                spontaneously, is now understood to be driven not just by the worm \
                itself but by this bacterial release.

                This is why doxycycline — an antibiotic — is now a standard part of \
                canine heartworm treatment protocols, given weeks before the adulticide \
                injections begin. The doxycycline depletes Wolbachia populations in \
                advance, blunting the inflammatory cascade when worms eventually die. \
                It is a striking example of treating a parasitic infection with an \
                antibiotic — targeting the bacterium inside the worm, rather than the \
                worm itself.

                **It Only Takes One**

                It takes a single bite from a single infected mosquito to transmit \
                heartworm larvae. There is no threshold of exposure, no repeated \
                contact required. One bite during one brief encounter with one mosquito \
                is sufficient — and six months later, adult worms may be present in \
                the pulmonary arteries. This is why year-round prevention, without \
                gaps, is the only reliable protection.

                **Dogs and Heartworms: The Full Lifecycle**

                Dogs are the definitive host for Dirofilaria immitis. Without \
                prevention, infection is highly likely in endemic areas. Adult worms \
                can survive 5–7 years in a dog, and a single dog can harbor hundreds \
                of worms in a heavy infection.

                Early infection is typically asymptomatic — which is why annual \
                testing is essential, since owners have no way to detect infection \
                without a blood test. As disease progresses, dogs develop exercise \
                intolerance, a soft persistent cough, fatigue, and weight loss. \
                Advanced disease can include caval syndrome — a life-threatening \
                emergency in which a massive worm burden obstructs blood flow through \
                the heart\u{2019}s valves, causing sudden cardiovascular collapse. Caval \
                syndrome requires emergency surgical worm extraction, not standard \
                treatment protocol.

                **The Exercise Paradox**

                During heartworm treatment, the thing most owners associate with a \
                healthy, happy dog — running, play, exercise — becomes genuinely \
                dangerous. Physical activity increases blood flow through the lungs \
                and raises the risk of pulmonary embolism as dying worm fragments \
                travel through the vessels. Dogs undergoing treatment must be strictly \
                cage-rested for weeks to months — often the hardest part of the \
                treatment process for both the dog and the owner. A dog that appears \
                to be feeling better partway through treatment is still at serious \
                risk if exercise restrictions are lifted too early.

                **Cats and Heartworms: A Different and Serious Disease**

                Cats are an atypical host for Dirofilaria immitis. The cat\u{2019}s immune \
                system is far more effective at killing larvae than a dog\u{2019}s, and most \
                larvae die before reaching adulthood. Cats typically harbor only 1–3 \
                adult worms rather than the dozens possible in dogs.

                This might sound reassuring — it is not. When larvae die in the \
                pulmonary arteries, they trigger a severe inflammatory response driven \
                in part by Wolbachia release. This is Heartworm Associated Respiratory \
                Disease (HARD) — a syndrome that closely mimics feline asthma or \
                bronchitis and is frequently misdiagnosed and treated incorrectly as \
                a result. When adult worms die in cats, the acute inflammatory response \
                can cause respiratory collapse and sudden death with no preceding \
                warning signs.

                There is no approved adulticide treatment for heartworms in cats. \
                Management is supportive only — corticosteroids to reduce inflammation, \
                monitoring, and waiting for worms to die naturally over 2–3 years. \
                Throughout this period the cat remains at risk of sudden fatal \
                decompensation. Prevention is the only reliable protection.

                **Ferrets: Small Body, High Stakes**

                Ferrets are susceptible to heartworm disease and, like cats, are an \
                atypical host. Just one or two adult worms can be fatal given their \
                small heart size. Clinical signs — coughing, lethargy, respiratory \
                distress — can develop rapidly. Prevention using a \
                veterinarian-recommended product is essential for ferrets in endemic \
                areas.

                **Myths vs. Facts**

                **Myth: "My cat lives indoors — she can\u{2019}t get heartworms."**
                Fact: Studies suggest up to 25% of heartworm-positive cats are \
                classified as exclusively indoor. Mosquitoes enter homes routinely. \
                Indoor cats are at lower risk than outdoor cats, but they are not \
                protected without prevention medication.

                **Myth: "Heartworm prevention kills the worms my dog already has."**
                Fact: Monthly preventives eliminate larvae acquired in the previous \
                30 days. They have no effect on established adult worms — which is \
                exactly why testing before starting or restarting prevention is \
                essential. Administering certain preventives to a microfilaria-positive \
                dog can trigger a severe anaphylactic reaction.

                **Myth: "Heartworm is a Southern problem."**
                Fact: Heartworm has been diagnosed in all 50 US states. The range \
                continues to expand as climate shifts extend mosquito seasons. \
                Veterinarians in historically low-risk regions are seeing increasing \
                case numbers.

                **Myth: "My dog seems fine, so he probably doesn\u{2019}t have heartworms."**
                Fact: Early and even moderate heartworm infection is frequently \
                completely asymptomatic. By the time clinical signs appear, significant \
                and potentially irreversible pulmonary damage has often already \
                occurred. The only way to know is an annual blood test.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "No signs are detectable in early infection — dogs are typically asymptomatic for months to years after initial infection. In cats, acute larval death can cause sudden respiratory distress (HARD) with no preceding warning signs. Ferrets may deteriorate rapidly due to their small body size.",
                    delayed: "Clinical signs in dogs develop progressively over months to years as worm burden increases and pulmonary damage accumulates. Cats with adult worms face ongoing risk of sudden acute decompensation throughout the 2–3 year natural lifespan of the worms."
                ),
                symptoms: [
                    "Persistent soft cough",
                    "Exercise intolerance and fatigue",
                    "Reduced appetite and weight loss",
                    "Difficulty breathing or rapid breathing",
                    "Pot-bellied appearance (fluid accumulation from right-sided heart failure)",
                    "Pale or bluish gums (sign of poor oxygenation)",
                    "Fainting or collapse",
                    "Sudden death (particularly in cats and ferrets)",
                    "Coughing up blood (advanced disease)",
                    "Asthma-like wheezing or open-mouth breathing (cats — HARD presentation)",
                    "Many infected dogs show no signs until disease is advanced"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Dogs are the definitive host. Without prevention, infection is highly likely in endemic areas. Adult worms cause progressive, irreversible damage to the pulmonary arteries and heart. Treatment is a prolonged, expensive, and risky process requiring strict exercise restriction for months. Advanced disease can cause caval syndrome — sudden cardiovascular collapse requiring emergency surgery. Annual testing and year-round prevention are essential."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .high,
                        notes: "Cats are less frequently infected than dogs, but when infection does occur it can be severe or fatal — even 1–2 worms can be lethal. There is no approved adulticide treatment for cats; management is supportive only. Heartworm Associated Respiratory Disease (HARD) closely mimics feline asthma and is frequently misdiagnosed. Sudden death can occur with no preceding signs. Indoor cats are not fully protected — mosquitoes enter homes. Prevention is critical in endemic areas."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Ferrets are the primary concern among small mammals and are genuinely susceptible to heartworm disease. Due to their small heart size, even 1–2 adult worms can be rapidly fatal. Clinical signs include coughing, lethargy, and respiratory distress. Year-round prevention with a veterinarian-recommended product is essential for ferrets in endemic areas. Heartworm disease is not a significant concern in rabbits, guinea pigs, or other common small pets."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Birds are not a meaningful host for Dirofilaria immitis. Heartworm disease is not a clinical concern in pet birds."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Reptiles are not a meaningful host for Dirofilaria immitis. Heartworm disease is not a clinical concern in pet reptiles."
                    )
                ],
                preventionTips: [
                    "Use veterinarian-prescribed heartworm prevention year-round — monthly oral, topical, or injectable options are available for dogs, cats, and ferrets",
                    "Test dogs annually for heartworm infection — prevention must not be started or restarted without a current negative test result",
                    "Do not assume indoor cats are safe — mosquitoes enter homes and indoor cats do develop heartworm disease",
                    "Never skip or delay prevention doses — a single missed dose creates a window of vulnerability that cannot be reversed",
                    "If a dose is missed, resume prevention immediately and consult your veterinarian about whether a retest is recommended",
                    "Reduce mosquito exposure where possible — eliminate standing water around the home",
                    "Ferrets in heartworm-endemic areas require year-round prevention — consult a veterinarian experienced with exotic species",
                    "Follow American Heartworm Society guidelines for testing frequency and prevention protocols in your region"
                ],
                sources: [
                    "American Heartworm Society — Current Canine Guidelines: https://www.heartwormsociety.org/veterinary-resources/american-heartworm-society-guidelines",
                    "American Heartworm Society — Current Feline Guidelines: https://www.heartwormsociety.org/veterinary-resources/feline-guidelines",
                    "Merck Veterinary Manual — Heartworm Disease: https://www.merckvetmanual.com/circulatory-system/heartworm-disease/heartworm-disease-in-dogs-and-cats",
                    "Cornell University College of Veterinary Medicine — Heartworm in Cats: https://www.vet.cornell.edu/departments-centers-and-institutes/cornell-feline-health-center/health-information/feline-health-topics/heartworm-in-cats",
                    "AVMA — Heartworm Disease: https://www.avma.org/resources-tools/pet-owners/petcare/heartworm-disease",
                    "UC Davis School of Veterinary Medicine — Heartworm Disease in Ferrets: https://www.vetmed.ucdavis.edu/hospital/small-animal/services/zoological-companion-animal-medicine/ferret-health"
                ],
                relatedEntries: nil
            ),

            // MARK: - Mange (Sarcoptic & Demodectic)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000026")!,
                name: "Mange (Sarcoptic & Demodectic)",
                alternateNames: [
                    "Sarcoptic mange",
                    "Demodectic mange",
                    "Demodicosis",
                    "Fox mange",
                    "Red mange",
                    "Canine scabies",
                    "Scabies",
                    "Demodex",
                    "Sarcoptes",
                    "Mange mites",
                    "Skin mites",
                    "Mite infestation",
                    "Notoedric mange",
                    "Notoedres"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "mange_thumb",
                description: """
                Mange is a term for skin diseases caused by microscopic mites that \
                infest the skin of companion animals. Two distinct forms exist and are \
                often confused: sarcoptic mange and demodectic mange. They have \
                different causes, different levels of contagiousness, and very different \
                clinical courses — and they cannot be distinguished by appearance alone. \
                Veterinary diagnosis by skin scraping or other testing is required.

                Sarcoptic mange is caused by Sarcoptes scabiei, a mite that burrows \
                into the skin and triggers a severe allergic reaction. It is highly \
                contagious between animals and is zoonotic — contact with an affected \
                animal can cause a transient itchy rash in humans. Sarcoptic mange is \
                sometimes called fox mange because wild foxes are a common reservoir; \
                domestic dogs can acquire it through contact with foxes or their \
                environments.

                Demodectic mange is caused by Demodex mites — microscopic organisms \
                that normally live in small numbers within the hair follicles of healthy \
                animals. Disease occurs when the immune system is unable to keep mite \
                populations in check. This typically affects puppies, elderly animals, \
                or those with underlying illness. Demodectic mange is not contagious \
                between most animals (with one exception: Demodex gatoi, the \
                superficial feline Demodex species, can spread between cats in close \
                contact).

                Both forms can range from mild and localized to severe and \
                life-threatening. Prompt veterinary evaluation is essential for correct \
                diagnosis and appropriate treatment.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                The two forms of mange damage the skin through entirely different \
                mechanisms.

                In sarcoptic mange, the Sarcoptes mite burrows tunnels into the \
                outermost layer of the skin (stratum corneum), where it lays eggs. The \
                immune system mounts an intense hypersensitivity reaction against the \
                mites, their eggs, and their waste products. This allergic response — \
                not the physical burrowing — is responsible for the extreme, relentless \
                itching that defines sarcoptic mange. Affected animals scratch, bite, \
                and rub themselves raw. The resulting wounds are highly vulnerable to \
                secondary bacterial infection, which compounds skin damage and can \
                become severe in its own right.

                In demodectic mange, Demodex mites are a normal resident of healthy \
                skin in very small numbers. Disease develops when immune regulation \
                breaks down and mite numbers multiply unchecked. Mites block hair \
                follicles, trigger deep follicular inflammation, and destroy the \
                follicular structure. Localized demodectic mange — patches of hair loss \
                in young animals — often resolves on its own. Generalized demodectic \
                mange involves widespread follicular destruction, secondary bacterial \
                skin infection (pyoderma), and systemic inflammation. In severe cases, \
                the combination of overwhelming infection burden and immune compromise \
                becomes life-threatening.

                **The Two Faces of Mange**

                Sarcoptic and demodectic mange are frequently confused, even used \
                interchangeably in casual conversation. They are fundamentally different \
                conditions:

                Sarcoptic mange: caused by Sarcoptes scabiei; highly contagious between \
                animals; zoonotic (causes a transient rash in humans); the primary \
                driver is an allergic immune response to the mite; intense itching is \
                the hallmark sign.

                Demodectic mange: caused by Demodex mites that normally reside in skin; \
                not contagious between animals (with the D. gatoi exception in cats); \
                not zoonotic; the primary driver is immune suppression; hair loss with \
                minimal itching is the more typical picture.

                These distinctions matter for treatment, isolation decisions, and \
                household management. Only a veterinarian can confirm which type is \
                present.

                **Transmission & Spread**

                Sarcoptic mange spreads rapidly through direct contact between animals. \
                It can also spread via shared bedding, grooming tools, and other \
                fomites. Sarcoptes mites can survive off a host for two to six days \
                under favorable conditions, making environmental contamination a genuine \
                concern. Dogs commonly acquire sarcoptic mange through contact with \
                infected dogs, foxes, coyotes, or other wildlife. In shelters, kennels, \
                and dog parks, transmission can occur quickly and affect multiple animals.

                Demodectic mange does not spread between dogs. Mother dogs normally pass \
                Demodex mites to their puppies during nursing — this is part of normal \
                skin flora establishment and does not cause disease in a healthy puppy. \
                Generalized demodectic mange in an adult dog is a significant clinical \
                signal: it nearly always indicates an underlying immunocompromising \
                condition — chronic illness, cancer, or prolonged immune-suppressing \
                medication — and warrants investigation beyond the skin.

                **Scabies by Any Other Name**

                In human medicine, infestation with Sarcoptes scabiei is called scabies \
                — caused by the same genus of mite, adapted to a different host. \
                Sarcoptic mange is zoonotic: when humans handle or come into close \
                contact with a mange-affected animal, mites can briefly burrow into \
                human skin and cause an intensely itchy rash. However, mite varieties \
                adapted to animals cannot complete their life cycle on human skin and do \
                not establish a permanent infestation. The rash is self-limiting and \
                typically resolves without treatment once the animal source is addressed. \
                Any human who develops an itchy rash after contact with a \
                mange-affected animal should consult a physician — particularly if the \
                rash is persistent or widespread.

                **Treatment Goals**

                Veterinary treatment for sarcoptic mange aims to eliminate the mite \
                infestation from all affected animals, resolve secondary bacterial skin \
                infection, relieve itch and inflammation, and decontaminate the \
                environment to prevent reinfestation. All animals in contact with an \
                affected pet should be evaluated and treated simultaneously — even those \
                without visible signs.

                Treatment for demodectic mange aims to eliminate the excess mite \
                population, manage secondary pyoderma, and — in generalized cases — \
                identify and address any underlying immunocompromising condition driving \
                the outbreak. Animals should not be considered clear until multiple \
                consecutive negative skin scrapings are confirmed at veterinary \
                re-checks. Generalized demodectic mange requires sustained, often \
                prolonged treatment and close monitoring.

                **Myths vs. Facts**

                **Myth:** Demodectic mange is contagious — my dog will spread it to \
                other dogs.
                **Fact:** Demodectic mange caused by D. canis is not contagious between \
                dogs. All dogs carry Demodex mites as a normal part of their skin flora. \
                Disease only develops when a dog\u{2019}s immune system cannot keep mite \
                populations in check.

                **Myth:** My pet got mange because they were dirty or poorly cared for.
                **Fact:** Sarcoptic mange is acquired through contact with an infected \
                animal — not through poor hygiene. Demodectic mange is driven by immune \
                status, which is outside an owner\u{2019}s control. Either form can affect \
                well-cared-for, healthy-appearing animals.

                **Myth:** If the itching stops, the mange is gone.
                **Fact:** Improvement in symptoms does not confirm mite elimination. \
                Treatment must continue until veterinary testing shows the infestation \
                is fully cleared. Stopping treatment early is one of the most common \
                causes of relapse.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Sarcoptic mange: itching and skin irritation typically begin 10 days to 8 weeks after exposure. Demodectic mange: patchy hair loss and follicular changes may develop gradually over days to weeks.",
                    delayed: "Untreated sarcoptic mange progresses to widespread hair loss, crusting, skin thickening, and secondary bacterial infection. Generalized demodectic mange can become life-threatening in severely immunocompromised animals."
                ),
                symptoms: [
                    "Intense, persistent itching (especially sarcoptic mange)",
                    "Patchy or widespread hair loss",
                    "Red, inflamed, crusty, or scabby skin",
                    "Sores, scabs, or open wounds from self-trauma",
                    "Thickened, roughened skin texture (chronic cases)",
                    "Secondary skin infection (increased odor, discharge)",
                    "Ear margin crusting or scaling (early sarcoptic mange sign in dogs)",
                    "Swollen lymph nodes (generalized demodectic mange)",
                    "Weight loss and lethargy (severe or prolonged cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Both sarcoptic and demodectic mange occur in dogs and can reach severe levels. Sarcoptic mange causes intense, unrelenting pruritus and spreads rapidly to other animals. Generalized demodectic mange — particularly in immunocompromised adults or genetically predisposed breeds including German Shepherds, Shar Peis, and West Highland White Terriers — can become life-threatening when secondary bacterial pyoderma develops."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .high,
                        notes: "Cats are less commonly affected than dogs but are susceptible to notoedric mange (Notoedres cati — a sarcoptic-type mite causing intense pruritus) and feline demodicosis (D. cati, follicular and immune-suppression linked; D. gatoi, superficial and contagious between cats). Cats with underlying immunosuppressive conditions such as FeLV or FIV are at higher risk for severe demodectic disease."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Several small mammal species are susceptible to species-specific mange mites. Rabbits can develop severe sarcoptic mange (Sarcoptes scabiei var. cuniculi), particularly affecting the ears, face, and feet. Guinea pigs are highly susceptible to Trixacarus caviae, a mange mite that causes intense pruritus and, in severe infestations, can trigger seizure-like episodes and death. Hamsters and gerbils can also be affected by sarcoptic-type mites. Prompt veterinary evaluation is critical — small mammals deteriorate rapidly under the stress of severe mite infestation."
                    )
                ],
                preventionTips: [
                    "Avoid allowing your pet to contact wildlife such as foxes, coyotes, or unknown stray animals — a common source of sarcoptic mange.",
                    "Schedule routine wellness exams with your veterinarian — early-stage demodectic mange is simpler to treat before it becomes generalized.",
                    "If sarcoptic mange is diagnosed, have all animals in the household evaluated and treated simultaneously to prevent reinfection.",
                    "Wash and disinfect your pet\u{2019}s bedding, blankets, and grooming tools thoroughly if sarcoptic mange is diagnosed.",
                    "Quarantine newly acquired animals before introducing them to resident pets to reduce the risk of transmitting sarcoptic mange or other parasites.",
                    "For dogs diagnosed with generalized demodectic mange, work with your veterinarian to investigate any underlying condition that may be suppressing immunity.",
                    "Perform regular skin checks during grooming — especially on the ears, elbows, hocks, and belly — to notice early changes that may warrant veterinary attention.",
                    "If you develop an itchy rash after handling a pet diagnosed with sarcoptic mange, consult your own physician."
                ],
                sources: [
                    "https://www.merckvetmanual.com/integumentary-system/mange/mange-in-dogs-and-cats",
                    "https://vcahospitals.com/know-your-pet/mange-in-dogs",
                    "https://vcahospitals.com/know-your-pet/mange-in-cats",
                    "https://www.vet.cornell.edu/departments-centers-and-institutes/cornell-feline-health-center/health-information/feline-health-topics/mange",
                    "https://www.aspca.org/pet-care/general-pet-care/parasites",
                    "https://lafeber.com/vet/demodex-and-sarcoptic-mange-in-small-mammals/"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000022",  // Tick-Borne Diseases
                    "1D000001-0000-0000-0000-000000000028",  // Fleas
                    "1D000001-0000-0000-0000-000000000031",  // Rabbit Ear Mites (Psoroptes cuniculi)
                    "1D000001-0000-0000-0000-000000000033"   // Snake Mites (Ophionyssus natricis)
                ]
            ),

            // MARK: - Baylisascaris (Raccoon Roundworm)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000027")!,
                name: "Baylisascaris (Raccoon Roundworm)",
                alternateNames: [
                    "Baylisascaris procyonis",
                    "Raccoon roundworm",
                    "Baylisascariasis",
                    "Raccoon ascarid",
                    "Neural larva migrans",
                    "Ocular larva migrans",
                    "Visceral larva migrans",
                    "Baylisascaris infection",
                    "Raccoon parasite",
                    "Baylisascaris baylisascaris",
                    "Baylis ascaris"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "baylisascaris_thumb",
                description: """
                Baylisascaris procyonis is a roundworm that lives in the intestines of \
                raccoons — its natural definitive host. Raccoons typically carry the \
                parasite without showing signs of illness. The danger lies in what \
                happens when the parasite\u{2019}s eggs are ingested by other animals or \
                humans: in a non-raccoon host, the larvae do not complete their normal \
                life cycle in the gut. Instead, they migrate aggressively through the \
                body — into organs, eyes, and the brain — causing devastating, often \
                irreversible damage.

                This condition is called larva migrans, and Baylisascaris is considered \
                one of the most dangerous causes of neural larva migrans in North \
                America. In humans, particularly young children, neurological damage can \
                be severe and permanent. There is no reliable cure once larvae have \
                entered the nervous system.

                Dogs are uniquely vulnerable on two levels: they can carry adult \
                Baylisascaris in their intestines and shed infectious eggs in their \
                feces (as raccoons do), and they are also at risk from larval migration \
                if they ingest large numbers of eggs. Small mammals and birds are highly \
                susceptible to fatal larval disease. Raccoon roundworm is not \
                vaccine-preventable. Prevention depends entirely on limiting exposure to \
                raccoon feces and contaminated environments.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Baylisascaris eggs are passed in raccoon feces. After one to four weeks \
                in the environment, eggs become infectious (embryonate) and can survive \
                in soil for years. When ingested by a host other than a raccoon, the \
                larvae hatch in the intestine — but rather than maturing into adult \
                worms as they would in a raccoon, they migrate. The larvae move through \
                the intestinal wall into the bloodstream and from there into any tissue \
                they encounter: liver, lungs, heart, eyes, and most critically, the \
                brain and spinal cord.

                In the nervous system, migrating larvae cause direct mechanical injury \
                as they travel, and intense surrounding inflammation as the immune \
                system reacts to their presence. The result is progressive, often \
                catastrophic neurological damage: loss of coordination, inability to \
                stand, blindness, seizures, and death. Because the larvae remain alive \
                for a prolonged period during migration, damage continues to accumulate. \
                In the eye, larval migration can destroy the retina and cause permanent \
                blindness even if the animal or person survives.

                In dogs, a unique complication exists: dogs can harbor adult intestinal \
                Baylisascaris worms without showing signs of illness — meaning an \
                infected dog can shed enormous numbers of infectious eggs in its feces \
                without the owner\u{2019}s knowledge, creating a contamination risk for \
                humans and other animals in the household.

                **The Raccoon Latrine**

                Raccoons are habitual animals. They tend to return to the same sites \
                repeatedly to defecate — elevated surfaces such as logs, stumps, flat \
                rocks, tree bases, deck railings, and rooftops. These sites are called \
                raccoon latrines. Over time, latrines accumulate enormous concentrations \
                of feces, and with them, enormous concentrations of Baylisascaris eggs. \
                A single infected raccoon may shed millions of eggs per day. In a latrine \
                used for months or years, soil and surface contamination becomes extreme.

                Baylisascaris eggs are unusually resilient. They are resistant to most \
                common disinfectants, tolerant of freezing temperatures, and can survive \
                in soil or on surfaces for years under the right conditions. This makes \
                latrine sites persistently dangerous long after raccoons have moved on. \
                Dogs that investigate or roll in raccoon latrines, and pets or children \
                who play in contaminated soil, are at meaningful risk.

                Identifying and safely decontaminating a raccoon latrine — a process \
                that requires heat (not chemicals) — is a task for professional wildlife \
                or pest management services.

                **The Wandering Larva**

                In a raccoon, Baylisascaris larvae mature normally in the intestine and \
                cause little harm. In any other host, the larvae face a biological \
                dead-end: they cannot complete their life cycle, but they do not stop \
                moving. Instead, they migrate continuously through tissues, following \
                chemical gradients in the body that guide them toward — but never to — \
                the raccoon gut that would allow them to mature. This aimless migration \
                is what makes Baylisascaris so destructive. The larvae are not \
                particularly large, but they are relentless, and the brain and spinal \
                cord offer them no exit.

                In small mammals and birds — the natural intermediate hosts in the wild \
                — this process plays a role in the parasite\u{2019}s lifecycle. Raccoons \
                acquire Baylisascaris not only by ingesting embryonated eggs directly, \
                but also by preying on infected intermediate hosts such as mice, \
                rabbits, and birds in which larvae have already migrated into muscle \
                tissue. For these prey animals, larval migration is typically fatal.

                **A Child\u{2019}s Greatest Risk**

                Among human populations, young children are disproportionately affected \
                by Baylisascaris infection. Toddlers explore the world with their hands \
                and mouths; they play in sandboxes and outdoor areas that may be \
                contaminated with raccoon feces; they do not recognize feces as \
                dangerous. Geophagia — the deliberate eating of soil or dirt — is also \
                seen in some young children and dramatically elevates ingestion risk.

                Neurological Baylisascaris disease in humans is rare but well-documented. \
                Cases have been reported across North America, and affected children have \
                sustained permanent brain damage or died. The condition is often \
                unrecognized initially because early symptoms are nonspecific and the \
                exposure to raccoon feces may not be recalled or reported. Treatment \
                with antiparasitic medications may slow larval migration but cannot \
                reverse neurological damage already caused.

                Households with dogs known or suspected to carry Baylisascaris, or \
                properties with active raccoon activity, should be treated as a human \
                health concern — not only an animal one.

                **Treatment Goals**

                In animals, veterinary management aims to eliminate intestinal \
                Baylisascaris infection in dogs before egg shedding begins or \
                continues, and to support animals with neurological disease through \
                the acute phase of larval migration. Animals showing neurological signs \
                from larval migration require emergency veterinary care; the goal is to \
                reduce ongoing inflammation and limit further damage, but recovery \
                from significant neural larva migrans is often incomplete.

                Fecal testing of dogs with known or suspected raccoon exposure is \
                critical — the window between infection and the onset of egg shedding \
                is approximately 50 to 76 days, and fecal testing or empiric treatment \
                may be recommended for exposed dogs even before shedding begins.

                **Zoonotic Risk**

                Baylisascaris procyonis is a serious zoonotic pathogen. Human infection \
                occurs through accidental ingestion of embryonated eggs from raccoon \
                feces, contaminated soil, surfaces, or objects. Children are at the \
                highest risk due to hand-to-mouth behavior and ground-level play. Dogs \
                that carry adult intestinal Baylisascaris represent an indirect zoonotic \
                risk if their feces contaminate areas accessible to children or other \
                household members.

                If your pet is suspected or confirmed to have Baylisascaris, thorough \
                handwashing after any fecal contact is essential. Any member of the \
                household — especially children — who may have been exposed to \
                contaminated environments should be discussed with a physician. Do not \
                wait for symptoms; early intervention before neurological signs develop \
                is far more likely to be effective.

                Individuals who are immunocompromised may face additional risk and \
                should take extra precautions. Contact your own physician for guidance \
                specific to your situation.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Baylisascaris eggs require 2–4 weeks in the environment to become infectious after being shed. Once ingested, larval migration begins within days. Early neurological signs — subtle incoordination, head tilt, or behavior changes — may appear days to several weeks after a significant exposure.",
                    delayed: "Progressive neurological deterioration can develop over days to weeks as larval migration continues. Intestinal infection in dogs typically produces no early signs. Neurological signs, once they appear, may worsen rapidly and can become irreversible."
                ),
                symptoms: [
                    "Loss of coordination or stumbling (ataxia)",
                    "Abnormal head tilt or circling",
                    "Muscle weakness or inability to stand",
                    "Abnormal eye movements (nystagmus)",
                    "Vision loss or apparent blindness",
                    "Seizures",
                    "Behavioral changes — confusion, disorientation, loss of learned behaviors",
                    "Lethargy and general decline",
                    "No outward symptoms in dogs with intestinal-only infection"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Dogs face risk on two levels: as definitive hosts, dogs can harbor adult Baylisascaris in the intestine and shed infectious eggs in feces — typically without showing any signs of illness. As paratenic hosts (if a large egg burden is ingested), dogs can also develop neural larva migrans with serious neurological consequences. Dogs with raccoon exposure or raccoon feces contact should be assessed by a veterinarian even if asymptomatic."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cats are resistant to intestinal Baylisascaris infection — adult worms rarely establish in feline intestines. However, cats can develop larval migration disease if exposed to significant egg quantities. Neurological signs from larval migration carry a guarded outlook. Cats with outdoor access in areas with raccoon activity carry some risk."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Rabbits, mice, squirrels, and other small mammals are natural intermediate hosts for Baylisascaris in the wild. Larval migration in small mammals is rapid and almost uniformly fatal at high exposure levels. Pet rabbits, guinea pigs, and rodents that have any exposure to raccoon feces — through outdoor time, contaminated hay, or environments with raccoon access — are at extreme risk. This is an underrecognized danger for small mammal owners."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .high,
                        notes: "Birds are natural intermediate hosts and are highly susceptible to neural larva migrans from Baylisascaris. Ground-foraging birds — including poultry, doves, and softbills — are at greatest risk through contact with contaminated soil or litter. Neurological signs are the primary manifestation and carry a poor prognosis. Outdoor aviaries in areas with raccoon activity should be assessed for latrine contamination."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Reptiles are not a meaningful host for Baylisascaris. Documented susceptibility is limited. The primary risk would be incidental exposure via heavily contaminated substrate, and clinical disease in reptiles from this parasite is rarely reported. Risk is considered low but not zero."
                    )
                ],
                preventionTips: [
                    "Prevent your dog from accessing areas where raccoons defecate — including wood piles, flat rocks, decks, and any area with visible raccoon activity.",
                    "Do not allow pets to roll in, sniff closely, or ingest raccoon feces or soil from suspected raccoon latrines.",
                    "If a raccoon latrine is identified on your property, do not attempt to clean it with standard disinfectants — Baylisascaris eggs are chemically resistant. Contact a professional wildlife management service for safe remediation using heat-based methods.",
                    "Have your dog fecally tested by a veterinarian if raccoon exposure has occurred — especially if your dog has eaten feces or soil in areas with raccoon activity.",
                    "Keep children away from areas with known or suspected raccoon latrine activity. Sandboxes should be covered when not in use to prevent raccoon defecation.",
                    "Teach children to wash hands thoroughly after outdoor play, especially in wooded or urban areas with raccoon populations.",
                    "Keep small pets — rabbits, guinea pigs, rodents — in enclosures raccoons cannot access. Inspect outdoor runs and hutches regularly.",
                    "Outdoor aviaries should be designed to prevent raccoon intrusion and substrate contact with raccoon feces.",
                    "If a household member — especially a child — may have been exposed to raccoon feces or contaminated environments, contact a physician promptly. Do not wait for symptoms to appear."
                ],
                sources: [
                    "https://www.cdc.gov/baylisascaris/index.html",
                    "https://www.merckvetmanual.com/digestive-system/gastrointestinal-parasites-of-small-animals/baylisascaris-procyonis-in-small-animals",
                    "https://www.avma.org/resources-tools/pet-owners/petcare/raccoon-roundworm-baylisascaris",
                    "https://www.capcvet.org/guidelines/baylisascaris/",
                    "https://www.vet.cornell.edu/departments-centers-and-institutes/cornell-wildlife-health-lab/wildlife-health-topics/baylisascaris"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000023",  // GI Parasites
                    "1D000001-0000-0000-0000-000000000029"   // E. cuniculi
                ]
            ),

            // MARK: - Fleas
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000028")!,
                name: "Fleas",
                alternateNames: [
                    "Flea infestation",
                    "Ctenocephalides felis",
                    "Ctenocephalides canis",
                    "Cat flea",
                    "Dog flea",
                    "Flea allergy dermatitis",
                    "FAD",
                    "Flea bite hypersensitivity",
                    "Flea dirt",
                    "Flea eggs",
                    "Siphonaptera",
                    "Ectoparasite",
                    "Flea control",
                    "Flea prevention",
                    "Rabbit flea",
                    "Spilopsyllus cuniculi"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "fleas_thumb",
                description: """
                Fleas are small, wingless, blood-feeding insects that are among the most \
                common external parasites affecting companion animals worldwide. The cat \
                flea (Ctenocephalides felis) is the species responsible for the vast \
                majority of infestations in both dogs and cats, despite its name.

                Flea infestations cause more than itching. Fleas are medically \
                significant disease vectors: they transmit tapeworms, Bartonella \
                bacteria (the cause of cat scratch disease in humans), murine typhus, \
                and — in certain geographic regions — plague. In young, small, or \
                debilitated animals, heavy flea infestations can cause life-threatening \
                blood loss anemia. In animals with flea allergy dermatitis, even a \
                single flea bite can trigger an intense, prolonged skin reaction.

                Fleas are not vaccine-preventable. Control requires treating both the \
                affected animal and the environment simultaneously — because adult fleas \
                on a pet represent only a small fraction of the total flea population \
                in a household. Flea infestations are a year-round concern in most of \
                North America and in many other regions, and they affect indoor and \
                outdoor pets alike.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                Fleas cause harm through several distinct mechanisms.

                The most immediate is blood loss. Each flea consumes many times its \
                body weight in blood daily. In adult healthy animals, this is rarely \
                significant on its own. In kittens, puppies, elderly animals, small \
                mammals, or animals carrying large flea burdens, blood loss accumulates \
                rapidly and can result in life-threatening anemia — sometimes within \
                days in very young or small animals.

                The second mechanism is allergic hypersensitivity. Many animals develop \
                flea allergy dermatitis (FAD), an immune-mediated skin reaction to \
                proteins in flea saliva. Animals with FAD do not need a large flea \
                burden to suffer severely — a single bite can trigger intense, \
                widespread itching that persists long after the flea is gone. FAD is \
                one of the most common causes of skin disease in dogs and cats and can \
                lead to self-trauma, hair loss, open wounds, and secondary bacterial \
                skin infection if not managed.

                The third mechanism is disease transmission. Fleas are vectors for \
                multiple pathogens with consequences for animal and human health alike.

                **Beyond the Itch: Fleas as Disease Vectors**

                Most pet owners think of fleas as a nuisance. In reality, fleas are \
                capable of transmitting several significant diseases:

                Tapeworms (Dipylidium caninum): Fleas are the essential intermediate \
                host for the most common tapeworm affecting dogs and cats. Flea larvae \
                ingest tapeworm eggs from the environment; when a dog or cat swallows \
                an infected adult flea during grooming, the tapeworm cycle completes in \
                the pet\u{2019}s intestine. Children can acquire Dipylidium the same way — by \
                accidentally swallowing an infected flea. Rigorous flea control is \
                essential for effective tapeworm prevention. See the GI Parasites entry \
                for full detail on the flea-tapeworm lifecycle.

                Bartonella (Cat Scratch Disease): Bartonella henselae is a bacterium \
                transmitted among cats primarily through flea feces (flea dirt). Cats \
                serve as the main animal reservoir and are often asymptomatic carriers. \
                Humans typically acquire cat scratch disease through a scratch or bite \
                from an infected cat — flea dirt in the wound, not the flea bite itself, \
                is the primary transmission route to people. In healthy humans, cat \
                scratch disease causes swollen lymph nodes and flu-like illness; in \
                immunocompromised individuals, it can cause more serious systemic \
                disease.

                Murine Typhus (Rickettsia typhi): Murine typhus is a bacterial \
                infection transmitted primarily by rat fleas, but the cat flea can also \
                serve as a vector. It is endemic in parts of the southern United States, \
                Hawaii, and tropical and subtropical regions worldwide. Clinical signs \
                in pets are generally mild or absent; human infection causes fever, \
                headache, and rash and is occasionally severe.

                Plague (Yersinia pestis): Plague is a rare but serious flea-borne \
                bacterial disease endemic to parts of the western United States and \
                other global regions. Rodent fleas are the primary transmission vehicle, \
                but cats — who hunt infected rodents and can carry infected fleas into \
                the home — are a recognized bridge to human exposure. Dogs are more \
                resistant than cats but can carry fleas from plague-endemic environments. \
                Flea prevention is a meaningful plague risk reduction measure in \
                endemic areas.

                **The Flea-Tapeworm Connection**

                Fleas and tapeworms have an obligate relationship: Dipylidium caninum \
                cannot complete its lifecycle without a flea. Flea larvae eat tapeworm \
                eggs shed in feces; adult fleas carry the developing tapeworm stage \
                internally. An animal (or child) swallowing an infected flea completes \
                the cycle. This is why treating a tapeworm infestation without \
                simultaneously eliminating fleas is a reliable path to reinfection. \
                Full detail on this lifecycle is covered in the GI Parasites entry.

                **95% of the Problem Is in Your Home**

                One of the most important — and most underappreciated — facts about \
                flea infestations is that adult fleas living on your pet represent \
                roughly 5% of the total flea population in an infested household. The \
                remaining 95% exists as eggs, larvae, and pupae in carpets, upholstered \
                furniture, bedding, floor cracks, and other environmental hiding places. \
                These immature stages are invisible to the naked eye and are not killed \
                by treatments applied only to the animal.

                Treating the pet alone — without treating the home environment — will \
                not resolve a flea infestation. The pupal stage is particularly \
                resilient: flea pupae can remain dormant inside their cocoons for \
                months, protected from both environmental conditions and most insect \
                growth regulators. Emergence from pupae is triggered by vibration, \
                warmth, and carbon dioxide — which is why returning to a home that has \
                been empty for weeks can result in a sudden apparent explosion of adult \
                fleas.

                Effective flea control requires simultaneous treatment of all pets in \
                the household and targeted environmental treatment, sustained over a \
                period of months. A veterinarian can recommend an appropriate \
                coordinated strategy.

                **Treatment Goals**

                Veterinary management of flea infestation aims to eliminate the adult \
                flea burden from all affected animals, interrupt the flea life cycle in \
                the home environment, treat secondary consequences including anemia, \
                skin infection, and allergic skin disease, and address any transmitted \
                parasites such as tapeworms. Animals with severe anemia from flea \
                infestation — particularly young or small animals — may require urgent \
                supportive care. Animals with flea allergy dermatitis require sustained \
                flea prevention to prevent recurrence, since even very low-level \
                exposure can trigger relapse.

                **Myths vs. Facts**

                **Myth:** My pet lives indoors, so they can\u{2019}t get fleas.
                **Fact:** Fleas enter homes on clothing, shoes, other animals, and \
                through small gaps in doors or screens. Indoor-only pets acquire flea \
                infestations regularly. Indoor pets in multi-pet households are also \
                exposed through any pet that goes outdoors.

                **Myth:** I\u{2019}ve looked at my pet carefully and I don\u{2019}t see any fleas, \
                so they don\u{2019}t have them.
                **Fact:** Adult fleas move fast and hide effectively in fur, especially \
                around the base of the tail, the groin, and the abdomen. In animals \
                with flea allergy dermatitis, intense skin symptoms can be caused by \
                very few fleas — by the time you look, the flea may already be gone. \
                Look for flea dirt (tiny dark specks that turn red-brown when wet on a \
                damp white tissue) rather than the fleas themselves.

                **Myth:** Once I treat my pet, the flea problem is solved.
                **Fact:** Treating only the animal leaves the 95% of the flea \
                population living in the environment untreated. Re-infestation from the \
                environment is nearly certain without concurrent home treatment. Full \
                resolution of an established infestation typically takes several months \
                of consistent treatment.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Signs of flea infestation — itching, flea dirt, visible fleas — can appear quickly once fleas establish on a pet. In animals with flea allergy dermatitis, intense skin reaction can begin within minutes to hours of a single bite. Anemia from blood loss develops over days to weeks depending on flea burden and animal size.",
                    delayed: "Environmental flea populations build over weeks to months, making infestations progressively harder to control without treating the home. Flea pupae can remain dormant for months and emerge long after surface treatments appear to have worked."
                ),
                symptoms: [
                    "Persistent scratching, biting, or licking — especially at the base of the tail, groin, and abdomen",
                    "Visible fleas or flea dirt (dark specks in the coat that turn red-brown on a damp white tissue)",
                    "Hair loss — typically at the base of the tail, inner thighs, and belly",
                    "Red, inflamed, or scabbed skin",
                    "Skin thickening or discoloration in chronic cases",
                    "Restlessness and agitation",
                    "Pale gums (sign of anemia — especially in young, small, or heavily infested animals)",
                    "Lethargy and weakness (severe anemia)",
                    "Tapeworm segments visible near the rear end or in feces (rice-grain sized, may move)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Dogs are highly susceptible to flea infestation and flea allergy dermatitis. Ctenocephalides felis (cat flea) is responsible for most infestations despite its name. Dogs with FAD suffer intense skin disease from minimal flea exposure and require sustained prevention. Dogs in plague-endemic regions of the western US represent a bridge risk for human exposure if they carry infected fleas from outdoor environments."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cats are the primary reservoir host for Bartonella henselae and are commonly asymptomatic carriers. Flea allergy dermatitis is a leading cause of skin disease in cats. Kittens are at significant risk of anemia from heavy infestations. Cats that hunt in plague-endemic areas carry a recognized risk of bringing infected fleas — and occasionally infected prey — into contact with household members."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Rabbits, ferrets, and guinea pigs are susceptible to flea infestation, typically from fleas carried by cohabiting dogs or cats. Small body size means blood loss anemia can develop rapidly and become life-threatening, particularly in young or small animals. Rabbits in the UK and Europe face an additional risk: the rabbit flea (Spilopsyllus cuniculi) is the primary vector of myxomatosis. Rabbit owners in myxomatosis-endemic regions should treat for fleas as part of myxomatosis prevention. See the Myxomatosis entry for detail."
                    )
                ],
                preventionTips: [
                    "Use veterinarian-recommended year-round flea prevention for all pets in the household — including pets that primarily stay indoors.",
                    "Treat all pets in the home simultaneously. Leaving even one untreated animal in a household allows flea populations to persist.",
                    "If an infestation is established, treat both the animals and the home environment. Wash all bedding in hot water, vacuum thoroughly and frequently (including under furniture and along baseboards), and use a veterinarian- or pest-management-recommended environmental product.",
                    "Vacuum bags or canisters should be emptied outside immediately after use during active infestation — flea eggs and larvae can survive inside a vacuum.",
                    "Consistent treatment over several months is required to fully interrupt the flea lifecycle. Stopping early allows emerging pupae to restart the cycle.",
                    "Check your pet regularly for flea dirt during grooming — comb through the coat over a damp white tissue and look for red-brown specks.",
                    "If your pet is diagnosed with tapeworms, assume fleas are present or recently present and address both simultaneously.",
                    "In plague-endemic areas of the western United States, year-round flea prevention for dogs and cats is a meaningful public health measure — especially for pets that may contact wild rodents or their environments.",
                    "If a household member develops swollen lymph nodes, fever, or a rash after contact with a cat — particularly a cat with suspected flea infestation — consult a physician and mention the possible Bartonella exposure."
                ],
                sources: [
                    "https://www.merckvetmanual.com/integumentary-system/fleas-and-flea-allergy-dermatitis/overview-of-fleas",
                    "https://www.capcvet.org/guidelines/fleas/",
                    "https://www.cdc.gov/bartonella/pets/index.html",
                    "https://www.cdc.gov/plague/prevention/index.html",
                    "https://www.avma.org/resources-tools/pet-owners/petcare/fleas",
                    "https://vcahospitals.com/know-your-pet/fleas-and-flea-control-in-dogs"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000007",  // Myxomatosis
                    "1D000001-0000-0000-0000-000000000023",  // GI Parasites
                    "1D000001-0000-0000-0000-000000000026"   // Mange
                ]
            ),

            // MARK: - Encephalitozoon cuniculi (E. cuniculi)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000029")!,
                name: "Encephalitozoon cuniculi (E. cuniculi)",
                alternateNames: ["E. cuniculi", "Encephalitozoonosis", "rabbit encephalitozoonosis",
                                 "microsporidian infection", "E cuniculi", "Encephalitozoon"],
                categories: [.diseasesAndConditions],
                imageAsset: "e_cuniculi_thumb",
                description: """
                Encephalitozoon cuniculi — commonly shortened to E. cuniculi — is a \
                microscopic obligate intracellular parasite that primarily infects \
                rabbits, targeting the brain, kidneys, and eyes. It belongs to a group \
                called microsporidia, which are fungal-related organisms that can only \
                survive and replicate inside the cells of a host.

                Infection is widespread in domestic rabbit populations, but many \
                animals carry the organism for life without ever developing illness. \
                When active disease does occur, it can range from subtle kidney changes \
                to severe neurological signs that appear suddenly — and can be \
                life-threatening. A distinctive pattern in young rabbits is eye disease \
                caused by infection acquired in the womb. This condition is not \
                vaccine-preventable.

                A separate strain (Strain III) is documented in dogs, where it can \
                cause renal and neurological disease. E. cuniculi is considered \
                zoonotic, though clinically significant infection in humans is rare \
                and primarily a concern for immunocompromised individuals.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                E. cuniculi invades the cells of its host and replicates inside them, \
                triggering inflammatory responses that damage the organs it targets. \
                It has a particular affinity for three systems: the brain and spinal \
                cord, the kidneys, and the lens of the eye.

                In the nervous system, the parasite causes granulomatous inflammation \
                (a localized immune attack) that disrupts normal brain function. This \
                is responsible for the most dramatic signs owners notice — sudden head \
                tilt, loss of balance, rolling, or collapse.

                In the kidneys, E. cuniculi produces a slow, progressive inflammatory \
                injury that can go undetected for months to years. Some rabbits present \
                with kidney disease as the only finding, with no neurological signs at all.

                In the eye, a uniquely striking mechanism occurs. When a pregnant doe \
                is infected, the parasite can cross into developing fetuses and become \
                trapped inside the lens — a structure with no blood supply, and \
                therefore unreachable by the immune system. As the rabbit matures, \
                the organism eventually triggers rupture of the lens capsule, releasing \
                inflammatory material directly into the eye. This causes phacoclastic \
                uveitis (severe internal eye inflammation from a ruptured lens), which \
                presents as a white, cloudy, or visibly damaged eye. This pattern in a \
                young rabbit is highly characteristic of E. cuniculi, even before \
                any testing is performed.

                **The Silent Passenger**

                A critical feature of this organism is how often it causes no disease \
                at all. Seroprevalence studies — which detect antibodies indicating \
                prior exposure — suggest that a significant proportion of domestic \
                rabbits have been exposed without ever becoming clinically ill. A \
                healthy immune system can hold the organism in check indefinitely. \
                This makes interpretation tricky: a positive antibody test confirms \
                exposure, but not necessarily active disease. Diagnosis requires \
                veterinary evaluation to determine whether the organism is actually \
                responsible for the signs a rabbit is showing.

                **Transmission & Spread**

                E. cuniculi spores are shed in the urine of infected animals. \
                Transmission occurs when another rabbit ingests or inhales spores \
                from contaminated bedding, food, or water. Spores are environmentally \
                resilient and can persist for several weeks outside a host.

                Intrauterine transmission (from infected mother to offspring) also \
                occurs and is the primary route responsible for the eye disease \
                described above.

                Three genetically distinct strains have been identified: Strain I \
                (rabbit), Strain II (mouse), and Strain III (dog/canis). Each strain \
                has a primary host species, though cross-species infection can occur. \
                Pet rabbits are most commonly affected by Strain I.

                **Treatment Goals**

                Veterinary care focuses on controlling inflammation, supporting \
                affected organ systems, and managing secondary complications. \
                Neurological signs — particularly head tilt — may improve with \
                appropriate treatment over weeks to months, though full resolution \
                is not always achieved. Kidney disease is generally managed long-term \
                rather than cured. Severe eye involvement may require surgical removal \
                of the lens to relieve pain and ongoing inflammation. Early veterinary \
                evaluation is essential — many rabbits with this diagnosis can \
                maintain a good quality of life with appropriate ongoing care, and \
                outcomes are significantly better when treatment begins early.

                **Zoonotic Risk**

                E. cuniculi is considered zoonotic, but clinically significant \
                infection in humans is rare. Risk is primarily a concern for \
                immunocompromised individuals — including those undergoing \
                chemotherapy, organ transplant recipients, and people with HIV/AIDS. \
                Healthy adults rarely develop illness from exposure. If your rabbit \
                has been diagnosed with E. cuniculi, practice good hand hygiene after \
                handling your pet or cleaning their enclosure, and consult your own \
                physician if you have any health concerns.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation ranges from weeks to months; many infected animals remain asymptomatic indefinitely. Neurological signs may appear suddenly, even after a long silent period.",
                    delayed: "Kidney disease often develops silently over months to years. Eye disease from intrauterine infection typically becomes apparent in young rabbits as the immune system matures."
                ),
                symptoms: [
                    "Head tilt (torticollis)",
                    "Loss of balance or stumbling",
                    "Rolling or spinning episodes",
                    "Rapid involuntary eye movements (nystagmus)",
                    "White, cloudy, or inflamed eye",
                    "Visible cataract or lens opacity",
                    "Hind limb weakness or paralysis",
                    "Urinary incontinence or wet hindquarters",
                    "Increased thirst and urination",
                    "Weight loss",
                    "Seizures (rare)",
                    "Sudden death (rare)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Rabbits are the primary host. Infection is widespread in domestic rabbit populations; many animals remain asymptomatic, but active disease can cause severe neurological signs, progressive kidney failure, or destructive eye disease. Also documented in mice and chinchillas."
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Strain III (canis) is documented in dogs and can cause renal disease and neurological signs. Clinical disease is less common than in rabbits but is well-established, particularly in immunosuppressed or young animals."
                    ),
                ],
                preventionTips: [
                    "Quarantine new rabbits for a minimum of 4 weeks before introducing them to resident animals.",
                    "Clean and disinfect housing, food bowls, and water sources regularly — E. cuniculi spores can survive in the environment for several weeks.",
                    "Practice thorough hand hygiene after handling rabbits or cleaning their enclosures, especially if anyone in the household is immunocompromised.",
                    "Schedule routine veterinary wellness exams for rabbits — bloodwork and urinalysis can detect kidney changes before symptoms become apparent.",
                    "Purchase rabbits from reputable breeders who screen breeding animals for E. cuniculi.",
                    "If your rabbit has been diagnosed with E. cuniculi and you have concerns about your own health, consult your physician."
                ],
                sources: [
                    "Merck Veterinary Manual — Encephalitozoonosis in Rabbits",
                    "LafeberVet — Encephalitozoon cuniculi in Rabbits",
                    "Veterinary Partner (VIN) — Encephalitozoonosis",
                    "VCA Animal Hospitals — Encephalitozoon cuniculi Infection in Rabbits",
                    "House Rabbit Society — E. cuniculi"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000024",  // Toxoplasma
                    "1D000001-0000-0000-0000-000000000027",  // Baylisascaris
                    "1D000001-0000-0000-0000-000000000031",  // Rabbit Ear Mites (Psoroptes cuniculi)
                    "1D000001-0000-0000-0000-000000000037",  // Coccidiosis & Cryptosporidiosis
                    "1D000001-0000-0000-0000-000000000038",  // GI Stasis in Rabbits
                    "1D000001-0000-0000-0000-000000000045"   // Small Mammal Husbandry Guide
                ]
            ),

            // MARK: - Psittacine Beak and Feather Disease (PBFD)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000030")!,
                name: "Psittacine Beak and Feather Disease (PBFD)",
                alternateNames: ["PBFD", "beak and feather disease", "beak and feather virus",
                                 "BFDV", "circovirus", "psittacine circovirus",
                                 "feather loss in parrots", "psittacine beak feather disease",
                                 "psittacine circoviral disease", "PCD"],
                categories: [.diseasesAndConditions],
                imageAsset: "pbfd_thumb",
                description: """
                Psittacine Beak and Feather Disease (PBFD) is a serious viral \
                infection caused by Beak and Feather Disease Virus (BFDV), a \
                circovirus that affects parrots and related birds (psittacines). \
                It is considered the most significant infectious disease in captive \
                and wild psittacine populations worldwide.

                The virus attacks the immune system and the cells responsible for \
                feather and beak development, causing progressive, irreversible \
                damage. There is currently no cure and no commercially available \
                vaccine. Disease can take two distinct forms: an acute form that \
                kills young chicks rapidly, and a chronic form in older birds \
                characterized by the gradual destruction of feathers and beak \
                tissue over months to years.

                PBFD is not contagious to humans or to non-psittacine pets. \
                However, the virus poses an extreme biosecurity risk in any \
                setting where multiple birds are kept — it is environmentally \
                stable, can persist for months to years on surfaces, and spreads \
                readily through feather dust and contaminated materials.
                """,
                toxicityInfo: """
                **How It Harms the Body**

                BFDV targets two critical systems simultaneously: the immune \
                system and the tissues that produce feathers and beak material.

                The virus invades and destroys cells in the bursa of Fabricius \
                and the thymus — the organs responsible for developing a bird\u{2019}s \
                immune defenses. This immunosuppression (weakening of the immune \
                system) leaves infected birds unable to fight off secondary \
                infections that a healthy bird would normally resist. Many birds \
                with PBFD ultimately die from opportunistic infections rather \
                than the virus itself.

                Simultaneously, the virus destroys the feather follicles — the \
                structures that produce and maintain feathers. This causes \
                abnormal feather growth, feather fragility, and eventually \
                permanent feather loss. In green-plumaged species, scattered \
                yellow contour feathers appearing throughout the plumage can be \
                one of the earliest visible signs — often mistaken by owners for \
                a color variation rather than a disease signal. Beak and claw \
                tissue can also be affected, leading to structural deformities \
                that impair the bird\u{2019}s ability to eat and function.

                **A Feather at a Time**

                In the chronic form of PBFD — the most commonly recognized \
                pattern in pet birds — the progression is gradual and \
                unmistakable once an owner knows what to look for. Abnormal \
                feathers appear first: they may be stunted, clubbed, curled, \
                or retained in their sheaths when they should have opened \
                fully. With each successive molt, the feather abnormalities \
                worsen and spread to areas previously unaffected. Eventually, \
                large areas of the body become permanently featherless. Beak \
                changes — softening, elongation, or irregular surfaces — \
                typically appear later in the disease course. Birds in the \
                chronic form may survive for months to years, but the disease \
                is considered uniformly progressive and eventually fatal.

                The acute form occurs primarily in young chicks and nestlings. \
                It progresses rapidly, causing severe immune failure, \
                gastrointestinal signs, and death — often before significant \
                feather abnormalities have time to develop.

                **A Flock of Naked Birds**

                PBFD has almost certainly been present in Australian parrots for \
                far longer than the disease has been formally understood. In 1888, \
                ornithologist Edwin Ashby documented a flock of completely \
                featherless red-rumped parrots in the Adelaide Hills of South \
                Australia — and reported that the species disappeared from the \
                area entirely for several years afterward. This observation, made \
                nearly a century before the virus was identified, is now recognized \
                as likely the earliest recorded account of PBFD in wild birds. \
                Genetic evidence suggests BFDV has been present in Australasian \
                psittacines for at least 10 million years, making it one of the \
                most ancient known viral relationships between a pathogen and its \
                host group.

                **Transmission & Spread**

                BFDV is shed in feather dust, feather debris, feces, and crop \
                secretions. Transmission occurs through direct contact with an \
                infected bird, inhalation of contaminated feather dust, or \
                contact with contaminated surfaces, caging, food bowls, or \
                nesting material. A bird can be infected and actively shedding \
                virus before any clinical signs appear, making introduction of \
                apparently healthy birds a recognized route of spread.

                The virus is exceptionally environmentally stable — it can \
                persist on surfaces and in the environment for months to years \
                and is resistant to many common disinfectants. This makes \
                decontamination after an infected bird has been housed in a \
                space extremely difficult.

                PBFD is thought to have originated in Australia, where it is \
                endemic in many wild parrot populations. Its global spread is \
                attributed largely to the international pet bird trade. The \
                budgerigar — one of the world\u{2019}s most popular pet birds — has \
                been identified as a likely key vehicle: widespread export of \
                budgerigars from Australia beginning in the early 1840s is \
                believed to have carried BFDV into Europe, North America, Asia, \
                and Africa, where it now affects psittacine species that had \
                no prior exposure to the virus. High-risk settings include bird \
                fairs, pet stores, aviaries, and any environment where birds \
                from multiple sources are housed together or nearby.

                **Treatment Goals**

                There is no antiviral treatment for PBFD. Veterinary care \
                focuses on supporting the immune system, managing secondary \
                infections as they arise, and maintaining the bird\u{2019}s quality \
                of life for as long as possible. Birds with PBFD require \
                ongoing veterinary monitoring and must be isolated from other \
                birds to prevent spread. In some cases — particularly in birds \
                with very early or limited disease — the immune system may \
                mount a partial response, and a small number of exposed birds \
                have been documented to clear the virus. Veterinary evaluation \
                is essential to determine the extent of disease and guide \
                care decisions.
                """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Acute form (chicks): rapid onset within days to weeks; death can occur before feather abnormalities develop. Chronic form (older birds): initial feather abnormalities may appear weeks to months after infection.",
                    delayed: "Chronic form progresses over months to years, with each molt bringing worsening feather loss and eventual beak involvement. Immunosuppression develops in parallel, increasing susceptibility to secondary infections over time."
                ),
                symptoms: [
                    "Abnormal, stunted, or malformed feathers",
                    "Feathers retained in sheaths (pinfeathers that fail to open)",
                    "Curled, clubbed, or fragile feathers",
                    "Scattered yellow feathers in green-plumaged birds (early sign)",
                    "Progressive feather loss across the body",
                    "Beak softening, elongation, or surface irregularities",
                    "Claw deformities",
                    "Lethargy and reduced activity",
                    "Weight loss",
                    "Diarrhea or abnormal droppings",
                    "Recurring infections (respiratory or gastrointestinal)",
                    "Sudden death in young chicks (acute form)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .bird,
                        severity: .severe,
                        notes: "Affects all psittacine species — including parrots, cockatoos, cockatiels, budgerigars, lovebirds, macaws, and conures. No cure; chronic form is uniformly progressive and fatal. Acute form in chicks is rapidly fatal. BFDV poses a major biosecurity risk in any multi-bird setting."
                    ),
                ],
                preventionTips: [
                    "Test all new birds for PBFD before introducing them to a household or aviary — PCR testing is available through avian veterinarians and is the most reliable diagnostic method.",
                    "Quarantine all new birds for a minimum of 90 days before introducing them to resident birds.",
                    "If a bird tests positive for PBFD, isolate it immediately from all other birds and consult an avian veterinarian.",
                    "Disinfect caging, perches, food bowls, and any shared surfaces thoroughly — use disinfectants known to be effective against non-enveloped viruses, as BFDV is highly stable in the environment.",
                    "Avoid purchasing birds from environments where multiple birds from different sources are housed together, such as bird fairs or large pet store aviaries.",
                    "Schedule regular wellness exams with an avian veterinarian for all pet birds, particularly if they have contact with other birds."
                ],
                sources: [
                    "Merck Veterinary Manual — Psittacine Beak and Feather Disease",
                    "LafeberVet — Psittacine Beak and Feather Disease (PBFD)",
                    "VCA Animal Hospitals — Beak and Feather Disease in Birds",
                    "Veterinary Partner — Psittacine Beak and Feather Disease",
                    "Association of Avian Veterinarians (AAV)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000004",  // Psittacosis (Parrot Fever)
                    "1D000001-0000-0000-0000-000000000035",  // Air Sac Mites (Sternostoma tracheacolum)
                    "1D000001-0000-0000-0000-000000000036",  // PDD (Proventricular Dilatation Disease)
                    "1D000001-0000-0000-0000-000000000044"   // Bird Husbandry Guide
                ]
            ),

            // MARK: - Rabbit Ear Mites (Psoroptes cuniculi)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000031")!,
                name: "Rabbit Ear Mites (Psoroptes cuniculi)",
                alternateNames: ["Psoroptes cuniculi", "ear canker", "rabbit ear mite",
                                 "otoacariasis", "psoroptic mange", "ear mange",
                                 "rabbit ear mites", "psoroptes", "ear mites in rabbits"],
                categories: [.diseasesAndConditions],
                imageAsset: "psoroptes_thumb",
                description: """
                    Rabbit ear mites — caused by the parasite Psoroptes cuniculi — \
                    are one of the most common ectoparasite (external parasite) \
                    infestations in pet rabbits worldwide. The condition is also \
                    known as ear canker or psoroptic mange.

                    P. cuniculi is a non-burrowing mite that lives on the surface \
                    of the skin inside the ear canal. Its saliva and waste products \
                    trigger intense inflammation, producing the thick, layered crusts \
                    that are the hallmark of this condition. Many owners mistake these \
                    early crusts for ordinary ear dirt — a dangerous misidentification, \
                    because untreated infestations can progress to deep ear infections \
                    and, in severe cases, to neurological disease and fatal meningitis.

                    With prompt veterinary treatment, most affected rabbits recover \
                    fully. Delays in treatment significantly worsen outcomes and allow \
                    the infestation to spread to other animals in the household.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    P. cuniculi mites pierce the skin at the base of hairs inside the \
                    ear canal and feed on the host's lymphatic fluids and skin debris. \
                    Their saliva and fecal material trigger a powerful inflammatory \
                    response — causing intense itching, redness, and the release of \
                    serum (fluid from the bloodstream) onto the skin surface.

                    **The Cycle That Feeds Itself**
                    This serum, along with mite waste, shed skin cells, and ear wax, \
                    dries out and forms the characteristic crusts of ear canker. What \
                    makes this infestation self-reinforcing is that the mites then \
                    feed on those crusts, fueling further population growth. As the \
                    infestation matures, mites shift to feeding directly on serum, \
                    hemoglobin, and red blood cells drawn from the inflamed tissue. \
                    The crusts build up in thick, layered deposits — sometimes filling \
                    the entire ear canal and spilling onto the external ear flap, face, \
                    and neck. In heavy infestations, the sheer weight of crust \
                    accumulation can cause the ears to droop.

                    The skin beneath the crusts is raw, moist, and painful. A foul \
                    odor from the ears is a common indicator of secondary bacterial \
                    infection, which develops readily in this warm, inflamed \
                    environment. If the infection spreads inward to the middle ear \
                    (otitis media) or inner ear (otitis interna), it can cause \
                    vestibular signs — head tilt, loss of balance, and rolling — that \
                    owners may mistake for a neurological disease. Without treatment, \
                    the infection can progress to meningitis (inflammation of the \
                    membranes surrounding the brain), which can be fatal.

                    One notable feature of P. cuniculi: unlike many mite species, \
                    these mites are large enough to be visible to the naked eye inside \
                    the ear, appearing as small white moving specks. Veterinary \
                    confirmation via ear cytology (microscopic examination of debris) \
                    is still recommended to confirm the diagnosis and check for \
                    secondary infections.

                    **Transmission & Spread**
                    Ear mites spread primarily through direct contact between animals. \
                    They can also survive off a host for up to 21 days in the \
                    environment — particularly in warm, humid conditions — making \
                    contaminated bedding, enclosures, and shared equipment a secondary \
                    transmission route. The full mite life cycle from egg to adult \
                    takes approximately 21 days, meaning a single untreated rabbit \
                    can rapidly sustain and expand an infestation without reinfection.

                    Rabbits are the primary host. Occasional infections have been \
                    documented in guinea pigs, dogs, and cats, though these species \
                    are far less commonly affected. Lop-eared rabbit breeds may be \
                    more prone to wax and debris accumulation in the ear canal, \
                    which can predispose them to infestation.

                    **Important: Do Not Remove the Crusts**
                    The crusts of ear canker are extremely painful, and attempting \
                    to remove them from an unsedated rabbit causes significant \
                    distress and can leave raw, ulcerated wounds. Crust removal \
                    should only be performed by a veterinarian with appropriate \
                    pain management. With proper treatment, the crusts will soften \
                    and resolve on their own.

                    **Treatment Goals**
                    Veterinary care focuses on eliminating the mite infestation, \
                    treating secondary bacterial or yeast infections, and managing \
                    pain. The environment must also be treated simultaneously to \
                    prevent reinfection from surviving mites in bedding and \
                    enclosure materials. Treatment must extend beyond 21 days to \
                    cover the full mite life cycle. Early veterinary intervention \
                    is essential — rabbits with head tilt or balance problems from \
                    advanced infection may not recover completely even with treatment.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Initial signs — ear scratching, head shaking, and light crusting in the ear canal — may appear within days to weeks of infestation. Early crusts are often mistaken for normal ear wax.",
                    delayed: "Without treatment, crusts thicken and expand over weeks to months. Secondary bacterial infection, deep ear involvement, and vestibular signs (head tilt, loss of balance) represent advanced disease requiring urgent veterinary care."
                ),
                symptoms: [
                    "Scratching at the ears or head",
                    "Frequent head shaking",
                    "Brown, red-brown, or honey-colored crusts inside the ear canal",
                    "Crusting extending to the ear flap (pinna), face, or neck",
                    "Ear drooping from the weight of crust accumulation",
                    "Foul odor from the ears",
                    "Head tilt (sign of inner ear involvement)",
                    "Loss of balance or stumbling (sign of inner ear involvement)",
                    "Becoming head-shy or resisting being touched around the ears",
                    "Lethargy and reduced appetite",
                    "Weight loss in severe or prolonged cases"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Rabbits are the primary host; one of the most common ectoparasite infestations in pet rabbits worldwide. Untreated cases can progress to secondary bacterial ear infection, vestibular disease, and fatal meningitis. Also documented occasionally in guinea pigs."
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .low,
                        notes: "Occasional infection documented. Dogs are not a primary host and rarely develop significant disease, but exposure from an infested rabbit in the household is possible."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .low,
                        notes: "Occasional infection documented. Cats are not a primary host and rarely develop significant disease, but exposure from an infested rabbit in the household is possible."
                    ),
                ],
                preventionTips: [
                    "Have any new rabbit examined by a veterinarian before introducing it to other animals — ear mites are easily transmitted and may not be immediately visible.",
                    "Quarantine new rabbits for a minimum of 4 weeks before housing them with resident animals.",
                    "Clean and disinfect enclosures, bedding, and food and water bowls regularly — mites can survive in the environment for up to 21 days.",
                    "If one rabbit in a multi-rabbit household is diagnosed with ear mites, all rabbits in the household should be evaluated and treated.",
                    "Avoid contact between pet rabbits and wild rabbits.",
                    "Schedule routine wellness exams for pet rabbits — early detection allows treatment before the infestation progresses to ear infection or neurological involvement."
                ],
                sources: [
                    "Merck Veterinary Manual — Ear Mites in Rabbits",
                    "LafeberVet — Psoroptes cuniculi in Rabbits",
                    "VCA Animal Hospitals — Ear Mites in Rabbits",
                    "PetMD — Rabbit Ear Mites (Psoroptes cuniculi)",
                    "Rutgers NJAES — Common Mites of Your Rabbit: Ear Mites and Canker"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000026",  // Mange (Sarcoptic & Demodectic)
                    "1D000001-0000-0000-0000-000000000029",  // Encephalitozoon cuniculi (E. cuniculi)
                    "1D000001-0000-0000-0000-000000000038",  // GI Stasis in Rabbits
                    "1D000001-0000-0000-0000-000000000045",  // Small Mammal Husbandry Guide
                    "1D000001-0000-0000-0000-000000000047",  // Myiasis (Fly Strike)
                    "1D000001-0000-0000-0000-000000000048"   // Cheyletiellosis (Walking Dandruff)
                ]
            ),

            // MARK: - RHDV2 (Rabbit Hemorrhagic Disease)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000032")!,
                name: "RHDV2 (Rabbit Hemorrhagic Disease)",
                alternateNames: ["Rabbit Hemorrhagic Disease Virus 2", "RHDVb", "Viral Hemorrhagic Disease", "VHD", "Lagovirus europaeus GI.2"],
                categories: [.diseasesAndConditions],
                imageAsset: "rhdv2_thumb",
                description: """
                    Rabbit Hemorrhagic Disease Virus 2 (RHDV2) is a highly contagious \
                    and often fatal viral disease caused by a calicivirus — the same \
                    family of viruses responsible for norovirus in humans. It triggers \
                    rapid, massive internal hemorrhage and acute liver destruction. \
                    RHDV2 first emerged in France in 2010 and has since spread across \
                    Europe, Australia, and North America. In 2020, it was confirmed in \
                    wild North American cottontail and jackrabbit populations for the \
                    first time — a significant shift that accelerated its spread across \
                    the western United States and Canada.

                    Unlike its predecessor RHDV1, RHDV2 affects young kittens (baby \
                    rabbits) as well as hares and pikas, broadening its host range \
                    considerably. Many infected rabbits are found dead with no \
                    observable warning signs. Domestic rabbits are highly susceptible \
                    regardless of age, breed, or whether they are kept indoors.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    RHDV2 attacks the liver and vascular system simultaneously. The \
                    virus replicates explosively in liver cells, triggering acute \
                    hepatic necrosis — a catastrophic breakdown of liver tissue. This \
                    destroys the liver's ability to regulate blood clotting, causing \
                    disseminated intravascular coagulation (DIC): the body attempts \
                    to clot everywhere at once while simultaneously hemorrhaging \
                    uncontrollably. Massive internal bleeding into the lungs, \
                    intestines, and kidneys follows within 12 to 36 hours of \
                    infection. Jaundice (yellow discoloration of the eyes, skin, \
                    or gums) reflects liver failure in subacute cases.

                    **Dead Without Warning**
                    One of RHDV2's most alarming features is its peracute form: the \
                    disease kills so rapidly that no signs of illness are ever seen. \
                    Owners frequently find apparently healthy rabbits dead — sometimes \
                    with blood at the nose or mouth — with no prior indication anything \
                    was wrong. This is not unusual; it is the most common presentation \
                    in documented outbreaks. Any sudden, unexplained rabbit death \
                    should be reported to a veterinarian immediately, both for \
                    diagnosis confirmation and to protect any remaining rabbits \
                    in the household.

                    **Farther Than Fences Can Stop**
                    RHDV2 is exceptionally stable in the environment — surviving for \
                    months on contaminated surfaces, soil, hay, and fabric at room \
                    temperature. It can be carried into a home on shoes, clothing, \
                    garden tools, and fresh produce. Flies, fleas, and mosquitoes \
                    act as mechanical vectors, ferrying the virus between animals \
                    without becoming infected themselves. Birds of prey and \
                    scavengers can spread it over large distances after consuming \
                    infected carcasses. Indoor-only rabbits are not automatically \
                    protected — active biosecurity is required.

                    **Transmission & Spread**
                    Direct contact with infected rabbits or their secretions (urine, \
                    feces, respiratory droplets) is the primary route. Indirect \
                    transmission via contaminated hutches, food bowls, bedding, and \
                    clothing is well documented. The virus is resistant to many \
                    common household disinfectants but is inactivated by sodium \
                    hypochlorite (bleach). RHDV2's 2020 breakthrough into North \
                    American cottontail rabbits (Sylvilagus spp.) — a species \
                    completely unaffected by RHDV1 — removed a major natural \
                    firebreak that had previously limited spread in the wild, \
                    and created a self-sustaining wild reservoir that continues \
                    to expand geographically.

                    **A Continent Unprepared**
                    When RHDV2 arrived in the American Southwest in 2020, it \
                    encountered wild rabbit populations with no prior exposure \
                    and no immunity. It swept through desert cottontails and \
                    black-tailed jackrabbits across New Mexico, Arizona, Colorado, \
                    California, Nevada, Utah, and Texas, decimating local \
                    populations. The ecological consequences extended beyond \
                    rabbits: in Europe, RHDV-driven wild rabbit population \
                    collapses have threatened predators that depend on rabbits \
                    as prey — most notably the Iberian lynx, the world's most \
                    endangered wild cat, whose recovery efforts have been \
                    complicated by unreliable rabbit prey availability. North \
                    American wild rabbit losses carry similar cascading risks \
                    for hawks, eagles, foxes, and coyotes. This ongoing wild \
                    reservoir now poses a transmission risk to domestic rabbits \
                    throughout affected regions — even to rabbits that never \
                    leave the home.

                    **Treatment Goals**
                    There is no approved antiviral treatment for RHDV2. Veterinary \
                    care focuses on supportive therapy: IV fluids, nutritional \
                    support, and management of secondary complications. Given the \
                    speed of disease progression, outcomes are often poor even \
                    with prompt intervention. Vaccination is the most effective \
                    protective measure currently available. A conditional \
                    USDA-licensed vaccine became available in the United States \
                    in 2022; rabbit owners in affected regions should consult \
                    a rabbit-savvy veterinarian about vaccination eligibility \
                    and scheduling. RHDV2 does not infect humans, dogs, cats, \
                    birds, or reptiles — but humans can passively carry the \
                    virus on hands, clothing, and shoes and introduce it to \
                    susceptible rabbits.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Peracute form: sudden death within 12–36 hours, often with no prior signs. Subacute form: fever, lethargy, and loss of appetite appearing within 1–3 days of exposure.",
                    delayed: "Subacute cases may develop jaundice, neurological signs, and respiratory distress over 1–2 weeks. Rabbits that survive acute illness may shed virus for several weeks."
                ),
                symptoms: [
                    "Sudden death with no prior signs (most common presentation)",
                    "Lethargy and weakness",
                    "Loss of appetite",
                    "High fever",
                    "Labored or rapid breathing",
                    "Seizures, incoordination, or paddling movements",
                    "Bleeding from the nose, mouth, or rectum",
                    "Jaundice (yellow tint to skin, eyes, or gums)",
                    "Abdominal bloating or pain",
                    "Collapse"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Domestic rabbits of all breeds and ages are highly susceptible. Unlike RHDV1, RHDV2 affects young kittens as well as adults. Case fatality rates in unvaccinated domestic rabbits exceed 90% in documented outbreaks. Guinea pigs, hamsters, gerbils, and rats are not susceptible to RHDV2. This entry applies specifically to rabbits within the small mammal category."
                    )
                ],
                preventionTips: [
                    "Ask a rabbit-savvy veterinarian about RHDV2 vaccination — especially if you live in a state with confirmed wild rabbit cases",
                    "Keep domestic rabbits away from wild rabbits, wild rabbit droppings, and areas frequented by wild lagomorphs",
                    "Remove shoes before entering rabbit areas if you have been outdoors where wild rabbits are present",
                    "Wash hands thoroughly before handling rabbits, especially after contact with other animals or outdoor environments",
                    "Do not offer wild-foraged grass, plants, or hay from unknown sources to domestic rabbits",
                    "Disinfect hutches, food bowls, and equipment with a dilute bleach solution — RHDV2 is resistant to many common disinfectants but is inactivated by sodium hypochlorite",
                    "Quarantine any new rabbit for at least 30 days before introducing them to existing rabbits",
                    "Report sudden or unexplained rabbit deaths to your veterinarian immediately — prompt diagnosis protects remaining animals and aids disease surveillance"
                ],
                sources: [
                    "USDA APHIS — Rabbit Hemorrhagic Disease: https://www.aphis.usda.gov/livestock-poultry-disease/rabbit-hemorrhagic-disease",
                    "House Rabbit Society — RHDV2 Information: https://rabbit.org/rhdv2/",
                    "Merck Veterinary Manual — Rabbit Hemorrhagic Disease: https://www.merckvetmanual.com/exotic-and-laboratory-animals/rabbits/rabbit-hemorrhagic-disease",
                    "AVMA — Rabbit Hemorrhagic Disease: https://www.avma.org/resources-tools/animal-health-and-welfare/animal-health/rabbit-hemorrhagic-disease",
                    "Wikipedia — Rabbit Haemorrhagic Disease: https://en.wikipedia.org/wiki/Rabbit_haemorrhagic_disease"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000007",  // Myxomatosis
                    "1D000001-0000-0000-0000-000000000045",  // Small Mammal Husbandry Guide
                    "1D000001-0000-0000-0000-000000000046"   // Feline Calicivirus (FCV)
                ]
            ),

            // MARK: - Snake Mites (Ophionyssus natricis)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000033")!,
                name: "Snake Mites (Ophionyssus natricis)",
                alternateNames: ["Reptile mites", "O. natricis", "snake mite infestation", "ophionyssus"],
                categories: [.diseasesAndConditions],
                imageAsset: "snake_mites_thumb",
                description: """
                    Snake mites (Ophionyssus natricis) are the most common ectoparasite \
                    of captive snakes — blood-feeding parasites that pierce soft skin \
                    between scales to feed on blood and tissue fluids. Although small \
                    enough to overlook, heavy infestations are well documented to cause \
                    severe anemia, dehydration, and death. They also affect captive \
                    lizards, blue-tongued skinks, turtles, and crocodilians — any \
                    reptile sharing an enclosure or collection with an infested animal \
                    is at risk.

                    Snake mites are not a minor nuisance. They reproduce rapidly under \
                    warm, humid conditions (completing a full life cycle in as little as \
                    13 days), spread easily through reptile collections via shared \
                    equipment or handling, and are difficult to eradicate because most \
                    insecticides commonly used in mammal care are highly toxic to \
                    snakes. Early detection and prompt veterinary treatment are essential. \
                    O. natricis can also transiently bite humans, causing skin irritation \
                    and dermatitis — though it does not establish a lasting infestation \
                    on people.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    O. natricis feeds by lacerating the thin, soft skin between scales \
                    with its chelicerae (mouthparts), drawing blood directly from the \
                    snake. A single mite is inconsequential; a heavy infestation \
                    represents hundreds or thousands of simultaneous feeding sites. The \
                    cumulative blood loss causes progressive anemia — reducing the \
                    snake's oxygen-carrying capacity — alongside dehydration from fluid \
                    loss at feeding wounds. Open bite wounds create entry points for \
                    bacteria, particularly Aeromonas hydrophila, a pathogen that causes \
                    hemorrhagic septicemia in reptiles. Left untreated, the combined \
                    effects of blood loss, dehydration, and secondary infection can be \
                    fatal. Chronic infestation also causes dysecdysis (abnormal shedding) \
                    as mites concentrated under retained shed skin prevent clean \
                    separation.

                    **The Invisible Load**
                    One of the most important things to understand about snake mites is \
                    how easily they are missed. Unfed mites are tiny (under 1mm) and \
                    pale yellow to ivory — nearly invisible on most snakes. Only \
                    engorged females become visibly dark red or black and large enough \
                    to spot easily. Mites preferentially cluster in the eye caps \
                    (spectacles), labial pits, and skin folds around the cloaca — \
                    areas that require deliberate inspection to examine. A snake that \
                    is spending unusual amounts of time in its water dish is often \
                    attempting to drown mites — a behavioral sign that frequently \
                    predates visible symptoms. Any new snake should be quarantined and \
                    carefully examined before joining an existing collection.

                    **The Poison Problem**
                    Treating snake mites is complicated by a well-documented paradox: \
                    most of the insecticides and acaricides routinely used against \
                    mites in mammals are potentially neurotoxic to snakes and other \
                    reptiles. This means treatment requires veterinary guidance \
                    specific to reptiles — off-the-shelf flea and tick products \
                    designed for dogs or cats must never be used on snakes. Critically, \
                    treating only the animal is insufficient — mites spend significant \
                    portions of their life cycle off the host, hiding in enclosure \
                    cracks, substrate, and equipment. Effective eradication requires \
                    simultaneous treatment of both the animal and the entire \
                    environment.

                    **Transmission & Spread**
                    Direct contact between infested and uninfested reptiles is the \
                    primary route of spread in collections. Mites and eggs are readily \
                    transferred on hands, clothing, shared equipment, and untreated \
                    substrate. The exotic pet trade is a major vector for global \
                    spread — O. natricis has been documented on wild snakes and \
                    lizards in Australia, Central America, and Central Asia, widely \
                    attributed to introductions through the captive reptile trade \
                    rather than native populations. Newly acquired reptiles — \
                    including those sold in pet stores — should always be quarantined \
                    and examined before introduction to any existing collection.

                    **A Mite That Bites Back**
                    O. natricis will opportunistically bite humans when mite populations \
                    are large, food is scarce, or when reptiles are handled. Human \
                    bites cause papular and vesiculobullous (blister-like) skin \
                    eruptions — itchy raised welts that can be mistaken for other \
                    dermatitis causes. The mites do not establish a lasting infestation \
                    on humans and will not complete their life cycle on a human host, \
                    but the dermatitis can be significant and persistent. Handlers \
                    and household members of infested reptiles should be aware of \
                    this possibility. If skin reactions develop after contact with \
                    reptiles or their enclosures, consult a physician.

                    **The Vector Problem**
                    Beyond direct harm, O. natricis is a confirmed mechanical vector \
                    of Aeromonas hydrophila (the bacterium responsible for hemorrhagic \
                    septicemia in reptiles) and is the leading suspected vector of \
                    Reptarenavirus — the causative agent of Inclusion Body Disease \
                    (IBD), a fatal neurological disease of boid snakes. The IBD \
                    vector role remains under active investigation, but the association \
                    is strong enough that mite control is considered a core component \
                    of IBD biosecurity in any snake collection.

                    **Treatment Goals**
                    Veterinary treatment aims to eliminate mites from both the animal \
                    and the enclosure environment simultaneously. The snake's water \
                    source, substrate, hides, and all cage furniture must be treated \
                    or replaced alongside the animal — treating the snake alone \
                    will result in rapid reinfestation from eggs and non-feeding \
                    mite stages surviving in the environment. Biological control \
                    using predatory mites (Stratiolaelaps scimitus, formerly \
                    Hypoaspis miles) has been used successfully in some collections \
                    as a non-toxic adjunct to veterinary treatment. A reptile-savvy \
                    veterinarian should direct any treatment plan.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Behavioral changes often appear before visible mites: prolonged soaking in water dish, increased rubbing against enclosure surfaces, restlessness. Visible mites (dark red or black engorged females) may be spotted in eye caps, labial pits, or skin folds.",
                    delayed: "With sustained infestation: lethargy, progressive weight loss, dysecdysis (abnormal shedding), crusting skin lesions. Anemia, dehydration, and septicemia develop in heavy or prolonged infestations and can be fatal without treatment."
                ),
                symptoms: [
                    "Prolonged soaking or unusual time spent in water dish",
                    "Rubbing or scraping against enclosure surfaces",
                    "Visible dark red or black mites on skin, especially around eyes, mouth, and cloaca",
                    "Restlessness or unusual agitation",
                    "Lethargy and reduced activity",
                    "Loss of appetite",
                    "Abnormal shedding (incomplete or retained shed)",
                    "Crusting or scabbing skin, especially between scales",
                    "Pale mucous membranes (sign of anemia)",
                    "Weight loss",
                    "Skin abscesses at bite sites"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Snakes are the primary and most severely affected host. Heavy infestations are documented to cause fatal anemia, dehydration, and septicemia. Lizards (including blue-tongued skinks, alligator lizards), turtles, and crocodilians sharing collections or enclosures with infested snakes are also susceptible. Any captive reptile in contact with infested animals or equipment is at risk."
                    )
                ],
                preventionTips: [
                    "Quarantine all new reptiles for a minimum of 30 days and inspect thoroughly for mites before introducing them to existing animals or equipment",
                    "Examine snakes regularly — check around the eyes, mouth, labial pits, and cloaca where mites preferentially cluster",
                    "Treat soaking in the water dish as a warning sign — this is a common early behavioral indicator of mite infestation",
                    "Never share equipment, hides, or substrate between enclosures without thorough disinfection",
                    "Wash hands and change clothing before handling other reptiles after contact with a new or unknown animal",
                    "Do not use flea or tick products designed for dogs or cats on reptiles — many are toxic to snakes",
                    "If mites are found, consult a reptile-savvy veterinarian before treating — enclosure environment must be treated simultaneously with the animal",
                    "If you develop itchy skin welts after handling reptiles or their enclosures, consult a physician — O. natricis can transiently bite humans"
                ],
                sources: [
                    "Merck Veterinary Manual — Mites of Reptiles: https://www.merckvetmanual.com/exotic-and-laboratory-animals/reptiles/parasitic-diseases-of-reptiles",
                    "LafeberVet — Ophionyssus natricis in Reptiles: https://lafeber.com/vet/ophionyssus-natricis/",
                    "Wikipedia — Ophionyssus natricis: https://en.wikipedia.org/wiki/Ophionyssus_natricis",
                    "PMC — Human Dermatitis Caused by Ophionyssus natricis: https://pmc.ncbi.nlm.nih.gov/articles/PMC4345101/",
                    "Acarologia — Occurrence of O. natricis on captive snakes from Panama: https://www1.montpellier.inrae.fr/CBGP/acarologia/article.php?id=4161"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis
                    "1D000001-0000-0000-0000-000000000026",  // Mange
                    "1D000001-0000-0000-0000-000000000034",  // Inclusion Body Disease (IBD)
                    "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
                    "1D000001-0000-0000-0000-000000000042",  // Reptile Respiratory Infections
                    "1D000001-0000-0000-0000-000000000043",  // Reptile Husbandry Guide
                    "1D000001-0000-0000-0000-000000000048"   // Cheyletiellosis (Walking Dandruff)
                ]
            ),

            // MARK: - Inclusion Body Disease (IBD)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000034")!,
                name: "Inclusion Body Disease (IBD)",
                alternateNames: ["IBD", "Boid Inclusion Body Disease", "BIBD", "stargazing disease",
                                 "twisty neck disease", "boid encephalitis", "Reptarenavirus infection"],
                categories: [.diseasesAndConditions],
                imageAsset: "ibd_thumb",
                description: """
                    Inclusion Body Disease (IBD) is a transmissible, progressive, and \
                    always fatal viral disease of boid snakes — primarily boa constrictors \
                    and pythons. It is caused by Reptarenavirus, a member of the arenavirus \
                    family, and is the most commonly diagnosed viral disease in captive boid \
                    snakes worldwide. The disease has been recognized since the mid-1970s \
                    and has been reported in captive snake collections across North America, \
                    Europe, Australia, and Africa.

                    There is no treatment and no vaccine. Snakes that develop clinical signs \
                    do not recover. The disease progresses to severe neurological dysfunction, \
                    secondary infections, and death. Euthanasia is the only humane option \
                    once clinical disease is confirmed. Boa constrictors may carry and shed \
                    the virus for months to years before showing symptoms — making silent \
                    carriers a significant biosecurity challenge in any collection.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    Reptarenavirus infects cells throughout the body, producing large \
                    abnormal protein masses — called inclusion bodies — inside the cytoplasm \
                    of affected cells. These inclusion bodies accumulate in neurons, liver \
                    cells, kidney cells, pancreatic cells, red and white blood cells, and \
                    bone marrow cells. Their presence physically disrupts normal cell \
                    function. In the brain and spinal cord, the result is progressive \
                    neurological deterioration: loss of coordination, inability to right \
                    itself when placed on its back, corkscrewing of the head and neck, \
                    and the characteristic \u{201C}stargazing\u{201D} posture — the snake \
                    involuntarily arches its head backward as if staring at the ceiling, \
                    a sign of severe brain dysfunction it cannot control. The accumulation \
                    of inclusion bodies in immune cells causes widespread immunosuppression, \
                    leaving the snake vulnerable to secondary bacterial, fungal, protozoal, \
                    and blood-borne infections that ultimately cause death. In pythons, \
                    neurological signs predominate and disease progresses rapidly — \
                    typically within weeks to months. In boa constrictors, the infection \
                    is often chronic, and some animals carry the virus for years before \
                    clinical signs develop.

                    **The Stargazer**
                    Stargazing is the sign most commonly associated with IBD in the \
                    reptile-keeping community — and for good reason. The image of a \
                    snake with its head thrown back, unable to orient itself, is \
                    distinctive and deeply unsettling to witness. It reflects irreversible \
                    neurological damage: the pathways that allow a snake to control its \
                    head and neck position have been destroyed by encephalitis. At this \
                    stage, the snake cannot strike or constrict prey, cannot shed normally, \
                    and can no longer right itself when turned over. Stargazing does not \
                    appear until the disease is already advanced. By the time this sign \
                    is visible, significant irreversible damage has occurred.

                    **The Silent Carrier**
                    One of the most dangerous features of IBD in collections is the \
                    boa constrictor's capacity to carry and shed Reptarenavirus without \
                    showing any signs of illness. In one published study of 131 captive \
                    boid snakes, 19% tested positive for IBD — and of those infected \
                    animals, 87% were clinically healthy at the time of testing. A boa \
                    that appears completely normal may have been harboring and transmitting \
                    the virus for months or years. This subclinical carrier state means \
                    that quarantine and testing before introducing any new boa or python \
                    into an existing collection is not optional — it is the only meaningful \
                    biosecurity available.

                    **Transmission & Spread**
                    The exact primary route of transmission remains incompletely understood \
                    — an unusual situation for a disease this well studied. Direct contact \
                    between snakes, contact with infected secretions, and vertical \
                    transmission from mother to offspring (confirmed in boa constrictors) \
                    are all documented. Snake mites (Ophionyssus natricis) are the leading \
                    suspected mechanical vector — mite infestations are consistently \
                    observed in collections affected by IBD outbreaks, and controlling \
                    mites is considered a core component of IBD prevention. Shared \
                    equipment, enclosures, and poor quarantine practices facilitate \
                    rapid spread through collections. Because infected snakes can shed \
                    virus before showing any symptoms, a single asymptomatic introduction \
                    into an established collection can be catastrophic.

                    **A Forty-Year Mistaken Identity**
                    For decades, IBD was widely described as a retrovirus disease — \
                    a label that appears in older veterinary literature, reptile-keeping \
                    guides, and many websites to this day. This conclusion came from \
                    electron microscopy studies in the 1970s and 1980s that observed \
                    retrovirus-like particles in tissue from infected snakes, and from \
                    the detection of reverse transcriptase — a hallmark enzyme of \
                    retroviruses — in the blood of infected animals. The retrovirus \
                    theory was reasonable given the tools available at the time, but \
                    it was never confirmed. In 2012, three independent research groups \
                    using modern genomic sequencing simultaneously identified the true \
                    causative agents: a group of novel, highly divergent arenaviruses, \
                    now classified in the new genus Reptarenavirus within the family \
                    Arenaviridae. This discovery reframed IBD entirely and opened the \
                    door to modern diagnostic testing. The retrovirus label, however, \
                    persists widely in older resources and should be treated as outdated.

                    **Myths vs. Facts**
                    **Myth:** IBD is caused by a retrovirus.
                    **Fact:** IBD is caused by Reptarenavirus, a member of the arenavirus \
                    family. The retrovirus theory was based on incomplete early evidence \
                    and has been superseded by modern genomic research published from \
                    2012 onward.

                    **Myth:** Stargazing always means IBD.
                    **Fact:** Stargazing is a neurological sign that can result from \
                    multiple causes — spinal trauma, other infections, and toxin exposure \
                    can all produce similar signs. IBD is one possible cause, but \
                    diagnosis requires veterinary evaluation and confirmatory testing.

                    **Myth:** Only sick-looking snakes can spread IBD.
                    **Fact:** Published research has shown that the majority of \
                    Reptarenavirus-infected boas are clinically healthy at the time of \
                    diagnosis. Asymptomatic carriers are a well-documented reality and \
                    the primary reason strict quarantine protocols exist.

                    **Treatment Goals**
                    There is no antiviral treatment for IBD and no vaccine. Veterinary \
                    care focuses on supportive therapy for comfort and secondary infection \
                    management, but cannot halt disease progression. Euthanasia is \
                    recommended when clinical signs are confirmed, both for the welfare \
                    of the affected snake and to prevent transmission to other animals. \
                    Modern RT-PCR diagnostic testing using blood, oral swabs, or tissue \
                    samples allows confirmation of Reptarenavirus infection in living \
                    snakes — a significant improvement over the earlier reliance on \
                    post-mortem inclusion body detection. Any boid snake showing \
                    neurological signs should be evaluated by a reptile-savvy veterinarian \
                    promptly and isolated from all other collection animals immediately.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "In pythons: acute neurological signs including disorientation, stargazing, and loss of righting reflex — progressing rapidly over days to weeks. In boas: early signs may be subtle — intermittent regurgitation, head tremors, reduced appetite — sometimes preceded by months to years of asymptomatic viral carriage.",
                    delayed: "Progressive neurological deterioration: corkscrewing of the head and neck, inability to strike or constrict prey, abnormal shedding, secondary pneumonia, stomatitis. Immunosuppression opens the door to fatal secondary infections. All symptomatic cases are ultimately fatal."
                ),
                symptoms: [
                    "Stargazing — head involuntarily arched backward, appearing to stare upward",
                    "Inability to right itself when placed on its back",
                    "Disorientation and loss of coordination",
                    "Corkscrewing or twisting of the head and neck",
                    "Head tremors",
                    "Intermittent or chronic regurgitation",
                    "Loss of appetite or refusal to feed",
                    "Inability to strike or constrict prey",
                    "Abnormal shedding",
                    "Open-mouth breathing or respiratory distress",
                    "Swollen or infected mouth (stomatitis)",
                    "Progressive weight loss",
                    "Lethargy and decreased responsiveness"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Affects boa constrictors and pythons (including ball pythons, Burmese pythons, reticulated pythons, and green anacondas). Always fatal once clinical signs develop. Boas tend to be long-term subclinical carriers; pythons typically develop acute, rapidly fatal neurological disease. IBD-like disease has been reported anecdotally in a small number of non-boid snake species, but confirmed IBD caused by Reptarenavirus is documented primarily in the families Boidae and Pythonidae. Dogs, cats, small mammals, and birds are not susceptible."
                    )
                ],
                preventionTips: [
                    "Quarantine all new boas and pythons for a minimum of 3 to 6 months before introducing them to an existing collection — asymptomatic carriers are well documented",
                    "Ask a reptile-savvy veterinarian about Reptarenavirus RT-PCR testing for any new acquisition before it contacts existing animals",
                    "Control snake mites aggressively — mite infestations are consistently associated with IBD outbreaks and Ophionyssus natricis is the leading suspected vector",
                    "Never share enclosures, water dishes, hides, or handling equipment between animals without thorough disinfection",
                    "Wash hands thoroughly between handling different snakes, even apparently healthy ones",
                    "Isolate any boa or python showing neurological signs, regurgitation, or abnormal shedding immediately and contact a reptile veterinarian",
                    "If IBD is confirmed in one animal, all snakes that shared the same enclosure or equipment should be considered potentially exposed and evaluated",
                    "Source new animals from reputable breeders with documented health screening practices — pet store animals from large mixed collections carry higher exposure risk"
                ],
                sources: [
                    "Veterinary Partner (VIN) — Inclusion Body Disease of Snakes: https://veterinarypartner.vin.com/default.aspx?pid=19239&id=8006507",
                    "Merck Veterinary Manual — Inclusion Body Disease: https://www.merckvetmanual.com/exotic-and-laboratory-animals/reptiles/viral-diseases-of-reptiles",
                    "Wikipedia — Inclusion Body Disease: https://en.wikipedia.org/wiki/Inclusion_body_disease",
                    "mBio (ASM Journals) — Identification of arenaviruses as candidate etiological agents for IBD (Stenglein et al., 2012): https://journals.asm.org/doi/10.1128/mbio.00180-12",
                    "Purdue University Veterinary Teaching Hospital — Inclusion Body Disease in Boas and Pythons: https://vet.purdue.edu/hospital/small-animal/primary-care/documents/InclusionBodyDiseaseinBoasandPythons.pdf"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000033",  // Snake Mites
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis
                    "1D000001-0000-0000-0000-000000000042",  // Reptile Respiratory Infections
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
            ),

            // MARK: - Air Sac Mites (Sternostoma tracheacolum)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000035")!,
                name: "Air Sac Mites (Sternostoma tracheacolum)",
                alternateNames: ["air sac mite", "air sac mite disease", "tracheal mite", "respiratory mite", "Sternostoma tracheacolum", "sternostomiasis", "air sac mite infestation", "finch tracheal mites", "canary air sac mites"],
                categories: [.diseasesAndConditions],
                imageAsset: "air_sac_mites_thumb",
                description: """
                    Air Sac Mites (Sternostoma tracheacolum) is an internal \
                    parasitic infestation caused by microscopic mites that colonize \
                    the respiratory system — including the trachea, syrinx \
                    (the avian vocal organ), bronchi, air sacs, and lungs. It is \
                    one of the most serious respiratory diseases of captive finches \
                    and canaries and can be fatal without prompt veterinary treatment.

                    The disease ranges from subtle to rapidly progressive. In light \
                    infestations, birds may appear healthy for weeks while mite \
                    numbers gradually increase. In heavy infestations, respiratory \
                    distress can escalate quickly and become life-threatening. Birds \
                    are highly skilled at concealing illness, and a bird may appear \
                    outwardly normal until the infestation is severe.

                    Air Sac Mites is not vaccine-preventable. It is not zoonotic — \
                    the mite does not infect humans. The condition is contagious \
                    among susceptible birds through direct contact and shared \
                    environment.

                    Small passerines — particularly finches (including Gouldian, \
                    zebra, and society finches) and canaries — are the most commonly \
                    and severely affected. Larger psittacines such as parrots and \
                    cockatiels are occasionally reported but are less frequently \
                    affected with severe disease. Dogs, cats, small mammals, and \
                    reptiles are not susceptible.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**

                    Sternostoma tracheacolum mites colonize the inner surfaces of \
                    the trachea, syrinx, bronchi, air sacs, and in severe cases the \
                    lung tissue itself. As mite numbers increase, they physically \
                    obstruct the airway and trigger chronic inflammation and thickening \
                    of the respiratory epithelium, progressively impairing the bird's \
                    ability to oxygenate effectively.

                    The syrinx — located at the base of the trachea where it \
                    bifurcates into the two bronchi — is particularly vulnerable. \
                    Mite colonization of the syrinx disrupts vocal production, \
                    causing the voice changes and loss of song that are often the \
                    first noticed signs in canaries and finches. As the infestation \
                    worsens, the bird must work harder to breathe, leading to visible \
                    respiratory effort (tail bobbing), open-mouth breathing, exercise \
                    intolerance, and eventually cardiovascular strain and anoxia \
                    (oxygen deprivation).

                    Birds have a uniquely efficient respiratory system built around \
                    a circuit of air sacs that allows near-continuous airflow through \
                    the lungs — unlike the in-and-out breathing cycle of mammals. \
                    This system makes birds exceptionally aerobically capable, but \
                    also uniquely vulnerable: mites colonizing the air sacs disrupt \
                    a much larger portion of the breathing circuit than a simple \
                    tracheal blockage would suggest, which is why even moderate \
                    infestations can cause disproportionate respiratory impairment.

                    **Transmission & Spread**

                    The most common transmission route is parent-to-chick feeding. \
                    Adult birds regurgitate food directly into the mouths of their \
                    chicks, and mites present in the parent's trachea or syrinx are \
                    transferred during this process. This means an entire clutch can \
                    acquire a significant mite burden before the adults show any \
                    obvious signs of illness.

                    Transmission also occurs through shared perches, food and water \
                    dishes, nest boxes, and close cage proximity. Newly introduced \
                    birds that have not been quarantined are one of the most common \
                    sources of infestation in established aviaries. Mites cannot \
                    survive extended periods off a host, but cage materials and nest \
                    boxes can sustain transmission within an active flock.

                    **Treatment Goals**

                    Veterinary treatment focuses on eliminating the mite infestation \
                    using appropriate antiparasitic therapy, managing respiratory \
                    compromise in birds that are already in distress, and \
                    decontaminating the environment to prevent reinfection. All birds \
                    in an affected flock should be evaluated and treated \
                    simultaneously — subclinical carriers are a significant \
                    reinfection risk if left untreated. An avian veterinarian \
                    experienced with small passerines is strongly recommended; \
                    treatment choices and dosing in finches and canaries differ \
                    substantially from those used in dogs and cats. Early \
                    veterinary intervention significantly improves outcomes.

                    **The Song Goes Silent**

                    Canaries are bred and prized for their song, and finches fill \
                    aviaries with constant chatter. When Sternostoma tracheacolum \
                    colonizes the syrinx, the first change many owners notice is not \
                    a sick bird — it is a quieter one. Song may become rough, raspy, \
                    or broken; pitch may shift noticeably; or vocalization may decline \
                    or cease as the syrinx becomes obstructed and inflamed. In \
                    finches, which vocalize less prominently than canaries, owners \
                    may simply notice a bird that seems unusually still or spends \
                    more time on the cage floor than on its perches.

                    A canary that stops singing is not merely going through a molt. \
                    Unexplained changes in vocalization in a bird should always \
                    prompt veterinary evaluation.

                    **The Click in the Night**

                    One of the most distinctive clinical signs of air sac mite \
                    infestation is an audible clicking, ticking, or rattling sound \
                    produced during breathing. This sound is generated when the bird \
                    inhales or exhales against mite-congested airways. Experienced \
                    avian veterinarians and longtime finch and canary keepers often \
                    recognize this sound immediately as a warning sign — it can \
                    sometimes be heard from across a quiet room.

                    Normal breathing in a healthy bird is nearly silent. If you can \
                    hear your bird breathing at close range — particularly if there \
                    is a rhythmic click, tick, or wheeze — that is a clinical sign \
                    requiring prompt veterinary evaluation, not watchful waiting.

                    **The Gouldian Crisis**

                    The Gouldian finch (Erythrura gouldiae) is one of Australia's \
                    most visually striking birds — and one of its most critically \
                    endangered. Wild populations declined sharply through the 20th \
                    century due to habitat loss, altered fire regimes, and the \
                    historical live bird trade. In captivity, where the species is \
                    widely kept and bred for both conservation and aviculture, \
                    Sternostoma tracheacolum became a serious threat to breeding \
                    success: research funded by Australia's CSIRO identified heavy \
                    mite burdens as a significant cause of chick mortality and \
                    clutch failure in captive Gouldian colonies. Because adult birds \
                    commonly carry mites subclinically and transmit them during the \
                    feeding of chicks, the parasite can quietly devastate a breeding \
                    program before a single adult appears overtly ill.

                    The Gouldian finch's vulnerability to air sac mites influenced \
                    how avian veterinarians and aviculturists approach mite screening \
                    in small passerines more broadly — establishing regular veterinary \
                    checkups, tracheal transillumination screening, and whole-flock \
                    treatment as recognized standards of care.

                    **Myths vs. Facts**

                    **Myth:** A bird that is still eating is not seriously ill.
                    **Fact:** Birds are hardwired to conceal illness — a survival \
                    instinct from wild ancestors for whom visible weakness meant \
                    predation. Birds often continue eating until they are critically \
                    compromised. Subtle signs such as fluffed feathers, tail bobbing, \
                    or decreased vocalization frequently appear well before a bird \
                    stops eating or looks overtly unwell.

                    **Myth:** Clicking or wheezing sounds are just a harmless quirk.
                    **Fact:** Any audible respiratory sound — clicking, ticking, \
                    wheezing, or rattling — is a clinical sign in a bird. Healthy \
                    birds breathe nearly silently. Audible breathing warrants \
                    veterinary evaluation.

                    **Myth:** Small birds like finches and canaries don't need \
                    veterinary care.
                    **Fact:** Small passerines benefit greatly from regular avian \
                    veterinary checkups. Air sac mites can be detected before \
                    clinical signs develop using tracheal transillumination — a \
                    straightforward, non-invasive technique available to experienced \
                    avian veterinarians. Early detection dramatically changes outcomes.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Subtle voice changes or reduced vocalization may appear within days to a few weeks of initial infestation. Many birds — especially those acquiring mites from parents at a young age — show no obvious signs for weeks or longer while mite numbers gradually increase.",
                    delayed: "Advanced respiratory distress, open-mouth breathing, and severe exercise intolerance develop as mite numbers increase, typically over weeks to months in untreated birds. In heavy infestations, deterioration can accelerate rapidly and become fatal."
                ),
                symptoms: [
                    "Audible clicking, ticking, or rattling sounds during breathing",
                    "Tail bobbing or pumping with each breath (increased respiratory effort)",
                    "Open-mouth breathing or gaping",
                    "Voice changes — rough, scratchy, or altered song quality",
                    "Reduced or absent singing or vocalization",
                    "Head shaking or scratching at the beak and face",
                    "Nasal discharge or crusty nostrils",
                    "Lethargy or decreased activity",
                    "Fluffed feathers, appearing cold or unwell",
                    "Exercise intolerance — breathlessness after minimal exertion",
                    "Spending time on the cage floor rather than perching",
                    "Weight loss",
                    "Sudden deterioration or death in severe cases"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .bird,
                        severity: .severe,
                        notes: "Finches (including Gouldian, zebra, and society finches) and canaries are the most severely and commonly affected. Heavy infestations are often fatal without treatment. Larger psittacines such as parrots and cockatiels may occasionally be affected but are rarely reported with severe disease. Dogs, cats, small mammals, and reptiles are not susceptible."
                    )
                ],
                preventionTips: [
                    "Quarantine all new birds for a minimum of 30 days in a separate airspace from your existing flock before any introduction.",
                    "Schedule regular checkups with an avian veterinarian — air sac mites can often be detected before clinical signs develop using tracheal transillumination.",
                    "During breeding season, monitor chicks closely for early respiratory signs; parent-to-chick transmission during feeding is the most common route of spread.",
                    "If one bird in a flock is diagnosed, have all flock members evaluated and treated simultaneously — subclinical carriers will reinfect treated birds if left untreated.",
                    "Clean and disinfect perches, food and water dishes, nest boxes, and cage furniture regularly.",
                    "Avoid introducing wild-caught birds to captive aviaries — wild passerines may carry mites and other parasites without visible signs of illness.",
                    "Contact an avian veterinarian if you notice any change in your bird's vocalization, breathing sounds, or activity level."
                ],
                sources: [
                    "LafeberVet — Sternostoma (Air Sac Mites) in Passerine Birds",
                    "Merck Veterinary Manual — Tracheal Mites in Birds",
                    "VCA Animal Hospitals — Air Sac Mites in Birds",
                    "PetMD — Air Sac Mites in Birds",
                    "Wikipedia — Sternostoma tracheacolum",
                    "CSIRO Australia — Gouldian Finch (Erythrura gouldiae) Parasitology Research"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000004",  // Psittacosis (Parrot Fever)
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000030",  // PBFD (Psittacine Beak and Feather Disease)
                    "1D000001-0000-0000-0000-000000000036",  // PDD (Proventricular Dilatation Disease)
                    "1D000001-0000-0000-0000-000000000044",  // Bird Husbandry Guide
                    "1D000001-0000-0000-0000-000000000048"   // Cheyletiellosis (Walking Dandruff)
                ]
            ),

            // MARK: - Proventricular Dilatation Disease (PDD)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000036")!,
                name: "Proventricular Dilatation Disease (PDD)",
                alternateNames: ["PDD", "avian bornavirus", "parrot bornavirus", "macaw wasting disease", "macaw wasting syndrome", "proventricular dilatation syndrome", "neuropathic gastric dilatation", "PaBV", "ABV", "avian ganglioneuritis", "proventricular dilation disease"],
                categories: [.diseasesAndConditions],
                imageAsset: "pdd_thumb",
                description: """
                    Proventricular Dilatation Disease (PDD) is a progressive, \
                    often fatal neurological and gastrointestinal disease of \
                    psittacine birds — parrots, macaws, cockatoos, African greys, \
                    conures, and their relatives — caused by Avian Bornavirus \
                    (specifically Parrot Bornavirus, or PaBV). The virus attacks \
                    the nerves of the digestive tract and, in many cases, the \
                    central nervous system, leading to a gradual loss of the \
                    ability to digest and pass food normally.

                    The disease is chronic and insidious. Birds may carry the \
                    virus for months to years before signs appear, and early \
                    symptoms are often subtle — weight loss in a bird that still \
                    has a good appetite, or the passage of obviously undigested \
                    food in the droppings. By the time severe signs develop, \
                    significant and often irreversible nerve damage has occurred.

                    PDD is not vaccine-preventable. It is not considered a \
                    significant zoonotic risk to humans based on current evidence. \
                    The disease is contagious among psittacine birds through \
                    exposure to feces and feather dust from infected individuals. \
                    Dogs, cats, small mammals, and reptiles are not susceptible.

                    Any psittacine bird can be affected, but macaws, African \
                    greys, cockatoos, Amazon parrots, and conures are among the \
                    most frequently reported species. Birds of any age may be \
                    affected, though younger birds and recently acquired birds \
                    introduced from unknown sources are at elevated risk.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**

                    Parrot Bornavirus (PaBV) is a neurotropic virus — meaning it \
                    specifically targets nerve tissue. After infection, the virus \
                    triggers an immune-mediated inflammatory response \
                    (lymphoplasmacytic ganglioneuritis) that progressively destroys \
                    the ganglia (nerve clusters) that control the muscular activity \
                    of the gastrointestinal tract. The result is a loss of \
                    coordinated motility — the rhythmic muscular contractions that \
                    move food through the digestive system slow, stall, and \
                    eventually fail.

                    The proventriculus — the glandular, enzyme-secreting portion \
                    of the avian stomach that sits just before the muscular \
                    gizzard — becomes dilated and dysfunctional as nerve supply \
                    is lost. Food accumulates, ferments, and passes undigested. \
                    Despite eating normally or even voraciously, the bird is \
                    effectively starving: nutrients cannot be properly absorbed \
                    from food that never undergoes normal digestion.

                    In a significant proportion of cases, Avian Bornavirus also \
                    invades the central nervous system, causing neurological \
                    signs that may be subtle at first — mild incoordination or \
                    unusual posturing — and progress to ataxia (loss of \
                    coordinated movement), seizures, blindness, or severe \
                    weakness. CNS involvement often carries a more guarded \
                    outlook than purely gastrointestinal disease.

                    **Transmission & Spread**

                    Avian Bornavirus is shed primarily in the feces and urine \
                    of infected birds, and via feather dust and respiratory \
                    secretions. Infection occurs through ingestion of or contact \
                    with contaminated material — shared food and water dishes, \
                    shared perches, or direct bird-to-bird contact. Feather dust \
                    in aviaries with high bird density is a significant exposure \
                    route.

                    One of the most challenging aspects of PDD control is the \
                    prolonged incubation period: infected birds may shed virus \
                    for months to years before showing any clinical signs. A \
                    newly acquired bird that appears completely healthy may \
                    already be infected and actively shedding, making quarantine \
                    and testing essential before any new bird is introduced to \
                    an existing collection. There is no reliable way to confirm \
                    a bird is uninfected based on appearance alone.

                    ABV has been detected in wild psittacine populations and in \
                    a range of non-psittacine bird species, though clinical \
                    disease in species other than parrots is less well \
                    characterized.

                    **Treatment Goals**

                    There is currently no cure for PDD. Veterinary management \
                    focuses on reducing the severity of the inflammatory nerve \
                    response, supporting nutritional status with highly digestible \
                    diets that reduce the digestive workload, managing \
                    neurological signs where present, and maintaining quality of \
                    life for as long as possible. Some birds with well-managed \
                    GI disease achieve stable periods with appropriate care, \
                    but the disease is progressive and cannot be reversed. \
                    Early veterinary involvement is essential for diagnosis — \
                    which typically requires imaging, crop biopsy, or PCR \
                    testing — and for developing an appropriate long-term \
                    management plan.

                    Infected birds in multi-bird households represent an \
                    ongoing transmission risk. An avian veterinarian should \
                    guide decisions about isolation, testing of flock mates, \
                    and long-term management of the affected bird and any \
                    potentially exposed companions.

                    **The Disease That Had No Name**

                    PDD has one of the more dramatic discovery histories in \
                    avian medicine. Beginning in the 1970s, veterinarians and \
                    breeders in Europe and North America began encountering a \
                    mysterious wasting disease in imported macaws — birds that \
                    ate well but lost weight steadily, eventually passing \
                    obviously undigested food and dying of malnutrition or \
                    sudden neurological collapse. With no identifiable cause, \
                    the condition was called Macaw Wasting Disease, then \
                    Macaw Wasting Syndrome, then Proventricular Dilatation \
                    Syndrome — names that described what was happening without \
                    explaining why.

                    The cause remained unknown for more than three decades. It \
                    was not until 2008 that two independent research groups \
                    simultaneously identified a novel bornavirus — now known as \
                    Parrot Bornavirus — as the causative agent, using advanced \
                    genomic sequencing techniques unavailable to earlier \
                    researchers. The discovery reframed PDD from a mysterious \
                    GI condition into a neurological disease with a viral driver, \
                    and opened the door to PCR-based diagnostic testing that is \
                    now widely used in avian practice.

                    The broader Bornavirus family has an unusual history of its \
                    own: the original Borna disease virus was first described in \
                    sheep and horses in Borna, Germany in the late 19th century, \
                    and the town's name became permanently attached to the entire \
                    viral family. Avian bornaviruses are genetically distinct from \
                    mammalian bornaviruses, and their discovery significantly \
                    expanded understanding of how widely distributed this viral \
                    group is across vertebrate species.

                    **The Hungry Bird That Starves**

                    Perhaps no aspect of PDD is more distressing to owners than \
                    this: many affected birds maintain a normal or even increased \
                    appetite throughout much of the disease course. A bird may \
                    eat enthusiastically, appear engaged and alert, and yet lose \
                    weight steadily because its damaged digestive system can no \
                    longer extract nutrition from what it consumes. Droppings \
                    containing clearly undigested seeds or food particles — a \
                    finding called \u{201C}whole seed passage\u{201D} — are one \
                    of the most telling early signs that something is \
                    fundamentally wrong with digestive function.

                    This disconnect between apparent appetite and progressive \
                    weight loss is a key reason routine weight monitoring is \
                    recommended for all pet parrots. A kitchen gram scale and \
                    a weekly weigh-in can detect clinically meaningful weight \
                    loss weeks before a bird looks visibly thin.

                    **Myths vs. Facts**

                    **Myth:** PDD is a stomach disease.
                    **Fact:** PDD is primarily a neurological disease. The \
                    stomach (proventriculus) dilates and fails because the nerves \
                    controlling it are destroyed — the stomach itself is not the \
                    primary target. In many birds, the central nervous system is \
                    also affected, producing signs that have nothing to do with \
                    digestion.

                    **Myth:** A bird with PDD will obviously look sick.
                    **Fact:** PDD is insidious. Birds can carry and shed Avian \
                    Bornavirus for months to years before any sign of illness \
                    appears. Early disease may show only as subtle weight loss \
                    or slightly abnormal droppings — signs easy to overlook \
                    without regular monitoring and veterinary checkups.

                    **Myth:** Isolating the sick bird is sufficient to protect \
                    the rest of a flock.
                    **Fact:** Because infected birds shed virus before they show \
                    signs, other birds in the household may already have been \
                    exposed by the time one bird is diagnosed. All flock mates \
                    should be evaluated and tested by an avian veterinarian, \
                    not just the bird showing clinical signs.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Incubation period is highly variable — infected birds may shed virus for months to years before signs appear. Early signs are often subtle: gradual weight loss despite normal appetite, mild changes in droppings such as the presence of undigested food, or slight behavioral changes.",
                    delayed: "Progressive weight loss, regurgitation, and passage of clearly undigested food develop as nerve damage advances. Neurological signs — incoordination, seizures, weakness — may appear at any stage and indicate central nervous system involvement. Advanced disease is typically irreversible."
                ),
                symptoms: [
                    "Progressive weight loss despite normal or increased appetite",
                    "Undigested food in droppings (whole seeds or obvious food particles visible)",
                    "Regurgitation or vomiting",
                    "Crop impaction or slow crop emptying (delayed crop transit)",
                    "Distended or visibly enlarged crop or abdomen",
                    "Passage of abnormal droppings — unusually wet, bulky, or foul-smelling",
                    "Ataxia — stumbling, loss of balance, difficulty perching",
                    "Tremors or muscle weakness",
                    "Seizures",
                    "Head tilt or abnormal posturing",
                    "Blindness or apparent visual disturbance",
                    "Lethargy and decreased activity",
                    "Fluffed feathers or behavioral changes"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .bird,
                        severity: .severe,
                        notes: "Primarily affects psittacine birds — parrots, macaws, cockatoos, African greys, Amazon parrots, conures, and related species. Macaws, African greys, and cockatoos are among the most frequently reported. Birds of any age may be affected. ABV has been detected in non-psittacine species but clinical disease is less well characterized. Dogs, cats, small mammals, and reptiles are not susceptible."
                    )
                ],
                preventionTips: [
                    "Quarantine all new birds for a minimum of 30–45 days in a completely separate airspace before introducing them to an existing flock — and consult an avian veterinarian about PCR testing for Avian Bornavirus during the quarantine period.",
                    "Weigh your bird regularly using a kitchen gram scale — weekly weigh-ins can detect meaningful weight loss weeks before a bird looks visibly thin. Keep a written log.",
                    "Schedule regular wellness exams with an avian veterinarian familiar with psittacines — many cases of PDD are diagnosed incidentally during routine checkups.",
                    "Do not share food dishes, water dishes, perches, or toys between a newly acquired bird and existing birds until quarantine is complete and veterinary clearance is obtained.",
                    "If one bird in a multi-bird household is diagnosed with PDD, have all flock mates evaluated and tested — birds can shed ABV long before showing clinical signs.",
                    "Clean and disinfect cage surfaces, food and water dishes, and perches regularly, particularly in multi-bird households.",
                    "Source new birds from reputable breeders or rescues with established health-testing protocols; avoid acquiring birds whose history is unknown."
                ],
                sources: [
                    "LafeberVet — Proventricular Dilatation Disease (PDD)",
                    "Merck Veterinary Manual — Proventricular Dilatation Disease in Birds",
                    "VCA Animal Hospitals — Proventricular Dilatation Disease in Birds",
                    "Cornell University College of Veterinary Medicine — Avian Health",
                    "Wikipedia — Avian bornavirus",
                    "Wikipedia — Proventricular dilatation disease",
                    "PetMD — Proventricular Dilatation Disease in Birds"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000004",  // Psittacosis (Parrot Fever)
                    "1D000001-0000-0000-0000-000000000030",  // PBFD (Psittacine Beak and Feather Disease)
                    "1D000001-0000-0000-0000-000000000035",  // Air Sac Mites
                    "1D000001-0000-0000-0000-000000000044"   // Bird Husbandry Guide
                ]
            ),

            // MARK: - Coccidiosis & Cryptosporidiosis
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000037")!,
                name: "Coccidiosis & Cryptosporidiosis",
                alternateNames: ["coccidia", "coccidiosis", "cryptosporidium", "cryptosporidiosis", "crypto", "Isospora", "Cystoisospora", "Eimeria", "oocysts", "protozoal diarrhea", "intestinal protozoa", "coccidian parasites", "puppy coccidia", "kitten coccidia", "rabbit coccidia", "reptile cryptosporidium", "snake cryptosporidium", "Cryptosporidium varanii", "Cryptosporidium parvum"],
                categories: [.diseasesAndConditions],
                imageAsset: "coccidia_thumb",
                description: """
                    Coccidiosis and Cryptosporidiosis are two distinct but related \
                    protozoal infections caused by microscopic single-celled \
                    parasites belonging to the same biological group — the \
                    Apicomplexa. Though closely related, they behave quite \
                    differently across species and vary enormously in severity: \
                    from a self-limiting bout of diarrhea in an otherwise healthy \
                    puppy to a fatal, incurable wasting disease in snakes.

                    Coccidia (most commonly Cystoisospora in dogs and cats, and \
                    Eimeria in rabbits and other small mammals) primarily infect \
                    the lining of the intestines, causing diarrhea that ranges \
                    from mild to severe depending on the age and immune status \
                    of the animal. Young, stressed, or immunocompromised animals \
                    are most vulnerable. In healthy adult dogs and cats, \
                    coccidial infections are often self-limiting, though veterinary \
                    diagnosis and treatment are still warranted.

                    Cryptosporidium is a separate genus that causes a distinct \
                    disease with a more serious profile. In reptiles — \
                    particularly snakes — Cryptosporidium varanii causes a \
                    chronic, progressive gastric disease that is widely considered \
                    incurable and often fatal. In dogs, cats, and small mammals, \
                    Cryptosporidium typically causes diarrhea similar in \
                    presentation to classical coccidia, but carries an additional \
                    concern: several Cryptosporidium species are zoonotic, \
                    capable of infecting humans.

                    Neither coccidiosis nor cryptosporidiosis is \
                    vaccine-preventable. Both spread through the fecal-oral route \
                    via microscopic oocysts shed in the feces of infected animals.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**

                    Both Coccidia and Cryptosporidium complete part of their life \
                    cycle inside the cells lining the intestinal tract. They \
                    invade and multiply within the epithelial cells (the single \
                    cell layer that lines the gut surface), destroying them in \
                    the process. This damages the gut's absorptive surface, \
                    impairing the absorption of nutrients and fluids and triggering \
                    inflammation — the result is diarrhea, dehydration, and in \
                    severe cases, protein loss, secondary infections, and systemic \
                    illness.

                    In young animals, the intestinal lining is still maturing and \
                    the immune system is not yet fully competent — this is why \
                    puppies, kittens, juvenile rabbits, and hatchling reptiles are \
                    disproportionately affected. A parasite burden that a healthy \
                    adult might clear with minimal signs can cause life-threatening \
                    hemorrhagic diarrhea in a six-week-old puppy or a \
                    newly weaned rabbit.

                    Cryptosporidium in reptiles follows a more destructive \
                    course. C. varanii (the primary species affecting snakes) \
                    does not remain limited to the intestinal surface — it \
                    invades the gastric epithelium of the stomach and \
                    proventriculus, triggering a chronic inflammatory reaction \
                    that causes progressive thickening and fibrosis (hardening) \
                    of the stomach wall. The thickened stomach can no longer \
                    stretch and function normally, causing food to back up, \
                    ferment, and eventually be regurgitated. The snake becomes \
                    unable to digest and absorb prey effectively and loses weight \
                    progressively — often despite continued feeding attempts. \
                    This process is not reversible with currently available \
                    treatments.

                    **Transmission & Spread**

                    Both parasites spread through the fecal-oral route. Infected \
                    animals shed oocysts — microscopic, environmentally resistant \
                    egg-like stages — in their feces. Oocysts are immediately or \
                    near-immediately infectious when passed (unlike many \
                    intestinal parasites that require a development period in \
                    the environment), which makes contaminated surfaces, bedding, \
                    soil, food, and water highly efficient transmission routes.

                    Oocysts are extraordinarily resilient. They can survive for \
                    months in moist environments and resist many standard \
                    disinfectants. Cryptosporidium oocysts in particular are \
                    notable for their resistance to chlorination at concentrations \
                    used in standard water treatment — a property with significant \
                    implications for public health.

                    For reptiles, transmission within a collection occurs through \
                    shared enclosures, shared equipment, and handling by keepers \
                    who move between enclosures without adequate disinfection. \
                    An infected snake may shed oocysts without showing clinical \
                    signs, making detection difficult and silent spread within \
                    a collection a serious concern.

                    **Treatment Goals**

                    For dogs, cats, and small mammals with coccidiosis, \
                    veterinary treatment focuses on eliminating the parasitic \
                    infection with appropriate antiparasitic therapy, correcting \
                    dehydration and electrolyte imbalances (which can be severe \
                    in young or small animals), managing secondary complications \
                    such as secondary bacterial infection, and supporting the \
                    animal's recovery with nutritional support where needed. \
                    Most otherwise healthy animals recover well with prompt \
                    veterinary care.

                    For reptiles with Cryptosporidium, treatment goals shift \
                    toward supportive care — maintaining body condition for as \
                    long as possible through assisted feeding, managing secondary \
                    complications, and maintaining quality of life — because no \
                    reliably curative treatment currently exists for C. varanii \
                    infection in snakes. Veterinary guidance is essential for \
                    managing the infected animal and for protecting other reptiles \
                    in the same collection.

                    **Zoonotic Risk**

                    Cryptosporidium — but not classical Coccidia — poses a \
                    meaningful zoonotic risk. Cryptosporidium parvum and \
                    C. hominis are the primary species that infect humans, \
                    typically through contaminated water or contact with infected \
                    animals or their feces. C. felis (cats), C. canis (dogs), \
                    and C. meleagridis have all been documented causing infection \
                    in humans, particularly in individuals who are \
                    immunocompromised.

                    Classical Coccidia (Cystoisospora, Eimeria) are \
                    species-specific and are not considered a significant \
                    zoonotic risk — the species infecting dogs and cats do not \
                    normally infect humans.

                    If your pet is diagnosed with Cryptosporidiosis, wash hands \
                    thoroughly after any contact with the animal or its \
                    environment. If you are immunocompromised, pregnant, elderly, \
                    or very young, consult your physician about your level of \
                    risk. Standard hygiene precautions are highly effective at \
                    preventing transmission.

                    **A Parasite That Survived Milwaukee**

                    In April 1993, the municipal water supply of Milwaukee, \
                    Wisconsin became contaminated with Cryptosporidium parvum \
                    oocysts — almost certainly from agricultural runoff entering \
                    the Lake Michigan intake used by one of the city's water \
                    treatment plants. Over the following weeks, an estimated \
                    403,000 people became ill with watery diarrhea. It remains \
                    the largest documented waterborne disease outbreak in United \
                    States history.

                    The episode exposed a critical vulnerability: \
                    Cryptosporidium oocysts are resistant to the chlorination \
                    levels used in standard municipal water treatment. The \
                    Milwaukee outbreak directly prompted the US EPA to strengthen \
                    water treatment regulations and establish specific monitoring \
                    requirements for Cryptosporidium in public water supplies. \
                    It also accelerated research into the parasite's biology and \
                    into the UV irradiation methods that are now used alongside \
                    chlorination to address its chlorine resistance.

                    For pet owners, the Milwaukee story is a reminder that \
                    Cryptosporidium is not an exotic concern — it is a parasite \
                    that operates at the intersection of animal health, \
                    environmental contamination, and public health in ways that \
                    genuinely matter.

                    **The Snake That Cannot Digest**

                    Experienced reptile keepers know the pattern: a snake that \
                    begins regurgitating prey items it had previously digested \
                    without difficulty, a mid-body swelling that appears and \
                    disappears, steady weight loss in a snake that strikes and \
                    constricts normally. This triad — regurgitation, mid-body \
                    swelling (from the thickened, distended stomach), and wasting \
                    — is the clinical signature of Cryptosporidium varanii in \
                    snakes, and it carries a grim outlook.

                    Unlike the GI cryptosporidiosis seen in mammals, which is \
                    primarily a surface infection of the intestinal lining, \
                    C. varanii drives a deep inflammatory reaction that \
                    physically remodels the stomach wall. The resulting fibrosis \
                    is structural — no antiparasitic can reverse scar tissue \
                    once it forms. A snake that has reached the regurgitation \
                    stage has already sustained irreversible damage. This is why \
                    new reptile acquisitions should always be quarantined and \
                    evaluated by a reptile-experienced veterinarian before \
                    joining an established collection — by the time signs appear, \
                    the window for protecting other animals has already closed.

                    **Myths vs. Facts**

                    **Myth:** Coccidia and Cryptosporidium are the same parasite.
                    **Fact:** They belong to the same broad group (Apicomplexa) \
                    but are distinct genera with different host ranges, disease \
                    mechanisms, zoonotic profiles, and treatment responses. \
                    Classical Coccidia (Cystoisospora, Eimeria) are not \
                    zoonotic; Cryptosporidium is. Reptile Cryptosporidium \
                    causes incurable gastric disease; mammalian coccidiosis is \
                    usually treatable.

                    **Myth:** A healthy-looking adult dog or cat cannot spread \
                    coccidia.
                    **Fact:** Adult animals frequently carry and shed coccidial \
                    oocysts without showing any signs of illness. Subclinical \
                    carriers are a significant source of infection for puppies, \
                    kittens, and immunocompromised animals sharing the same \
                    environment.

                    **Myth:** Bleach kills coccidia and Cryptosporidium oocysts.
                    **Fact:** Standard dilutions of household bleach are not \
                    reliably effective against oocysts. Ammonia-based disinfectants \
                    at appropriate concentrations, steam cleaning, and thorough \
                    drying are more effective environmental control measures. \
                    Consult your veterinarian for specific disinfection guidance.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "In dogs, cats, and small mammals, signs typically appear within 3–11 days of exposure. Young animals may develop diarrhea rapidly. In reptiles, gastric Cryptosporidiosis develops insidiously over weeks to months before signs are evident.",
                    delayed: "In mammals, severe cases progress to bloody diarrhea, significant dehydration, and systemic illness without treatment, particularly in young or immunocompromised animals. In snakes, progressive regurgitation, mid-body swelling, and wasting develop over months as gastric fibrosis advances."
                ),
                symptoms: [
                    "Watery or soft diarrhea — may be bloody in severe cases",
                    "Mucus in the stool",
                    "Straining to defecate",
                    "Vomiting or regurgitation",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Dehydration — sunken eyes, dry gums, skin that does not spring back when gently pinched",
                    "Pot-bellied appearance (particularly in young animals)",
                    "Weight loss despite eating",
                    "Mid-body swelling (snakes — from thickened, distended stomach)",
                    "Passage of undigested or poorly digested food (snakes)",
                    "Failure to thrive in young or juvenile animals"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Cystoisospora (Isospora) canis and C. ohioensis are the most common coccidial species in dogs. Cryptosporidium canis also documented. Puppies under 6 months, stressed, or recently rehomed dogs are most vulnerable. Healthy adults often show few or no signs but can act as subclinical carriers."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cystoisospora felis and C. rivolta are the most common coccidial species in cats. Cryptosporidium felis also documented. Kittens and immunocompromised cats are most at risk. As with dogs, healthy adult cats may carry and shed oocysts without clinical signs."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Rabbits are susceptible to both intestinal and hepatic (liver-affecting) Eimeria species, with some strains causing severe or fatal disease in young rabbits. Guinea pigs and rodents are susceptible to Eimeria as well. Cryptosporidium cuniculus is documented in rabbits. Young, newly weaned, or stressed small mammals are at greatest risk."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Cryptosporidium baileyi and related species have been documented in pet birds but are less commonly reported in clinical practice than in other species. More significant in poultry and commercial bird settings, which are outside this app's scope."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Cryptosporidium varanii (formerly C. serpentis) causes chronic, progressive, and typically fatal gastric disease in snakes. Cryptosporidium saurophilum affects lizards, primarily causing intestinal disease. No reliably curative treatment currently exists for C. varanii in snakes. All new reptile acquisitions should be quarantined and evaluated before joining an established collection."
                    )
                ],
                preventionTips: [
                    "Keep living environments clean and dry — promptly remove feces from enclosures, litter boxes, and bedding, as oocysts become infectious quickly after being passed.",
                    "Quarantine all new animals before introducing them to existing pets — this applies especially to reptiles, where silent Cryptosporidium infection can devastate an established collection.",
                    "Wash hands thoroughly after handling any animal, cleaning enclosures, or contact with fecal material — particularly important for Cryptosporidium given its zoonotic potential.",
                    "Have young animals (puppies, kittens, juvenile rabbits, hatchling reptiles) evaluated by a veterinarian early — fecal testing can detect coccidial oocysts before severe illness develops.",
                    "Avoid overcrowding — high animal density accelerates fecal-oral transmission and increases stress, which lowers resistance to infection.",
                    "For reptile keepers: use dedicated equipment (tongs, water dishes, feeding tools) for each enclosure, or disinfect thoroughly between uses. Standard bleach dilutions are not reliably effective against oocysts — consult your veterinarian for appropriate disinfectants.",
                    "Source animals from reputable breeders or rescues with health-testing protocols; avoid acquiring animals with unknown histories, particularly reptiles.",
                    "If a diagnosis of Cryptosporidiosis is confirmed, consult your physician if you or household members are immunocompromised, pregnant, elderly, or very young."
                ],
                sources: [
                    "Merck Veterinary Manual — Coccidiosis in Dogs and Cats",
                    "Merck Veterinary Manual — Cryptosporidiosis in Animals",
                    "ASPCA Animal Poison Control Center — Protozoal Parasites",
                    "Cornell University College of Veterinary Medicine — Feline Coccidiosis",
                    "LafeberVet — Cryptosporidiosis in Reptiles",
                    "VCA Animal Hospitals — Coccidiosis in Dogs",
                    "VCA Animal Hospitals — Cryptosporidiosis in Cats",
                    "Wikipedia — Cryptosporidiosis",
                    "Wikipedia — Coccidiosis",
                    "US EPA — Cryptosporidium: Drinking Water Health Advisory (Milwaukee outbreak context)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000023",  // GI Parasites
                    "1D000001-0000-0000-0000-000000000024",  // Toxoplasma
                    "1D000001-0000-0000-0000-000000000029",  // Encephalitozoon cuniculi (E. cuniculi)
                    "1D000001-0000-0000-0000-000000000044",  // Bird Husbandry Guide
                    "1D000001-0000-0000-0000-000000000045"   // Small Mammal Husbandry Guide
                ]
            ),

            // MARK: - GI Stasis in Rabbits (Gut Shutdown)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000038")!,
                name: "GI Stasis in Rabbits (Gut Shutdown)",
                alternateNames: [
                    "GI stasis",
                    "gut stasis",
                    "rabbit ileus",
                    "gastrointestinal stasis",
                    "intestinal stasis",
                    "gut shutdown",
                    "gastrointestinal ileus",
                    "rabbit gut stasis",
                    "GI ileus"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "gi_stasis_thumb",
                description: """
                    GI stasis is a life-threatening condition in which the normal movement of \
                    food, fluid, and gas through a rabbit's digestive tract slows dramatically \
                    or stops entirely. Without prompt veterinary care, the condition can become \
                    fatal within 24 to 48 hours.

                    Unlike dogs and cats, rabbits are hindgut fermenters — they rely on a \
                    complex population of beneficial bacteria and a continuous flow of dietary \
                    fiber to keep digestion moving. When that flow is disrupted, gas accumulates \
                    in the gastrointestinal tract, pain intensifies, and the rabbit stops eating. \
                    Once a rabbit stops eating, the condition accelerates rapidly.

                    GI stasis is not contagious and is not caused by a pathogen. In most cases \
                    it is directly linked to diet, environment, or stress, making it largely \
                    preventable with correct husbandry. Any rabbit can be affected, but animals \
                    on low-fiber diets, those experiencing stress, and those with underlying \
                    dental disease are most commonly seen. Guinea pigs and chinchillas share a \
                    similar physiological vulnerability and can develop GI stasis under comparable \
                    conditions. Dogs, cats, birds, and reptiles are not subject to this \
                    husbandry-driven form of the condition.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    Rabbits have a digestive system built around continuous, high-volume movement. \
                    The cecum — a large fermentation chamber that can account for roughly 40% of \
                    the rabbit's gastrointestinal volume — houses billions of bacteria that break \
                    down fibrous plant material. Fiber is not just food for the rabbit; it is the \
                    physical stimulus that keeps the entire system in motion. When fiber intake \
                    drops, gut motility (the rhythmic muscular contractions that move food forward) \
                    slows. Slowed motility allows gas to accumulate. Gas causes pain. Pain causes \
                    the rabbit to stop eating. Not eating causes further motility loss — a \
                    self-reinforcing spiral that can reach a critical point within hours.

                    A critical anatomical fact: rabbits cannot vomit. Gas and gut contents \
                    cannot be expelled orally. Once the system stalls, there is no natural \
                    safety valve. Painful gas distension can become severe, and the gut \
                    bacteria responsible for healthy digestion begin to die off — making \
                    recovery harder the longer the condition is left untreated.

                    **The Dropping They're Supposed to Eat**
                    Most rabbit owners know their rabbit eats some of its own droppings — but \
                    not all droppings are the same. Cecotropes (also called night droppings or \
                    cecal pellets) are soft, grape-cluster-shaped droppings produced from the \
                    cecum. They are rich in B vitamins, proteins, volatile fatty acids, and \
                    living gut bacteria that the rabbit's digestive system cannot fully absorb \
                    in a single pass through the gut. Eating them directly from the anus — a \
                    behavior called cecotrophy — is not a sign of poor hygiene. It is a \
                    nutritional requirement.

                    When GI motility begins to slow, cecotrope production becomes irregular \
                    or stops. An owner finding soft, uneaten cecotropes clustered in the hutch — \
                    when their rabbit used to consume them without leaving a trace — is observing \
                    one of the earliest and most reliable warning signs of developing stasis. It \
                    also means the rabbit is being deprived of critical nutrition at exactly the \
                    moment its system is most stressed. This detail alone is worth knowing: if \
                    you are finding soft droppings, contact your veterinarian — do not wait for \
                    more obvious symptoms to develop.

                    **Causes & Risk Factors**
                    • **Low-fiber diet** — the single most common driver. Rabbits require \
                    unlimited access to grass hay (timothy, orchard grass, meadow hay) as the \
                    foundation of their diet. Hay provides the long-strand fiber that physically \
                    stimulates gut motility. A diet built primarily on pellets, greens, or treats \
                    is a significant risk factor regardless of how much the rabbit eats.

                    • **Dental disease** — tooth root problems, molar spurs, or incisor \
                    misalignment cause pain while eating, leading to reduced food intake and \
                    subsequent motility loss. A rabbit that suddenly stops eating should always \
                    have its teeth evaluated by a veterinarian — dental pain is a frequently \
                    missed trigger for stasis.

                    • **Stress** — rabbits are prey animals that instinctively suppress visible \
                    signs of distress. Physical or psychological stress — including transport, \
                    environmental change, loud noise, the introduction of new animals, or pain \
                    from any source — can slow or halt gut motility directly.

                    • **Dehydration** — adequate water intake is essential for gut motility and \
                    the passage of ingested material. Rabbits on insufficient water, or those in \
                    hot environments, are at elevated risk. Water availability should be monitored \
                    closely during warm weather.

                    • **Hairballs (trichobezoars)** — unlike cats, rabbits cannot vomit up \
                    ingested fur. Hair accumulates in the stomach, particularly during heavy \
                    molting seasons. Adequate fiber helps move hair through naturally; low-fiber \
                    diets allow hairballs to grow to an obstructive size.

                    • **Inactivity and obesity** — overweight rabbits and those with insufficient \
                    exercise space show higher rates of GI motility problems. Physical movement \
                    directly supports gut motility.

                    • **Post-illness or post-surgical vulnerability** — any period of reduced \
                    eating, including recovery from an unrelated condition or procedure, can \
                    initiate stasis. Rabbits recovering from illness require close dietary monitoring.

                    **Treatment Goals**
                    Veterinary treatment focuses on restoring gut motility, relieving gas pain, \
                    correcting dehydration, and returning the rabbit to voluntary eating as \
                    quickly as possible. Pain management is central to recovery — a rabbit in \
                    pain will not eat, and a rabbit that will not eat cannot recover on its own. \
                    GI stasis does not resolve without veterinary intervention. Outcomes are \
                    significantly better with early treatment; delays of even a few hours worsen \
                    the prognosis considerably.

                    **Myths vs. Facts**
                    **Myth:** \u{201C}My rabbit is still moving around, so it can\u{2019}t be that serious.\u{201D}
                    **Fact:** Rabbits instinctively hide signs of illness — movement does not \
                    rule out stasis. A rabbit that is quieter than usual, not eating its \
                    cecotropes, or producing fewer droppings than normal may already be in the \
                    early stages. Waiting for dramatic symptoms costs critical treatment time.

                    **Myth:** \u{201C}Rabbits are fine on a pellet-only diet.\u{201D}
                    **Fact:** Pellets are a supplement, not a dietary foundation. A pellet-only \
                    rabbit is at significantly elevated risk for GI stasis, dental disease, and \
                    obesity. Unlimited grass hay is not optional — it is the single most \
                    important item in a rabbit's diet.

                    **Myth:** \u{201C}GI stasis just means my rabbit needs a tummy rub.\u{201D}
                    **Fact:** Gentle abdominal palpation may provide minor comfort in very mild \
                    cases, but it does not address motility failure, gas accumulation, pain, or \
                    dehydration — the four interconnected problems driving the condition. \
                    Veterinary evaluation is required; home management is not a substitute.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Reduced or absent fecal pellets and loss of appetite are often the first signs, sometimes within a few hours of onset. Uneaten cecotropes (soft, grape-cluster-shaped droppings) left in the hutch are among the earliest owner-observable warning signs and should prompt immediate veterinary contact.",
                    delayed: "Without treatment, critical deterioration typically occurs within 24 to 48 hours. A rabbit that has not eaten or passed droppings for more than 12 hours requires urgent veterinary evaluation — do not wait overnight."
                ),
                symptoms: [
                    "Loss of appetite or complete refusal to eat",
                    "Reduced or absent fecal pellets",
                    "Uneaten cecotropes (soft, grape-cluster-shaped droppings left in the hutch)",
                    "Hunched, uncomfortable posture",
                    "Teeth grinding (bruxism) — a sign of pain",
                    "Lethargy, unusual stillness, or depression",
                    "Visibly swollen or distended abdomen",
                    "Hiding or avoiding contact",
                    "Labored or rapid breathing (in severe cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Rabbits are the primary and most severely affected species; the hindgut-fermenter digestive system makes them uniquely vulnerable to stasis when fiber intake is inadequate. Guinea pigs and chinchillas share a similar physiological design and are also susceptible. Life-threatening without prompt veterinary care."
                    )
                ],
                preventionTips: [
                    "Provide unlimited grass hay (timothy, orchard grass, or meadow hay) at all times — it is the single most important factor in preventing GI stasis and should make up the majority of the diet",
                    "Ensure fresh, clean water is always available; dehydration directly impairs gut motility and worsens risk during warm weather",
                    "Limit pellets to small supplemental amounts appropriate for body weight; avoid high-sugar, high-starch treats including dried fruit, crackers, bread, and commercial rabbit treats",
                    "Provide adequate exercise space — rabbits that cannot move freely are at higher risk; daily out-of-enclosure time supports gut motility",
                    "Monitor droppings every day — a sudden reduction in the number or size of fecal pellets, or the appearance of uneaten cecotropes (soft clustered droppings) in the hutch, warrants prompt veterinary contact",
                    "Schedule regular veterinary check-ups including dental evaluations — tooth problems are a leading hidden trigger for stasis and may not be visible to owners",
                    "Minimize environmental stressors; avoid sudden changes to housing, routine, or social environment where possible",
                    "During molting seasons, ensure hay intake is especially high to help move ingested fur through the digestive tract and reduce hairball risk"
                ],
                sources: [
                    "House Rabbit Society — GI Stasis: The Silent Killer (rabbit.org)",
                    "Merck Veterinary Manual — Gastrointestinal Diseases of Rabbits",
                    "LafeberVet — GI Stasis in Rabbits",
                    "VCA Animal Hospitals — Gastrointestinal Stasis in Rabbits",
                    "Wikipedia — Cecotrophy"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000029",  // E. cuniculi
                    "1D000001-0000-0000-0000-000000000031",  // Rabbit Ear Mites
                    "1D000001-0000-0000-0000-000000000045",  // Small Mammal Husbandry Guide
                    "1D000001-0000-0000-0000-000000000047"   // Myiasis (Fly Strike)
                ]
            ),

            // MARK: - Hypovitaminosis A (Vitamin A Deficiency)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000039")!,
                name: "Hypovitaminosis A (Vitamin A Deficiency)",
                alternateNames: [
                    "vitamin A deficiency",
                    "hypo A",
                    "hypovitaminosis A",
                    "VAD",
                    "vitamin A deficiency disease",
                    "avitaminosis A",
                    "low vitamin A"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "hypovitaminosis_a_thumb",
                description: """
                    Hypovitaminosis A is a nutritional disease caused by a chronic deficiency \
                    of vitamin A (retinol) in the diet. It is one of the most common \
                    diet-related diseases seen in captive reptiles and birds, and is \
                    almost entirely preventable with correct feeding.

                    Vitamin A is a fat-soluble vitamin essential for maintaining the \
                    integrity of epithelial tissues — the cell layers that line the skin, \
                    eyes, mouth, respiratory tract, and internal organs. When the body \
                    cannot obtain enough vitamin A over time, these linings begin to \
                    break down and are replaced by a thickened, non-functional cell type. \
                    The resulting damage creates a cascade of problems that affects \
                    multiple organ systems simultaneously.

                    The condition develops gradually over weeks to months. Owners often \
                    miss early signs because the disease appears insidious until it \
                    reaches an advanced and more visibly obvious stage. By the time \
                    swollen eyes, respiratory symptoms, or mouth changes are obvious, \
                    the deficiency has typically been ongoing for some time.

                    Reptiles — particularly box turtles, aquatic turtles, tortoises, \
                    chameleons, and bearded dragons — are the most commonly affected \
                    group in clinical practice. Parrots, budgerigars, and other psittacine \
                    birds on seed-only diets are also highly susceptible. Small mammals \
                    including rabbits and guinea pigs can develop vitamin A deficiency on \
                    inadequate diets, though this is less common when appropriate hay and \
                    fresh vegetables are provided. Dogs and cats are rarely affected, as \
                    commercial pet foods are routinely supplemented with vitamin A. \
                    This entry focuses on reptiles, birds, and small mammals.

                    Hypovitaminosis A is not contagious and is not caused by a pathogen. \
                    No vaccine exists or is applicable.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    Vitamin A plays a fundamental role in the maintenance of epithelial \
                    tissue — the cell layers that line and protect virtually every surface \
                    inside and outside the body. In a well-nourished animal, these linings \
                    are moist, functional, and effective barriers against infection and \
                    environmental insult.

                    When vitamin A is chronically deficient, a process called squamous \
                    metaplasia (skway-mus meh-tah-PLAY-zhuh) occurs: normal, healthy \
                    epithelial cells are progressively replaced by a thickened, dry, \
                    non-functional layer of squamous (scale-like) cells. This replacement \
                    happens across multiple organ systems at once.

                    In the eyes, the conjunctiva and cornea become dry and thickened. \
                    Fluid accumulates beneath the eyelids, producing the characteristic \
                    swollen-eyelid appearance that is among the most recognizable signs of \
                    vitamin A deficiency in turtles and tortoises. Left untreated, this \
                    leads to corneal damage and permanent vision loss.

                    In the mouth and respiratory tract, the normal moist lining is replaced \
                    by dry, thickened tissue that accumulates caseous (cheese-like) debris \
                    and becomes vulnerable to secondary bacterial infection. In birds, this \
                    produces blunting or loss of the choanal papillae — the small, spike-like \
                    projections visible in the roof of the mouth on examination. Their \
                    flattening or absence is a classic clinical finding in vitamin A-deficient \
                    psittacines.

                    In the kidneys, squamous metaplasia of the tubular lining impairs waste \
                    filtration and can progress to visceral gout — a painful, serious \
                    condition in which uric acid crystals deposit in the organs and tissues.

                    The damaged linings also lose their barrier function, making affected \
                    animals significantly more vulnerable to secondary bacterial, viral, and \
                    fungal infections — which often become the presenting complaint, \
                    masking the underlying nutritional cause.

                    **The Carrot Problem — and Why Beta-Carotene Is Not Always Enough**
                    Vitamin A does not occur in plant foods — what plants contain is \
                    beta-carotene, a precursor that must be converted to active vitamin A \
                    in the body. In humans and many mammals, this conversion is reasonably \
                    efficient. In reptiles, conversion is poor to negligible. A tortoise \
                    eating carrots and leafy greens is not reliably meeting its vitamin A \
                    needs from beta-carotene alone. Preformed vitamin A — found in animal-\
                    sourced foods such as liver and certain prey items — is far more \
                    bioavailable for reptiles than any plant-based source. This is why \
                    dietary correction in reptiles requires veterinary guidance specific to \
                    the species, rather than simply adding more vegetables.

                    Birds are somewhat better at converting beta-carotene than reptiles, \
                    which is why a parrot eating a varied diet that includes dark leafy \
                    greens, sweet potato, and red/orange vegetables is much better \
                    protected than one living on a seed mix. Seeds are virtually devoid of \
                    vitamin A or beta-carotene — a seed-only diet is a slow-motion \
                    nutritional crisis.

                    **Causes & Risk Factors**
                    • **Seed-only diets in birds** — the most common single cause of \
                    hypovitaminosis A in psittacines. Seeds contain almost no vitamin A \
                    or beta-carotene. Birds fed exclusively on seed mix with no fresh \
                    vegetables, leafy greens, or formulated pellets are at high risk. \
                    Budgerigars, cockatiels, and Amazon parrots are particularly \
                    over-represented in clinical cases.

                    • **Monotonous or inadequate diets in reptiles** — box turtles fed \
                    primarily on fruit (low in vitamin A); aquatic turtles fed \
                    exclusively on commercial turtle sticks; tortoises without access \
                    to appropriate leafy vegetation; chameleons fed feeder insects without \
                    supplementation. Any reptile diet lacking variety and appropriate \
                    supplementation is at risk.

                    • **Reliance on beta-carotene alone in reptiles** — as described above, \
                    reptiles convert beta-carotene to vitamin A poorly. A diet that appears \
                    colorful and vegetable-rich may still be deficient in bioavailable \
                    vitamin A for reptile species.

                    • **Missing or inadequate supplementation** — captive reptiles typically \
                    require vitamin A supplementation, but over-supplementation causes \
                    toxicity (hypervitaminosis A). Species-appropriate supplementation \
                    should always be guided by a veterinarian familiar with exotic species.

                    • **Small mammals on restricted diets** — rabbits and guinea pigs on \
                    hay-only or pellet-only diets without fresh vegetables can develop \
                    mild to moderate deficiency over time. Guinea pigs, like humans, also \
                    cannot synthesize vitamin C — dietary deficiencies in this species \
                    tend to cluster.

                    • **Young and growing animals** — rapidly growing juveniles have higher \
                    vitamin A demands and develop deficiency faster than adults on the same \
                    inadequate diet.

                    **Treatment Goals**
                    Veterinary treatment focuses on correcting the vitamin A deficiency \
                    in a controlled, species-appropriate manner, managing secondary \
                    infections that have developed as a result of compromised epithelial \
                    barriers, and providing supportive care for affected organ systems \
                    including the eyes and kidneys. Vitamin A supplementation requires \
                    careful veterinary management — the margin between corrective and \
                    toxic doses (hypervitaminosis A) is narrow in some species, and \
                    inappropriate supplementation can cause additional harm. Dietary \
                    correction is a central part of long-term management. Outcomes are \
                    significantly better when the deficiency is identified and addressed \
                    before advanced organ damage has occurred.

                    **Myths vs. Facts**
                    **Myth:** \u{201C}My turtle eats carrots, so it must be getting enough vitamin A.\u{201D}
                    **Fact:** Reptiles convert beta-carotene from plant sources to active \
                    vitamin A very poorly. Carrots and orange vegetables are not a reliable \
                    vitamin A source for turtles or tortoises. Species-appropriate \
                    supplementation and dietary guidance from an exotic animal veterinarian \
                    is essential.

                    **Myth:** \u{201C}Seeds are a natural diet for parrots, so they must be nutritionally complete.\u{201D}
                    **Fact:** Wild parrots eat a diverse range of foods including fruits, \
                    flowers, shoots, nuts, and insects — not a single-food seed diet. \
                    Commercial seed mixes are particularly poor in vitamin A. A captive \
                    parrot on seeds alone is on a path toward nutritional deficiency.

                    **Myth:** \u{201C}The swelling around my turtle\u{2019}s eyes is just an infection.\u{201D}
                    **Fact:** Periocular swelling (swelling around the eyes) in turtles and \
                    tortoises is a classic sign of vitamin A deficiency, not a primary \
                    infection. Secondary infection is common, but treating the infection \
                    without addressing the underlying nutritional deficiency will result \
                    in recurrence.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Develops gradually over weeks to months of inadequate dietary intake. Early signs are often subtle — reduced appetite, mild lethargy, or slightly dull eyes — and are frequently missed until the condition is more advanced.",
                    delayed: "Advanced signs including swollen eyelids, respiratory symptoms, mouth lesions, and secondary infections typically emerge after prolonged deficiency. Once organ systems such as the kidneys are involved, recovery is significantly more difficult and outcomes are less predictable."
                ),
                symptoms: [
                    "Swollen, puffy, or closed eyelids (particularly in turtles and tortoises)",
                    "Discharge or crusting around the eyes",
                    "Mouth breathing or wheezing",
                    "Nasal discharge",
                    "White or yellowish deposits in the mouth (secondary infection)",
                    "Loss of appetite or refusal to eat",
                    "Lethargy and weakness",
                    "Skin changes — dry, flaky, or abnormal shedding",
                    "Blunted or absent choanal papillae (visible in birds on veterinary exam)",
                    "Swollen limbs or facial swelling (advanced cases)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Turtles, tortoises, and chelonians are the most commonly affected reptiles in clinical practice. Box turtles, red-eared sliders, and other aquatic turtles are frequently presented with periocular swelling as the primary complaint. Chameleons and bearded dragons are also at risk. Squamous metaplasia affecting eyes, kidneys, and respiratory tract can cause permanent damage if the deficiency is prolonged."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .severe,
                        notes: "Psittacine birds (parrots, budgerigars, cockatiels, Amazon parrots) on seed-only diets are at high risk. Classic finding on veterinary examination is blunting or loss of choanal papillae. Respiratory lesions, secondary infections, and kidney involvement are common in advanced cases. Dietary correction is central to treatment and long-term prevention."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Rabbits and guinea pigs on restricted diets lacking fresh vegetables can develop vitamin A deficiency. Less commonly seen than in reptiles and birds when appropriate hay and varied vegetables are provided. Reproductive problems and immune suppression have been documented in deficient small mammals."
                    )
                ],
                preventionTips: [
                    "For reptiles: work with a veterinarian experienced in exotic species to design a species-appropriate diet and supplementation plan — generic reptile supplements vary widely in vitamin A content and form",
                    "For turtles and tortoises: do not rely on carrots or orange vegetables as primary vitamin A sources; reptiles convert beta-carotene to active vitamin A poorly",
                    "For birds: transition psittacines away from seed-only diets toward a varied diet including dark leafy greens (kale, dandelion, parsley), orange and yellow vegetables (sweet potato, squash, peppers), and a formulated pellet base",
                    "For all captive exotic pets: schedule regular veterinary check-ups including nutritional assessments — deficiency develops silently and early detection substantially improves outcomes",
                    "Do not supplement vitamin A without veterinary guidance — the margin between a corrective dose and a toxic dose is narrow in some species, and hypervitaminosis A (vitamin A toxicity) is a serious condition in its own right",
                    "For small mammals: ensure diet includes varied fresh vegetables; rabbits and guinea pigs benefit from dark leafy greens as a regular dietary component",
                    "Research your specific species' dietary requirements before acquiring any exotic pet — nutritional disease is among the most common causes of preventable illness in captive reptiles and birds"
                ],
                sources: [
                    "Merck Veterinary Manual — Vitamin A Deficiency in Animals",
                    "LafeberVet — Hypovitaminosis A in Birds",
                    "VCA Animal Hospitals — Vitamin A Deficiency in Reptiles",
                    "UC Davis School of Veterinary Medicine — Exotic Animal Care Sheets",
                    "Veterinary Partner — Nutritional Disorders in Pet Birds"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis (Abnormal Shedding)
                    "1D000001-0000-0000-0000-000000000009",  // Thermal Burns
                    "1D000001-0000-0000-0000-000000000040",  // Shell Rot
                    "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
                    "1D000001-0000-0000-0000-000000000043",  // Reptile Husbandry Guide
                    "1D000001-0000-0000-0000-000000000044",  // Bird Husbandry Guide
                    "1D000001-0000-0000-0000-000000000045"   // Small Mammal Husbandry Guide
                ]
            ),

            // MARK: - Shell Rot (Ulcerative Shell Disease)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000040")!,
                name: "Shell Rot (Ulcerative Shell Disease)",
                alternateNames: [
                    "shell rot",
                    "ulcerative shell disease",
                    "SCUD",
                    "septicemic cutaneous ulcerative disease",
                    "shell infection",
                    "shell necrosis",
                    "turtle shell rot",
                    "tortoise shell rot",
                    "shell ulcer"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "shell_rot_thumb",
                description: """
                    Shell rot — clinically known as ulcerative shell disease — is a \
                    progressive infection of a chelonian's shell caused by bacteria, \
                    fungi, or both. It is one of the most common conditions seen in \
                    captive turtles and tortoises, and in most cases it is a direct \
                    consequence of husbandry failures that can be prevented.

                    The shell of a turtle or tortoise is not inert armor — it is living \
                    bone and keratin, richly supplied with blood vessels and nerve \
                    endings. It is directly connected to the animal's spine and ribcage. \
                    What begins as a soft spot, discolored patch, or minor pitting on the \
                    surface can penetrate through the outer keratin layer (scutes) into \
                    the underlying bone, and in severe cases reach the body cavity and \
                    internal organs. A shell infection that reaches this depth is \
                    life-threatening.

                    Shell rot is not contagious — it cannot be transmitted from one \
                    chelonian to another by contact. However, multiple animals sharing a \
                    poorly maintained, chronically damp, or abrasive enclosure may all \
                    develop the condition independently from the same environmental \
                    deficiencies. This can appear to resemble spread, but it reflects \
                    parallel husbandry failure rather than transmission.

                    Aquatic and semi-aquatic turtles are most commonly affected due to \
                    the moisture-rich environments they require. Tortoises and box turtles \
                    are less commonly affected but not immune, particularly when kept in \
                    enclosures that are too humid, too abrasive, or with inadequate \
                    drainage. This entry focuses on chelonians (turtles, tortoises, and \
                    terrapins). Lizards and snakes can develop analogous scale rot and \
                    skin infections, but those conditions have distinct presentations and \
                    are covered separately. Dogs, cats, birds, and small mammals are not \
                    subject to this condition.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    The chelonian shell is composed of two main layers: the outer \
                    keratinized scutes (the visible patterned plates) and the underlying \
                    bone — the carapace on top and the plastron on the underside. Both \
                    layers are vascularized living tissue. The scutes protect the bone, \
                    and the bone protects the organs directly beneath.

                    Shell rot begins when the outer surface is compromised. A small crack \
                    from a fall or bite, chronic softening from excessive moisture, \
                    erosion from an abrasive substrate, or tissue weakness from nutritional \
                    deficiency (particularly calcium and vitamin A) creates an entry point \
                    for opportunistic bacteria and fungi. Once established, the infection \
                    breaks down tissue layer by layer.

                    Early shell rot is confined to the scutes — pitting, softening, \
                    discoloration, and a foul odor are the hallmarks at this stage. The \
                    affected scutes may begin to lift or separate at the edges. If caught \
                    here, outcomes with veterinary treatment are generally good.

                    If the infection penetrates through the scutes into the underlying \
                    bone (osteomyelitis — bone infection), the damage becomes significantly \
                    more serious. The bone becomes porous, discolored, and structurally \
                    compromised. The animal often shows systemic signs of illness at \
                    this stage — lethargy, reduced appetite, and withdrawal.

                    In the most severe cases — particularly with aggressive gram-negative \
                    bacterial infections — the infection breaches the internal surface of \
                    the shell and enters the coelomic cavity (the body cavity equivalent \
                    to the abdomen). Septicemia (a life-threatening whole-body bacterial \
                    infection) can follow, and at this stage the condition is often fatal \
                    even with aggressive treatment.

                    **Not Just Skin Deep — Why the Shell Is an Organ**
                    Most owners understand intuitively that the shell is important, but \
                    fewer appreciate just how anatomically integrated it is. A chelonian's \
                    spine and ribs are fused directly into the carapace. The shell is not \
                    worn like a house — it is part of the skeleton. Nerves run through it, \
                    blood vessels supply it, and it can register pain. A chelonian with \
                    shell rot is not merely disfigured — it is living with an infected bone \
                    that is attached to its spine. This is why seemingly minor discoloration \
                    or softness on the surface always warrants veterinary evaluation rather \
                    than a wait-and-see approach.

                    **Causes & Risk Factors**
                    • **Chronic moisture and poor drainage (aquatic/semi-aquatic turtles)** \
                    — aquatic turtles require clean water, but they also require a dry \
                    basking area they can fully exit the water onto. A turtle that cannot \
                    dry its shell completely every day is at significant risk. Stagnant, \
                    soiled water dramatically increases bacterial load.

                    • **Trauma** — shell fractures, chips, or bite wounds from tank mates \
                    create immediate entry points for infection. Even small cracks that \
                    appear superficial should be evaluated by a veterinarian; what is \
                    visible on the surface rarely represents the full extent of damage.

                    • **Abrasive substrate** — sharp gravel, rough rock surfaces, or \
                    inappropriate substrate that repeatedly scratches the shell surface \
                    creates microabrasions that accumulate into significant damage over time.

                    • **Nutritional deficiencies** — calcium deficiency produces soft, \
                    pliable shells in young chelonians that are structurally vulnerable to \
                    compression and abrasion. Vitamin A deficiency impairs the integrity \
                    of the epithelial tissue lining the scutes. Both conditions dramatically \
                    increase shell rot risk when combined with environmental stressors.

                    • **Poor water quality (aquatic turtles)** — high bacterial counts in \
                    unchlorinated, unfiltered, or infrequently changed water expose the \
                    shell surface to continuous bacterial pressure. Gram-negative bacteria \
                    including Pseudomonas and Aeromonas species are common causative \
                    agents and thrive in warm, stagnant, waste-laden water.

                    • **Overcrowding and bite wounds** — turtles housed together may bite \
                    each other's shells, particularly during feeding competition. Each bite \
                    wound is a potential infection site.

                    • **Low temperatures** — chelonians are ectotherms (cold-blooded); \
                    their immune systems function optimally only within their species-\
                    appropriate temperature range. Animals kept too cold are immunosuppressed \
                    and significantly less able to resist opportunistic infection.

                    **Treatment Goals**
                    Veterinary treatment focuses on debriding (removing) infected and \
                    necrotic (dead) shell tissue to halt the spread of infection, \
                    controlling bacterial and fungal infection, supporting the animal's \
                    immune system, and addressing the underlying husbandry deficiencies \
                    that allowed the condition to develop. In cases where the infection \
                    has reached the bone, treatment is more extensive and recovery is \
                    prolonged. Shell tissue can regenerate over time with appropriate care, \
                    but deep bone loss may result in permanent structural changes. Early \
                    veterinary intervention significantly improves outcomes.

                    **Myths vs. Facts**
                    **Myth:** \u{201C}It\u{2019}s just a small soft spot — I\u{2019}ll keep an eye on it.\u{201D}
                    **Fact:** Shell rot progresses beneath the surface faster than it \
                    appears to externally. By the time a soft spot is visibly worsening, \
                    infection may already be deeper than it looks. Early veterinary \
                    evaluation is always the correct response to any new softness, \
                    discoloration, pitting, or odor on the shell.

                    **Myth:** \u{201C}I cleaned it with iodine/hydrogen peroxide, so it should heal.\u{201D}
                    **Fact:** Surface antiseptics do not penetrate infected shell tissue \
                    effectively and can damage surrounding healthy tissue. Shell rot \
                    requires professional debridement and targeted treatment — topical \
                    home antiseptics are not a substitute for veterinary care.

                    **Myth:** \u{201C}My other turtle is fine, so it can\u{2019}t be the enclosure.\u{201D}
                    **Fact:** Individual animals respond differently to the same \
                    environmental stressors. One turtle developing shell rot in a shared \
                    enclosure is a signal to evaluate the entire setup — the other \
                    animal may develop the same problem, or may simply not have reached \
                    the threshold yet.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Early shell rot can develop over days to weeks from the point of initial shell compromise or chronic husbandry deficiency. First signs — a small soft area, slight discoloration, pitting, or faint odor — are easily missed without regular hands-on shell inspection.",
                    delayed: "Without treatment, infection spreads progressively deeper through the scutes and into underlying bone. Bone involvement may develop over weeks to months. Systemic illness and life-threatening septicemia can follow if the infection penetrates the body cavity."
                ),
                symptoms: [
                    "Soft, pliable, or spongy area on the shell (carapace or plastron)",
                    "Discoloration — white, yellow, gray, or dark patches on the shell",
                    "Pitting or pockmarks on the shell surface",
                    "Lifting, separating, or flaking scutes (shell plates)",
                    "Foul or unusual odor from the shell",
                    "Bloody or discharge-producing areas on the shell",
                    "Lethargy and withdrawal (suggests deeper infection)",
                    "Loss of appetite",
                    "Swelling around the shell margin"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Chelonians (turtles, tortoises, and terrapins) are the affected group. Aquatic and semi-aquatic turtles — including red-eared sliders, painted turtles, and map turtles — are most commonly affected due to chronic moisture exposure. Tortoises and box turtles are also susceptible. Life-threatening if infection reaches the bone or body cavity. Snakes and lizards can develop scale rot, a related but distinct condition."
                    )
                ],
                preventionTips: [
                    "Ensure aquatic and semi-aquatic turtles have a dry, accessible basking area that allows the shell to dry completely every day — this is non-negotiable for preventing chronic moisture damage",
                    "Maintain clean, filtered water with regular water changes; bacterial load in soiled water is a primary driver of shell infections in aquatic turtles",
                    "Choose smooth, non-abrasive substrate and décor; sharp edges and rough gravel create microabrasions that accumulate into infection risk over time",
                    "Provide species-appropriate temperatures at all times — chelonians kept too cold are immunosuppressed and cannot resist opportunistic infection",
                    "Ensure diet provides adequate calcium and vitamin A; nutritional deficiencies produce structurally vulnerable shells and impair immune function",
                    "Perform regular hands-on shell inspections — run a finger gently over the entire carapace and plastron to detect early softness, discoloration, or pitting before it becomes visible to the eye alone",
                    "Any shell crack, bite wound, or chip should be evaluated by a veterinarian promptly — do not wait for visible worsening",
                    "House compatible animals together and avoid overcrowding; bite wounds are a common shell rot entry point in communal enclosures",
                    "Wash hands thoroughly after handling any chelonian with suspected or confirmed shell rot; opportunistic bacteria involved (including Pseudomonas and Aeromonas species) can pose a risk to immunocompromised individuals"
                ],
                sources: [
                    "Merck Veterinary Manual — Shell Diseases in Reptiles",
                    "VCA Animal Hospitals — Shell Rot in Turtles",
                    "LafeberVet — Ulcerative Shell Disease in Chelonians",
                    "Veterinary Partner — Turtle and Tortoise Shell Problems"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis (Abnormal Shedding)
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
            ),

            // MARK: - Stomatitis / Mouth Rot (Infectious Stomatitis)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000041")!,
                name: "Stomatitis / Mouth Rot (Infectious Stomatitis)",
                alternateNames: [
                    "mouth rot",
                    "stomatitis",
                    "infectious stomatitis",
                    "ulcerative stomatitis",
                    "necrotic stomatitis",
                    "reptile mouth rot",
                    "snake mouth rot",
                    "lizard mouth rot",
                    "gum rot",
                    "oral rot"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "mouth_rot_thumb",
                description: """
                    Mouth rot — clinically known as infectious stomatitis or ulcerative \
                    stomatitis — is a bacterial infection of the oral cavity affecting \
                    reptiles. It is one of the most common conditions seen in captive \
                    snakes and lizards, and in the vast majority of cases it is a \
                    direct consequence of husbandry deficiencies that compromise the \
                    animal's immune defenses. Left untreated, it can progress from a \
                    localized oral infection to a life-threatening systemic illness.

                    Unlike stomatitis in dogs, cats, or humans — which often has immune-\
                    mediated or dental causes — mouth rot in reptiles is almost always a \
                    secondary infection. The underlying problem is not the bacteria \
                    themselves, but the conditions that allowed bacteria to gain a \
                    foothold: temperatures too low for the immune system to function, \
                    chronic stress, nutritional deficiencies, or physical trauma to the \
                    mouth. Correct the husbandry, and the predisposing conditions \
                    resolve. Treat the infection without correcting the husbandry, \
                    and recurrence is likely.

                    The condition is not contagious in the traditional sense — a healthy \
                    reptile with appropriate husbandry will not contract mouth rot from a \
                    tank mate. However, multiple animals sharing a poorly maintained \
                    enclosure may all develop the condition from the same environmental \
                    deficiencies.

                    Snakes and lizards are most commonly affected. Chelonians (turtles \
                    and tortoises) can also develop oral infections, though they present \
                    less frequently. Dogs, cats, birds, and small mammals are not subject \
                    to this condition. No vaccine exists or is applicable.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**
                    Reptiles carry a natural population of gram-negative bacteria in their \
                    oral cavity — species including Pseudomonas, Aeromonas, Klebsiella, \
                    and Salmonella are commonly found in the healthy reptile mouth. Under \
                    normal conditions, a functioning immune system keeps these bacteria in \
                    check. When immune function is suppressed — most often by chronic low \
                    temperatures, stress, or nutritional deficiency — the balance shifts \
                    and these opportunistic bacteria begin to proliferate unchecked.

                    Early mouth rot affects the gingival tissue (gums) and the mucous \
                    membranes lining the mouth. The tissue becomes inflamed, reddened, \
                    and begins to develop petechiae (pinpoint hemorrhages — small red \
                    dots). A characteristic caseous (cheese-like or cottage cheese-like) \
                    discharge accumulates in the oral cavity. This material is a mixture \
                    of dead tissue, bacteria, and inflammatory cells, and its presence is \
                    one of the most recognizable signs of the condition.

                    As the infection progresses, the tissue becomes necrotic (dies) and \
                    the infection spreads deeper into the gums, bones of the jaw, and \
                    palate. Teeth may loosen and fall out. In snakes, the infection can \
                    spread posteriorly into the trachea and lungs, producing a respiratory \
                    infection (pneumonia) as a serious secondary complication. In advanced \
                    cases the bacteria enter the bloodstream — septicemia (a life-\
                    threatening whole-body bacterial infection) — and the infection can \
                    seed internal organs. At this stage the condition can be rapidly fatal.

                    **The Open Mouth That Should Be Closed**
                    Healthy reptiles breathe with their mouths closed. A reptile — \
                    particularly a snake — that is repeatedly observed with its mouth \
                    slightly open, or that is holding its head in an elevated or unusual \
                    position, may be doing so because oral inflammation and caseous \
                    discharge are physically preventing normal jaw closure. This is \
                    not a quirk or a behavioral habit. An open-mouthed snake that is \
                    not in the middle of eating or yawning is showing a classic warning \
                    sign that warrants prompt veterinary evaluation.

                    **Causes & Risk Factors**
                    • **Suboptimal temperatures** — the single most common predisposing \
                    factor. Reptile immune systems are directly temperature-dependent; \
                    they function within a narrow optimal range specific to each species. \
                    A reptile kept chronically below its preferred body temperature has a \
                    suppressed immune system regardless of how clean the enclosure appears. \
                    This is why mouth rot is so frequently seen in winter, or after a \
                    thermostat failure, or in animals in enclosures that have never been \
                    correctly set up thermally.

                    • **Chronic stress** — inappropriate housing, excessive handling, \
                    predator scent exposure (e.g., housing prey animals nearby), \
                    overcrowding, or incompatible tank mates all generate chronic stress \
                    that suppresses immune function over time.

                    • **Oral trauma** — snakes that strike the glass or walls of their \
                    enclosure repeatedly (a behavior called \u{201C}glass surfing\u{201D} driven by \
                    stress or hunger), or that injure their mouth during feeding on prey \
                    items that are too large, create micro-wounds that become immediate \
                    infection entry points. Rough handling that causes the animal to bite \
                    the handler and injure its own mouth is another common cause.

                    • **Nutritional deficiency** — particularly vitamin A deficiency, \
                    which impairs the integrity of the mucous membranes lining the oral \
                    cavity. A reptile with underlying hypovitaminosis A is significantly \
                    more vulnerable to oral infection. Calcium deficiency also weakens \
                    jaw bone structure.

                    • **Pre-existing illness** — any condition that weakens the animal \
                    generally — parasitism, respiratory infection, or other concurrent \
                    disease — reduces the immune reserve available to resist opportunistic \
                    oral bacteria.

                    • **Inadequate hygiene** — soiled substrate, fecal contamination, \
                    or old food debris in the enclosure increases bacterial load and \
                    provides an ongoing source of pathogen exposure.

                    **Treatment Goals**
                    Veterinary treatment focuses on removing caseous oral debris under \
                    appropriate conditions, controlling the bacterial infection, managing \
                    pain, providing nutritional support for animals that have stopped \
                    eating, and — critically — identifying and correcting the underlying \
                    husbandry deficiencies that allowed the condition to develop. In \
                    advanced cases where the infection has spread to the jaw bones, \
                    lungs, or bloodstream, treatment is significantly more intensive. \
                    Early veterinary intervention substantially improves outcomes; \
                    delayed treatment allows the infection to penetrate deeper structures \
                    from which recovery is far more difficult.

                    **Myths vs. Facts**
                    **Myth:** \u{201C}I cleaned the mouth out with a cotton swab, so I\u{2019}ve treated it.\u{201D}
                    **Fact:** Removing visible caseous discharge at home does not address \
                    the infection in the underlying tissue, does not correct the \
                    temperature or husbandry deficiencies driving the condition, and \
                    creates a risk of further oral trauma during the process. Veterinary \
                    debridement and targeted treatment are required; home cleaning is not \
                    a substitute.

                    **Myth:** \u{201C}My reptile is still eating, so it can\u{2019}t be that serious.\u{201D}
                    **Fact:** Some reptiles continue eating in early or moderate stages \
                    of mouth rot. Continued eating does not indicate the infection is \
                    resolving — it indicates the animal has not yet reached the stage \
                    where oral pain prevents feeding. Loss of appetite in a reptile with \
                    mouth rot signals significant progression.

                    **Myth:** \u{201C}It will clear up on its own if I improve the husbandry.\u{201D}
                    **Fact:** Correcting husbandry is essential — but it is not \
                    sufficient once a bacterial infection is established in oral tissue. \
                    The infection will not resolve without veterinary treatment. \
                    Improving husbandry prevents recurrence; it does not cure an \
                    active infection.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Early signs — reddening of the gums, pinpoint hemorrhages in the oral tissue, and slight swelling — can appear within days of immune compromise. Early-stage mouth rot may be detectable only during routine handling when the mouth is briefly visible.",
                    delayed: "Without treatment, caseous (cheese-like) discharge accumulates in the oral cavity, tissue becomes necrotic, and the infection spreads deeper into jaw structures and potentially to the lungs and bloodstream. Advanced cases can deteriorate rapidly over days to weeks."
                ),
                symptoms: [
                    "Redness, swelling, or bleeding of the gums",
                    "White, yellow, or gray caseous (cheese-like) discharge in the mouth",
                    "Holding the mouth open or slightly agape — especially in snakes",
                    "Reluctance to eat or complete refusal of food",
                    "Rubbing the face or mouth against enclosure surfaces",
                    "Loose or missing teeth",
                    "Swelling of the jaw or face",
                    "Mucus or discharge from the mouth or nostrils",
                    "Lethargy and reduced activity",
                    "Labored or audible breathing (suggests spread to the lungs)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Snakes and lizards are most commonly affected and can deteriorate rapidly without treatment. Chelonians (turtles and tortoises) are also susceptible but present less frequently. Can progress from localized oral infection to jaw bone involvement, pneumonia, or fatal septicemia. Husbandry correction is essential alongside veterinary treatment to prevent recurrence."
                    )
                ],
                preventionTips: [
                    "Maintain species-appropriate temperatures consistently — reptile immune function is directly temperature-dependent; a reptile kept too cold is immunosuppressed regardless of other husbandry factors",
                    "Provide a proper thermal gradient so the animal can thermoregulate — one end of the enclosure should allow the animal to reach its preferred body temperature; the other end should be cooler",
                    "Use a quality thermostat and thermometer, and check temperatures regularly — thermostat failures are a common trigger for husbandry-related illness",
                    "Minimize stress: provide adequate hide spots, avoid overcrowding, limit handling to appropriate frequency, and do not house prey species nearby",
                    "Feed appropriately sized prey items — prey that is too large increases the risk of oral trauma during feeding; a mouse or rat wider than the widest part of the snake's body is too large",
                    "If the animal repeatedly strikes the enclosure walls, address the underlying cause (hunger, stress, enclosure too small) rather than accepting the behavior as normal",
                    "Maintain clean substrate and remove waste promptly to reduce bacterial load in the enclosure",
                    "Ensure diet supports immune function — species-appropriate vitamin and mineral supplementation, including vitamin A, should be discussed with an exotic animal veterinarian",
                    "Perform regular hands-on oral inspection during handling — gently opening the mouth to observe gum color and check for early discharge allows early detection before the condition advances",
                    "Wash hands thoroughly after handling any reptile — Salmonella and other gram-negative bacteria present in the reptile oral cavity and gut are transmissible to humans"
                ],
                sources: [
                    "Merck Veterinary Manual — Stomatitis in Reptiles",
                    "VCA Animal Hospitals — Mouth Rot in Reptiles",
                    "LafeberVet — Infectious Stomatitis in Reptiles",
                    "Veterinary Partner — Reptile Stomatitis"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis (Abnormal Shedding)
                    "1D000001-0000-0000-0000-000000000033",  // Snake Mites
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000040",  // Shell Rot
                    "1D000001-0000-0000-0000-000000000042",  // Reptile Respiratory Infections
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
            ),

            // MARK: - Reptile Respiratory Infections
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000042")!,
                name: "Reptile Respiratory Infections",
                alternateNames: [
                    "Snake Pneumonia",
                    "Lizard Respiratory Infection",
                    "Reptile Pneumonia",
                    "Ophidian Paramyxovirus",
                    "OPMV",
                    "Fer-de-Lance Virus",
                    "Ferlavirus",
                    "Nidovirus",
                    "Nannizziopsis",
                    "Yellow Fungus Disease",
                    "Snake URI",
                    "Reptile URI",
                    "Upper Respiratory Infection",
                    "Respiratory Infection"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "reptile_respiratory_thumb",
                description: """
                    Respiratory infections are among the most common illnesses seen in captive \
                    reptiles — affecting snakes, lizards, and chelonians (turtles and tortoises). \
                    Most cases are caused by opportunistic bacteria such as Pseudomonas, Aeromonas, \
                    and Klebsiella that exploit husbandry failures — most often inadequate \
                    temperatures, excess humidity, poor ventilation, or chronic stress. A smaller \
                    but far more dangerous subset is caused by viruses including ophidian \
                    paramyxovirus (OPMV), nidovirus, and adenovirus, which act as primary \
                    pathogens and can cause rapidly progressive, life-threatening disease. Fungal \
                    pathogens — most notably Aspergillus species and Nannizziopsis species — \
                    represent a third, less common but often severe category, typically arising \
                    in immunocompromised individuals.

                    Bacterial and fungal pneumonia are not contagious between animals — they arise \
                    from each individual animal's own opportunistic flora or environmental spore \
                    exposure when the immune system is compromised. Viral infections, by contrast, \
                    are highly contagious and can spread rapidly through a collection. There is no \
                    vaccine available for any reptile respiratory pathogen.

                    This entry covers the full spectrum from common bacterial pneumonia to severe \
                    viral and fungal disease. Snakes are most commonly and severely affected, \
                    though lizards and chelonians are also susceptible. Open-mouth breathing in a \
                    reptile is never normal and always warrants prompt veterinary evaluation.
                    """,
                toxicityInfo: """
                    **Breathing in Cold Blood**
                    Reptiles are ectotherms — they rely on their environment to regulate body \
                    temperature rather than generating heat internally. This has profound \
                    consequences for immune function. A reptile's immune cells operate most \
                    effectively within its species-specific preferred optimal temperature zone \
                    (POTZ). When temperatures fall below this range, immune activity slows \
                    significantly. A sick reptile in a too-cool enclosure is literally unable to \
                    mount an effective defense against infection — bacterial, viral, or fungal.

                    This connection between temperature and immunity explains why husbandry \
                    correction — restoring proper thermal gradients — is not merely background \
                    advice but an essential component of treatment. It also explains why \
                    respiratory infections can deteriorate rapidly in animals already stressed \
                    by suboptimal conditions.

                    **How It Harms the Body**
                    In bacterial pneumonia, gram-negative organisms colonize the lower airways \
                    and lung tissue when immune surveillance is impaired. Unlike mammals, reptiles \
                    have limited respiratory clearance mechanisms — they lack an effective cough \
                    reflex and have reduced mucociliary function. Mucus, inflammatory debris, \
                    and bacteria accumulate in the airways, impairing gas exchange and creating \
                    conditions for further bacterial proliferation.

                    Viral infections cause more direct and severe damage. Ophidian paramyxovirus \
                    (OPMV), also called Ferlavirus, was first identified in Fer-de-Lance vipers \
                    (Bothrops spp.) — hence its common name. It infects both respiratory \
                    epithelium and neural tissue, which is why affected snakes often show a \
                    combination of breathing difficulty and neurological signs such as star-gazing \
                    and loss of the righting reflex. This overlap with the neurological \
                    presentation of Inclusion Body Disease (IBD) can make clinical differentiation \
                    challenging without diagnostic testing. Nidovirus, increasingly recognized in \
                    ball pythons and other pythonids, causes severe necrotizing pneumonia with \
                    thick mucus production and can progress rapidly to respiratory failure. \
                    Adenovirus causes respiratory and hepatic disease across a range of species \
                    and may co-infect alongside other pathogens.

                    Fungal respiratory infections are less common but frequently severe. Aspergillus \
                    species — the same genus responsible for aspergillosis in birds — can infect \
                    reptile airways when spore loads are high or immune function is significantly \
                    depressed. Nannizziopsis species (associated with Yellow Fungus Disease in \
                    bearded dragons and other agamids) primarily cause destructive skin and tissue \
                    disease, but in severe cases can disseminate internally and involve the \
                    respiratory tract. Fungal infections are difficult to diagnose on clinical \
                    signs alone, often progress insidiously, and typically require prolonged \
                    veterinary-directed antifungal treatment that differs fundamentally from \
                    antibacterial therapy — making accurate diagnosis essential.

                    **Transmission & Spread**
                    Bacterial and fungal pneumonia are not directly contagious between animals. \
                    Bacterial infections arise from each individual's own commensal flora under \
                    conditions of immune suppression; fungal infections arise from environmental \
                    spore exposure in a similarly immunocompromised host. Each affected animal \
                    represents its own husbandry or immune problem — not a contagion event.

                    Viral pathogens are a different matter entirely. OPMV and nidovirus spread \
                    through direct contact, respiratory secretions, and fomites — contaminated \
                    surfaces, shared equipment, and unwashed hands. Infected animals may shed \
                    virus before clinical signs appear, making early detection difficult. \
                    Once introduced to a collection, these viruses can spread rapidly, and \
                    there is no specific antiviral treatment available. Strict quarantine of \
                    all new animals — for a minimum of 90 days — and immediate isolation of \
                    any symptomatic animal are the only effective defenses.

                    **Treatment Goals**
                    Treatment is directed entirely by a veterinarian. For bacterial infections, \
                    goals include correcting husbandry deficiencies, providing supportive care \
                    such as fluid therapy and nutritional support, and systemic antimicrobial \
                    treatment guided by culture and sensitivity results. Nebulization therapy \
                    may be used to deliver medications directly to the airways and help clear \
                    accumulated secretions. For fungal infections, treatment goals similarly \
                    include husbandry correction and supportive care, alongside antifungal \
                    therapy — a distinct category of medication that must be prescribed and \
                    monitored by a veterinarian. For viral infections, there is no specific \
                    treatment — management is supportive, and outcomes depend heavily on the \
                    pathogen involved and how early veterinary care was sought. Early \
                    intervention for any respiratory infection significantly improves the \
                    chances of recovery.

                    **Myths vs. Facts**
                    **Myth:** \u{201C}Open-mouth breathing just means my snake is too warm.\u{201D}
                    **Fact:** A reptile may briefly gape when severely overheated, but sustained \
                    open-mouth breathing in a correctly-temperatured enclosure is a classic sign \
                    of respiratory distress. Any reptile gaping repeatedly or persistently \
                    requires veterinary evaluation — it is not normal behavior to dismiss.

                    **Myth:** \u{201C}My reptile is still eating, so it can\u{2019}t be that sick.\u{201D}
                    **Fact:** Many reptiles, particularly snakes, continue eating in the early \
                    stages of a respiratory infection. Continued feeding does not rule out \
                    significant disease. By the time anorexia develops, the infection is often \
                    well advanced.

                    **Myth:** \u{201C}I\u{2019}ll just warm up the enclosure and wait to see if it clears.\u{201D}
                    **Fact:** Improving temperature is a necessary first step — but it is not \
                    treatment. Bacterial infections require antimicrobials; fungal infections \
                    require antifungal therapy; viral infections require veterinary-directed \
                    supportive care. Delaying evaluation allows infections to progress and \
                    narrows the window for effective treatment.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Bacterial and fungal infections often develop gradually over days to weeks. Early signs may be subtle: a slight increase in nasal mucus, mild lethargy, or reduced appetite. Viral infections can progress more rapidly — sometimes within days of exposure.",
                    delayed: "Advanced disease includes persistent open-mouth breathing, audible wheezing or crackling, significant mucus discharge from the mouth or nostrils, severe weight loss, and inability to maintain normal posture. In viral infections, neurological signs — star-gazing, head tremors, loss of the righting reflex — may develop alongside respiratory deterioration."
                ),
                symptoms: [
                    "Open-mouth breathing (gaping)",
                    "Wheezing, clicking, or crackling sounds when breathing",
                    "Mucus or discharge from the nostrils or mouth",
                    "Lethargy and reduced activity",
                    "Loss of appetite",
                    "Upward head positioning to help drain respiratory secretions",
                    "Labored or rapid breathing",
                    "Weight loss",
                    "Star-gazing, head tremors, or loss of righting reflex (viral infections)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .severe,
                        notes: "Snakes are most commonly and severely affected — particularly boids (ball pythons, boa constrictors) and viperids. Viral pathogens (OPMV, nidovirus) drive the severe rating and can cause rapid respiratory failure. Lizards and chelonians are primarily affected by bacterial and fungal pneumonia, which are serious but more treatable with prompt veterinary care. The severe rating reflects the worst-case viral presentation."
                    )
                ],
                preventionTips: [
                    "Maintain correct temperature gradients with a hot spot appropriate for the species — thermal regulation is essential for immune function",
                    "Keep humidity at species-appropriate levels; excessive moisture promotes bacterial and fungal growth in the respiratory tract",
                    "Provide adequate enclosure ventilation while avoiding cold drafts",
                    "Quarantine all new reptiles for a minimum of 90 days before any contact with established animals",
                    "Isolate any animal showing signs of respiratory illness immediately — viral pathogens spread through direct contact and shared surfaces",
                    "Use dedicated equipment for each animal (feeding tongs, water dishes, cleaning tools) and disinfect thoroughly between uses",
                    "Wash hands thoroughly after handling any reptile or cleaning its enclosure",
                    "Schedule regular veterinary checkups — early respiratory infections may not be obvious to owners, and prompt treatment significantly improves outcomes"
                ],
                sources: [
                    "Merck Veterinary Manual — Respiratory Diseases of Reptiles: https://www.merckvetmanual.com/exotic-and-laboratory-animals/reptiles/respiratory-diseases-of-reptiles",
                    "LafeberVet — Respiratory Diseases in Snakes: https://lafeber.com/vet/respiratory-diseases-in-snakes/",
                    "Veterinary Partner — Reptile Health Resources: https://veterinarypartner.vin.com/",
                    "UC Davis School of Veterinary Medicine — Exotic Animal Resources: https://www.vetmed.ucdavis.edu/hospital/small-animal/ccr/exotics",
                    "Wikipedia — Ferlavirus (Ophidian Paramyxovirus): https://en.wikipedia.org/wiki/Ferlavirus",
                    "Wikipedia — Nannizziopsis vriesii (Yellow Fungus Disease): https://en.wikipedia.org/wiki/Nannizziopsis_vriesii"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000034",  // Inclusion Body Disease (IBD)
                    "1D000001-0000-0000-0000-000000000033",  // Snake Mites
                    "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000043"   // Reptile Husbandry Guide
                ]
            ),

            // MARK: - Reptile Husbandry Guide
            // Type 4 (Husbandry Guide)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000043")!,
                name: "Reptile Husbandry Guide",
                alternateNames: [
                    "reptile care", "reptile care guide", "reptile care sheet",
                    "reptile setup", "reptile husbandry", "snake care", "lizard care",
                    "turtle care", "tortoise care", "bearded dragon care",
                    "ball python care", "corn snake care", "leopard gecko care",
                    "crested gecko care", "chameleon care", "blue tongue skink care",
                    "iguana care", "gecko care", "boa care", "monitor lizard care",
                    "water dragon care", "anole care", "reptile enclosure setup",
                    "reptile vivarium", "reptile lighting", "reptile heating",
                    "UVB reptile", "reptile substrate", "reptile feeding",
                    "reptile humidity", "reptile thermostat", "reptile quarantine",
                    "new reptile owner", "reptile beginner"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "reptile_husbandry_thumb",
                description: """
                    This guide covers the foundational care requirements for commonly \
                    kept pet reptiles \u{2014} including snakes, lizards, and chelonians \
                    (turtles and tortoises). It is designed for new owners preparing a \
                    setup before bringing an animal home, as well as experienced keepers \
                    looking to audit or improve their husbandry.

                    Pet reptiles in this category span a wide range of species, each with \
                    specific needs. Snakes commonly kept as pets include ball pythons, corn \
                    snakes, boa constrictors, and king snakes. Popular lizards include \
                    bearded dragons, leopard geckos, crested geckos, blue-tongued skinks, \
                    chameleons, and green iguanas. Chelonians include red-eared sliders, \
                    box turtles, sulcata tortoises, Russian tortoises, and other aquatic, \
                    semi-aquatic, and terrestrial species.

                    The majority of health problems seen in captive reptiles \u{2014} \
                    respiratory infections, metabolic bone disease, shedding difficulties, \
                    stomatitis, and nutritional deficiencies \u{2014} are directly caused \
                    by preventable husbandry failures. Correct enclosure setup, appropriate \
                    temperatures, proper lighting, and species-appropriate nutrition are not \
                    optional extras; they are the foundation of a healthy animal. A reptile \
                    that appears healthy may be in early-stage decline if the fundamentals \
                    are wrong.

                    This guide provides general guidance applicable across the reptile pet \
                    trade. Individual species requirements vary significantly \u{2014} the \
                    needs of a ball python and a chameleon, for example, are almost entirely \
                    different. Always research your specific species in detail, and consult \
                    a veterinarian with experience in reptile medicine for personalized \
                    guidance.
                    """,
                toxicityInfo: """
                    Reptiles are among the most misunderstood pets in the hobby. They are \
                    often perceived as low-maintenance, but in reality they have complex \
                    environmental and nutritional needs that must be met precisely to prevent \
                    illness. This guide covers the core areas of reptile husbandry \u{2014} \
                    enclosure setup, temperature, lighting, humidity, diet, handling, and \
                    veterinary care \u{2014} with species-specific examples for snakes, \
                    lizards, and chelonians throughout.

                    **Enclosure & Habitat**
                    The enclosure is a reptile\u{2019}s entire world, and getting it right \
                    is the single most important thing an owner can do. At minimum, most \
                    reptiles need an enclosure large enough to allow full body extension plus \
                    room to explore \u{2014} for snakes, that means the combined length and \
                    width of the enclosure should equal or exceed the snake\u{2019}s body \
                    length. Many species require significantly more space.

                    Enclosure type matters. Glass terrariums with screen tops work well for \
                    many lizards and snakes but lose humidity quickly \u{2014} a \
                    consideration for tropical species. PVC or wood enclosures retain heat \
                    and humidity better and are preferred for many snakes and high-humidity \
                    lizards. Chelonians have varied needs: aquatic turtles require deep water \
                    filtration systems, while tortoises need large dry enclosures \u{2014} \
                    or outdoor pens where climate allows.

                    Substrate should match the species\u{2019} natural environment. Desert \
                    species such as bearded dragons and leopard geckos do well on \
                    loose particle-free substrates or tile; tropical snakes and lizards \
                    benefit from coconut fiber or bioactive soil mixes that retain humidity. \
                    Avoid cedar and pine wood shavings \u{2014} the aromatic oils are toxic \
                    to reptiles. A physical hide is essential for all species \u{2014} most \
                    should have at least two: one on the warm side and one on the cool side \
                    of the enclosure. Arboreal species such as crested geckos and chameleons \
                    need vertical space with climbing branches and foliage. Fossorial species \
                    such as some skinks and hognose snakes need deep substrate for burrowing.

                    **Temperature & Lighting**
                    Reptiles are ectotherms \u{2014} they cannot generate body heat \
                    internally and depend entirely on external sources to regulate their body \
                    temperature. This is not a limitation to work around; it is the core of \
                    how their physiology functions. Temperature affects immune function, \
                    digestion, metabolism, and mood. A reptile kept too cold cannot digest \
                    food properly, cannot fight infection effectively, and will become \
                    lethargic and ill.

                    Every reptile enclosure must provide a thermal gradient: a warm end, a \
                    cool end, and a basking spot at the warm end where the animal can raise \
                    its body temperature to its preferred optimal temperature zone. Basking \
                    spot temperatures vary widely \u{2014} bearded dragons require a basking \
                    surface of around 100\u{2013}110\u{00B0}F, while ball pythons need a \
                    warm side ambient of around 88\u{2013}92\u{00B0}F and do not require a \
                    hot basking spot. Leopard geckos need a warm side around \
                    88\u{2013}92\u{00B0}F. Most chelonians require basking areas of \
                    85\u{2013}95\u{00B0}F depending on species. The cool end of all \
                    enclosures should drop to species-appropriate ambient temperatures so \
                    the animal can actively cool itself.

                    All heat sources must be controlled by a thermostat. Unregulated heat \
                    sources \u{2014} including older-style heat rocks \u{2014} are one of \
                    the leading causes of thermal burns in reptiles. Heat can be provided \
                    by ceramic heat emitters, halogen basking bulbs, radiant heat panels, \
                    or heat mats used under-tank for species that benefit from belly heat, \
                    always with a thermostat.

                    UVB lighting is essential for most diurnal lizards and all chelonians. \
                    UVB allows reptiles to synthesize vitamin D3 in the skin \u{2014} \
                    without it, calcium metabolism fails, leading to metabolic bone disease. \
                    Bearded dragons, chameleons, iguanas, blue-tongued skinks, and tortoises \
                    all require high-output UVB. UVB output degrades over time \u{2014} most \
                    bulbs should be replaced every 6\u{2013}12 months even if they are still \
                    emitting visible light. Some nocturnal lizards (leopard geckos, crested \
                    geckos) and most snakes do not require UVB to survive, but evidence \
                    increasingly supports that low-level UVB is beneficial even for these \
                    species. Maintain a consistent photoperiod of 12\u{2013}14 hours of \
                    light in summer and 10\u{2013}12 hours in winter to mimic natural cycles \
                    and support normal behavior.

                    **Humidity**
                    Humidity requirements vary dramatically between reptile species and must \
                    be researched for each specific animal. Desert species such as bearded \
                    dragons and leopard geckos thrive at 30\u{2013}40% relative humidity; \
                    maintaining them above 50% consistently can predispose them to \
                    respiratory infections. Tropical species such as ball pythons, crested \
                    geckos, and green iguanas require 60\u{2013}80% humidity; dropping below \
                    this chronically causes shedding problems and skin irritation. Many \
                    chelonians fall in the middle \u{2014} Russian tortoises tolerate drier \
                    conditions while box turtles require humid hides and higher ambient \
                    humidity.

                    Always measure humidity with a digital hygrometer \u{2014} guessing is \
                    unreliable. Humidity can be raised by misting the enclosure, adding a \
                    water feature, using a moisture-retaining substrate, or reducing \
                    ventilation slightly. It can be lowered by increasing ventilation, using \
                    non-moisture-retaining substrate, or reducing misting frequency.

                    During shedding, all reptiles benefit from a slightly elevated humidity \
                    level and access to a humid hide \u{2014} a small enclosed space with \
                    moist moss or substrate. Low humidity is one of the most common causes \
                    of retained shed, which can constrict blood flow to digits, tails, and \
                    eye caps if not resolved. Too-high humidity in combination with poor \
                    ventilation promotes bacterial and fungal growth \u{2014} including the \
                    pathogens responsible for respiratory infections and shell rot in \
                    chelonians.

                    **Diet & Nutrition**
                    Reptile diets fall into three broad categories \u{2014} carnivores, \
                    insectivores, and herbivores/omnivores \u{2014} and feeding a reptile \
                    the wrong diet is a reliable path to nutritional disease.

                    Snakes are obligate carnivores and are fed whole prey: mice, rats, \
                    chicks, and other appropriately sized prey items. Always feed \
                    pre-killed or frozen/thawed prey \u{2014} live prey can injure or even \
                    kill a snake. Feeding frequency varies with age: young snakes typically \
                    eat every 5\u{2013}7 days, while adults may eat every 10\u{2013}14 \
                    days. Monitor body condition \u{2014} visible spine and ribs indicates \
                    underfeeding; a heavy visible fold along the sides indicates overfeeding.

                    Most commonly kept lizards are insectivores, at least in part. Bearded \
                    dragons eat insects as juveniles (roughly 70% insects, 30% greens) and \
                    transition to primarily greens as adults (70% greens, 30% insects). \
                    Leopard geckos and crested geckos are primarily insectivorous throughout \
                    their lives. All insects fed to reptiles should be gut-loaded \u{2014} \
                    fed a nutritious diet for 24\u{2013}48 hours before being offered to the \
                    reptile \u{2014} and dusted with calcium and vitamin supplements \
                    immediately before feeding. Suitable feeder insects include crickets, \
                    dubia roaches, hornworms, black soldier fly larvae, and silkworms. \
                    Mealworms and superworms are high in fat and should be offered as \
                    occasional treats only.

                    Herbivorous and omnivorous lizards (iguanas, uromastyx, adult bearded \
                    dragons) and most tortoises should receive a varied diet of dark leafy \
                    greens \u{2014} collard greens, mustard greens, dandelion greens, and \
                    turnip greens form the foundation. High-oxalate greens such as spinach \
                    and beet greens should be offered sparingly. Iceberg lettuce has \
                    negligible nutritional value and should be avoided. Fruit should be \
                    limited due to high sugar content. Aquatic turtles are primarily \
                    carnivorous and eat whole prey, commercial turtle pellets, and dark \
                    leafy greens. Always research the specific dietary requirements of your \
                    species.

                    Calcium supplementation is essential for virtually all reptiles. Calcium \
                    deficiency over time produces metabolic bone disease \u{2014} one of the \
                    most commonly seen and entirely preventable conditions in captive \
                    reptiles. Use calcium without vitamin D3 for reptiles receiving adequate \
                    UVB lighting, and calcium with D3 for those without (though providing \
                    proper UVB is always preferred over supplementation alone). Vitamin A \
                    deficiency is also common and causes a range of symptoms including eye \
                    and respiratory problems \u{2014} ensure dietary sources of vitamin A \
                    through appropriate greens and gut-loaded insects. Fresh water should be \
                    available at all times even for desert species.

                    **Handling & Enrichment**
                    Allow newly acquired reptiles a minimum of one to two weeks to acclimate \
                    to their enclosure before beginning regular handling. Acclimation periods \
                    allow the animal to establish its normal feeding and hiding routines and \
                    reduce the stress of an already stressful transition.

                    Handling tolerance varies widely between species and individuals. Bearded \
                    dragons are generally one of the most tolerant lizards and often accept \
                    daily handling. Ball pythons, corn snakes, and most boa constrictors \
                    typically tolerate regular handling of 15\u{2013}30 minutes a few times \
                    per week. Chameleons are highly stress-sensitive and should be handled \
                    minimally \u{2014} they are primarily display animals. Many tortoises \
                    can be handled briefly but tire and stress quickly. Always avoid handling \
                    within 48 hours of a snake feeding, as this can cause regurgitation.

                    Signs of stress in reptiles include gaping or hissing, fleeing, tail \
                    lashing, inflating the body (some lizards and tortoises), color change \
                    to dark tones, musking (releasing musk from scent glands), and defecating \
                    during handling. These are clear communication that the animal wants to \
                    be returned to its enclosure. Always support the full body length \u{2014} \
                    never dangle a reptile or restrain it tightly. Wash hands before and \
                    after every handling session.

                    Enclosure enrichment is important even for species not typically \
                    associated with high activity. Hides, cork bark tunnels, climbing \
                    branches, varied substrate textures, and opportunities to forage all \
                    support normal behavioral expression and reduce chronic stress. \
                    Rearranging the enclosure occasionally provides novelty and mental \
                    stimulation. Most reptiles are solitary and should be housed alone \u{2014} \
                    cohabitation of different species is never appropriate, and \
                    same-species cohabitation requires careful research. Many lizards are \
                    territorial; many snakes are solitary predators that will attempt to \
                    consume cage mates.

                    **Common Mistakes to Avoid**
                    Even well-intentioned reptile owners frequently make a few recurring \
                    errors that cause serious long-term harm.

                    \u{201C}My reptile seems fine, so the husbandry must be correct.\u{201D} \
                    Reptiles are stoic prey animals that conceal illness instinctively. A \
                    reptile in a suboptimal setup may appear normal for months while slowly \
                    developing metabolic bone disease, chronic dehydration, or immune \
                    suppression. By the time signs are visible, the damage is often advanced.

                    \u{201C}I don\u{2019}t need a thermostat \u{2014} I\u{2019}ll just \
                    check the temperature.\u{201D} Unregulated heat sources are one of the \
                    leading causes of thermal burns in captive reptiles. Heat rocks, ceramic \
                    emitters, and heat mats without thermostats can reach dangerous \
                    temperatures. A thermostat is not optional equipment \u{2014} it is as \
                    essential as the heat source itself.

                    \u{201C}UVB through a window is enough.\u{201D} Glass and most plastics \
                    filter out virtually all UVB radiation. A reptile basking in a sunny \
                    window is receiving warmth but no usable UVB. Diurnal lizards and \
                    chelonians require a dedicated UVB bulb inside the enclosure, replaced \
                    every 6\u{2013}12 months regardless of whether it still produces \
                    visible light.

                    \u{201C}Loose substrate will cause impaction.\u{201D} This widespread \
                    belief has led many owners to keep reptiles on bare tile or paper towel \
                    unnecessarily. Impaction from substrate ingestion is almost always a \
                    secondary problem caused by dehydration, inadequate temperatures, or \
                    nutritional deficiency \u{2014} not the substrate itself. Appropriate \
                    loose substrates support natural behaviors like burrowing and are part \
                    of good husbandry for many species.

                    \u{201C}A 20-gallon tank is fine for a ball python.\u{201D} Minimum \
                    enclosure size recommendations have shifted significantly in recent \
                    years. Many species commonly sold in small enclosures \u{2014} ball \
                    pythons, bearded dragons, corn snakes \u{2014} benefit from \
                    substantially more space than older care guides suggest. Research \
                    current, evidence-based recommendations for your specific species \
                    rather than relying on pet store guidance.

                    \u{201C}I\u{2019}ll just feed my snake live prey \u{2014} it\u{2019}s \
                    more natural.\u{201D} Live prey can bite, scratch, and seriously injure \
                    or kill a snake. Frozen/thawed prey is safer, more convenient, and \
                    nutritionally equivalent. The perceived enrichment benefit of live \
                    feeding does not outweigh the injury risk.

                    \u{201C}All reptiles are solitary \u{2014} or all reptiles can be \
                    housed together.\u{201D} Neither extreme is correct. Most snakes and \
                    many lizards are genuinely solitary and will stress, fight, or attempt \
                    to consume cage mates. Some species tolerate or benefit from same-species \
                    cohabitation under specific conditions. Multi-species enclosures are \
                    almost never appropriate. Research your specific species before making \
                    any cohabitation decision.

                    **Veterinary Care**
                    One of the most important things a reptile owner can do is identify an \
                    exotic-specialist veterinarian before one is urgently needed. General \
                    practice veterinarians vary significantly in their experience with \
                    reptiles \u{2014} a veterinarian who regularly sees dogs and cats may \
                    not have the training to evaluate and treat a reptile effectively. \
                    Contact your local reptile community, herpetological society, or the \
                    Association of Reptilian and Amphibian Veterinarians (ARAV) for \
                    referrals.

                    Every new reptile \u{2014} whether wild-caught or captive-bred \u{2014} \
                    should receive a wellness examination within the first one to two weeks \
                    of ownership. This visit establishes a baseline, identifies any \
                    underlying illness or parasites, and gives the owner a chance to confirm \
                    their husbandry setup. A fecal parasite examination is recommended at \
                    intake for all reptiles, and annually thereafter. Wild-caught reptiles \
                    carry a substantially higher parasite burden than captive-bred animals \
                    and require a thorough health evaluation. Whenever possible, \
                    captive-bred animals from reputable breeders are strongly preferred.

                    Reptiles are prey species in the wild and instinctively conceal illness \
                    \u{2014} by the time behavioral or physical signs of disease are obvious \
                    to an owner, the animal may already be significantly compromised. Annual \
                    wellness exams allow veterinarians to detect early-stage issues before \
                    they become emergencies. Signs that warrant prompt veterinary evaluation \
                    include lethargy or unusual inactivity, refusal to eat for more than two \
                    to three feeding cycles, unexplained weight loss, abnormal or incomplete \
                    shedding, respiratory sounds (clicking, wheezing), swollen or discolored \
                    limbs or face, open-mouth breathing when not basking, discharge from the \
                    eyes or nostrils, and softening of the shell in chelonians.

                    All new reptiles should be quarantined from any existing reptiles for a \
                    minimum of 30\u{2013}90 days before introduction to shared spaces. \
                    Reptiles carry Salmonella bacteria naturally \u{2014} it is part of \
                    their normal flora and does not cause disease in the reptile itself. \
                    Always wash hands thoroughly after handling any reptile or objects from \
                    their enclosure, and take particular care when reptiles are in contact \
                    with young children, immunocompromised individuals, or pregnant persons.
                    """,
                toxicityInfoSectionTitle: "Husbandry Overview",
                onsetTime: nil,
                symptoms: [],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .reptile,
                        severity: .moderate,
                        notes: "Covers core husbandry requirements for commonly kept reptiles, including snakes, lizards, and chelonians."
                    )
                ],
                preventionTips: [
                    "Research your specific species thoroughly before purchasing \u{2014} husbandry requirements vary dramatically even within the reptile category.",
                    "Provide a thermal gradient with a distinct warm end, cool end, and basking spot \u{2014} never house a reptile in a single-temperature enclosure.",
                    "Use a thermostat on all heat sources \u{2014} unregulated heat sources are a leading cause of thermal burns in reptiles.",
                    "Provide appropriate UVB lighting for all diurnal lizards and chelonians, and replace UVB bulbs every 6\u{2013}12 months even if they still produce visible light.",
                    "Match enclosure humidity to your species\u{2019} natural environment and measure it with a digital hygrometer \u{2014} do not guess.",
                    "Feed whole, gut-loaded, appropriately sized prey and supplement with calcium \u{2014} nutritional deficiencies are among the most preventable causes of reptile illness.",
                    "Always feed snakes pre-killed or frozen/thawed prey \u{2014} live prey can seriously injure or kill a snake.",
                    "Allow newly acquired reptiles at least one to two weeks to acclimate before regular handling, and learn to recognize signs of stress.",
                    "Quarantine all new reptiles from existing reptiles for 30\u{2013}90 days before any shared contact.",
                    "Schedule a wellness exam with a reptile-experienced veterinarian within the first week of ownership \u{2014} do not wait for illness."
                ],
                sources: [
                    "Association of Reptilian and Amphibian Veterinarians (ARAV) \u{2014} Reptile Husbandry Guidelines",
                    "Merck Veterinary Manual \u{2014} Reptile Husbandry and Disease",
                    "VCA Animal Hospitals \u{2014} Reptile Care Articles (various species)",
                    "LafeberVet \u{2014} Reptile Nutrition and Husbandry",
                    "UC Davis School of Veterinary Medicine \u{2014} Exotic Animal Care",
                    "ReptiFiles \u{2014} Species-Specific Husbandry Research Guides: https://reptifiles.com"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
                    "1D000001-0000-0000-0000-000000000009",  // Thermal Burns
                    "1D000001-0000-0000-0000-000000000010",  // Dysecdysis (Abnormal Shedding)
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000033",  // Snake Mites
                    "1D000001-0000-0000-0000-000000000034",  // Inclusion Body Disease (IBD)
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000040",  // Shell Rot
                    "1D000001-0000-0000-0000-000000000041",  // Stomatitis / Mouth Rot
                    "1D000001-0000-0000-0000-000000000042"   // Reptile Respiratory Infections
                ]
            ),

            // MARK: - Bird Husbandry Guide
            // Type 4 (Husbandry Guide)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000044")!,
                name: "Bird Husbandry Guide",
                alternateNames: [
                    "bird care", "avian care", "parrot care", "budgie care",
                    "budgerigar care", "cockatiel care", "finch care", "canary care",
                    "lovebird care", "conure care", "macaw care", "cockatoo care",
                    "avian husbandry", "bird care guide", "bird care sheet",
                    "bird setup guide", "avian setup"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "bird_husbandry_thumb",
                description: """
                    Birds are among the most rewarding exotic pets to keep — intelligent, \
                    social, and long-lived — but they have precise environmental, nutritional, \
                    and social needs that differ dramatically from dogs and cats. This guide \
                    covers foundational care requirements for commonly kept pet bird species, \
                    including psittacines such as parrots, macaws, cockatoos, cockatiels, \
                    budgerigars, lovebirds, and conures, as well as passerines such as \
                    canaries and finches.

                    Most health problems seen in captive birds are directly linked to \
                    husbandry failures — poor diet, inappropriate housing, inadequate social \
                    interaction, or environmental toxin exposure. A bird that appears healthy \
                    may already be suffering from chronic nutritional deficiencies or \
                    low-level respiratory irritation. Because birds instinctively conceal \
                    signs of illness, problems are often advanced by the time they become \
                    obvious.

                    Birds are also uniquely vulnerable to airborne toxins. Their highly \
                    efficient respiratory system — which includes air sacs that allow \
                    continuous airflow through the lungs — means that fumes from non-stick \
                    cookware, aerosol sprays, scented candles, and smoke can be lethal \
                    within minutes. This is not a minor precaution; it is one of the most \
                    important things a bird owner can know.

                    This guide provides general husbandry principles. Requirements vary \
                    significantly across species — a macaw and a canary have very different \
                    housing, social, and dietary needs. Consult a veterinarian with avian \
                    experience before acquiring a bird, and establish care with an \
                    avian-specialist veterinarian shortly after.
                    """,
                toxicityInfo: """
                    Birds kept as pets represent a remarkable range of species, from small \
                    passerines like finches and canaries to large psittacines like macaws \
                    and cockatoos. What they share is a need for proper housing, nutrition, \
                    social contact, and air quality — all areas where captive environments \
                    commonly fall short.

                    **Enclosure & Habitat**
                    The cage should be as large as possible — birds fly horizontally, so \
                    width matters more than height. Bar spacing must match the bird\u{2019}s \
                    size: narrow bars (no more than \u{00BD} inch apart) for budgies, \
                    finches, and canaries to prevent head entrapment, and appropriately \
                    spaced, heavy-gauge bars for large parrots that could bend thinner wire. \
                    Stainless steel or powder-coated cages are preferable; avoid galvanized \
                    metal, which can cause zinc toxicity as birds chew on bars.

                    Provide multiple perches of varying diameters and textures to promote \
                    foot health and prevent pressure sores — natural wood branches are \
                    excellent. Avoid sandpaper perch covers, which abrade the feet. Place \
                    the cage in a stable, draft-free location away from the kitchen (air \
                    quality risk), exterior doors, and direct air conditioning or heating \
                    vents. Some direct natural light is beneficial but the bird must always \
                    be able to retreat to shade.

                    **Temperature & Lighting**
                    Most companion birds are comfortable between 65\u{2013}85\u{00B0}F \
                    (18\u{2013}29\u{00B0}C). Avoid sudden temperature swings and drafts, \
                    which can trigger respiratory illness. Birds should never be placed near \
                    open windows in cold weather, even briefly.

                    Full-spectrum lighting that includes ultraviolet wavelengths supports \
                    vitamin D3 synthesis, feather condition, and psychological wellbeing — \
                    particularly important for indoor birds that receive little or no \
                    unfiltered sunlight. Photoperiod (the daily light/dark cycle) influences \
                    hormonal status and breeding behavior; maintaining a consistent \
                    10\u{2013}12 hour light period helps stabilize hormone cycles in \
                    many species.

                    **Humidity**
                    Most psittacines originate from tropical and subtropical environments \
                    and do best at relative humidity between 40\u{2013}60%. Dry indoor \
                    air — particularly in heated homes during winter — can cause dry skin, \
                    feather quality problems, and irritation of the respiratory mucosa. A \
                    room humidifier or regular misting can help. Canaries and finches are \
                    somewhat less sensitive, though they also benefit from bathing \
                    opportunities. Monitor with a hygrometer and aim for consistency \
                    rather than perfection.

                    **Diet & Nutrition**
                    Diet is one of the most common sources of preventable disease in \
                    captive birds. For psittacines, a high-quality pelleted diet should \
                    form the majority of intake, supplemented with a wide variety of fresh \
                    vegetables, leafy greens, and limited fresh fruit. Seeds are palatable \
                    but nutritionally incomplete and should not be the primary food source. \
                    All-seed diets are associated with obesity, vitamin A deficiency, and \
                    fatty liver disease.

                    Several foods are toxic to birds and must be avoided entirely: avocado \
                    (all parts, including the flesh — contains persin, which causes cardiac \
                    and respiratory failure), chocolate, caffeine, alcohol, onion, garlic, \
                    and fruit pits or apple seeds. High-salt, high-sugar, and processed \
                    human foods are also inappropriate.

                    Calcium and vitamin A are the two most common nutritional deficiencies \
                    in pet birds. Cuttlebone or mineral blocks provide accessible calcium \
                    and support beak health. Leafy greens, orange and yellow vegetables, \
                    and egg yolk are good dietary sources of vitamin A precursors. Avoid \
                    supplementing with fat-soluble vitamins without veterinary guidance, as \
                    oversupplementation can be harmful. Finches and canaries eat \
                    proportionally more seed but still benefit from fresh food variety and \
                    calcium sources.

                    Provide fresh water daily. Wash food and water dishes thoroughly every \
                    day — bacterial contamination of water dishes is a common and \
                    underappreciated cause of illness.

                    **Handling & Enrichment**
                    Social needs vary enormously by species. Parrots — including cockatiels, \
                    budgies, conures, macaws, and African greys — are highly social and can \
                    develop serious behavioral problems including feather-destructive \
                    behavior, excessive vocalization, and self-mutilation when their social \
                    and cognitive needs go unmet. Daily interaction, foraging opportunities, \
                    and rotating toys are essential. Some species bond strongly to a single \
                    person and may become aggressive toward others; early socialization helps.

                    Finches and canaries are generally not handleable in the same way — \
                    they are better appreciated as aviary birds and are typically kept in \
                    pairs or groups to meet their social needs. Housing a single finch or \
                    canary alone is generally not recommended.

                    For psittacines, basic training using positive reinforcement — starting \
                    with step-up commands — builds trust and makes veterinary handling much \
                    easier. Signs of chronic stress include feather plucking, over-preening, \
                    repetitive movements, loss of appetite, and increased aggression. A bird \
                    exhibiting these signs warrants both a behavioral assessment and a \
                    veterinary examination to rule out underlying medical causes.

                    **Common Mistakes to Avoid**
                    Even well-intentioned bird owners frequently make a few recurring errors \
                    that cause serious long-term harm.

                    \u{201C}Seeds are a complete diet.\u{201D} This is the most common \
                    nutritional mistake in companion bird care. Seeds are high in fat and \
                    low in the vitamins and amino acids birds need — an all-seed diet is \
                    associated with vitamin A deficiency, obesity, and fatty liver disease. \
                    Seeds should be a small part of the diet, not its foundation.

                    \u{201C}My bird seems fine, so they must be healthy.\u{201D} Birds \
                    evolved as prey animals and are hardwired to conceal illness. By the \
                    time a bird looks sick, it is often significantly compromised. Regular \
                    weigh-ins and annual veterinary exams catch problems before they \
                    become visible.

                    \u{201C}Scented candles and air fresheners are safe — I just use them \
                    in the other room.\u{201D} Airborne toxins travel freely through a \
                    home\u{2019}s ventilation. There is no safe distance. Aerosol sprays, \
                    plug-in fresheners, incense, and scented candles should not be used \
                    anywhere in a bird\u{2019}s household.

                    \u{201C}Non-stick cookware is only dangerous if it burns.\u{201D} PTFE \
                    releases toxic fumes at temperatures regularly reached during normal \
                    cooking — not just when pans are badly overheated. The risk begins well \
                    before any visible smoke or odor. The only safe approach for bird \
                    households is to eliminate PTFE-coated products entirely.

                    \u{201C}My bird just needs a companion — any bird will do.\u{201D} \
                    Introducing an incompatible species or a bird with an undetected \
                    infectious disease can be fatal. Any new bird should be quarantined for \
                    at least 30 days and screened by a veterinarian before contact with \
                    resident birds.

                    \u{201C}Birds are low-maintenance pets.\u{201D} Psittacines in \
                    particular have cognitive and social needs comparable to a young child. \
                    Boredom and social isolation are leading causes of feather-destructive \
                    behavior, self-mutilation, and chronic stress. A bird left alone in a \
                    cage for most of the day is not thriving.

                    **Air Quality & Toxins**
                    Birds have the most efficient respiratory system of any vertebrate — \
                    air passes through a network of air sacs in addition to the lungs, \
                    maximizing gas exchange. This makes them uniquely and acutely vulnerable \
                    to airborne toxins at concentrations that would cause no immediate harm \
                    to mammals.

                    Polytetrafluoroethylene (PTFE), the coating used in non-stick cookware \
                    and bakeware, releases toxic fumes when overheated. Exposure can cause \
                    acute respiratory failure and death within minutes. PTFE is also found \
                    in some heat lamp coatings, drip pans, self-cleaning oven linings, hair \
                    dryers, irons, and ironing board covers. The safest approach is to \
                    remove PTFE-coated products from any space a bird inhabits. This is not \
                    a precaution to take lightly — PTFE toxicity kills birds rapidly and \
                    often without warning.

                    Other significant airborne hazards include: aerosol sprays (air \
                    fresheners, cooking sprays, hairspray, pesticides, cleaning products), \
                    scented candles and incense, cigarette and e-cigarette smoke, burning \
                    food and overheated cooking oils, paint fumes and new carpet or \
                    furniture off-gassing, and carbon monoxide from gas appliances. Any \
                    bird showing sudden respiratory distress, weakness, or collapse should \
                    be moved to fresh air immediately and seen by a veterinarian as \
                    an emergency.

                    **Veterinary Care**
                    Birds require a veterinarian with avian training and experience — a \
                    general small animal practice may not have the equipment or expertise \
                    to examine birds appropriately. Establish care with an avian-specialist \
                    veterinarian within the first few weeks of ownership. Annual wellness \
                    examinations are recommended for most species; some long-lived parrots \
                    benefit from twice-yearly visits.

                    Because birds evolved as prey species, they instinctively suppress \
                    outward signs of illness. A bird that appears only mildly unwell may \
                    be significantly compromised. Symptoms warranting urgent evaluation \
                    include: labored breathing or tail-bobbing with each breath, discharge \
                    from the eyes or nares, changes in droppings (color, consistency, or \
                    volume), sudden weight loss, loss of balance, seizures, or any sudden \
                    change in behavior or vocalization. Weigh your bird regularly on a gram \
                    scale at home — consistent weight monitoring is one of the earliest \
                    indicators of health decline.

                    Quarantine any new bird for at least 30 days before introducing it to \
                    other birds in the household. New birds should be examined and screened \
                    for common infectious diseases before quarantine ends. Many serious \
                    avian diseases, including psittacosis and PBFD, can be carried \
                    without obvious signs.
                    """,
                toxicityInfoSectionTitle: "Husbandry Overview",
                onsetTime: nil,
                symptoms: [],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .bird,
                        severity: .moderate,
                        notes: "Covers core husbandry requirements for commonly kept pet birds including psittacines (parrots, cockatiels, budgerigars, lovebirds, conures, macaws, cockatoos) and passerines (canaries, finches)."
                    )
                ],
                preventionTips: [
                    "Feed psittacines a high-quality pelleted diet as the foundation — all-seed diets are associated with obesity, vitamin A deficiency, and fatty liver disease.",
                    "Remove all PTFE/non-stick coated cookware and appliances from areas where birds live — overheated PTFE fumes can kill a bird within minutes.",
                    "Never allow birds access to avocado in any form — all parts of the avocado plant contain persin, which causes cardiac and respiratory failure in birds.",
                    "Provide fresh water and clean food and water dishes every day — bacterial contamination of water dishes is a common cause of illness.",
                    "Use a gram scale to weigh your bird regularly — consistent weight monitoring is one of the earliest signs of health decline before symptoms appear.",
                    "Provide perches of varying diameters and materials to promote foot health — a single uniform perch leads to pressure sores and arthritis over time.",
                    "Keep aerosol sprays, scented candles, incense, and cigarette or e-cigarette smoke away from any room a bird occupies.",
                    "Establish care with an avian-specialist veterinarian within the first few weeks of ownership and schedule annual wellness exams.",
                    "Quarantine any new bird for at least 30 days before introducing it to other birds — many serious avian diseases can be carried without visible signs.",
                    "Take respiratory distress — labored breathing, tail-bobbing, open-mouth breathing — seriously as an emergency; birds deteriorate rapidly once signs are visible."
                ],
                sources: [
                    "Association of Avian Veterinarians (AAV) — Avian Care Guidelines",
                    "Merck Veterinary Manual — Psittacines: Management and Nutrition",
                    "Merck Veterinary Manual — Canaries and Finches: Husbandry",
                    "LafeberVet — Basic Principles of Avian Nutrition: https://lafeber.com/vet/basic-principles-of-avian-nutrition/",
                    "LafeberVet — Toxic and Dangerous Foods for Birds: https://lafeber.com/vet/toxic-dangerous-foods-birds/",
                    "VCA Animal Hospitals — Feeding Pet Birds",
                    "University of California Davis School of Veterinary Medicine — Avian & Exotic Animal Care",
                    "ASPCA Animal Poison Control Center — Birds and Toxic Substances"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000004",  // Psittacosis
                    "1D000001-0000-0000-0000-000000000014",  // Aspergillosis
                    "1D000001-0000-0000-0000-000000000030",  // PBFD
                    "1D000001-0000-0000-0000-000000000035",  // Air Sac Mites
                    "1D000001-0000-0000-0000-000000000036",  // PDD
                    "1D000001-0000-0000-0000-000000000037",  // Coccidiosis & Cryptosporidiosis
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "00112233-4455-6677-8899-aabbccddef22"   // Inhalant Toxins (PTFE / Teflon Toxicosis)
                ]
            ),

            // MARK: - Small Mammal Husbandry Guide
            // Type 4 (Husbandry Guide)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000045")!,
                name: "Small Mammal Husbandry Guide",
                alternateNames: [
                    "rabbit care", "guinea pig care", "chinchilla care", "ferret care",
                    "hamster care", "gerbil care", "rat care", "mouse care", "degu care",
                    "small mammal care", "exotic small mammal", "pocket pet care",
                    "husbandry guide", "care guide", "care sheet", "setup guide",
                    "rabbit husbandry", "guinea pig husbandry", "ferret husbandry",
                    "small pet care", "bunny care"
                ],
                categories: [.diseasesAndConditions],
                imageAsset: "small_mammal_husbandry_thumb",
                description: """
                    This guide covers core husbandry requirements for commonly kept \
                    small mammal pets. It is intended for current and prospective owners \
                    who want to provide the best possible care for their animals and \
                    understand how husbandry choices directly affect long-term health.

                    Species covered include rabbits, guinea pigs, chinchillas, ferrets, \
                    hamsters, gerbils, rats, mice, and degus. While these animals are \
                    often grouped together as \u{201C}small pets,\u{201D} their care \
                    requirements differ significantly — a chinchilla and a ferret have \
                    almost nothing in common nutritionally or environmentally. Reading \
                    species-specific resources and consulting an exotic-specialist \
                    veterinarian is essential for each animal you keep.

                    The majority of health problems seen in captive small mammals are \
                    directly caused by husbandry failures: incorrect diet, inadequate \
                    enclosure size, improper temperature, inappropriate companions, or \
                    insufficient veterinary care. This guide provides foundational \
                    information, but it is not a substitute for professional guidance. \
                    Requirements vary between species and individual animals — a \
                    veterinarian familiar with exotic small mammals is your most \
                    important resource.
                    """,
                toxicityInfo: """
                    Small mammals are among the most popular exotic pets, but they are \
                    often underestimated in the level of care they require. These are \
                    prey animals with strong instincts to conceal illness, specialized \
                    dietary needs, and — in many cases — complex social and behavioral \
                    requirements. Understanding those needs is the foundation of keeping \
                    them healthy.

                    **Enclosure & Habitat**
                    Enclosure size is one of the most consistently underestimated aspects \
                    of small mammal care. Most commercially sold \u{201C}starter cages\u{201D} \
                    are far too small for the animals they are marketed for. Rabbits \
                    require a minimum of a large exercise pen or dedicated room — not a \
                    hutch. Guinea pigs need a minimum of 7.5 square feet of floor space \
                    for one animal, more for pairs or groups. Hamsters need enclosures \
                    with a footprint equivalent to at least a 40-gallon tank, with a \
                    minimum of 6 inches of loose substrate for burrowing — this is a \
                    behavioral necessity, not a luxury. Gerbils and degus have similar \
                    burrowing needs.

                    Solid-bottom flooring is essential for rabbits and guinea pigs — \
                    wire-bottom cages cause painful sore hocks (pododermatitis). \
                    Chinchillas and degus tolerate metal mesh better but still benefit \
                    from solid resting platforms. Ferrets require large multi-level \
                    enclosures and several hours of daily supervised out-of-cage time in \
                    a ferret-proofed space. Rats are highly intelligent and need \
                    enclosures with both floor space and vertical height for climbing. \
                    All species benefit from hides and shelter areas — prey animals need \
                    places to retreat and feel secure.

                    Avoid enclosures made primarily of soft plastic — chinchillas, \
                    degus, rabbits, and ferrets will chew through plastic quickly, \
                    with ingestion risk.

                    **Temperature & Lighting**
                    Most small mammals are sensitive to heat, particularly chinchillas, \
                    rabbits, guinea pigs, and ferrets. Rabbits and guinea pigs are \
                    comfortable between 60\u{2013}75\u{00B0}F and show signs of heat stress \
                    above 80\u{00B0}F. Chinchillas and degus are adapted to cool, arid \
                    climates — temperatures above 70\u{00B0}F are stressful, and \
                    above 75\u{00B0}F can be dangerous. Ferrets tolerate 50\u{2013}80\u{00B0}F \
                    but are highly susceptible to heat stroke in warm environments. \
                    Hamsters can enter a state of torpor (a shallow, involuntary \
                    hibernation) if temperatures drop below 50\u{00B0}F — this is often \
                    mistaken for death by owners and is a medical concern.

                    Unlike reptiles and many birds, most small mammals do not require \
                    UVB lighting. However, a consistent photoperiod (day/night cycle) \
                    supports natural behavior and reproductive cycles. Avoid placing \
                    enclosures in direct sunlight — even brief exposure through a window \
                    can cause lethal overheating, especially in rabbits and chinchillas. \
                    Keep enclosures away from heating vents, drafts, and air conditioning \
                    units.

                    **Humidity**
                    Chinchillas and degus are adapted to low-humidity environments and \
                    do best between 30\u{2013}50% relative humidity. High humidity \
                    increases their risk of respiratory disease and fungal skin \
                    infections. Dust bathing — typically using chinchilla dust two to \
                    three times per week — supports coat health in these species by \
                    absorbing excess oils and moisture.

                    Most other small mammals tolerate moderate household humidity without \
                    difficulty. The key for all species is avoiding damp or wet substrate \
                    — wet bedding promotes bacterial growth, ammonia accumulation, and \
                    skin and respiratory problems. Spot-clean enclosures daily and perform \
                    full substrate changes on a regular schedule.

                    **Diet & Nutrition**
                    Diet is the single most impactful aspect of small mammal husbandry \
                    and is the source of the most common serious health problems.

                    Rabbits require unlimited timothy or orchard grass hay as the \
                    foundation of their diet — approximately 80% of daily intake. Hay \
                    supports both gut motility and dental wear (rabbit teeth grow \
                    continuously throughout life). Fresh leafy greens provide variety \
                    and hydration. Pellets should be limited to a small daily portion. \
                    High-sugar foods including fruit, carrots, and commercial treat \
                    sticks are inappropriate as regular offerings and contribute to GI \
                    imbalance and obesity.

                    Guinea pigs also require unlimited hay and share the rabbit\u{2019}s \
                    need for continuous dental wear. Critically, guinea pigs cannot \
                    synthesize their own vitamin C and will develop scurvy without a \
                    reliable dietary source. Fresh vitamin C-rich vegetables (bell \
                    peppers are an excellent source) or a guinea pig-specific supplement \
                    are essential daily. Do not rely on vitamin C added to water — it \
                    degrades rapidly and intake is unreliable.

                    Chinchillas and degus require a high-fiber, low-fat, low-sugar diet \
                    based on quality grass hay and a limited amount of species-appropriate \
                    pellets. Degus are exceptionally susceptible to diabetes and must \
                    never receive fruit, sugary treats, or high-carbohydrate foods. \
                    Raisins, which are sometimes recommended in older resources, are \
                    inappropriate for both species.

                    Ferrets are strict carnivores. They require a high-protein, \
                    high-fat, low-carbohydrate diet. Fruit, vegetables, and \
                    carbohydrate-heavy foods are inappropriate for ferrets and can \
                    contribute to insulinoma (pancreatic tumors) over time.

                    Hamsters, gerbils, rats, and mice are omnivores and generally \
                    thrive on a high-quality commercial block or pelleted diet \
                    supplemented with fresh vegetables and occasional protein sources. \
                    Seed-only diets are nutritionally unbalanced — animals select \
                    high-fat seeds preferentially and leave the rest, leading to \
                    deficiencies over time. Fresh water must always be available; \
                    water bottles should be checked daily for blockages.

                    **Handling & Enrichment**
                    Regular, gentle handling from an early age helps small mammals \
                    become comfortable with human contact and makes health monitoring \
                    easier. Prey animals instinctively conceal signs of illness — \
                    owners who handle their animals frequently are far more likely to \
                    detect subtle changes in weight, coat condition, or behavior before \
                    a problem becomes critical.

                    Rabbits should always have their hindquarters supported when lifted. \
                    A rabbit that kicks out against an unsupported back can fracture or \
                    dislocate its own spine — this is one of the most preventable \
                    serious injuries in rabbit care. Never grab a rabbit by its ears.

                    Guinea pigs are highly social animals and should be housed in \
                    same-sex pairs or small groups whenever possible. Solitary guinea \
                    pigs are prone to depression, stress-related illness, and shortened \
                    lifespan. Hamsters, by contrast, are largely solitary and most \
                    species should be housed alone — two hamsters in the same enclosure \
                    will often fight, sometimes fatally.

                    Rats are among the most social and intelligent of commonly kept \
                    small mammals and should not be housed alone. Pairs or small \
                    same-sex groups are strongly recommended. Enrichment for rats \
                    includes climbing structures, foraging opportunities, tunnels, \
                    and regular interaction with their owners.

                    Chinchillas are active and agile, especially in the evenings. \
                    They require exercise outside the enclosure in a chinchilla-proofed \
                    space. Ferrets need several hours of supervised out-of-cage playtime \
                    daily in a fully ferret-proofed room — they are escape artists and \
                    will investigate every gap, cabinet, and appliance.

                    **Common Mistakes to Avoid**
                    Many of the most serious health problems in small mammals are \
                    preventable. These are among the most common husbandry errors:

                    \u{2022} Feeding rabbits a carrot-heavy or fruit-heavy diet. Carrots \
                    are high in sugar and should be an occasional treat, not a staple. \
                    The image of rabbits eating carrots is a cultural myth — in the wild, \
                    rabbits eat grasses, not root vegetables.

                    \u{2022} Providing insufficient hay for rabbits and guinea pigs. No \
                    hay means no dental wear and no gut motility — both lead to \
                    life-threatening conditions.

                    \u{2022} Keeping guinea pigs alone. Solitary housing is a welfare \
                    concern for this highly social species.

                    \u{2022} Using an enclosure that is too small, especially for \
                    hamsters. A hamster in an undersized cage without adequate burrowing \
                    depth will display stereotypic (repetitive, stress-driven) behaviors \
                    such as bar-chewing and pacing.

                    \u{2022} Using cedar or pine wood shavings as bedding. The aromatic \
                    phenols in these woods are respiratory irritants and can cause \
                    liver damage in small mammals over time. Choose paper-based, \
                    aspen, or hemp bedding instead.

                    \u{2022} Feeding degus any fruit or sugary food. Degus have an \
                    extremely low tolerance for dietary sugar and are highly prone to \
                    diabetes mellitus.

                    \u{2022} Assuming small size means low maintenance. Many small \
                    mammals require more specialized care than a dog or cat and have \
                    shorter windows to detect and treat illness.

                    \u{2022} Skipping veterinary care because the animal \u{201C}seems \
                    fine.\u{201D} Prey animals mask illness until they can no longer \
                    compensate — waiting for obvious symptoms often means waiting too long.

                    **Veterinary Care**
                    Small mammals require veterinary care from a practitioner experienced \
                    with exotic species. General practice veterinarians may have limited \
                    training in rabbit, guinea pig, or ferret medicine — seek out an \
                    exotic-specialist or a veterinarian who explicitly lists small \
                    mammals as a focus.

                    Annual wellness exams are a minimum standard. Prey animals mask \
                    illness instinctively — a rabbit or guinea pig that appears healthy \
                    may already be significantly unwell by the time symptoms become \
                    visible. Regular exams allow a veterinarian to catch dental \
                    disease, weight changes, and internal problems before they become \
                    emergencies.

                    Dental disease is extremely common in rabbits, guinea pigs, and \
                    chinchillas, all of which have continuously growing teeth that can \
                    develop painful points, overgrowth, or root elongation. Any \
                    decrease in appetite, drooling, or weight loss in these species \
                    should prompt a prompt dental evaluation.

                    Unspayed female rabbits have a very high lifetime risk of uterine \
                    cancer — spaying at a young age is recommended by most exotic \
                    veterinarians as a preventive measure. Female guinea pigs, ferrets, \
                    and rats also have significant reproductive cancer risks that may \
                    warrant spaying.

                    Ferrets are susceptible to canine distemper virus and should be \
                    vaccinated. They are also uniquely prone to adrenal gland disease \
                    and insulinoma, particularly in middle age — regular veterinary \
                    monitoring is important.

                    Signs that warrant same-day or emergency veterinary evaluation in \
                    any small mammal include: not eating for more than 12 hours, \
                    labored breathing, sudden hind limb weakness or paralysis, \
                    significant bleeding, seizures, or suspected ingestion of a \
                    toxic substance.
                    """,
                toxicityInfoSectionTitle: "Husbandry Overview",
                onsetTime: nil,
                symptoms: [],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .moderate,
                        notes: "Covers core husbandry requirements for commonly kept small mammals including rabbits, guinea pigs, chinchillas, ferrets, hamsters, gerbils, rats, mice, and degus."
                    )
                ],
                preventionTips: [
                    "Provide unlimited grass hay at all times for rabbits and guinea pigs — it is the foundation of their diet and essential for dental health and gut motility.",
                    "Guinea pigs cannot synthesize vitamin C — supply a fresh dietary source (such as bell pepper) or a species-appropriate supplement every day.",
                    "House guinea pigs in same-sex pairs or groups — solitary guinea pigs are prone to stress-related illness and significantly shortened lifespan.",
                    "Provide at least 6 inches of loose, deep substrate for hamsters and gerbils — burrowing is a core behavioral need, not optional enrichment.",
                    "Keep chinchillas and degus below 70\u{00B0}F and in low humidity (30\u{2013}50%) — both species are adapted to cool, arid conditions and are vulnerable to heat and dampness.",
                    "Never use cedar or pine shavings as bedding — the aromatic phenols are respiratory irritants that can cause lasting harm; use paper-based, aspen, or hemp bedding.",
                    "Support a rabbit\u{2019}s full body — including hindquarters — whenever lifting; unsupported kicking can fracture the spine.",
                    "Handle your small mammal regularly to detect early changes in weight, coat condition, and behavior — prey animals instinctively conceal illness.",
                    "Schedule a wellness exam with an exotic-specialist veterinarian within the first week of ownership and annually thereafter.",
                    "Ferrets require several hours of daily supervised out-of-cage exercise in a fully ferret-proofed space — they are escape artists with a talent for finding gaps."
                ],
                sources: [
                    "Merck Veterinary Manual — Rabbits: https://www.merckvetmanual.com/exotic-and-laboratory-animals/rabbits",
                    "Merck Veterinary Manual — Guinea Pigs: https://www.merckvetmanual.com/exotic-and-laboratory-animals/guinea-pigs",
                    "Merck Veterinary Manual — Chinchillas: https://www.merckvetmanual.com/exotic-and-laboratory-animals/chinchillas",
                    "Merck Veterinary Manual — Ferrets: https://www.merckvetmanual.com/exotic-and-laboratory-animals/ferrets",
                    "Merck Veterinary Manual — Hamsters and Gerbils: https://www.merckvetmanual.com/exotic-and-laboratory-animals/hamsters",
                    "House Rabbit Society — Basic Rabbit Care: https://rabbit.org/care",
                    "LafeberVet — Small Mammal Care and Husbandry: https://lafeber.com/vet/",
                    "VCA Animal Hospitals — Guinea Pig Care: https://vcahospitals.com/know-your-pet/guinea-pigs",
                    "VCA Animal Hospitals — Ferret Care: https://vcahospitals.com/know-your-pet/ferrets",
                    "Association of Exotic Mammal Veterinarians (AEMV) — Member Resources: https://aemv.org"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000029",  // E. cuniculi
                    "1D000001-0000-0000-0000-000000000031",  // Rabbit Ear Mites
                    "1D000001-0000-0000-0000-000000000032",  // RHDV2
                    "1D000001-0000-0000-0000-000000000037",  // Coccidiosis & Cryptosporidiosis
                    "1D000001-0000-0000-0000-000000000038",  // GI Stasis in Rabbits
                    "1D000001-0000-0000-0000-000000000039",  // Hypovitaminosis A
                    "1D000001-0000-0000-0000-000000000047",  // Myiasis (Fly Strike)
                    "1D000001-0000-0000-0000-000000000048"   // Cheyletiellosis (Walking Dandruff)
                ]
            ),

            // MARK: - Feline Calicivirus (FCV)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000046")!,
                name: "Feline Calicivirus (FCV)",
                alternateNames: ["FCV", "Feline Calici", "Calicivirus", "VS-FCV",
                                 "Virulent Systemic FCV", "Feline Upper Respiratory Infection",
                                 "Feline URI", "Limping Kitten Syndrome"],
                categories: [.diseasesAndConditions],
                imageAsset: "fcv_thumb",
                description: """
                    Feline Calicivirus (FCV) is one of the most prevalent infectious \
                    diseases in cats worldwide and a leading cause of feline upper \
                    respiratory infection, alongside Feline Herpesvirus-1 (FHV-1). \
                    FCV belongs to the Caliciviridae family — the same virus family \
                    that includes Rabbit Hemorrhagic Disease Virus 2 (RHDV2), though \
                    the two are entirely different viruses with no cross-infection risk.

                    FCV presents in two distinct clinical forms. Classic FCV causes \
                    oral ulcers, sneezing, nasal discharge, and conjunctivitis, with \
                    severity ranging from mild to debilitating depending on the strain. \
                    A rarer and far more dangerous form — Virulent Systemic FCV \
                    (VS-FCV) — causes widespread vascular inflammation, facial and \
                    limb swelling, hemorrhagic discharge, jaundice, and multi-organ \
                    failure, with reported mortality rates as high as 60–67%.

                    One of FCV's defining challenges is its genetic diversity. Unlike \
                    Feline Panleukopenia, where vaccination is highly protective, FCV \
                    mutates rapidly and exists as many antigenically distinct strains — \
                    meaning vaccinated cats can still contract the disease. Vaccination \
                    with the core FVRCP vaccine significantly reduces severity and \
                    remains strongly recommended, but does not guarantee full protection.

                    Cats in multi-cat households, shelters, and catteries face the \
                    highest exposure risk. VS-FCV outbreaks have occurred in shelter \
                    populations and among vaccinated adult cats, making early \
                    recognition and isolation protocols essential.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**

                    Classic FCV primarily targets the epithelial cells lining the \
                    mouth and upper respiratory tract. Viral replication causes cell \
                    death, producing the characteristic oral ulcers that form most \
                    often on the tongue, hard palate, and the skin bordering the nose \
                    and lips. Oral pain can be severe enough to cause complete refusal \
                    to eat.

                    Some cats develop immune-mediated polyarthritis — joint \
                    inflammation triggered by the immune response to infection or \
                    vaccination — resulting in sudden lameness in one or more limbs. \
                    This presentation is sometimes called \u{201C}Limping Kitten \
                    Syndrome\u{201D} and is typically self-limiting, resolving within \
                    days without specific treatment.

                    Virulent Systemic FCV (VS-FCV) causes systemic vasculitis — \
                    widespread blood vessel inflammation — leading to fluid leakage \
                    into surrounding tissues. This produces the distinctive facial \
                    and limb edema seen in affected cats, along with skin ulceration, \
                    jaundice, respiratory distress from pneumonia, and multi-organ \
                    failure. VS-FCV is a true emergency requiring immediate \
                    veterinary intervention.

                    **Transmission & Spread**

                    FCV spreads efficiently through direct contact with infected cats \
                    (nasal and ocular discharge, saliva), aerosol transmission from \
                    sneezing, and contaminated surfaces, hands, clothing, food bowls, \
                    and litter boxes. FCV is a non-enveloped virus that is \
                    environmentally stable — it can survive on surfaces for up to one \
                    month at room temperature.

                    Recovered cats can become asymptomatic carriers and shed virus \
                    intermittently for months, particularly during periods of stress. \
                    Some cats become persistent long-term shedders. This makes \
                    multi-cat household introductions and shelter environments \
                    especially high-risk settings. Dilute bleach solution (1:32 ratio) \
                    is effective at inactivating the virus on surfaces.

                    **The Vaccination Reality**

                    FCV vaccination is included in the core FVRCP vaccine recommended \
                    for all cats. It significantly reduces disease severity and is \
                    strongly recommended — but FCV's rapid mutation rate and antigenic \
                    diversity mean that even fully vaccinated cats can contract \
                    infection. This is a fundamental difference from Feline \
                    Panleukopenia, where vaccination is highly reliable. Keeping \
                    vaccinations current remains the most important preventive step.

                    **Treatment Goals**

                    There is no specific antiviral treatment for FCV. Supportive care \
                    is the cornerstone of management and may include nutritional \
                    support (appetite stimulants, assisted feeding, or feeding tubes \
                    for cats refusing food due to oral pain), fluid therapy, antibiotics \
                    for secondary bacterial infections, and pain management for oral \
                    ulcers and joint inflammation. VS-FCV cases require aggressive \
                    hospitalization and intensive supportive care.

                    **Myths vs. Facts**

                    Myth: \u{201C}My cat is vaccinated, so it can\u{2019}t get \
                    calicivirus.\u{201D}
                    Fact: The FVRCP vaccine significantly reduces disease severity \
                    but does not guarantee protection against all FCV strains. \
                    Vaccination is still strongly recommended.

                    Myth: \u{201C}Limping after a calicivirus vaccine means something \
                    went wrong.\u{201D}
                    Fact: Transient lameness is a recognized, self-limiting side \
                    effect of some FCV vaccines, caused by a mild immune-mediated \
                    joint response. It typically resolves within days without treatment.

                    Myth: \u{201C}FCV only affects kittens.\u{201D}
                    Fact: Cats of any age can contract FCV. Adult cats — particularly \
                    unvaccinated individuals and those in high-density environments — \
                    are at significant risk. VS-FCV outbreaks have disproportionately \
                    affected adult cats.

                    **Ferrets & Rabbits: A Note on Caliciviruses**

                    FCV has been reported in ferrets, though clinical disease is \
                    uncommon. Rabbits have limited documented susceptibility to FCV. \
                    Importantly, Rabbit Hemorrhagic Disease Virus 2 (RHDV2) — an \
                    entirely separate calicivirus — poses a life-threatening risk to \
                    rabbits and is covered in its own dedicated entry.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "2–10 days after exposure; oral ulcers, sneezing, nasal discharge, and fever typically appear first",
                    delayed: "VS-FCV systemic signs (facial/paw edema, jaundice, hemorrhagic discharge) develop rapidly as disease progresses; recovered cats may shed virus for months without active signs"
                ),
                symptoms: [
                    "Oral ulcers (tongue, hard palate, nasal philtrum)",
                    "Excessive drooling",
                    "Sneezing",
                    "Nasal discharge",
                    "Conjunctivitis (eye discharge and redness)",
                    "Fever",
                    "Inappetence or refusal to eat",
                    "Sudden limping or lameness (Limping Kitten Syndrome)",
                    "Facial swelling (muzzle, nose, and eye area) — VS-FCV",
                    "Limb edema (paw/leg swelling) — VS-FCV",
                    "Skin ulcers on the face and body — VS-FCV",
                    "Jaundice (yellow tint to skin and gums) — VS-FCV",
                    "Hemorrhagic discharge from eyes or nose — VS-FCV",
                    "Labored breathing or pneumonia — VS-FCV"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Primary species. Classic FCV causes oral ulcers, sneezing, and upper respiratory signs of variable severity. Virulent Systemic FCV (VS-FCV) is rare but carries mortality rates up to 60–67%; any cat showing facial swelling, jaundice, or hemorrhagic signs requires emergency veterinary care. All cats should receive the core FVRCP vaccine, though vaccination reduces — but does not eliminate — infection risk due to FCV's rapid mutation."
                    ),
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .low,
                        notes: "FCV has been documented in ferrets, though clinical disease is uncommon. Rabbits have limited documented susceptibility to FCV. Note that Rabbit Hemorrhagic Disease Virus 2 (RHDV2) — a separate but related calicivirus — is a serious and distinct threat to rabbits covered in its own entry."
                    )
                ],
                preventionTips: [
                    "Vaccinate all cats with the core FVRCP vaccine and maintain boosters on schedule — this significantly reduces disease severity even if it does not guarantee full protection",
                    "Isolate any new cats for at least 2 weeks before introducing them to resident cats",
                    "Separate sick cats from healthy cats immediately at the first sign of upper respiratory illness",
                    "Disinfect food bowls, litter boxes, and surfaces with a dilute bleach solution (1 part bleach to 32 parts water) — FCV can survive on surfaces for up to one month",
                    "Wash hands thoroughly between handling different cats, especially in multi-cat or shelter settings",
                    "Minimize stress in multi-cat households — stress triggers viral shedding in recovered carrier cats",
                    "Inform your veterinarian if your cat was recently adopted from a shelter, as shelter cats have elevated FCV exposure risk"
                ],
                sources: [
                    "Cornell Feline Health Center — Feline Calicivirus (feline.cornell.edu)",
                    "Merck Veterinary Manual — Feline Calicivirus (merckvetmanual.com)",
                    "American Veterinary Medical Association — Feline Calicivirus (avma.org)",
                    "UC Davis School of Veterinary Medicine — Feline Respiratory Disease Complex (vetmed.ucdavis.edu)",
                    "VCA Animal Hospitals — Calicivirus in Cats (vcahospitals.com)",
                    "International Society of Feline Medicine — ISFM Consensus Guidelines on Feline Upper Respiratory Tract Disease (isfm.net)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000021",  // FHV-1 (Feline Herpesvirus-1)
                    "1D000001-0000-0000-0000-000000000003",  // Feline Panleukopenia
                    "1D000001-0000-0000-0000-000000000032"   // RHDV2 (same virus family, different virus)
                ]
            ),

            // MARK: - Myiasis (Fly Strike)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000047")!,
                name: "Myiasis (Fly Strike)",
                alternateNames: ["Fly Strike", "Flystrike", "Blowfly Strike", "Botfly",
                                 "Cuterebra", "Warble Fly", "Maggot Infestation",
                                 "Subcutaneous Myiasis", "Wound Myiasis"],
                categories: [.diseasesAndConditions],
                imageAsset: "myiasis_thumb",
                description: """
                    Myiasis is the infestation of a living animal by fly larvae \
                    (maggots). While the word may sound clinical, the condition is \
                    better known by pet owners as \u{201C}fly strike\u{201D} — and \
                    it is one of the most rapid-onset emergencies in small animal \
                    medicine, particularly in rabbits.

                    Two distinct types of myiasis are seen in pets. Blowfly strike \
                    occurs when flies (most commonly Lucilia sericata and related \
                    species) lay eggs on soiled, wounded, or compromised skin. Eggs \
                    hatch within hours, and larvae begin feeding on tissue \
                    immediately — causing destruction that can become life-threatening \
                    within 24 hours in rabbits. Dogs and cats with open wounds, skin \
                    folds, or heavily soiled coats are also at significant risk.

                    Cuterebra myiasis (botfly or warble fly infestation) is a \
                    separate and distinct presentation. Cuterebra flies do not lay \
                    eggs directly on the host — larvae hatch from eggs deposited near \
                    burrows or on vegetation and enter the host through natural \
                    openings or skin abrasions. The larva then migrates subcutaneously \
                    (under the skin), forming a visible breathing pore and a \
                    characteristic swelling, most often on the face, neck, or trunk. \
                    Cuterebra is most common in dogs, cats, and rabbits in North America.

                    Both forms peak during warm months (spring through early fall) \
                    when fly populations are highest. Outdoor, partially outdoor, and \
                    hutch-housed animals face the greatest exposure risk.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**

                    In blowfly strike, fly eggs hatch into larvae within as little as \
                    8–12 hours. The larvae feed on necrotic and living tissue, \
                    secreting enzymes that liquefy skin and underlying structures. \
                    Bacterial toxins and the larval waste products are rapidly absorbed \
                    into the bloodstream, causing systemic toxemia — fever, \
                    cardiovascular shock, and organ compromise. In rabbits, this \
                    cascade can be fatal within 24 hours if untreated. Even cases \
                    that appear superficially localized often involve far more \
                    extensive tissue destruction than is visible on the surface.

                    In Cuterebra myiasis, a single larva migrates through subcutaneous \
                    tissue, occasionally entering abnormal migration pathways — \
                    including the central nervous system in cats — causing \
                    neurological signs that may persist even after larval removal. \
                    The breathing pore (warble) typically appears as a raised lump \
                    with a small opening. Attempting to remove the larva without \
                    veterinary guidance risks rupturing it, which can trigger a severe \
                    anaphylactic reaction.

                    **The Rabbit Emergency**

                    Fly strike is a disproportionate emergency in rabbits compared to \
                    dogs and cats. Rabbits groom differently, mask signs of illness, \
                    and have skin that is particularly vulnerable to rapid larval \
                    penetration. A rabbit with fly strike can deteriorate from \
                    early infestation to fatal toxemia within hours. Any rabbit \
                    showing sudden agitation, hunched posture, reluctance to move, or \
                    visible larvae or eggs near the hindquarters, tail, or perineum \
                    requires emergency veterinary care immediately — do not wait.

                    GI stasis, obesity, dental disease, or any condition that \
                    prevents a rabbit from grooming its hindquarters dramatically \
                    increases fly strike risk by allowing urine scalding and fecal \
                    soiling to accumulate — providing the moist, soiled environment \
                    flies prefer for egg laying.

                    **Transmission & Spread**

                    Flies are attracted to wounds, soiled coats, urine scalding, \
                    diarrhea, odorous skin folds, and the perineal region of animals \
                    with loose cecotropes or GI disturbance. Risk is highest in \
                    warm, humid conditions when fly populations peak. Cuterebra \
                    infestation occurs through contact with larva-bearing vegetation \
                    or soil near rodent burrows, particularly during outdoor \
                    exploration in late summer and fall.

                    **Zoonotic Risk**

                    Cuterebra larvae can very rarely infest humans, typically through \
                    accidental contact with larva-bearing environments. This is \
                    uncommon and does not require alarm-level precautions — standard \
                    hygiene when handling affected animals is sufficient. Blowfly \
                    strike in pets does not pose meaningful human risk under normal \
                    handling conditions.

                    **Treatment Goals**

                    Blowfly strike treatment involves prompt removal of all larvae \
                    under veterinary supervision, thorough wound debridement, \
                    systemic antibiotics for secondary infection and toxemia, fluid \
                    therapy, pain management, and nutritional support. The full extent \
                    of tissue damage is often not apparent until larvae are removed \
                    and the wound is fully explored. Cuterebra removal is a \
                    veterinary procedure — the larva must be extracted intact to \
                    avoid anaphylaxis from larval contents.

                    **Seasonal Awareness**

                    Fly strike risk rises sharply in spring and remains elevated \
                    through early fall. Owners of outdoor rabbits and other small \
                    mammals should perform daily hindquarter checks during warm \
                    months. Fly-proof hutch screening, prompt removal of soiled \
                    bedding, and regular grooming of long-coated animals are the \
                    most effective preventive measures.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Blowfly eggs hatch in as little as 8–12 hours; larvae begin tissue destruction immediately; Cuterebra warble (swelling with breathing pore) typically develops over 3–4 weeks after larval entry",
                    delayed: "Systemic toxemia and shock from blowfly strike can develop within 24 hours in rabbits; Cuterebra CNS migration (particularly in cats) may cause neurological signs that persist after larval removal"
                ),
                symptoms: [
                    "Visible maggots, fly eggs (white specks), or larval tracks in coat or wounds",
                    "Foul-smelling discharge from affected area",
                    "Matted or wet fur over damaged skin",
                    "Skin wounds that appear larger than expected or rapidly worsening",
                    "Sudden agitation, distress, or abnormal behavior (early rabbit sign)",
                    "Hunched posture or reluctance to move (rabbits)",
                    "Fever",
                    "Inappetence or lethargy",
                    "Raised lump with small central pore (Cuterebra warble)",
                    "Scratching or biting at a specific skin area (Cuterebra)",
                    "Neurological signs: head tilt, circling, seizures (Cuterebra CNS migration — cats)",
                    "Cardiovascular shock in severe or advanced cases"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .severe,
                        notes: "Rabbits are the highest-risk species — fly strike is a rapid-onset emergency with systemic toxemia and death possible within 24 hours. Hindquarter soiling from GI stasis, obesity, or dental disease dramatically elevates risk. Daily hindquarter checks are essential during warm months for all outdoor or hutch-housed rabbits. Guinea pigs, chinchillas, and other hutch-housed small mammals are also at meaningful risk."
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .severe,
                        notes: "Significant risk, particularly around open wounds, skin folds, and heavily soiled coats. Cuterebra infestation most common in dogs with outdoor access in late summer and fall. Botfly warbles typically appear on the face, neck, or trunk."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .severe,
                        notes: "Significant risk from blowfly strike around wounds and soiled fur. Cuterebra infestation can result in aberrant CNS larval migration, causing neurological signs (head tilt, seizures, circling) that may persist after larval removal — an important species-specific risk."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Rare in healthy indoor birds and not a primary concern under good husbandry. Risk increases meaningfully for birds kept outdoors or in outdoor aviaries, particularly those with wounds, compromised feathering, or accumulated fecal soiling — conditions that attract flies."
                    ),
                    SpeciesRisk(
                        species: .reptile,
                        severity: .low,
                        notes: "Myiasis is rare in captive reptiles under appropriate husbandry conditions. Outdoor-housed reptiles or those with skin wounds may occasionally be affected. Veterinary evaluation required if suspected."
                    )
                ],
                preventionTips: [
                    "Perform daily hindquarter checks on rabbits and small mammals during warm months (spring through early fall) — fly strike can progress to an emergency within hours",
                    "Keep outdoor hutches and enclosures fly-screened and clean; remove soiled bedding promptly",
                    "Address any condition that causes hindquarter soiling — including GI stasis, obesity, or dental disease in rabbits — as these dramatically elevate fly strike risk",
                    "Keep wounds clean, dry, and covered; consult your veterinarian about any wound that is slow to heal",
                    "Regularly groom long-coated dogs and cats, especially during summer, and inspect skin folds in predisposed breeds",
                    "Do NOT attempt to remove a Cuterebra (botfly) larva at home — rupture can cause a severe anaphylactic reaction; seek veterinary care immediately",
                    "Consult your veterinarian about fly repellent options approved for use in your pet's species — many human and equine products are toxic to small animals"
                ],
                sources: [
                    "Merck Veterinary Manual — Myiasis (merckvetmanual.com)",
                    "House Rabbit Society — Flystrike (rabbit.org)",
                    "VCA Animal Hospitals — Cuterebra Infestation in Cats and Dogs (vcahospitals.com)",
                    "Cornell University College of Veterinary Medicine — Cuterebra (vet.cornell.edu)",
                    "LafeberVet — Myiasis in Exotic Animals (lafeber.com)",
                    "PDSA (UK) — Flystrike in Rabbits (pdsa.org.uk)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000045",  // Small Mammal Husbandry Guide
                    "1D000001-0000-0000-0000-000000000038",  // GI Stasis in Rabbits
                    "1D000001-0000-0000-0000-000000000031"   // Rabbit Ear Mites
                ]
            ),

            // MARK: - Cheyletiellosis (Walking Dandruff)
            ToxicItem(
                id: UUID(uuidString: "1D000001-0000-0000-0000-000000000048")!,
                name: "Cheyletiellosis (Walking Dandruff)",
                alternateNames: ["Walking Dandruff", "Cheyletiella", "Cheyletiella Mites",
                                 "Rabbit Mites", "Fur Mites", "Cheyletiella yasguri",
                                 "Cheyletiella blakei", "Cheyletiella parasitovorax"],
                categories: [.diseasesAndConditions],
                imageAsset: "w_dandruff_thumb",
                description: """
                    Cheyletiellosis is a skin disease caused by Cheyletiella mites — \
                    large, non-burrowing surface mites that live in the keratin layer \
                    of the skin and feed on tissue fluid and skin debris. The condition \
                    gets its memorable common name, \u{201C}Walking Dandruff,\u{201D} \
                    from a striking and distinctive sign: when the coat is examined \
                    closely, the skin scales appear to move — because the mites \
                    beneath them are moving through the debris.

                    Cheyletiellosis affects rabbits, dogs, and cats, with rabbits \
                    being the most commonly and severely affected species. Guinea pigs \
                    are occasionally affected. Three species of Cheyletiella mites are \
                    recognized in companion animals: C. parasitovorax (rabbits), \
                    C. yasguri (dogs), and C. blakei (cats), though cross-species \
                    infestation does occur.

                    One of the most important aspects of cheyletiellosis is that it \
                    is frequently misidentified by owners — and sometimes even \
                    initially by clinicians — as ordinary dry skin or dandruff. This \
                    delay in recognition matters because Cheyletiella mites are \
                    contagious between animals in the same household and can \
                    temporarily infest humans. Any animal with persistent or \
                    unexplained skin scaling should be evaluated by a veterinarian \
                    rather than assumed to have a simple grooming or dietary issue.
                    """,
                toxicityInfo: """
                    **How It Harms the Body**

                    Cheyletiella mites live on the surface of the skin rather than \
                    burrowing into it. They pierce the skin to feed on tissue fluid, \
                    causing an inflammatory reaction that produces scaling, flaking, \
                    and variable degrees of itching. In rabbits, heavy infestations \
                    can cause large, thick crusts — particularly along the dorsal \
                    midline (back) — and intense pruritus. In some rabbits, especially \
                    immunocompromised or debilitated individuals, infestations can \
                    become severe and debilitating.

                    Dogs and cats tend to show milder clinical signs than rabbits, \
                    sometimes presenting with only minimal scaling and little to no \
                    itch — which contributes to the condition being overlooked. In \
                    some cats, cheyletiellosis is nearly asymptomatic and discovered \
                    incidentally during grooming or veterinary examination.

                    **The Walking Dandruff Sign**

                    The characteristic \u{201C}walking dandruff\u{201D} appearance \
                    results from mites moving through the loose skin scales on the \
                    coat surface. This can sometimes be observed with the naked eye \
                    in heavy infestations — large white flakes near the dorsal midline \
                    or rump that appear to shift or move. A magnifying glass or \
                    examination under low magnification makes this far easier to \
                    detect. The mites are among the largest ectoparasites of companion \
                    animals and are visible under standard microscopy.

                    **Transmission & Spread**

                    Cheyletiella mites spread through direct contact between animals. \
                    They can also survive off the host for several days on bedding, \
                    grooming tools, and cage surfaces, enabling indirect transmission. \
                    Multi-animal households, shelters, boarding facilities, and \
                    grooming environments are common settings for spread. New animals \
                    introduced to a household should be examined before contact with \
                    resident pets.

                    **Zoonotic Risk**

                    Cheyletiella mites can temporarily infest humans, causing an \
                    itchy, self-limiting papular rash — most often on the arms, \
                    abdomen, and chest, reflecting areas of close contact with \
                    affected pets. Because human skin is not a suitable permanent \
                    host, the infestation is self-resolving once the source animal \
                    is treated and the environment is cleaned. Standard hygiene \
                    practices (handwashing after handling affected animals, laundering \
                    bedding) are sufficient precautions. Anyone experiencing a \
                    persistent or worsening rash after contact with an infested pet \
                    should consult a physician.

                    **Why It Gets Missed**

                    Cheyletiellosis is a classic example of a parasitic condition \
                    that is regularly dismissed as a non-infectious problem. Owners \
                    commonly attribute the scaling to diet, dry air, or insufficient \
                    grooming. The itch in dogs and cats can be subtle enough to go \
                    unnoticed. And because the mites are not visible to the naked eye \
                    under casual inspection, there is no obvious external trigger to \
                    prompt veterinary evaluation. The key message: visible skin \
                    flaking — especially along the back and rump — in any rabbit, \
                    dog, or cat should prompt veterinary evaluation rather than \
                    a trial of grooming products or dietary supplements.

                    **Treatment Goals**

                    Treatment involves antiparasitic therapy prescribed by a \
                    veterinarian for all animals in the household simultaneously — \
                    treating only the symptomatic individual risks reinfection from \
                    untreated housemates. Environmental decontamination (washing \
                    bedding, disinfecting cage surfaces and grooming tools) is an \
                    essential component of successful treatment. Your veterinarian \
                    will recommend the appropriate antiparasitic product for your \
                    pet's species, as not all products are safe across species.

                    **Myths vs. Facts**

                    Myth: \u{201C}My pet just has dry skin — it doesn\u{2019}t need \
                    a vet visit.\u{201D}
                    Fact: Persistent scaling, especially along the back or rump, \
                    can be cheyletiellosis. A veterinary skin examination and \
                    microscopy can confirm or rule out mites quickly.

                    Myth: \u{201C}Only one of my pets is itchy, so the others \
                    don\u{2019}t need treatment.\u{201D}
                    Fact: Cheyletiella infestations in dogs and cats can be \
                    asymptomatic. All in-contact animals should be treated \
                    simultaneously to prevent reinfection.

                    Myth: \u{201C}My indoor pet can\u{2019}t get mites.\u{201D}
                    Fact: Cheyletiella can be introduced through new animals, \
                    contaminated grooming equipment, bedding, or contact at \
                    boarding or veterinary facilities.
                    """,
                toxicityInfoSectionTitle: "What makes it harmful?",
                onsetTime: OnsetTime(
                    early: "Signs may develop within 1–3 weeks of exposure; initial scaling and flaking along the dorsal midline are often the first observable signs",
                    delayed: "Infestations can persist for months if untreated or if housemate animals are not treated simultaneously; zoonotic human rash typically appears within days of contact and resolves after source treatment"
                ),
                symptoms: [
                    "Visible skin scaling or flaking, especially along the back and rump",
                    "Large white scales that appear to move (\u{201C}walking dandruff\u{201D} sign)",
                    "Itching — variable; may be absent in dogs and cats",
                    "Excessive grooming or scratching",
                    "Coat thinning or hair loss over affected areas",
                    "Thick crusting along the dorsal midline (rabbits — severe cases)",
                    "Mild to no symptoms in some cats (incidental finding)"
                ],
                entrySeverity: nil,
                speciesRisks: [
                    SpeciesRisk(
                        species: .smallMammal,
                        severity: .high,
                        notes: "Rabbits are the most commonly and severely affected species. Heavy infestations cause thick scaling and crusting along the dorsal midline and can be highly debilitating, particularly in debilitated or immunocompromised animals. Guinea pigs are occasionally affected. C. parasitovorax is the primary mite species in rabbits. All in-contact small mammals should be treated simultaneously."
                    ),
                    SpeciesRisk(
                        species: .dog,
                        severity: .moderate,
                        notes: "Dogs are commonly affected, typically presenting with scaling and variable pruritus. Signs are often milder than in rabbits and can be subtle enough to be overlooked. C. yasguri is the primary species in dogs. All in-contact dogs and cats in the household should be treated simultaneously."
                    ),
                    SpeciesRisk(
                        species: .cat,
                        severity: .moderate,
                        notes: "Cats can be infested with relatively few clinical signs — some cases are essentially asymptomatic. C. blakei is the primary species in cats. Cats in multi-pet households with affected rabbits or dogs should be examined and treated even if they appear unaffected."
                    ),
                    SpeciesRisk(
                        species: .bird,
                        severity: .low,
                        notes: "Cheyletiella infestation is not a recognized concern in birds under normal husbandry. Included for completeness; consult a veterinarian if unusual skin scaling is observed in any bird."
                    )
                ],
                preventionTips: [
                    "Have any new rabbit, dog, or cat examined by a veterinarian before introducing them to resident pets",
                    "If cheyletiellosis is diagnosed in one household pet, treat all in-contact animals simultaneously — asymptomatic animals can carry and transmit mites",
                    "Wash all bedding, blankets, and soft furnishings in hot water and disinfect cage surfaces and grooming tools as part of treatment",
                    "Do not share grooming brushes, combs, or bedding between animals from different households without cleaning first",
                    "If you or a family member develops an unexplained itchy rash after contact with a pet, mention recent animal contact to your physician and have your pet evaluated",
                    "Consult your veterinarian before using any antiparasitic product — not all treatments are safe across species, and incorrect products can be harmful"
                ],
                sources: [
                    "Merck Veterinary Manual — Cheyletiellosis (merckvetmanual.com)",
                    "VCA Animal Hospitals — Cheyletiella Mites in Rabbits (vcahospitals.com)",
                    "House Rabbit Society — Mites and Cheyletiellosis (rabbit.org)",
                    "Cornell University College of Veterinary Medicine — Rabbit Dermatology (vet.cornell.edu)",
                    "PDSA (UK) — Mites in Rabbits (pdsa.org.uk)",
                    "Veterinary Partner — Cheyletiellosis (veterinarypartner.vin.com)"
                ],
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000031",  // Rabbit Ear Mites
                    "1D000001-0000-0000-0000-000000000045",  // Small Mammal Husbandry Guide
                    "1D000001-0000-0000-0000-000000000033",  // Snake Mites
                    "1D000001-0000-0000-0000-000000000035"   // Air Sac Mites
                ]
            ),
        ]
    }
}
