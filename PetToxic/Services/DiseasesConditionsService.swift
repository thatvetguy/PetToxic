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
                relatedEntries: nil
            ),
        ]
    }
}
