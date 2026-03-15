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

    // MARK: - Entry Type Classification

    /// UUIDs of non-infectious entries (Type 2: Husbandry, Type 3: Medical/Metabolic)
    private static let nonInfectiousEntryIDs: Set<String> = [
        "1D000001-0000-0000-0000-000000000005",  // Metabolic Bone Disease (MBD)
        "1D000001-0000-0000-0000-000000000009",  // Thermal Burns
        "1D000001-0000-0000-0000-000000000010",  // Dysecdysis (Abnormal Shedding)
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
                relatedEntries: nil
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
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000001"  // Rabies
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
                relatedEntries: [
                    "1D000001-0000-0000-0000-000000000011"  // Canine Influenza
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
                relatedEntries: nil
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
                relatedEntries: nil
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
        ]
    }
}
