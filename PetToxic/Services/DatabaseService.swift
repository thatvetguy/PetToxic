import Foundation

class DatabaseService {
    static let shared = DatabaseService()

    private var allItems: [ToxicItem] = []

    private init() {
        loadSampleData()
    }

    private func loadSampleData() {
        // Veterinarian-reviewed toxicity data
        // Will be replaced with SQLite database in production
        allItems = [
            // MARK: - Chocolate
            ToxicItem(
                id: UUID(uuidString: "d8c34930-fe78-414c-a182-49521dbfc266")!,
                name: "Chocolate",
                alternateNames: ["cocoa", "cacao", "dark chocolate", "milk chocolate", "baking chocolate", "white chocolate", "cocoa powder", "chocolate chips", "cocoa bean mulch"],
                categories: [.foods, .holidayHazards],
                imageAsset: "chocolate",
                description: "Chocolate is made from roasted cacao beans and is commonly found in candy, baked goods, beverages, and desserts. Cocoa bean hull mulch used in gardens also poses a risk.",
                toxicityInfo: "Chocolate contains theobromine and caffeine, both methylxanthines that dogs and cats cannot metabolize efficiently. Toxicity risk varies significantly by chocolate type — darker and more bitter chocolates are far more dangerous. In order of risk: cocoa powder and cacao beans are most dangerous, followed by unsweetened baking chocolate, semisweet chocolate, milk chocolate, and white chocolate (minimal risk). The high fat and sugar content in some chocolate products can also trigger pancreatitis.",
                onsetTime: OnsetTime(
                    early: "Caffeine effects begin within 30-60 minutes. Theobromine effects may take 2+ hours to appear. Initial signs include vomiting, restlessness, bloating, and increased thirst.",
                    delayed: "Theobromine is metabolized slowly (17.5-hour half-life in dogs). Effects can persist for several days. Signs may progress to cardiac arrhythmias, seizures, and other serious complications."
                ),
                symptoms: [
                    "Vomiting",
                    "Restlessness and hyperexcitability",
                    "Bloating",
                    "Increased thirst",
                    "Rapid heart rate or abnormal heart rhythm",
                    "Rapid breathing",
                    "Elevated body temperature",
                    "Muscle tremors or rigidity",
                    "Seizures (severe cases)",
                    "Very high doses: low blood pressure, slow heart rate, coma"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are commonly affected due to indiscriminate eating habits. Hospitalization is often required for treatment."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are more sensitive to methylxanthines than dogs, though they rarely consume chocolate voluntarily.")
                ],
                preventionTips: [
                    "Store all chocolate products in closed cabinets out of pet reach",
                    "Be especially vigilant during holidays when chocolate is abundant",
                    "Educate children not to share chocolate with pets",
                    "Remember that baking chocolate and dark chocolate are most dangerous"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Veterinary Information Network (VIN)", "VCA Animal Hospitals"],
                relatedEntries: ["f2a3b4c5-6d7e-8f9a-0b1c-2d3e4f5a6b7c"]
            ),

            // MARK: - Grapes & Raisins
            ToxicItem(
                id: UUID(uuidString: "d1bde5cd-6881-4765-ac4c-b9f43b40da70")!,
                name: "Grapes & Raisins",
                alternateNames: ["grapes", "raisins", "currants", "sultanas", "Zante currants", "dried grapes", "Corinthian raisins", "Vitis vinifera"],
                categories: [.foods],
                imageAsset: "grapes",
                description: "Grapes and their dried forms (raisins, sultanas, Zante currants) can cause acute kidney injury in dogs. All grape types may be toxic, including organic, seeded, seedless, and homegrown varieties. Grape juice, jelly, wine, leaves, and grape seed oil have not been reported to cause toxicosis, though their safety is not confirmed.",
                toxicityInfo: "The suspected toxic agent is tartaric acid, which varies in concentration depending on fruit ripeness — this explains why toxicity is unpredictable. Approximately 50-88% of dogs that ingest grapes or raisins never develop clinical signs, while others become severely ill from small amounts. Toxicity does not appear to be entirely dose-dependent, and individual sensitivity varies greatly. Because it is impossible to predict which dogs will be affected, any ingestion should be treated as potentially dangerous.",
                onsetTime: OnsetTime(
                    early: "Vomiting is the most common early sign and typically occurs within 24 hours. Other early signs include diarrhea, loss of appetite, lethargy, abdominal pain, and excessive salivation.",
                    delayed: "Acute kidney injury can develop 1-5 days after ingestion. Later signs may include increased thirst and urination, weakness, tremors, and decreased urine production as kidney failure progresses."
                ),
                symptoms: [
                    "Vomiting (most common, often contains grape/raisin pieces)",
                    "Diarrhea",
                    "Loss of appetite",
                    "Lethargy",
                    "Abdominal pain or distension",
                    "Excessive salivation",
                    "Increased thirst and urination",
                    "Weakness or incoordination",
                    "Tremors",
                    "Decreased urination (as kidney failure develops)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Unpredictable toxicity — any amount should be considered dangerous. Hospitalization is typically recommended."),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Rare anecdotal reports exist, but in one study of 13 cats with known ingestion, none developed kidney injury.")
                ],
                preventionTips: [
                    "Store grapes, raisins, and currants out of pet reach",
                    "Check ingredient lists on baked goods, trail mix, and cereals for raisins",
                    "Be cautious with grape juice and wine—both contain the same toxic compounds",
                    "Dispose of fallen grapes promptly if you have grapevines"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Xylitol
            ToxicItem(
                id: UUID(uuidString: "d7723ed0-6496-40b3-8b1c-84e129083cb9")!,
                name: "Xylitol",
                alternateNames: ["birch sugar", "wood sugar", "birch bark extract", "sugar alcohol", "E967"],
                categories: [.foods],
                imageAsset: "xylitol_gum_peanutbutter",
                description: "Xylitol is a sugar alcohol sweetener used in over 1,900 products, including sugar-free gum, candy, baked goods, peanut butter, protein bars, toothpaste, mouthwash, vitamins, supplements, medications, and some cosmetics. Xylitol content varies widely between products — even different flavors of the same brand can have vastly different amounts.",
                toxicityInfo: "Dogs have an exaggerated insulin response to xylitol (3-7 times greater than to regular sugar), causing rapid and potentially life-threatening hypoglycemia. Large ingestions can also cause acute liver failure through a mechanism that is not fully understood. Cats do not appear to have this response — studies show cats do not develop significant hypoglycemia or liver changes after xylitol ingestion. Other sugar alcohols (sorbitol, mannitol, maltitol, erythritol) do not cause similar effects in dogs.",
                onsetTime: OnsetTime(
                    early: "Hypoglycemia typically develops within 30-60 minutes of ingestion. Signs may be delayed several hours if xylitol was in gum that was swallowed without chewing.",
                    delayed: "Signs of liver injury (jaundice, vomiting, abdominal pain) may appear 12-72 hours after exposure, sometimes without prior hypoglycemia. Liver enzymes may peak 20-40 hours after ingestion."
                ),
                symptoms: [
                    "Vomiting",
                    "Weakness and lethargy",
                    "Loss of coordination or stumbling",
                    "Restlessness",
                    "Tremors",
                    "Seizures",
                    "Collapse or coma",
                    "Jaundice/yellowing of skin or gums (liver failure)",
                    "Abdominal pain (liver failure)",
                    "Abnormal bleeding or bruising (liver failure)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Even small amounts can be life-threatening. Individual response varies. Hospitalization is typically recommended."),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats do not appear to develop hypoglycemia or liver injury from xylitol based on available studies.")
                ],
                preventionTips: [
                    "Check ingredient labels for xylitol (also listed as birch sugar or E967)",
                    "Store sugar-free gum, candy, and mints securely—even one piece can be dangerous",
                    "Keep sugar-free peanut butter away from pets; always check labels before sharing",
                    "Be aware that some medications and supplements contain xylitol as a sweetener"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Onions
            ToxicItem(
                id: UUID(uuidString: "8a27c390-254f-47c9-90e7-7739694f603f")!,
                name: "Onions",
                alternateNames: ["onion", "red onion", "white onion", "yellow onion", "green onion", "scallions", "shallots", "chives", "leeks", "onion powder", "onion flakes", "dried onion", "dehydrated onion", "Allium cepa", "Allium porrum", "Allium schoenoprasum"],
                categories: [.foods],
                imageAsset: "onions",
                description: "Onions are common cooking vegetables found in many dishes, sauces, and seasonings. All forms are toxic: raw, cooked, dehydrated flakes, and powdered. Onion powder is more concentrated and therefore more toxic gram-for-gram than fresh onion. Cooking, dehydration, and spoilage do not reduce toxicity. Note: Some baby foods contain onion powder and can cause toxicosis in cats. This entry also covers chives, leeks, scallions, and shallots.",
                toxicityInfo: "Onions contain organosulfur compounds (primarily N-propyl disulfide) that damage red blood cells by converting hemoglobin to methemoglobin and causing Heinz body formation. This leads to hemolytic anemia. Dogs and cats are particularly susceptible because they have low erythrocyte catalase activity. Among Allium species, garlic is 3-5 times more potent than onion, which is more toxic than chives and leeks.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, abdominal pain, loss of appetite, depression, dehydration) may occur shortly after ingestion.",
                    delayed: "Signs of hemotoxicosis develop 1-7 days after ingestion in dogs, and as early as 12 hours to 5 days in cats. Signs include pale gums, rapid or labored breathing, weakness, brown urine, and jaundice."
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Depression and lethargy",
                    "Dehydration",
                    "Weakness",
                    "Pale gums",
                    "Rapid or labored breathing",
                    "Brown-colored urine",
                    "Jaundice/yellowing (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Japanese breeds (Akita, Shiba Inu, Shikoku, Kai Ken, Japanese Terrier, Tosa, Japanese Spitz, Hokkaido) are at increased risk due to a hereditary red blood cell condition."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are more susceptible than dogs. Heinz body anemia can occur with very small amounts. Caution with baby foods that may contain onion powder."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are susceptible to Allium toxicity.")
                ],
                preventionTips: [
                    "Keep all Allium vegetables (onions, garlic, leeks, chives, shallots, scallions) out of pet reach",
                    "Be cautious with table scraps—many dishes contain onion as seasoning",
                    "Check ingredient lists on baby food, soups, and prepared foods",
                    "Remember that all forms are toxic: raw, cooked, powdered, and dehydrated"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Garlic
            ToxicItem(
                id: UUID(uuidString: "dad777ea-3120-43b1-9b8f-aee413716abc")!,
                name: "Garlic",
                alternateNames: ["garlic cloves", "garlic powder", "garlic salt", "minced garlic", "roasted garlic", "garlic supplements", "Allium sativum"],
                categories: [.foods],
                imageAsset: "garlic",
                description: "Garlic is a pungent bulb used as a seasoning and in supplements. All forms are toxic: raw, cooked, dehydrated, and powdered. Garlic powder is more concentrated and therefore more toxic gram-for-gram than fresh garlic. \"Odor-free\" or \"deodorized\" garlic supplements have had some toxic compounds removed and are generally less toxic. Cooking, dehydration, and spoilage do not reduce toxicity.",
                toxicityInfo: "Garlic contains organosulfur compounds (primarily N-propyl disulfide) that damage red blood cells by converting hemoglobin to methemoglobin and causing Heinz body formation. This leads to hemolytic anemia. Garlic is 3-5 times more potent than onion. The stronger the odor/flavor, the greater the toxicity. Dogs and cats are particularly susceptible because they have low erythrocyte catalase activity, with cats having additional susceptibility to oxidant injury.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, abdominal pain, loss of appetite, depression, dehydration) and direct stomach irritation may occur shortly after ingestion.",
                    delayed: "Garlic-induced red blood cell changes develop more slowly than with onions in dogs, with the most severe hemolysis typically around 7 days. In cats, signs may appear as early as 12 hours to 5 days."
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Depression and lethargy",
                    "Dehydration",
                    "Weakness",
                    "Pale gums",
                    "Rapid or labored breathing",
                    "Brown-colored urine",
                    "Jaundice/yellowing (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "3-5 times more toxic than onion. Japanese breeds (Akita, Shiba Inu, Shikoku, Kai Ken, Japanese Terrier, Tosa, Japanese Spitz, Hokkaido) are at increased risk."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are more susceptible than dogs and can develop toxicosis from very small amounts. Any exposure is potentially dangerous."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are susceptible to Allium toxicity.")
                ],
                preventionTips: [
                    "Store fresh garlic bulbs and garlic powder in closed cabinets",
                    "Be cautious with table scraps and leftover food containing garlic",
                    "Avoid garlic-based pet supplements unless specifically directed by a veterinarian",
                    "Check ingredient lists on prepared foods, sauces, and seasonings"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Macadamia Nuts
            ToxicItem(
                id: UUID(uuidString: "df7f2d18-6f6c-40c8-9f77-cdfbc815e946")!,
                name: "Macadamia Nuts",
                alternateNames: ["macadamia", "Australia nut", "Queensland nut", "macadamia integrifolia", "macadamia tetraphylla"],
                categories: [.foods],
                imageAsset: "macadamia_nuts",
                description: "Macadamia nuts are creamy, high-fat tree nuts originally native to Australia. They are commonly found in cookies, candies, trail mixes, and baked goods.",
                toxicityInfo: "The exact mechanism of toxicity is unknown. Macadamia nuts affect nerve and muscle function in dogs, causing characteristic hind limb weakness. The high fat content also poses a risk of pancreatitis, particularly in predisposed breeds or dogs with a history of the condition. Macadamia nut toxicity has only been documented in dogs—it is unclear whether cats are resistant or simply do not consume enough to cause problems. Important: Macadamia nuts are often found in products that also contain chocolate, xylitol, or raisins, which are more dangerous. If your pet consumed a product containing macadamia nuts, check the ingredient list for these other toxins.",
                onsetTime: OnsetTime(
                    early: "Mild depression and vomiting may appear within 3 hours of ingestion",
                    delayed: "Muscle weakness typically develops within 6-12 hours, peaking around 12 hours; fever may peak around 8 hours"
                ),
                symptoms: [
                    "Weakness, especially in the hind legs",
                    "Difficulty walking or standing",
                    "Lethargy or depression",
                    "Vomiting",
                    "Tremors",
                    "Ataxia (lack of coordination)",
                    "Fever",
                    "Joint stiffness or muscle pain",
                    "Abdominal discomfort"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are the only species in which toxicity has been documented; symptoms typically resolve within 24-48 hours but veterinary guidance is recommended"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Toxicity has not been reported in cats; whether cats are resistant or simply don't consume enough is unknown")
                ],
                preventionTips: [
                    "Store macadamia nuts and products containing them in closed cabinets",
                    "Check ingredient lists on cookies, candies, and trail mixes",
                    "Be aware that macadamia nuts are often paired with chocolate, which is also toxic",
                    "Keep baked goods containing macadamia nuts out of pet reach"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Alcohol
            ToxicItem(
                id: UUID(uuidString: "63f63b3a-1172-4fb2-9702-45496c99df4d")!,
                name: "Alcohol",
                alternateNames: ["ethanol", "ethyl alcohol", "beer", "wine", "liquor", "spirits", "vodka", "whiskey", "rum", "cocktail", "isopropanol", "isopropyl alcohol", "rubbing alcohol", "methanol", "methyl alcohol", "wood alcohol", "hand sanitizer"],
                categories: [.foods, .recreationalSubstances],
                imageAsset: "beer_wine_bottles",
                description: "Alcohol toxicity can occur from ethanol (alcoholic beverages, some liquid medications, mouthwash, fermenting fruits), isopropanol (rubbing alcohol, some hand sanitizers, certain flea sprays), or methanol (windshield washer fluid, some paint removers).",
                toxicityInfo: "Alcohols are rapidly absorbed and act as central nervous system depressants. They cross the blood-brain barrier quickly and can cause dangerous drops in blood sugar, blood pressure, and body temperature. Isopropanol is more than twice as potent as ethanol. Dogs are highly susceptible to the effects of alcohol, and cats are especially sensitive. Significant absorption can also occur through the skin or by inhalation. Note: Raw yeast bread dough produces ethanol as it ferments—see the separate entry for Raw Yeast Dough.",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within 20-90 minutes of ingestion, potentially faster with larger amounts or on an empty stomach",
                    delayed: "Severe signs including respiratory depression, seizures, or coma may develop as intoxication progresses"
                ),
                symptoms: [
                    "Vomiting",
                    "Excessive drooling or nausea",
                    "Ataxia (stumbling, lack of coordination)",
                    "Disorientation or confusion",
                    "Lethargy or depression",
                    "Alcoholic odor on breath",
                    "Increased thirst and urination",
                    "Hypothermia (low body temperature)",
                    "Slow or labored breathing",
                    "Tremors",
                    "Seizures (in severe cases)",
                    "Collapse or coma (in severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are highly susceptible; even small amounts can cause signs of inebriation"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are especially sensitive to alcohol; smaller body size increases risk"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly sensitive due to small body size and rapid metabolism")
                ],
                preventionTips: [
                    "Keep alcoholic beverages out of reach, especially during parties when drinks may be left unattended",
                    "Store rubbing alcohol, hand sanitizers, and cleaning products securely",
                    "Do not give liquid medications containing alcohol without consulting a veterinarian",
                    "Dispose of fermenting or rotting fruits promptly",
                    "Be aware that cocktails made with milk or cream may be especially attractive to pets"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "VCA Animal Hospitals"],
                relatedEntries: nil
            ),

            // MARK: - Raw Yeast Dough
            ToxicItem(
                id: UUID(uuidString: "ec90eb4b-765b-45cb-9255-f449b656b7d3")!,
                name: "Raw Yeast Dough",
                alternateNames: ["bread dough", "raw bread dough", "unbaked dough", "rising dough", "pizza dough", "raw pizza dough", "sourdough starter", "yeast dough", "uncooked dough"],
                categories: [.foods, .holidayHazards],
                imageAsset: "raw_yeast_dough",
                description: "Raw, unbaked dough containing active yeast poses a serious danger to pets. This includes bread dough, pizza dough, roll dough, and sourdough starter left out to rise.",
                toxicityInfo: "Raw yeast dough presents a double danger. First, the warm environment of the stomach provides ideal conditions for the yeast to continue fermenting, causing the dough to expand and potentially fill the entire stomach. This expansion can cause painful bloating and may trigger life-threatening gastric dilatation-volvulus (GDV/bloat) in susceptible breeds. Second, as the yeast ferments sugars in the dough, it produces ethanol (alcohol), which is absorbed into the bloodstream and causes alcohol poisoning. Note: Fully baked bread is generally safe as an occasional treat. Uncooked yeast straight from the packet is not dangerous—it requires sugar to ferment.",
                onsetTime: OnsetTime(
                    early: "Bloating and unproductive attempts to vomit may begin within 30 minutes to 2 hours as dough expands",
                    delayed: "Signs of alcohol intoxication (ataxia, disorientation) typically develop as fermentation continues; severe signs may appear several hours after ingestion"
                ),
                symptoms: [
                    "Abdominal distention or bloating",
                    "Unproductive retching (trying to vomit but unable)",
                    "Vomiting",
                    "Ataxia (stumbling, lack of coordination)",
                    "Disorientation or confusion",
                    "Lethargy or weakness",
                    "Hypothermia (low body temperature)",
                    "Hypoglycemia (low blood sugar)",
                    "Slow or labored breathing",
                    "Tremors",
                    "Seizures (in severe cases)",
                    "Collapse or coma (in severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are most commonly affected; deep-chested breeds face additional GDV risk from stomach distention"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are also at risk for both bloating and alcohol poisoning from raw dough")
                ],
                preventionTips: [
                    "Never leave dough out to rise in areas accessible to pets, including countertops",
                    "Place rising dough in the oven (turned off) or microwave with the door closed",
                    "Do not feed raw bread dough, pizza dough, or sourdough starter to pets",
                    "Dispose of unused or old dough in a secure trash container outside the home",
                    "Be extra vigilant during holiday baking when dough is frequently left to rise"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "VCA Animal Hospitals"],
                relatedEntries: nil
            ),

            // MARK: - Caffeine
            ToxicItem(
                id: UUID(uuidString: "ae80bf97-0ffd-4ed8-b9d9-727e747d583b")!,
                name: "Caffeine",
                alternateNames: ["coffee", "coffee beans", "coffee grounds", "espresso", "tea", "tea bags", "green tea", "black tea", "energy drinks", "Red Bull", "Monster", "soda", "cola", "diet pills", "caffeine pills", "NoDoz", "Vivarin", "pre-workout", "guarana"],
                categories: [.foods],
                imageAsset: "coffee_grounds_energy_drink",
                description: "Caffeine is a stimulant found in coffee, tea, energy drinks, soda, diet pills, pre-workout supplements, and some medications. Coffee grounds, tea bags, and caffeine pills contain much higher concentrations than brewed beverages.",
                toxicityInfo: "Caffeine is a methylxanthine compound (related to theobromine in chocolate) that dogs and cats are much more sensitive to than humans. Their bodies metabolize caffeine very slowly, allowing it to build up to toxic levels. While a lap or two of coffee or tea is unlikely to harm most pets, ingestion of coffee grounds, tea bags, or just one or two caffeine pills can be fatal to small dogs and cats. Products containing guarana may have additional caffeine. Note: Chocolate also contains caffeine along with theobromine—see the separate Chocolate entry.",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within 1-2 hours of ingestion",
                    delayed: "Symptoms may last 12-36 hours depending on the amount consumed"
                ),
                symptoms: [
                    "Restlessness or hyperactivity",
                    "Agitation or pacing",
                    "Vomiting",
                    "Diarrhea",
                    "Excessive thirst and urination",
                    "Panting",
                    "Rapid heart rate (tachycardia)",
                    "Elevated blood pressure",
                    "Abnormal heart rhythms",
                    "Tremors",
                    "Elevated body temperature",
                    "Seizures (in severe cases)",
                    "Collapse (in severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are more sensitive to caffeine than humans; coffee grounds and caffeine pills pose the greatest risk"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are highly sensitive to caffeine and cannot metabolize it effectively; even small amounts can cause serious toxicity")
                ],
                preventionTips: [
                    "Store coffee grounds, beans, and pods in sealed containers out of pet reach",
                    "Never leave coffee cups or energy drinks unattended",
                    "Dispose of used coffee grounds and tea bags in a secure trash container",
                    "Keep diet pills, pre-workout supplements, and caffeine pills in closed cabinets",
                    "Be aware that some medications and herbal supplements contain caffeine"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "VCA Animal Hospitals"],
                relatedEntries: nil
            ),

            // MARK: - Avocado
            ToxicItem(
                id: UUID(uuidString: "6a0dda24-d0e1-47c4-af59-068101844c8b")!,
                name: "Avocado",
                alternateNames: ["guacamole", "avocado pit", "avocado seed", "avocado leaves", "persea americana"],
                categories: [.foods, .plants],
                imageAsset: "avocado",
                description: "Avocado is a popular fruit used in guacamole and many dishes. The leaves, fruit, seeds, and bark all contain persin, a fungicidal toxin. Toxicity varies dramatically by species—birds and small mammals are highly susceptible, while dogs and cats are relatively resistant.",
                toxicityInfo: "Avocado contains persin, a toxin that can cause myocardial (heart) damage and death in susceptible species. Birds are extremely sensitive and can die from even small amounts. Rabbits, guinea pigs, and other small mammals are also highly susceptible. Dogs and cats are relatively resistant to persin, but face other risks: the high fat content can trigger pancreatitis, and the large pit can cause life-threatening GI obstruction if swallowed. The leaves are the most toxic part of the plant. Guatemalan avocado varieties are most commonly associated with toxicosis.",
                onsetTime: OnsetTime(
                    early: "In birds, signs may appear within hours; in dogs/cats, GI upset may occur within 12-24 hours",
                    delayed: "Cardiovascular effects in susceptible species may develop within 24-48 hours of ingestion"
                ),
                symptoms: [
                    "Vomiting (dogs/cats)",
                    "Diarrhea (dogs/cats)",
                    "Abdominal pain (if pit ingested)",
                    "Lethargy",
                    "Difficulty breathing (birds, small mammals)",
                    "Weakness (birds, small mammals)",
                    "Inability to perch (birds)",
                    "Feather pulling or agitation (birds)",
                    "Swelling around neck and chest (birds)",
                    "Sudden death (birds, small mammals)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Dogs are relatively resistant to persin; main risks are pancreatitis from high fat content and GI obstruction from swallowing the pit"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats are relatively resistant to persin; may experience mild GI upset"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are extremely susceptible—even small amounts can cause cardiovascular damage and death; never feed avocado to birds"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Rabbits, guinea pigs, and other small mammals are highly susceptible to persin toxicity")
                ],
                preventionTips: [
                    "Never feed avocado to birds, rabbits, guinea pigs, or other small mammals",
                    "Keep avocado pits secured in trash—dogs may swallow them whole",
                    "If you have an avocado tree, prevent access to fallen fruit and leaves",
                    "Store ripe avocados in the refrigerator out of pet reach",
                    "Be cautious with guacamole at parties—it may also contain onion and garlic"
                ],
                sources: ["Merck Veterinary Manual", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Nutmeg
            ToxicItem(
                id: UUID(uuidString: "d6ac2e8a-00de-42cb-9c6b-f912ec43d5f3")!,
                name: "Nutmeg",
                alternateNames: ["ground nutmeg", "whole nutmeg", "nutmeg seed", "myristica fragrans", "myristicin"],
                categories: [.foods, .holidayHazards],
                imageAsset: "nutmeg",
                description: "Nutmeg is a spice made from the seed of the Myristica fragrans tree, commonly used in baked goods, eggnog, and seasonal dishes. Whole nutmeg seeds and ground nutmeg are found in most kitchens, especially during the holiday season.",
                toxicityInfo: "Nutmeg contains myristicin, a compound with hallucinogenic and neurotoxic properties. At normal culinary amounts (a dash in recipes), nutmeg is unlikely to cause serious problems—mild GI upset at most. However, ingestion of large amounts (1 teaspoon of ground nutmeg or 2-3 whole nutmeg seeds) can cause toxicity. Dogs cannot metabolize myristicin efficiently. Nutmeg essential oil is more concentrated and poses greater risk than the ground spice.",
                onsetTime: OnsetTime(
                    early: "Mild GI upset may occur within a few hours of ingestion",
                    delayed: "Neurological and cardiovascular signs may develop within 3-8 hours; symptoms can last up to 48 hours"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Disorientation or confusion",
                    "Hallucinations",
                    "Increased heart rate (tachycardia)",
                    "High blood pressure (hypertension)",
                    "Dry mouth",
                    "Abdominal pain",
                    "Tremors",
                    "Seizures (in severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Large amounts can cause hallucinogenic and cardiovascular effects; culinary amounts in baked goods are generally not a serious concern"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are also susceptible to myristicin; similar effects expected at high doses")
                ],
                preventionTips: [
                    "Store whole nutmeg seeds and ground nutmeg in closed cabinets out of pet reach",
                    "Be extra cautious during holiday baking season when nutmeg is commonly used",
                    "Keep nutmeg essential oil secured—it is more concentrated than the ground spice",
                    "A small bite of baked goods with nutmeg is unlikely to cause serious harm, but avoid sharing intentionally"
                ],
                sources: ["Veterinary Information Network (VIN)", "Pet Poison Helpline", "PetMD"],
                relatedEntries: nil
            ),

            // MARK: - Salt
            ToxicItem(
                id: UUID(uuidString: "c9fb21d1-a66a-418e-a63f-1b754ec048f2")!,
                name: "Salt",
                alternateNames: ["sodium chloride", "table salt", "rock salt", "de-icing salt", "road salt", "sea salt", "homemade play dough", "salt dough", "playdough", "paint balls", "sea water", "ocean water", "salty snacks", "ice melt", "ice melter", "ice melt pellets", "de-icer", "deicer", "sidewalk salt", "driveway salt", "calcium chloride", "magnesium chloride", "potassium chloride", "Safe Paw", "Safe Step", "Morton Safe-T-Salt", "Road Runner ice melt", "pet safe ice melt", "pet friendly ice melt"],
                categories: [.foods, .garageGarden],
                imageAsset: "salt_playdough",
                description: "While small amounts of salt are a normal part of a pet's diet, excessive salt intake can cause sodium poisoning. Common sources include homemade play dough, rock salt (de-icers), sea water at the beach, paint balls, table salt, and very salty snacks like chips or pretzels. In winter, pets can also be exposed by walking on treated sidewalks and driveways, then licking ice melt residue off their paws. This can cause both GI upset from ingestion and local irritation to paw pads.",
                toxicityInfo: "Excess salt overwhelms the body's ability to maintain fluid balance. Water is pulled out of cells—including brain cells—causing dehydration and neurological damage. The risk is much higher when pets don't have access to fresh water to help flush the excess sodium. Homemade play dough is a frequent culprit, as it contains very high salt concentrations and may be attractive to dogs. Important: Salt should never be used to induce vomiting at home—this outdated practice can cause salt poisoning.",
                onsetTime: OnsetTime(
                    early: "Vomiting is typically the first sign and may appear within a few hours of ingestion",
                    delayed: "Neurological signs (tremors, seizures, incoordination) may develop as sodium levels rise; death can occur within 24-48 hours in severe untreated cases"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Excessive thirst",
                    "Excessive urination",
                    "Lethargy or depression",
                    "Loss of appetite",
                    "Incoordination (walking drunk)",
                    "Muscle tremors",
                    "Seizures",
                    "Coma (in severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are frequently affected due to eating play dough, de-icing salt, or drinking sea water at the beach"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats can develop toxicity from ocean water exposure or licking salt from surfaces"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are also susceptible to salt toxicity")
                ],
                preventionTips: [
                    "Keep homemade play dough and salt dough out of pet reach—these contain dangerously high salt levels",
                    "Prevent pets from drinking sea water at the beach; bring fresh water for them",
                    "Store rock salt and de-icing products in sealed containers in the garage, out of pet reach",
                    "Wipe your pet's paws with a damp cloth or pet-safe wipes after winter walks to remove ice melt residue",
                    "Consider using pet booties in winter to protect paws from ice melt chemicals",
                    "Apply paw balm or wax before walks to create a protective barrier",
                    "Prevent pets from licking ice melt off the ground or eating snow in treated areas",
                    "\"Pet-safe\" or \"pet-friendly\" ice melts are less irritating but can still cause GI upset if ingested—no ice melt is truly safe",
                    "Rinse and dry paws thoroughly if your pet shows signs of irritation (licking paws, limping, red skin)",
                    "Avoid sharing salty snacks like chips, pretzels, or salted popcorn with pets",
                    "Never use salt to induce vomiting—this outdated practice can cause salt poisoning"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Fatty Foods & Grease
            ToxicItem(
                id: UUID(uuidString: "2e094121-64ea-499c-bfb4-6db98f139b55")!,
                name: "Fatty Foods & Grease",
                alternateNames: ["fat trimmings", "grease", "bacon grease", "meat drippings", "turkey skin", "chicken skin", "gravy", "fried foods", "greasy foods", "table scraps", "lard", "cooking oil", "butter", "bacon", "pork fat", "beef fat", "schmaltz", "duck fat"],
                categories: [.foods, .holidayHazards],
                imageAsset: "bacon_turkey_skin",
                description: "Fatty foods include meat trimmings, poultry skin, bacon, gravy, fried foods, butter, and cooking grease. While commonly shared as table scraps or treats, high-fat foods pose significant health risks to pets even though they are not technically toxic.",
                toxicityInfo: "Fatty foods are not poisonous in the traditional sense, but they can cause serious gastrointestinal problems. High-fat meals can trigger gastroenteritis (inflammation of the stomach and intestines) or pancreatitis (inflammation of the pancreas). Pancreatitis occurs when digestive enzymes activate prematurely within the pancreas, causing the organ to essentially digest itself. This can lead to severe pain, organ damage, diabetes, and in serious cases, death. Certain breeds are genetically predisposed to pancreatitis.",
                onsetTime: OnsetTime(
                    early: "Vomiting and diarrhea may occur within hours of ingestion",
                    delayed: "Pancreatitis symptoms typically develop 1-4 days after a fatty meal; some cases may not show signs until several days later"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea (may contain blood)",
                    "Loss of appetite",
                    "Abdominal pain",
                    "Lethargy or weakness",
                    "Hunched posture or 'praying position' (front legs down, rear end up)",
                    "Fever",
                    "Dehydration"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are commonly affected; miniature schnauzers, Yorkshire terriers, cocker spaniels, and poodles are at higher risk; overweight and older dogs also more susceptible"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats are less commonly affected by diet-induced pancreatitis; feline pancreatitis often occurs spontaneously or with other conditions like inflammatory bowel disease")
                ],
                preventionTips: [
                    "Never feed pets table scraps, especially fatty meat trimmings or poultry skin",
                    "Secure garbage cans to prevent scavenging",
                    "Be especially vigilant during holidays when fatty foods are more accessible",
                    "Inform guests not to share food with pets",
                    "Keep plates and serving dishes out of reach of counter-surfing pets",
                    "Store cooking grease and drippings securely before disposal"
                ],
                sources: ["Pet Poison Helpline", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "American Veterinary Medical Association (JAVMA)"],
                relatedEntries: nil
            ),

            // MARK: - Cooked Bones
            ToxicItem(
                id: UUID(uuidString: "59cf7dc4-5d83-4811-97f1-ce1d0162cd28")!,
                name: "Cooked Bones",
                alternateNames: ["chicken bones", "turkey bones", "pork bones", "beef bones cooked", "rib bones", "poultry bones", "fish bones", "lamb bones cooked", "ham bones", "steak bones", "pork chop bones", "t-bone", "drumstick bones", "wing bones", "spare ribs"],
                categories: [.foods, .holidayHazards],
                imageAsset: "cooked_bones",
                description: "Cooked bones from meat, poultry, or fish are common table scraps that pose serious mechanical hazards to pets. Cooking causes bones to become brittle and prone to splintering into sharp fragments when chewed.",
                toxicityInfo: "Cooked bones are not toxic, but they present dangerous mechanical risks. When cooked, bones lose moisture and become brittle, causing them to splinter into sharp shards when chewed. These fragments can cause lacerations to the mouth, throat, and digestive tract; become lodged in the esophagus or intestines causing obstruction; or perforate the stomach or intestinal wall, leading to life-threatening peritonitis (infection of the abdominal cavity). Bone fragments may require endoscopic removal or emergency surgery.",
                onsetTime: OnsetTime(
                    early: "Choking, gagging, or oral injuries may occur immediately during or after chewing",
                    delayed: "Signs of obstruction or perforation may develop 12-72 hours after ingestion; some cases may not show symptoms for several days"
                ),
                symptoms: [
                    "Choking or gagging",
                    "Excessive drooling",
                    "Pawing at mouth",
                    "Difficulty swallowing",
                    "Vomiting or retching",
                    "Bloody stool or constipation",
                    "Straining to defecate",
                    "Abdominal pain or bloating",
                    "Loss of appetite",
                    "Lethargy",
                    "Signs of shock (pale gums, rapid breathing, collapse) if perforation occurs"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs commonly chew and swallow bone fragments; larger pieces pose obstruction risk, smaller splinters pose perforation risk"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats may chew on smaller bones like fish or poultry; fish bones are particularly hazardous due to their thin, sharp structure")
                ],
                preventionTips: [
                    "Never give pets cooked bones of any kind",
                    "Dispose of bones in secure, pet-proof containers immediately after meals",
                    "Be especially cautious during holidays when bone-in meats are common",
                    "Inform guests not to give bones to pets",
                    "If you want to give your dog a bone, consult your veterinarian about appropriate raw bone options and supervision requirements"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "American Kennel Club", "FDA (U.S. Food and Drug Administration)"],
                relatedEntries: nil
            ),

            // MARK: - Milk & Dairy Products
            ToxicItem(
                id: UUID(uuidString: "9bc97e12-961b-4fee-adee-182c55d91ea9")!,
                name: "Milk & Dairy Products",
                alternateNames: ["milk", "cow's milk", "cheese", "ice cream", "yogurt", "cream", "butter", "cottage cheese", "sour cream", "whipped cream", "half and half", "lactose", "dairy", "cheddar", "mozzarella", "parmesan", "cream cheese", "whole milk", "skim milk"],
                categories: [.foods],
                imageAsset: "milk_dairy",
                description: "Milk and dairy products include cow's milk, cheese, ice cream, yogurt, cream, butter, and other foods derived from animal milk. Despite the popular image of cats drinking milk from a saucer, most adult dogs and cats cannot properly digest dairy products.",
                toxicityInfo: "Milk and dairy products are not toxic, but most adult pets are lactose intolerant. Puppies and kittens produce an enzyme called lactase that allows them to digest their mother's milk. As pets mature and are weaned, their bodies produce less lactase, making it difficult to break down lactose (the sugar in milk). When lactose passes undigested into the intestines, bacteria ferment it, causing gastrointestinal upset. Additionally, high-fat dairy products like ice cream and cheese can contribute to pancreatitis, particularly in dogs. Some pets tolerate small amounts of dairy or lower-lactose products (like aged cheese or yogurt) without issue, while others are highly sensitive. Important: Some dairy alternatives and sugar-free dairy products contain xylitol, an artificial sweetener that is extremely toxic to dogs. Always check ingredient labels.",
                onsetTime: OnsetTime(
                    early: "Symptoms typically appear within 12 hours of dairy consumption",
                    delayed: "Most symptoms resolve within 24 hours if no additional dairy is consumed; persistent symptoms may indicate a larger amount was consumed or a secondary issue like pancreatitis"
                ),
                symptoms: [
                    "Diarrhea (most common sign)",
                    "Gas and flatulence",
                    "Bloating",
                    "Abdominal discomfort or cramping",
                    "Vomiting",
                    "Nausea",
                    "Loose or watery stool"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Many dogs are lactose intolerant but some retain the ability to digest dairy; high-fat dairy poses additional pancreatitis risk"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats are more likely to be lactose intolerant than dogs; despite popular belief, milk is not recommended for cats")
                ],
                preventionTips: [
                    "Avoid giving pets milk or dairy products as treats",
                    "Never substitute cow's milk for mother's milk in orphaned puppies or kittens; use species-appropriate milk replacers instead",
                    "If you want to offer dairy, start with a very small amount and monitor for symptoms",
                    "Lower-lactose options like plain yogurt or aged cheese may be better tolerated in small quantities",
                    "Always check labels on dairy products and dairy alternatives for xylitol",
                    "Keep ice cream and other high-fat dairy away from pets prone to pancreatitis"
                ],
                sources: ["ASPCA Animal Poison Control Center", "PetMD", "VCA Animal Hospitals", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Black Walnuts
            ToxicItem(
                id: UUID(uuidString: "6349efb2-07ef-4da1-a8cc-bbd6dc338f77")!,
                name: "Black Walnuts",
                alternateNames: ["black walnut tree", "Juglans nigra", "black walnut wood", "black walnut shavings", "walnut hulls", "black walnut sawdust", "juglone", "walnut shells"],
                categories: [.foods, .plants],
                imageAsset: "black_walnuts",
                description: "Black walnuts come from the black walnut tree (Juglans nigra), common in parks and yards throughout eastern North America. The tree is grown for its premium hardwood and edible nuts. Dogs may be exposed to fallen nuts, hulls, sawdust, wood shavings, or branches. Importantly, there are two distinct clinical syndromes depending on which part of the tree is ingested.",
                toxicityInfo: "Black walnuts can cause two different clinical syndromes in dogs. Wood and shavings (including sawdust and branches) cause primarily neurologic and musculoskeletal signs—the relative risk of developing neurologic signs after ingesting wood is approximately 4 times higher than after ingesting nuts or hulls. Nuts and hulls most commonly cause vomiting and GI upset, with fewer neurologic signs. The toxicity is often attributed to tremorgenic mycotoxins (mold) on decomposing nuts, but fresh wood can also cause toxicity. Juglone, a naturally occurring compound found in all parts of the black walnut tree (highest concentrations in buds, nut hulls, and roots), is a respiration inhibitor that may also contribute to toxicity in dogs. Even small exposures to sawdust have caused clinical signs in some dogs. Note: English walnuts (the kind sold in grocery stores) are not considered toxic, though they can cause GI upset if eaten in large amounts.",
                onsetTime: OnsetTime(
                    early: "Signs from wood/shavings may appear within minutes to 19 hours; signs from nuts/hulls may appear within minutes to hours",
                    delayed: "Most clinical signs resolve within 9-33 hours with supportive care; all dogs with documented follow-up recovered fully"
                ),
                symptoms: [
                    "Vomiting",
                    "Lethargy or subdued behavior",
                    "Generalized or hind limb weakness",
                    "Stiffness",
                    "Ataxia (incoordination)",
                    "Tremors or muscle fasciculations",
                    "Diarrhea",
                    "Disorientation",
                    "Seizures (severe cases, more common with wood ingestion)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are commonly affected; neurologic signs are 4x more likely with wood/shavings than with nuts/hulls; Labrador retrievers and golden retrievers overrepresented in case reports"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Limited data; cats less commonly exposed due to feeding habits")
                ],
                preventionTips: [
                    "Keep dogs away from black walnut trees, especially fallen nuts and debris",
                    "Do not use black walnut shavings or sawdust as bedding",
                    "Rake up fallen walnuts, hulls, and branches regularly",
                    "Be extra vigilant in fall (September-December) when nuts are dropping and in spring when buried nuts resurface",
                    "If you have black walnut trees cut down or trimmed, keep dogs away from sawdust and debris"
                ],
                sources: ["Veterinary Information Network (VIN) - ASPCA APCC Case Series Study", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Fruit Pits & Seeds
            ToxicItem(
                id: UUID(uuidString: "f1369ae0-b97d-424d-98b7-b46a9b245109")!,
                name: "Fruit Pits & Seeds",
                alternateNames: ["apple seeds", "apple core", "cherry pits", "cherry seeds", "peach pits", "peach seeds", "apricot pits", "apricot seeds", "plum pits", "plum seeds", "nectarine pits", "stone fruit pits", "cyanogenic glycosides", "amygdalin"],
                categories: [.foods],
                imageAsset: "fruit_pits",
                description: "The pits and seeds of certain common fruits—including apples, cherries, peaches, apricots, plums, and nectarines—contain compounds that can release cyanide when crushed. However, the primary risk to most pets is actually choking and intestinal obstruction rather than cyanide poisoning.",
                toxicityInfo: "The pits and seeds of certain fruits—including apples, cherries, peaches, apricots, plums, and nectarines—contain cyanogenic glycosides (primarily amygdalin), which can release hydrogen cyanide when crushed. However, cyanide poisoning from fruit pits is rare in dogs and cats for several reasons: the seeds must be thoroughly crushed (not just swallowed whole), a large quantity of crushed seeds is required to cause toxicity, and the bitter taste discourages consumption. This type of toxicity is more commonly a concern for grazing animals. Leaves and stems may cause hypersalivation and GI irritation from natural resins, separate from any cyanide concern. The more common and immediate danger for pets is mechanical: pits can cause choking, tooth fractures, or intestinal obstruction requiring surgery—especially in smaller dogs.",
                onsetTime: OnsetTime(
                    early: "Choking or GI obstruction signs may occur immediately to 24 hours after ingestion; cyanide poisoning signs (if seeds were thoroughly crushed) can appear within 15-30 minutes",
                    delayed: "Signs of obstruction may develop over 24-72 hours as the pit moves through (or gets stuck in) the digestive tract"
                ),
                symptoms: [
                    "Vomiting",
                    "Decreased appetite",
                    "Constipation or straining to defecate",
                    "Abdominal pain or bloating",
                    "Lethargy",
                    "Hypersalivation (from leaf/stem irritation)",
                    "Difficulty breathing (rare, cyanide poisoning)",
                    "Bright red gums (rare, cyanide poisoning)",
                    "Dilated pupils (rare, cyanide poisoning)",
                    "Weakness or collapse (rare, cyanide poisoning)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Obstruction is the primary concern, especially in smaller dogs; cyanide poisoning is rare unless large quantities of seeds are thoroughly crushed and consumed"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats are very unlikely to consume enough pits or seeds to cause cyanide toxicity; leaves may cause hypersalivation from natural resins")
                ],
                preventionTips: [
                    "Always remove pits and cores before sharing fruit with pets",
                    "Dispose of fruit pits in secure, pet-proof trash containers",
                    "Pick up fallen fruit from under fruit trees regularly",
                    "Do not let pets chew on fruit tree branches, leaves, or pruned material",
                    "Keep compost bins secure; fermenting fruit can also cause alcohol toxicity",
                    "A single swallowed pit may pass without issue, but contact your vet for guidance, especially for smaller dogs"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Moldy Foods
            ToxicItem(
                id: UUID(uuidString: "beacabe2-00ab-4e59-8c8c-c09665f940b6")!,
                name: "Moldy Foods",
                alternateNames: ["moldy bread", "moldy cheese", "spoiled food", "rotten food", "compost", "garbage", "trash", "mycotoxins", "tremorgenic mycotoxins", "moldy walnuts", "moldy nuts", "penitrem-A", "roquefortine"],
                categories: [.foods],
                imageAsset: "moldy_bread_cheese",
                description: "Moldy or spoiled foods—including bread, cheese, nuts, pasta, and other items found in trash or compost—can contain dangerous fungal toxins called tremorgenic mycotoxins. Dogs that roam, scavenge, or have access to garbage or compost bins are most commonly affected.",
                toxicityInfo: "Certain molds that grow on spoiled foods produce tremorgenic mycotoxins, including penitrem-A and roquefortine C. These are classified as neurotoxins that affect the nervous system. While the exact mechanism is not fully understood, studies suggest penitrem-A inhibits glycine, an inhibitory neurotransmitter. The severity of signs varies from mild to severe depending on the type and amount of mycotoxin ingested. Moldy walnuts (especially black walnuts), moldy dairy products, and decomposing food in compost piles are common sources. With early aggressive treatment, prognosis is generally good.",
                onsetTime: OnsetTime(
                    early: "Tremors and neurologic signs can develop within hours of ingestion",
                    delayed: "Signs may persist for several days even with treatment; full recovery typically occurs with supportive care"
                ),
                symptoms: [
                    "Muscle tremors (often the first sign)",
                    "Ataxia (incoordination, 'walking drunk')",
                    "Seizures or convulsions",
                    "Vomiting",
                    "Hyperthermia (elevated body temperature)",
                    "Restlessness or agitation",
                    "Stiffness",
                    "Weakness"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are most commonly affected due to scavenging behavior; roaming dogs and those with access to garbage or compost are at highest risk"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats may also be affected but are less likely to consume moldy food due to more selective eating habits")
                ],
                preventionTips: [
                    "Secure all garbage cans with tight-fitting, pet-proof lids",
                    "Keep compost bins enclosed and inaccessible to pets",
                    "Do not leave food out to spoil; refrigerate or dispose of leftovers promptly",
                    "Supervise dogs outdoors, especially those prone to scavenging",
                    "Pick up fallen fruit and nuts from your yard before they decompose",
                    "Never intentionally feed moldy food to pets—even 'a little mold' can be dangerous"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Lilies (True Lilies)
            ToxicItem(
                id: UUID(uuidString: "419a437f-3834-47e1-934a-5fa379b98a00")!,
                name: "Lilies (True Lilies)",
                alternateNames: ["Easter lily", "Asiatic lily", "Tiger lily", "Stargazer lily", "Oriental lily", "Japanese show lily", "Rubrum lily", "Red lily", "Western lily", "Wood lily", "Daylily", "Hemerocallis", "Lilium", "Lilium longiflorum", "Lilium tigrinum", "Lilium speciosum", "Lilium auratum", "lily bouquet", "lily flower", "lily pollen"],
                categories: [.plants, .holidayHazards],
                imageAsset: "lily",
                description: "True lilies (Lilium species) and daylilies (Hemerocallis species) are popular flowering plants found in gardens, bouquets, and floral arrangements. They are especially common during Easter, Mother's Day, and other holidays. These lilies are extremely dangerous to cats — even tiny exposures can cause fatal kidney failure.",
                toxicityInfo: "True lilies are extremely toxic to cats. The toxic principle has not been identified, but all parts of the plant are dangerous — including the petals, leaves, pollen, and even the water in the vase. Cats can be poisoned by chewing on leaves or petals, grooming pollen off their fur, or drinking water from a vase containing lilies. Even very small exposures can cause acute kidney failure within 24-72 hours. Without aggressive early treatment, the damage is often irreversible and fatal. Importantly, lily toxicity has not been documented in dogs — this appears to be a cat-specific sensitivity. Note: Not all plants with 'lily' in the name are true lilies. Peace lilies (Spathiphyllum), Calla lilies (Zantedeschia), and Lily of the Valley (Convallaria) are NOT true lilies and cause toxicity through different mechanisms — see separate entries for these plants.",
                onsetTime: OnsetTime(
                    early: "Vomiting typically begins within 2 hours of ingestion; other early signs include drooling, loss of appetite, lethargy, and depression — these may appear within 6-12 hours",
                    delayed: "Signs of kidney failure develop 24-72 hours after exposure: increased thirst and urination initially, followed by decreased or absent urination as kidneys fail; without treatment, death typically occurs within 3-6 days"
                ),
                symptoms: [
                    "Vomiting (often the first sign)",
                    "Drooling or excessive salivation",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Hiding or withdrawn behavior",
                    "Increased thirst and urination (early kidney involvement)",
                    "Decreased or absent urination (kidney failure progressing)",
                    "Dehydration",
                    "Disorientation",
                    "Seizures (terminal stages)",
                    "Death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .cat, severity: .severe, notes: "EXTREMELY TOXIC — even tiny exposures (a few pollen grains, one leaf bite, vase water) can cause fatal kidney failure; all cats are susceptible regardless of age or health status"),
                    SpeciesRisk(species: .dog, severity: .low, notes: "True lily toxicity (kidney failure) has not been documented in dogs; severity is 'low' rather than 'none' because ingestion of plant material may still cause mild GI upset such as vomiting or diarrhea")
                ],
                preventionTips: [
                    "Never bring true lilies (Easter, Asiatic, Tiger, Stargazer, Oriental, Daylilies) into homes with cats — there is no safe way to have these plants around cats",
                    "Check all flower bouquets and arrangements carefully before bringing them home; request 'no lilies' when ordering flowers",
                    "If you receive a bouquet containing lilies, remove and dispose of them immediately before your cat can access them",
                    "Be especially vigilant during Easter, Mother's Day, and other holidays when lily arrangements are common gifts",
                    "If your cat has any potential exposure to lilies — even brushing against pollen — seek veterinary care immediately; do not wait for symptoms",
                    "Educate family members, pet sitters, and houseguests about the danger of lilies to cats"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Sago Palm
            ToxicItem(
                id: UUID(uuidString: "7e96af6d-05e2-438b-8391-70087f947bcb")!,
                name: "Sago Palm",
                alternateNames: ["cycad", "Cycas revoluta", "Cycas circinalis", "Zamia", "cardboard palm", "coontie", "queen sago", "king sago", "Japanese cycad", "Australian nut palm", "fern palm", "false sago palm", "iron tree", "cycad palm", "comptie", "Seminole bread", "Florida arrowroot", "bonsai palm", "sago cycas"],
                categories: [.plants],
                imageAsset: "sago_palm",
                description: "Sago palms are ancient seed plants with a stout trunk and large crown of feathery compound leaves. Despite the name, they are not true palms — they are cycads. Found naturally in tropical and subtropical regions, they are popular landscaping plants in the southern United States (especially Florida, Texas, and Gulf Coast states) and are increasingly kept as houseplants and bonsai in other regions. This indoor cultivation trend has brought sago palms into areas where they previously did not exist, increasing pet exposure risk.",
                toxicityInfo: "All parts of the sago palm are toxic, but the seeds (nuts) from the female plant are the most dangerous — ingesting as little as one seed has caused death in dogs. The primary toxin is cycasin, which causes severe liver damage and gastrointestinal injury. Another compound, BMAA (β-methylamino-L-alanine), acts as a neurotoxin. There is no antidote for sago palm poisoning; treatment is entirely supportive. Mortality rates can be as high as 50%. Early, aggressive veterinary care significantly improves survival.",
                onsetTime: OnsetTime(
                    early: "Gastrointestinal signs (vomiting, diarrhea, drooling, loss of appetite) typically appear within hours of ingestion — vomiting occurs in 80-90% of affected dogs",
                    delayed: "Neurologic signs (tremors, ataxia, seizures) and liver failure may develop 1-3 days after ingestion; liver damage may continue to progress for weeks after exposure"
                ),
                symptoms: [
                    "Vomiting (occurs in 80-90% of cases)",
                    "Diarrhea (may contain blood)",
                    "Drooling and hypersalivation",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Abdominal pain",
                    "Jaundice or yellowing of skin, gums, or eyes (liver failure)",
                    "Tremors",
                    "Ataxia (lack of coordination, stumbling)",
                    "Seizures or convulsions",
                    "Head pressing",
                    "Confusion or decreased responsiveness",
                    "Bleeding abnormalities (bruising, blood in stool, pale gums)",
                    "Collapse or coma",
                    "Death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are most commonly affected; young dogs are especially prone to chewing on the plant; even one seed can be fatal"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "No published case reports exist in cats, but toxic effects are anticipated to be the same as or worse than in dogs; cats should be considered equally at risk"),
                    SpeciesRisk(species: .bird, severity: .low, notes: "Insufficient data on cycad toxicity in birds; avoid exposure as a precaution")
                ],
                preventionTips: [
                    "Do not keep sago palms or any cycad species in homes or yards where dogs or cats have access",
                    "If you have sago palms in your landscaping, consider removing them entirely or fencing them off completely",
                    "Be aware that sago palms are increasingly sold as indoor bonsai plants — these are equally toxic",
                    "The seeds (large orange-red nuts) are the most toxic part; if your plant is female and produces seeds, the risk is even higher",
                    "Young dogs are especially prone to chewing on plants — supervise puppies around all landscaping",
                    "If you suspect any exposure, seek emergency veterinary care immediately — do not wait for symptoms to appear"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Azalea, Rhododendron & Mountain Laurel
            ToxicItem(
                id: UUID(uuidString: "674ec507-669c-4a1c-8bf5-cb745b03c2a7")!,
                name: "Azalea, Rhododendron & Mountain Laurel",
                alternateNames: ["azalea", "rhododendron", "Rhododendron spp", "rosebay", "great laurel", "wild honeysuckle", "azalea bush", "rhododendron bush", "Mountain laurel", "mountain laurel", "Kalmia", "Kalmia latifolia", "calico bush", "spoonwood", "American laurel", "ivy bush", "sheep laurel", "Kalmia angustifolia", "lambkill", "bog laurel", "Kalmia polifolia", "swamp laurel"],
                categories: [.plants],
                imageAsset: "azalea",
                description: "Azalea, Rhododendron, and Mountain Laurel are all members of the Heath family (Ericaceae) that contain grayanotoxins — a group of toxins that affect sodium channels in cell membranes. These popular landscaping plants are found throughout North America in gardens, parks, and wild areas. All parts of the plants are toxic, including the leaves, flowers, nectar, and even honey made from the flower nectar. Rhododendrons and azaleas are among the most commonly planted ornamental shrubs, while mountain laurel is common in eastern U.S. forests and increasingly used in landscaping.",
                toxicityInfo: "Azaleas, rhododendrons, and mountain laurels contain grayanotoxins (also called andromedotoxins) — a class of toxins that bind to sodium channels and keep them open, disrupting normal nerve and muscle function. All parts of these plants are toxic: leaves, flowers, nectar, pollen, and even honey produced from the nectar ('mad honey'). The toxin concentration can vary considerably between individual plants based on cultivar, climate, soil, and other growing conditions — so while some plants may cause only mild vomiting and diarrhea if ingested, others may cause serious cardiovascular or neurological effects.\n\nGrayanotoxins affect the heart by disrupting normal electrical conduction, leading to potentially life-threatening arrhythmias and changes in heart rate and blood pressure. They also affect the nervous system, causing weakness, incoordination, and in severe cases, paralysis.\n\n**Mountain Laurel (Kalmia latifolia):** This plant contains the same grayanotoxins as azaleas and rhododendrons and poses equal hazards to pets. It is common in eastern U.S. forests and mountain areas, and is also used as an ornamental landscape shrub. As with the other plants in this family, honey made from mountain laurel flowers can also be toxic.",
                onsetTime: OnsetTime(
                    early: "Vomiting and drooling typically appear within a few hours of ingestion; most signs develop within 12 hours",
                    delayed: "Cardiac signs can continue for days even after initial GI symptoms resolve; prolonged cardiac effects lasting up to 14 days have been reported in severe cases"
                ),
                symptoms: [
                    "Vomiting (most common sign)",
                    "Drooling and hypersalivation",
                    "Diarrhea (less common)",
                    "Loss of appetite",
                    "Weakness",
                    "Abdominal pain",
                    "Abnormal heart rate (too fast or too slow)",
                    "Low blood pressure",
                    "Tremors",
                    "Difficulty breathing",
                    "CNS depression or lethargy",
                    "Collapse",
                    "Coma (severe cases)",
                    "Death (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Most cases result in GI upset only (vomiting in ~29% of cases); cardiac arrhythmias are rare (~2%) because dogs typically do not eat enough to cause severe toxicity; large ingestions can be serious"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Vomiting is the main sign; diarrhea is rare in cats; cardiac signs can persist for days if they occur — veterinary evaluation recommended for any ingestion"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are highly susceptible to grayanotoxins due to their small body mass; birds that chew on leaves or flowers are at risk")
                ],
                preventionTips: [
                    "Supervise pets in yards where azaleas or rhododendrons are planted",
                    "Consider fencing off azalea beds or removing plants if your pet is prone to chewing on vegetation",
                    "Be aware that all parts are toxic — including fallen flowers and leaves",
                    "If you see your pet chewing on azalea, contact your veterinarian even if no symptoms are present yet",
                    "Be aware that mountain laurel grows wild in many eastern U.S. forests — keep pets supervised when hiking in these areas",
                    "All three plants (azalea, rhododendron, mountain laurel) pose the same level of risk — do not assume one is safer than others"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Tulips & Hyacinths
            ToxicItem(
                id: UUID(uuidString: "81d94db6-b452-4997-818a-fb89fde196fa")!,
                name: "Tulips & Hyacinths",
                alternateNames: ["tulip", "tulip bulb", "Tulipa", "Tulipa spp", "hyacinth", "hyacinth bulb", "Hyacinthus", "Hyacinthus orientalis", "Dutch hyacinth", "garden hyacinth", "spring bulbs", "flower bulbs", "tulipalin", "tuliposide"],
                categories: [.plants, .holidayHazards],
                imageAsset: "tulips_hyacinths",
                description: "Tulips and hyacinths are popular spring-flowering bulbs found in gardens, landscaping, and cut flower arrangements. Both belong to the Liliaceae (lily) family and share the same toxic compounds. Pets are most commonly poisoned when dogs dig up freshly planted bulbs or gain access to a bag of unplanted bulbs.",
                toxicityInfo: "Tulips and hyacinths contain allergenic lactones called tuliposides A and B, which are converted to the irritating compounds tulipalin A and B on contact with tissue. These plants also contain calcium oxalate crystals, which cause additional irritation. The toxic compounds are most concentrated in the bulbs — the leaves and flowers contain much lower levels and typically cause only mild, transient GI upset. Bulb ingestion can cause intense vomiting, diarrhea, and dehydration. Large ingestions of bulbs (rare) can cause more serious cardiovascular and respiratory effects. There is no specific antidote, but prognosis is excellent with timely supportive care. Note: Handling tulip and hyacinth bulbs can also cause skin irritation ('tulip fingers') in people — wash hands after planting.",
                onsetTime: OnsetTime(
                    early: "Vomiting, drooling, and GI upset typically appear within a few hours of ingestion",
                    delayed: "Most cases resolve within 24 hours with supportive care; severe cases involving large bulb ingestions may require monitoring for cardiovascular effects"
                ),
                symptoms: [
                    "Vomiting",
                    "Hypersalivation (drooling)",
                    "Diarrhea",
                    "Depression or lethargy",
                    "Loss of appetite",
                    "Oral irritation (pawing at mouth)",
                    "Dehydration (with significant vomiting/diarrhea)",
                    "Increased heart rate (large ingestions, rare)",
                    "Difficulty breathing (large ingestions, rare)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are most commonly affected because they dig up and chew on bulbs; ingestion of flowers or leaves typically causes only mild, transient GI upset"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats may chew on leaves or flowers; bulb ingestion is less common but equally dangerous; note that cats with nausea may seek out plants to help them vomit, so plant material in vomitus is not always the primary cause of illness"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Birds may be affected if they chew on plant material; limited data available")
                ],
                preventionTips: [
                    "Store unplanted bulbs in a secure location out of pet reach — a bag of bulbs is a common source of serious poisoning",
                    "Supervise dogs in the garden during planting season; consider fencing off freshly planted bulb beds",
                    "If your dog is a digger, avoid planting tulips and hyacinths in areas they can access",
                    "Keep cut tulips and hyacinths in vases out of pet reach; the water may also contain irritating compounds",
                    "If you see your pet chewing on tulip or hyacinth plants, contact your veterinarian even if symptoms haven't appeared yet"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "DVM360"],
                relatedEntries: nil
            ),

            // MARK: - Oleander
            ToxicItem(
                id: UUID(uuidString: "00270080-3cce-4b30-b9ee-571f90e92371")!,
                name: "Oleander",
                alternateNames: ["Nerium oleander", "common oleander", "rose bay", "rosebay", "yellow oleander", "Thevetia peruviana", "white oleander", "pink oleander", "red oleander", "oleander bush", "oleander shrub", "adelfa", "laurier rose"],
                categories: [.plants],
                imageAsset: "oleander",
                description: "Oleander is a large evergreen flowering shrub commonly found in warm climates, particularly in the southwestern United States, California, Texas, and Hawaii. It is widely planted as an ornamental in gardens and along highways due to its drought tolerance and showy flowers (white, pink, red, or yellow). Despite its beauty, oleander is one of the most toxic plants to pets and humans.",
                toxicityInfo: "Oleander contains cardiac glycosides, primarily oleandrin, which block the sodium-potassium ATPase pump in heart muscle cells. This causes dangerous electrolyte imbalances (hyperkalemia), increased intracellular calcium, and disruption of normal heart rhythm. All parts of the plant are extremely toxic — including the leaves, flowers, stems, roots, seeds, sap, and even water from a vase containing oleander cuttings. Animals have been fatally poisoned by ingesting just a few leaves, drinking water in which leaves were floating, or eating meat cooked on oleander wood skewers. There is an antidote (digoxin-specific Fab fragments), but it is rarely used due to cost. With aggressive supportive care, prognosis in small animals is fair to good. Note: Other plants in the cardiac glycoside family include foxglove, lily of the valley, kalanchoe, and milkweed — see separate entries for these plants. Pot-bellied pigs are also highly susceptible to oleander toxicity.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, drooling, abdominal pain, diarrhea) typically appear within 30 minutes to a few hours of ingestion",
                    delayed: "Cardiovascular and neurologic signs may develop within hours; effects may persist for 1-3 days even with treatment"
                ),
                symptoms: [
                    "Vomiting",
                    "Profuse drooling (hypersalivation)",
                    "Abdominal pain",
                    "Diarrhea (may be bloody)",
                    "Depression or lethargy",
                    "Loss of appetite",
                    "Cold extremities",
                    "Abnormal heart rate (bradycardia or tachycardia)",
                    "Irregular heart rhythm (arrhythmias)",
                    "Weakness or collapse",
                    "Tremors",
                    "Dilated pupils (mydriasis)",
                    "Seizures",
                    "Sudden death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are highly susceptible; even small amounts can cause life-threatening cardiac effects; this toxicosis is less commonly seen in small animal practice but poses significant risk when it occurs"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are highly susceptible to cardiac glycosides; smaller body size increases risk from even minimal exposure"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds (including budgerigars and parakeets) are susceptible to oleander toxicity")
                ],
                preventionTips: [
                    "Do not plant oleander in yards where pets have access — there is no safe way to have this plant around animals",
                    "If you have existing oleander, consider removing it or fencing it off completely",
                    "Never allow pets to drink from containers that have held oleander cuttings — the water is toxic",
                    "Do not use oleander branches as sticks or skewers — the toxin survives cooking",
                    "Be aware that oleander is commonly planted along highways and in public spaces in warm climates",
                    "Do not burn oleander clippings — the smoke can also be toxic if inhaled"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "DVM360"],
                relatedEntries: nil
            ),

            // MARK: - Autumn Crocus
            ToxicItem(
                id: UUID(uuidString: "741c92ff-a3da-4512-967c-628e8783cff8")!,
                name: "Autumn Crocus",
                alternateNames: ["Colchicum autumnale", "meadow saffron", "naked ladies", "naked boys", "fall crocus", "wonder bulb", "colchicum", "Colchicum", "crocus (autumn)"],
                categories: [.plants],
                imageAsset: "autumn_crocus",
                description: "Autumn crocus is a fall-blooming flowering plant with pink to purple crocus-like flowers. Despite its common name, it is NOT related to true crocuses — it belongs to a completely different plant family. The flowers emerge from the ground in autumn without leaves (hence the name 'naked ladies'), while the tulip-like leaves appear in spring. It is cultivated as an ornamental but is one of the most toxic plants to pets.",
                toxicityInfo: "Autumn crocus contains colchicine, a potent cell poison that stops cell division by binding to tubulin and preventing microtubule formation. Because it targets rapidly dividing cells, the GI tract lining and bone marrow are affected first and most severely. Poisoning progresses through distinct phases: an initial GI phase (oral irritation, bloody vomiting and diarrhea), followed by multi-organ effects in animals that survive the acute phase. All parts of the plant are toxic, with the highest concentrations in the seeds and corms (bulbs). There is no antidote — treatment is supportive only. IMPORTANT: Do not confuse autumn crocus with spring crocus (Crocus species), which is a completely different plant that causes only mild GI upset. If you are unsure which type of crocus your pet ingested, assume the worst and seek veterinary care immediately.",
                onsetTime: OnsetTime(
                    early: "GI signs (oral irritation, bloody vomiting, diarrhea, abdominal pain) can be delayed up to 10 hours after ingestion",
                    delayed: "Bone marrow suppression and multi-organ effects develop a few days after the initial GI signs in animals that survive the acute phase; recovery can take weeks"
                ),
                symptoms: [
                    "Oral irritation",
                    "Vomiting (often bloody)",
                    "Bloody diarrhea",
                    "Severe abdominal pain",
                    "Profuse drooling (hypersalivation)",
                    "Difficulty swallowing",
                    "Extreme thirst",
                    "Weakness and lethargy",
                    "Dehydration",
                    "Shock",
                    "Respiratory distress",
                    "Seizures",
                    "Bone marrow suppression (in survivors of acute phase)",
                    "Liver failure",
                    "Kidney failure",
                    "Cardiac arrhythmias",
                    "Death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Extremely toxic; even small amounts can cause life-threatening multi-organ failure; no antidote exists; prognosis is guarded even with aggressive treatment"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Extremely toxic; smaller body size increases risk; signs may be delayed up to 10 hours, making early recognition important"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are susceptible to colchicine toxicity; extremely small amounts can be fatal due to small body size")
                ],
                preventionTips: [
                    "Do not plant autumn crocus in areas accessible to pets",
                    "Learn to identify autumn crocus in both its fall (flowers only) and spring (leaves only) growth stages",
                    "The spring leaves can be confused with tulip leaves or wild garlic — keep pets away from areas where autumn crocus grows",
                    "If you have autumn crocus in your garden, consider removing it entirely or fencing it off",
                    "If you are unsure whether a crocus is spring crocus or autumn crocus, treat any ingestion as an emergency"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Insoluble Calcium Oxalate Plants
            ToxicItem(
                id: UUID(uuidString: "f52b8aba-d899-418b-8ce6-2844408a5e3c")!,
                name: "Insoluble Calcium Oxalate Plants",
                alternateNames: ["Dieffenbachia", "dumbcane", "dumb cane", "Philodendron", "heartleaf philodendron", "split-leaf philodendron", "Pothos", "golden pothos", "devil's ivy", "Peace lily", "Spathiphyllum", "Calla lily", "Zantedeschia", "Caladium", "angel wings", "Elephant ear", "Alocasia", "Colocasia", "Arrowhead vine", "Syngonium", "Monstera", "Swiss cheese plant", "Chinese evergreen", "Aglaonema", "Anthurium", "flamingo flower", "flamingo lily", "Araceae", "aroid", "arum family", "calcium oxalate crystals", "raphides", "ZZ plant", "Zamioculcas zamiifolia", "Zanzibar gem", "eternity plant", "aroid palm", "emerald palm", "Raven ZZ", "ZZ Raven", "Schefflera", "Schefflera actinophylla", "Schefflera arboricola", "umbrella tree", "umbrella plant", "dwarf umbrella tree", "octopus tree", "starleaf", "Queensland umbrella tree", "Australian ivy palm", "Jack-in-the-pulpit", "Arisaema", "Arisaema triphyllum", "Indian turnip", "bog onion", "brown dragon", "wild turnip", "dragon root", "pepper turnip", "three-leaved Indian turnip", "wake robin"],
                categories: [.plants],
                imageAsset: "pothos_philodendron",
                description: "The Araceae (aroid) family includes many of the most popular houseplants: Dieffenbachia (dumbcane), Philodendron, Pothos (devil's ivy), Peace lily, Calla lily, Caladium, Elephant ear, Monstera, Chinese evergreen, Anthurium, and Arrowhead vine. These plants are favored because they tolerate low light and infrequent watering, making them common in homes and offices. According to the ASPCA Animal Poison Control Center, the Araceae family is the most common plant exposure reported in pets. Also included in this family is the increasingly popular ZZ plant (Zamioculcas zamiifolia), known for its glossy, dark green leaves and extreme tolerance of neglect. Jack-in-the-pulpit (Arisaema triphyllum) is a native woodland wildflower in the same family, recognized by its distinctive hooded spathe and bright red berry cluster in fall — pets may encounter it on hiking trails or in wooded yards. Schefflera (umbrella tree), while belonging to a different plant family (Araliaceae), also contains insoluble calcium oxalate crystals and causes the same localized oral irritation.",
                toxicityInfo: "These plants contain insoluble calcium oxalate crystals called raphides — microscopic needle-sharp structures bundled inside specialized cells. When a pet bites or chews the plant, these crystals are forcibly ejected into the mouth and throat tissues, causing immediate intense pain. The crystals also contain irritating compounds like proteases that worsen local inflammation. Importantly, because the crystals are insoluble, they are NOT absorbed into the bloodstream and do NOT cause kidney damage — the effects are limited to the mouth, tongue, and throat. While symptoms can look alarming to pet owners (dramatic drooling, pawing at the mouth), the condition is generally self-limiting. The concentration of calcium oxalate varies between plants, so some cause more irritation than others. Note: 'Mother-in-law's tongue' can refer to both Dieffenbachia (covered here) and Snake Plant (Sansevieria), which contains different toxins — see separate entry for Snake Plant.\n\n**ZZ Plant (Zamioculcas zamiifolia)** — Despite sometimes being marketed as 'pet-safe,' ZZ plants are members of the Araceae family and contain the same insoluble calcium oxalate crystals. Chewing on the leaves or stems causes the same immediate oral pain and irritation as other plants in this group. The sap can also cause skin irritation on contact. Effects are localized and self-limiting — no systemic toxicity occurs.\n\n**Schefflera (Umbrella Tree)** — This popular indoor tree contains insoluble calcium oxalate crystals identical to those found in Araceae plants. Chewing on the leaves causes immediate oral pain, drooling, and pawing at the mouth. Effects are localized and self-limiting — no systemic toxicity occurs. The dwarf variety (Schefflera arboricola) is more common as a houseplant than the larger Queensland umbrella tree (Schefflera actinophylla).\n\n**Jack-in-the-pulpit (Arisaema)** — This native woodland wildflower contains the same insoluble calcium oxalate crystals as other Araceae family members. All parts are toxic, but the corm (underground bulb-like structure) and berries have the highest crystal concentration. The bright red berry cluster that forms in late summer and fall may attract curious pets on woodland walks. Despite the common name 'Indian turnip,' the raw corm is intensely acrid and causes severe oral pain if chewed. Effects are localized and self-limiting — no systemic toxicity occurs.",
                onsetTime: OnsetTime(
                    early: "Signs appear immediately or within minutes of chewing the plant — the pain response is rapid and dramatic",
                    delayed: "Symptoms typically resolve within 12-24 hours; severe swelling of the lips, tongue, or throat may take longer to subside"
                ),
                symptoms: [
                    "Hypersalivation (profuse drooling)",
                    "Pawing at the mouth or face",
                    "Oral pain",
                    "Swelling of the lips, tongue, or throat",
                    "Vomiting",
                    "Loss of appetite",
                    "Difficulty swallowing",
                    "Difficulty breathing (rare, if severe throat/laryngeal swelling occurs)",
                    "Eye pain, swelling, and sensitivity to light (rare, if ocular exposure)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Effects are localized to the mouth and throat; generally self-limiting; kidney damage does not occur with these plants"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats may be more likely to chew on houseplants; same localized, self-limiting effects; no systemic toxicity")
                ],
                preventionTips: [
                    "Keep Araceae family plants out of reach of pets, especially cats and puppies prone to chewing",
                    "Consider hanging planters or elevated plant stands",
                    "If your pet is a plant chewer, opt for pet-safe alternatives like spider plants, Boston ferns, or African violets",
                    "Supervise pets around houseplants and redirect chewing behavior",
                    "If you see your pet chewing on one of these plants, contact your veterinarian for guidance even though effects are usually mild"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Veterinary Information Network (VIN)", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Soluble Calcium Oxalate Plants
            ToxicItem(
                id: UUID(uuidString: "8e6a2493-6fc9-4ddd-83b1-acb7148fbdd4")!,
                name: "Soluble Calcium Oxalate Plants",
                alternateNames: ["Rhubarb", "rhubarb leaves", "garden rhubarb", "common rhubarb", "Rheum rhabarbarum", "Star fruit", "starfruit", "carambola", "Averrhoa carambola", "Shamrock", "shamrock plant", "Oxalis", "wood sorrel", "sorrel", "oxalic acid", "soluble oxalates", "Begonia", "Begonia spp", "wax begonia", "rex begonia", "tuberous begonia", "angel wing begonia", "begonia tuber", "elephant ear begonia", "polka dot begonia"],
                categories: [.plants, .foods],
                imageAsset: "rhubarb_starfruit",
                description: "Soluble calcium oxalate plants contain oxalic acid and oxalate salts that can be absorbed into the bloodstream — making them fundamentally different from the insoluble calcium oxalate houseplants (Philodendron, Pothos, etc.) that only cause local mouth irritation. The most common soluble oxalate plants encountered by pets are rhubarb (the leaves, not the edible stems), star fruit (carambola), shamrock plants (Oxalis), and begonias (especially the tubers). This type of toxicity is less commonly seen in small animals and is more of a concern in livestock that graze on these plants chronically.",
                toxicityInfo: "When soluble oxalates are absorbed from the GI tract, they bind with calcium in the bloodstream, causing a sudden drop in blood calcium levels (acute hypocalcemia). The calcium oxalate crystals that form can then accumulate in the kidneys, potentially causing acute kidney injury (AKI). While kidney damage from these plants is rare in dogs and cats, there is no established safe dose. Pets that are dehydrated or have pre-existing kidney disease may be at higher risk and should be treated more aggressively. Note that rhubarb toxicity applies to the LEAVES only — the stems (stalks) that humans eat are safe, though not particularly good for pets due to their tartness. Star fruit poses an additional concern because it can cause neurological effects in humans and animals with kidney disease.\n\n**Begonia** — All parts of begonias contain soluble oxalates, but the tubers (underground portions) have the highest concentration. Chewing on leaves typically causes only mild oral irritation and GI upset. However, if a pet digs up and consumes the tubers, more significant toxicity is possible, including the same hypocalcemia and potential kidney effects seen with other soluble oxalate plants. Tuberous begonias, commonly planted outdoors, pose a higher risk than wax begonias or rex begonias typically kept as houseplants.",
                onsetTime: OnsetTime(
                    early: "GI signs (hypersalivation, vomiting, diarrhea, loss of appetite) and signs of hypocalcemia (weakness, tremors, muscle twitching) may appear within hours of ingestion",
                    delayed: "Signs of kidney injury (increased thirst and urination, decreased urination, lethargy) may develop 24-36 hours after ingestion if AKI occurs"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Tremors or muscle twitching (from low calcium)",
                    "Tetany or muscle spasms (severe hypocalcemia)",
                    "Increased thirst and urination (early kidney involvement)",
                    "Decreased urination (as kidney injury progresses)",
                    "Blood in urine"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Large ingestions can cause hypocalcemia and potential kidney injury; dehydrated dogs or those with pre-existing kidney disease are at higher risk"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Same concerns as dogs; cats with chronic kidney disease (common in older cats) may be more vulnerable"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are more susceptible due to small body size; star fruit in particular has caused toxicity in pet birds")
                ],
                preventionTips: [
                    "If you grow rhubarb, fence off the garden or keep pets away — the large leaves can be tempting to chew",
                    "Never feed rhubarb leaves to pets (the stems are safe but not recommended)",
                    "Keep star fruit out of reach; do not share this fruit with pets",
                    "If you have shamrock plants as houseplants or decorations (common around St. Patrick's Day), keep them away from pets",
                    "Pets with kidney disease should be kept away from all oxalate-containing plants",
                    "If you plant tuberous begonias outdoors, be aware that dogs may dig up and chew the tubers — the most toxic part of the plant"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Daffodils
            ToxicItem(
                id: UUID(uuidString: "cdb80d59-274a-45f9-b5c5-1e716a7b402b")!,
                name: "Daffodils",
                alternateNames: ["daffodil", "Narcissus", "Narcissus spp", "jonquil", "jonquils", "paper white", "paperwhite", "paper whites", "narcissus bulb", "daffodil bulb", "yellow daffodil", "wild daffodil", "Lent lily", "lycorine", "amaryllis", "Amaryllis", "Amaryllis belladonna", "Hippeastrum", "belladonna lily", "naked lady lily", "amaryllis bulb"],
                categories: [.plants, .holidayHazards],
                imageAsset: "daffodil_amaryllis",
                description: "Daffodils (Narcissus species) and Amaryllis are popular flowering bulbs belonging to the Amaryllidaceae family. Daffodils are recognized by their distinctive trumpet-shaped yellow, white, or orange flowers and are found in gardens, parks, and floral arrangements — particularly around Easter and spring holidays. Amaryllis, with its large, showy trumpet-shaped flowers in red, pink, white, or striped patterns, is a popular gift plant during the winter holiday season. Both plants contain the same class of toxic alkaloids and pose similar risks to pets.",
                toxicityInfo: "Daffodils and Amaryllis contain phenanthridine alkaloids, with lycorine being the most abundant. These alkaloids induce vomiting by irritating the stomach lining and stimulating the vomiting center in the brain. The bulbs of both plants contain the highest concentration of toxins and also contain calcium oxalate crystals in their outer layers, which cause intense tissue irritation when chewed.\n\nDogs are most commonly poisoned when they dig up freshly planted bulbs or gain access to stored bulbs. Amaryllis bulbs are a particular concern during the holiday season when they are sold as gift plants or decorations.\n\nMost ingestions cause GI upset (vomiting, diarrhea, drooling). However, large ingestions — particularly of bulbs — can cause more serious effects including hypotension (low blood pressure), sedation, cardiac arrhythmias, tremors, and seizures. Hepatic (liver) effects have also been reported with Amaryllis. There is no specific antidote; treatment is supportive. With prompt veterinary care, prognosis is generally good.",
                onsetTime: OnsetTime(
                    early: "Vomiting is usually the first sign and can occur within 15 minutes to a few hours of ingestion; drooling, oral irritation, and diarrhea typically follow",
                    delayed: "Cardiovascular and neurologic signs (low blood pressure, abnormal heart rhythm, tremors, seizures) may develop with large ingestions; a published case report described a cat with signs persisting for 3 days before presentation, with full recovery by day 6"
                ),
                symptoms: [
                    "Vomiting (often the first sign)",
                    "Hypersalivation (drooling)",
                    "Diarrhea",
                    "Oral irritation or pain",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Tremors or shivering",
                    "Low blood pressure (weakness, collapse)",
                    "Abnormal heart rate or rhythm",
                    "Hypothermia (low body temperature)",
                    "Seizures or convulsions (large ingestions)",
                    "Difficulty breathing (rare, severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are most commonly affected because they dig up and chew on bulbs; ingestion of flowers or leaves typically causes GI upset, while bulb ingestion can cause more serious cardiovascular effects"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats can develop significant cardiovascular effects including hypothermia, bradycardia, and hypotension; a published case report documented full recovery with supportive care"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available; birds should be kept away from daffodils as a precaution")
                ],
                preventionTips: [
                    "Store unplanted bulbs in a secure location out of pet reach — a bag of bulbs is a common source of poisoning",
                    "Supervise dogs in the garden during planting season; consider fencing off freshly planted bulb beds",
                    "If your dog is a digger, avoid planting daffodils in areas they can access",
                    "Keep cut daffodils in vases out of pet reach; do not let pets drink the vase water",
                    "Be aware that daffodils are common in Easter bouquets and spring floral arrangements",
                    "Dispose of dead plant material securely — dried stems and leaves can still cause toxicity",
                    "Amaryllis bulbs are popular holiday gifts — keep them out of reach of pets, especially during the winter holiday season"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Canadian Veterinary Journal (case report)"],
                relatedEntries: nil
            ),

            // MARK: - Foxglove
            ToxicItem(
                id: UUID(uuidString: "2a95c561-533e-4a73-bd11-8d43bd127bb4")!,
                name: "Foxglove",
                alternateNames: ["Digitalis", "Digitalis purpurea", "purple foxglove", "common foxglove", "lady's glove", "fairy gloves", "folk's glove", "digitalis", "digoxin plant", "digitoxin plant", "dead man's bells", "witch's gloves"],
                categories: [.plants],
                imageAsset: "foxglove_digitalis",
                description: "Foxglove (Digitalis purpurea) is a tall, elegant flowering plant with distinctive bell-shaped flowers that grow in spikes, typically purple, pink, white, or yellow. It is commonly found in cottage gardens and naturalized areas throughout temperate regions. Despite its beauty, foxglove is one of the most dangerous plants to pets and humans — it is the original source of the heart medication digoxin.",
                toxicityInfo: "Foxglove contains cardiac glycosides, primarily digoxin and digitoxin, which interfere with the sodium-potassium pump in heart muscle cells. This disrupts the heart's electrical activity and can cause life-threatening arrhythmias. All parts of the plant are toxic, but the concentration of cardiac glycosides varies — flowers, seeds, and immature leaves contain the highest levels, while mature leaves are relatively lower in toxin content. Even water from a vase containing foxglove can be toxic. Importantly, while digoxin has a short half-life (~6 hours), digitoxin has a much longer half-life (5-7 days), meaning repeated small ingestions could potentially accumulate to toxic levels — unlike some other plant toxins that do not accumulate. The plant's bitter, unpalatable taste makes poisoning relatively rare, but when it occurs, it can be serious. Other plants containing cardiac glycosides include oleander and lily of the valley. There is no specific antidote readily available in veterinary practice; treatment is supportive. With prompt, aggressive veterinary care, prognosis in small animals is generally fair to good.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, drooling, diarrhea, loss of appetite) typically appear within a few hours of ingestion",
                    delayed: "Cardiovascular effects (arrhythmias, changes in heart rate) may develop hours after ingestion and can persist for days due to the long half-life of digitoxin"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Hypersalivation (drooling)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Weakness",
                    "Abnormal heart rate (too fast or too slow)",
                    "Cardiac arrhythmias",
                    "Dilated pupils",
                    "Tremors",
                    "Seizures (severe cases)",
                    "Collapse"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs may ingest larger quantities due to curious behavior; cardiac effects can be life-threatening; the long half-life of digitoxin means repeated small exposures can accumulate"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "The most common signs in cats are vomiting and lethargy; cardiovascular effects are rare in cats according to toxicology specialists"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are susceptible to cardiac glycoside toxicity; small body size increases risk")
                ],
                preventionTips: [
                    "Do not plant foxglove in areas accessible to pets",
                    "If you have existing foxglove, consider removing it or fencing it off completely",
                    "Never allow pets to drink from containers that have held foxglove cuttings — the water is toxic",
                    "Be aware that foxglove self-seeds readily and may appear in unexpected areas of your garden",
                    "Supervise pets around foxglove, especially young curious animals",
                    "Wear gloves when handling foxglove and wash hands thoroughly afterward"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "VETgirl"],
                relatedEntries: nil
            ),

            // MARK: - Lily of the Valley
            ToxicItem(
                id: UUID(uuidString: "f057eb34-f67c-4341-b971-1bde66ca3242")!,
                name: "Lily of the Valley",
                alternateNames: ["Convallaria majalis", "Convallaria", "May lily", "May bells", "Our Lady's tears", "Mary's tears", "muguet", "lily of the valley berries", "convallatoxin"],
                categories: [.plants],
                imageAsset: "lily_of_the_valley",
                description: "Lily of the Valley (Convallaria majalis) is a fragrant perennial plant with delicate white bell-shaped flowers and broad green leaves. It is popular in wedding bouquets and shade gardens. Despite its common name, it is NOT a true lily — it belongs to the Asparagaceae family and does NOT cause the kidney failure seen with true lily (Lilium) ingestion in cats. However, it is still extremely dangerous due to its potent cardiac glycosides.",
                toxicityInfo: "Lily of the Valley contains 38 different cardiac glycosides, with convallatoxin being the primary toxin. These compounds interfere with the heart's electrical conduction system, similar to digoxin. The plant also contains saponins, which contribute to GI irritation. All parts of the plant are toxic — including the flowers, leaves, stems, roots, and red-orange berries that appear in fall. The bulbs contain the highest concentration of toxins. Even the water in a vase containing lily of the valley flowers can be toxic and has caused documented pet deaths. Ingestion of as little as two leaves may be potentially fatal. A published case report documented sudden collapse and death in a 1-year-old dog after ingesting lily of the valley leaves. There is no specific antidote; treatment is supportive and may include medications to control heart rhythm abnormalities.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, drooling, diarrhea) typically appear within a few hours of ingestion",
                    delayed: "Cardiac effects may develop within hours and can be severe; death can occur rapidly in serious cases"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Hypersalivation (drooling)",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Lethargy or weakness",
                    "Abnormal heart rate (too slow or too fast)",
                    "Cardiac arrhythmias",
                    "Low blood pressure",
                    "Dilated pupils",
                    "Tremors",
                    "Seizures",
                    "Disorientation or confusion",
                    "Collapse",
                    "Sudden death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are susceptible to serious cardiac effects; a published case report documented sudden collapse and death after ingestion; even small amounts can be dangerous"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are equally susceptible to cardiac glycoside toxicity; this plant does NOT cause kidney failure like true lilies — the danger is cardiac, not renal"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly susceptible due to small body size; even minimal exposure can be dangerous")
                ],
                preventionTips: [
                    "Do not plant lily of the valley in areas accessible to pets — there is no safe way to have this plant around animals",
                    "If you receive lily of the valley in a bouquet, keep it completely out of pet reach",
                    "Never allow pets to drink water from vases containing lily of the valley — documented pet deaths have occurred from vase water alone",
                    "Be aware that the red-orange berries that appear in fall are also toxic and may be attractive to pets",
                    "Lily of the valley spreads aggressively via underground rhizomes — check for it spreading into pet-accessible areas",
                    "If you suspect any exposure, seek veterinary care immediately — do not wait for symptoms"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "JAVMA (case report)"],
                relatedEntries: nil
            ),

            // MARK: - Castor Beans
            ToxicItem(
                id: UUID(uuidString: "0bf15704-86a3-40a9-94e1-4ba4ffbdea1b")!,
                name: "Castor Beans",
                alternateNames: ["Ricinus communis", "castor bean plant", "castor oil plant", "castor plant", "mole bean plant", "African wonder tree", "palm of Christ", "ricin", "castor bean meal", "castor cake", "castor oil cake", "castor bean fertilizer"],
                categories: [.plants, .gardenProducts],
                imageAsset: "castor_bean_plant",
                description: "The castor bean plant (Ricinus communis) is a fast-growing ornamental plant with large, star-shaped leaves and spiny seed pods containing distinctive mottled seeds. It is grown for its dramatic tropical appearance and as a source of castor oil. The plant is found in warm climates and is sometimes used in landscaping, though it is extremely toxic to pets and humans.",
                toxicityInfo: "Castor beans contain ricin, one of the most potent naturally occurring toxins known — it is classified as a Category B bioterrorism agent. Ricin is a ribosome-inactivating protein that stops cells from making proteins, leading to cell death and multi-organ necrosis affecting the GI tract, liver, kidneys, and heart. All parts of the plant are toxic, but the seeds contain the highest concentration of ricin. Critically, the seed coat must be damaged (chewed or cracked) for ricin to be released — beans swallowed whole with intact seed coats may pass through the digestive tract without causing toxicosis. This means the degree of chewing directly determines severity. In dogs, signs of toxicosis have occurred after ingestion of as little as one chewed bean. Cats are less commonly affected, likely because they have more discerning palates. There is no antidote for ricin poisoning. IMPORTANT: Castor bean-based fertilizers and castor cake (the residue after oil extraction) are far more dangerous than the beans themselves — in one study, mortality from fertilizer/castor cake ingestion was 85% compared to 9% from the beans alone. If an animal survives liver injury, residual hepatic insufficiency may persist.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, abdominal pain) may appear within 6 hours of ingestion, though onset can be delayed up to 42 hours in some cases",
                    delayed: "Laboratory abnormalities typically appear 12-24 hours after ingestion; liver and kidney damage may progress over days"
                ),
                symptoms: [
                    "Vomiting (most common sign)",
                    "Depression or lethargy",
                    "Diarrhea (may contain blood)",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Bloody vomit (hematemesis)",
                    "Weakness",
                    "Ataxia (incoordination)",
                    "Hypersalivation (drooling)",
                    "Recumbency (inability to stand)",
                    "Melena (dark, tarry stool)",
                    "Tremors",
                    "Seizures",
                    "Pale gums",
                    "Difficulty breathing",
                    "Increased thirst",
                    "Decreased urination",
                    "Jaundice (yellowing)",
                    "Coma",
                    "Death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are most commonly affected; severity depends on number of beans, degree of chewing, and time to treatment; patients with only GI signs tend to have good prognosis, but liver injury carries a guarded prognosis; mortality from beans is ~9%, but mortality from castor bean fertilizer/castor cake is ~85%"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are rarely affected (likely due to discerning palate) but are equally susceptible if exposure occurs; same severe toxicity expected"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are susceptible to ricin toxicity; small body size increases risk from even minimal exposure")
                ],
                preventionTips: [
                    "Do not plant castor bean plants in areas accessible to pets — the risk is too high",
                    "If you have castor bean plants, remove them entirely or fence them off completely",
                    "Check organic fertilizers and soil conditioners carefully — castor bean meal (castor oil cake) is used in some products and carries an extremely high mortality rate (~85%) if ingested by pets, far higher than the beans themselves",
                    "Store any castor-containing products in locked, pet-proof containers",
                    "Be aware that castor bean plants may grow wild in warm climates — learn to identify them",
                    "If you suspect any exposure, seek emergency veterinary care immediately — there is no antidote and early intervention is critical"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "PubMed (case studies)"],
                relatedEntries: nil
            ),

            // MARK: - Wild Mushrooms
            ToxicItem(
                id: UUID(uuidString: "1ce957ec-633a-4946-9b76-933a16dfdb5c")!,
                name: "Wild Mushrooms",
                alternateNames: ["mushroom", "mushrooms", "toadstool", "toadstools", "Amanita", "death cap", "death angel", "destroying angel", "Amanita phalloides", "Amanita ocreata", "Amanita muscaria", "fly agaric", "Galerina", "Lepiota", "Inocybe", "Clitocybe", "Gyromitra", "false morel", "magic mushrooms", "psilocybin", "Psilocybe", "shrooms", "yard mushrooms", "backyard mushrooms", "lawn mushrooms"],
                categories: [.plants],
                imageAsset: "wild_mushrooms_amanita",
                description: "Wild mushrooms can appear suddenly in yards, parks, and wooded areas, especially during warm, wet weather in spring and fall. Although thousands of mushroom species exist in North America, fewer than 100 are poisonous — but those that are can cause serious illness or death. Mushrooms are extremely difficult to identify without expert knowledge, and toxic species can closely resemble edible ones. Dogs are more commonly affected due to their scavenging behavior, but cats can also be poisoned. Note: Although mushrooms are technically fungi rather than plants, they are included in this category for ease of reference. Important: Mushrooms sold in grocery stores (button, cremini, portobello, shiitake, etc.) are safe for pets.",
                toxicityInfo: "Wild mushrooms cause several distinct poisoning syndromes depending on the species. Because accurate identification is extremely difficult and often impossible, veterinarians treat all wild mushroom ingestions as potentially life-threatening (worst-case scenario). The main types of toxic mushrooms are:\n\nHepatotoxic (Liver-Destroying) — MOST DANGEROUS: Amanita phalloides (death cap), A. ocreata (death angel), Galerina, and Lepiota species contain amatoxins that cause delayed but severe liver failure. Signs begin 6–24 hours after ingestion, followed by a deceptive 'false recovery' period where the pet appears to improve, then liver failure develops at 36–48 hours. Kidney failure may occur in late stages. These mushrooms are frequently fatal.\n\nMuscarinic (SLUDGE syndrome): Inocybe and Clitocybe species cause profuse salivation, lacrimation (tearing), urination, diarrhea, and GI distress — similar to organophosphate poisoning. Signs appear within 5–30 minutes.\n\nIsoxazole (Neurotoxic): A. muscaria (fly agaric) and A. pantherina contain muscimol and ibotenic acid, causing a 'walking drunk' appearance, sedation, tremors, or seizures. Dogs enter a deep coma-like sleep; recovery usually occurs within 6–72 hours. These mushrooms can be fatal in dogs and cats. IMPORTANT: Cats are particularly attracted to DRIED A. muscaria and A. pantherina.\n\nGyromitrin (False Morels): Gyromitra species cause profuse vomiting and diarrhea; rarely fatal but can cause seizures and liver/kidney damage.\n\nGI Irritants: Many species (Agaricus, Boletus, Entoloma, Scleroderma) cause vomiting and diarrhea within 1–6 hours; generally self-limiting within 1–2 days.\n\nHallucinogenic: Psilocybe, Conocybe, and Gymnopilus ('magic mushrooms') cause ataxia, abnormal behavior, vocalization, nystagmus (abnormal eye movement), and hyperthermia. Rarely life-threatening.",
                onsetTime: OnsetTime(
                    early: "Varies dramatically by mushroom type: Muscarinic mushrooms cause signs within 5–30 minutes; GI irritants within 15 minutes to 6 hours; hallucinogenic within 30 minutes to 2 hours; isoxazole/neurotoxic within a few hours",
                    delayed: "CRITICAL: Hepatotoxic mushrooms (Amanita, Galerina, Lepiota) may not cause signs for 6–24 hours, then show a deceptive 'false recovery' before liver failure develops at 36–48 hours. This delay can give a dangerous false sense of security."
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea (may be bloody with hepatotoxic mushrooms)",
                    "Profuse drooling/hypersalivation",
                    "Excessive tearing (lacrimation)",
                    "Frequent urination",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Ataxia ('walking drunk,' lack of coordination)",
                    "Tremors",
                    "Seizures",
                    "Sedation or coma-like sleep",
                    "Abnormal behavior or vocalization (howling)",
                    "Nystagmus (abnormal eye movements)",
                    "Hyperthermia (elevated body temperature)",
                    "Jaundice/yellowing of skin, gums, or eyes (liver failure)",
                    "Abdominal pain",
                    "Dehydration",
                    "Collapse",
                    "Death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are most commonly affected due to scavenging behavior; dogs may be attracted to certain mushrooms (Amanita, Inocybe) due to their fishy odor; severity ranges from mild GI upset to life-threatening liver failure depending on species — all wild mushroom ingestions should be treated as potential emergencies"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats rarely eat mushrooms but can be seriously affected when they do; cats are particularly attracted to DRIED Amanita muscaria and A. pantherina, sometimes with fatal results"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Limited data but birds are assumed to be susceptible; small body size increases risk from even small exposures")
                ],
                preventionTips: [
                    "Regularly inspect your yard for mushrooms, especially after rain or during warm, wet weather — remove any you find before your pet can access them",
                    "Supervise pets closely in parks, wooded areas, and unfamiliar yards where mushrooms may be growing",
                    "Assume ALL wild mushrooms are toxic — even experts can have difficulty distinguishing safe from deadly species",
                    "Grocery store mushrooms (button, cremini, portobello, shiitake) are safe for pets",
                    "If your pet eats a wild mushroom, contact your veterinarian or poison control immediately — do not wait for symptoms",
                    "If possible, collect a sample of the mushroom: wrap in a damp paper or wax paper towel (NOT plastic), place in a paper bag, and refrigerate; note where you found it and what it was growing on",
                    "For emergency mushroom identification, contact the North American Mycological Association (NAMA) at namyco.org, or the Facebook group 'Poisons Help; Emergency Identification for Mushrooms & Plants' — provide clear photos (including gills/underside), geographic location, and what the mushroom was growing on"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "North American Mycological Association (NAMA)", "VCA Animal Hospitals", "UC Davis School of Veterinary Medicine"],
                relatedEntries: nil
            ),

            // MARK: - Blue-Green Algae (Cyanobacteria)
            ToxicItem(
                id: UUID(uuidString: "f122f209-b845-4921-a9e1-235abcd6876b")!,
                name: "Blue-Green Algae (Cyanobacteria)",
                alternateNames: ["cyanobacteria", "cyanobacterial poisoning", "blue green algae", "pond scum", "pond algae", "lake algae", "algae bloom", "algal bloom", "harmful algal bloom", "HAB", "microcystins", "anatoxins", "toxic algae", "green pond water", "pea soup water"],
                categories: [.plants, .environmentalHazards],
                imageAsset: "bluegreen_algae_pond",
                description: "Blue-green algae (cyanobacteria) are microscopic bacteria found in freshwater lakes, streams, ponds, and brackish water. Despite the name, they are bacteria rather than true algae. They grow and colonize to form 'blooms' that give water a blue-green or 'pea soup' appearance, or may look like blue or green paint on the surface. Wind can blow floating algae into thick mats near shorelines, making them easily accessible to pets. Blooms are most common during hot weather in mid- to late-summer and thrive in warm, stagnant, nutrient-rich water.",
                toxicityInfo: "Blue-green algae can produce toxins that cause rapid, severe illness — even a few mouthfuls of contaminated water can be fatal. Not all blooms produce toxins, but it is impossible to tell by appearance alone; all blooms should be treated as potentially deadly. There are two main toxin types that cause very different syndromes:\n\nMicrocystins are hepatotoxic (liver-damaging). They cause acute liver failure with signs including vomiting, diarrhea, bloody stool, weakness, pale gums, jaundice, seizures, and shock. Death typically occurs within days.\n\nAnatoxins are neurotoxic. They act as irreversible acetylcholinesterase inhibitors, causing a SLUDGE-like syndrome (Salivation, Lacrimation, Urination, Defecation, GI distress, Emesis) along with muscle tremors, rigidity, paralysis, and cyanosis (blue-tinged gums from lack of oxygen). Death can occur within minutes to hours from respiratory paralysis.\n\nThere is no antidote for either toxin type. The prognosis is poor once clinical signs develop. Dogs are most commonly affected because they swim in and drink from contaminated water, and may lick algae off their fur after swimming.",
                onsetTime: OnsetTime(
                    early: "Anatoxin poisoning can cause signs within minutes of exposure; microcystin signs may appear within hours",
                    delayed: "With microcystins, liver failure progresses over 1-3 days; death typically follows within days. With anatoxins, death can occur within minutes to hours from respiratory paralysis — animals are sometimes found dead near the water source."
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea (may be bloody or tarry)",
                    "Excessive drooling (hypersalivation)",
                    "Excessive tearing (lacrimation)",
                    "Frequent urination",
                    "Weakness and lethargy",
                    "Loss of appetite",
                    "Pale gums",
                    "Jaundice (yellowing of skin, gums, or eyes)",
                    "Muscle tremors or rigidity",
                    "Paralysis",
                    "Seizures",
                    "Difficulty breathing",
                    "Cyanosis (blue-tinged gums)",
                    "Collapse or shock",
                    "Sudden death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are most commonly affected — they swim in contaminated water, drink from lakes and ponds, and lick algae off their fur; even minimal exposure (a few mouthfuls) can be fatal"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are equally susceptible but less commonly exposed due to their aversion to swimming; cats drinking from outdoor water sources are still at risk"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds drinking from contaminated water sources are at high risk due to small body size")
                ],
                preventionTips: [
                    "Keep dogs away from any water that appears discolored, has visible scum or mats, or smells foul",
                    "Do not let dogs swim in or drink from ponds, lakes, or stagnant water during hot summer months — bring fresh water from home",
                    "If you see a 'Harmful Algal Bloom' warning sign, take it seriously and leave the area immediately",
                    "If your dog has contact with potentially contaminated water, rinse them thoroughly with clean water immediately and prevent them from licking their fur",
                    "Blooms can appear and disappear quickly — a body of water that was safe last week may not be safe today",
                    "If you suspect any exposure, seek emergency veterinary care immediately — do not wait for symptoms; minutes can matter with this toxin"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "EPA (Environmental Protection Agency)"],
                relatedEntries: nil
            ),

            // MARK: - Yew
            ToxicItem(
                id: UUID(uuidString: "35d425ef-8319-4820-9614-a9b1a0c4cfac")!,
                name: "Yew",
                alternateNames: ["Taxus", "Taxus baccata", "Taxus cuspidata", "Taxus canadensis", "Taxus brevifolia", "Taxus chinensis", "Taxus x media", "English yew", "Japanese yew", "Chinese yew", "American yew", "Canadian yew", "Pacific yew", "Western yew", "ground hemlock", "yew tree", "yew bush", "yew shrub", "yew berries", "taxine"],
                categories: [.plants],
                imageAsset: "yew_taxus_berries",
                description: "Yew (Taxus species) is an evergreen shrub or tree with flat, dark green needles and distinctive bright red berries. It is extremely common in landscaping, foundation plantings, hedges, formal gardens, and cemeteries throughout North America and Europe. Despite its popularity as an ornamental, yew is one of the most dangerous plants to pets — Japanese yew, English yew, and Chinese yew are among the most toxic plants in North America. Animals may be found dead with no prior symptoms, earning yew a reputation as a 'sudden death' plant.",
                toxicityInfo: "Yew contains taxine alkaloids (primarily taxine A and taxine B), which are potent cardiotoxins that depress electrical conduction through the heart, leading to fatal cardiac arrhythmias and acute heart failure. All parts of the plant are toxic — bark, needles, and seeds — EXCEPT the fleshy red covering of the berry (called an aril). However, the seed inside the berry IS highly toxic, and since pets typically chew rather than carefully separating flesh from seed, any berry ingestion should be considered dangerous.\n\nThe amount required for a lethal dose is alarmingly small — a dog can consume a potentially fatal amount simply by playing with or chewing on yew branches or sticks. Taxine concentrations are highest during winter months. Dried or wilted yew clippings remain fully toxic for several months and may actually be more palatable than fresh foliage, which contains a volatile oil that creates a bitter, unpleasant taste.\n\nAbsorption is rapid — horses have collapsed within 15 minutes of consumption, and similar rapid absorption is expected in dogs and cats. Death is often the first indication of yew toxicosis, with little opportunity for treatment. There is no antidote, and successful treatment has never been demonstrated experimentally.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, drooling) may appear within 1-3 hours; however, many animals show no warning signs before cardiac collapse",
                    delayed: "Cardiac effects can develop rapidly — death has been reported within hours of ingestion, and signs can occasionally be delayed up to 2 days; animals are sometimes found dead without any prior observed symptoms"
                ),
                symptoms: [
                    "Sudden death (may occur without prior symptoms)",
                    "Vomiting",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Abdominal pain",
                    "Muscle tremors",
                    "Weakness",
                    "Difficulty breathing (dyspnea)",
                    "Slow heart rate (bradycardia)",
                    "Cardiac arrhythmias",
                    "Low blood pressure",
                    "Incoordination (ataxia)",
                    "Seizures",
                    "Collapse"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs may chew on yew branches or eat fallen berries; a lethal dose can be consumed simply by playing with branches; death can occur rapidly with no warning signs; no antidote exists"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are equally susceptible to taxine cardiotoxicity; smaller body size means even minimal ingestion can be fatal"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Chinchillas are potentially susceptible to yew toxicity"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Budgerigars and canaries are susceptible; interestingly, macaws appear to be resistant, but other pet bird species should be considered at risk")
                ],
                preventionTips: [
                    "Do not plant yew in areas accessible to pets — the risk of sudden death is too high",
                    "If you have existing yew shrubs, consider removing them or fencing them off completely",
                    "Never leave yew clippings where pets can access them — dried clippings remain fully toxic for months and may be more palatable than fresh foliage",
                    "Do not allow dogs to play with or chew on yew branches or sticks — a lethal dose can be consumed this way",
                    "Be aware that yew is extremely common in landscaping, formal gardens, and cemeteries — supervise pets in unfamiliar yards",
                    "Toxin concentrations are highest in winter — be extra vigilant during cold months",
                    "If you suspect any yew ingestion, seek emergency veterinary care immediately — do not wait for symptoms; death can occur within hours"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Snake Plant & Dracaena
            ToxicItem(
                id: UUID(uuidString: "edb87d20-62af-4382-883e-5f979b4b7892")!,
                name: "Snake Plant & Dracaena",
                alternateNames: ["Sansevieria", "Sansevieria trifasciata", "Dracaena trifasciata", "mother-in-law's tongue", "mother in laws tongue", "good luck plant", "golden bird's nest", "viper's bowstring hemp", "Saint George's sword", "Sansevieria Moonshine", "Sansevieria cylindrica", "snake plant leaves", "Dracaena", "Dracaena fragrans", "Dracaena marginata", "Dracaena deremensis", "Dracaena surculosa", "corn plant", "cornstalk plant", "dragon tree", "red-edged dracaena", "ribbon plant", "Janet Craig", "Warneckii", "mass cane", "lucky bamboo", "Dracaena sanderiana", "Florida beauty"],
                categories: [.plants],
                imageAsset: "snake_plant_dracaena",
                description: "Snake plants and Dracaenas are extremely popular houseplants prized for their striking sword-shaped or arching leaves, air-purifying qualities, and extreme hardiness — they thrive on neglect. Snake plant (formerly Sansevieria, now reclassified as Dracaena trifasciata) and other Dracaena species (corn plant, dragon tree, lucky bamboo, Janet Craig, etc.) are commonly found in homes, offices, and commercial spaces. While toxic to pets, these plants are considered low toxicity and rarely cause serious illness.",
                toxicityInfo: "Snake plants and Dracaenas contain saponins, natural compounds that protect the plant against fungi, insects, and microbes. When ingested, saponins irritate the gastrointestinal tract by interacting with cell membranes, causing a foaming action that leads to nausea, vomiting, and diarrhea. The bitter taste of these plants makes them unpalatable, so pets rarely consume enough to cause serious toxicity.\n\nIn most cases, symptoms are mild and self-limiting. Cats may also develop dilated pupils. Vomiting occasionally contains small amounts of blood due to GI irritation, but this is typically minor. Severe effects are rare and typically only occur with large ingestions.\n\nIMPORTANT: Snake plant is sometimes called 'mother-in-law's tongue,' but this name is also used for Dieffenbachia — a completely different plant with a different toxin (insoluble calcium oxalate crystals). Snake plant/Dracaena causes systemic GI effects from saponins; Dieffenbachia causes only localized mouth and throat irritation. Do not confuse the two.",
                onsetTime: OnsetTime(
                    early: "GI symptoms (vomiting, diarrhea, drooling) typically appear within a few hours of ingestion",
                    delayed: "Most symptoms resolve within 24-48 hours; severe symptoms are rare but may take longer to resolve"
                ),
                symptoms: [
                    "Nausea",
                    "Vomiting",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Dilated pupils (cats)",
                    "Weakness",
                    "Incoordination or stumbling (rare, large ingestions)",
                    "Changes in heart rate or blood pressure (rare, large ingestions)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Toxicity is mild in most cases; bitter taste limits ingestion; GI upset is the primary concern; severe effects are rare"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats may chew on the long leaves; toxicity is typically mild with GI symptoms; may develop dilated pupils; same low risk as dogs"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Rabbits are susceptible to saponin toxicity; keep snake plants and dracaenas out of reach")
                ],
                preventionTips: [
                    "Place snake plants and dracaenas on high shelves or in rooms inaccessible to pets",
                    "Consider hanging planters to keep leaves out of reach of curious cats",
                    "If your pet is a plant chewer, opt for non-toxic alternatives like spider plants, Boston ferns, or African violets",
                    "Monitor pets around these plants — while toxicity is usually mild, repeated exposure should be avoided",
                    "If your pet ingests snake plant or dracaena and develops vomiting or diarrhea, contact your veterinarian for guidance",
                    "All Dracaena species (corn plant, dragon tree, lucky bamboo, etc.) contain the same saponin toxins as snake plant"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "University of North Carolina Department of Horticultural Science", "Wag Walking Veterinary Resources"],
                relatedEntries: nil
            ),

            // MARK: - Aloe Vera
            ToxicItem(
                id: UUID(uuidString: "508bc9a0-e697-4c2c-83ad-e3257d597785")!,
                name: "Aloe Vera",
                alternateNames: ["Aloe", "Aloe barbadensis", "Aloe vera plant", "medicinal aloe", "burn plant", "first aid plant", "aloe gel", "aloe latex", "aloe juice"],
                categories: [.plants],
                imageAsset: "aloe_vera_plant",
                description: "Aloe vera is an extremely popular succulent houseplant known for its thick, fleshy leaves containing a gel used in skincare and burn treatment. It is found in homes, offices, and gardens worldwide. While the clear inner gel is considered safe, the latex layer just beneath the leaf skin contains toxic compounds that can harm pets if ingested. Both the plant itself and aloe-containing products (gels, lotions, juices) can cause toxicity.",
                toxicityInfo: "Aloe vera contains two types of toxic compounds: saponins and anthraquinone glycosides. Both are concentrated in the latex — the yellow or orange sap-like layer found just beneath the outer leaf skin. The clear gel inside the leaf is generally considered safe and non-toxic.\n\nAnthraquinone glycosides are purgatives (laxatives) that increase mucus and water production in the colon, leading to vomiting and diarrhea. Saponins cause additional GI irritation and can affect blood sugar levels (potentially causing hypoglycemia) and may damage red blood cells in severe cases.\n\nMost cases of aloe vera ingestion result in mild to moderate GI upset that resolves with supportive care. Severe toxicity is uncommon but can occur with large ingestions. The change in urine color sometimes seen is related to effects on red blood cells. There is no specific antidote; treatment is supportive.",
                onsetTime: OnsetTime(
                    early: "GI symptoms (vomiting, diarrhea) typically appear within a few hours of ingestion",
                    delayed: "Most symptoms resolve within 24-48 hours with supportive care; severe cases may require longer treatment"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite (anorexia)",
                    "Lethargy or depression",
                    "Abdominal pain or cramping",
                    "Dehydration (from fluid loss)",
                    "Weakness",
                    "Change in urine color (red or dark)",
                    "Tremors (rare, large ingestions)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Toxicity is usually mild to moderate with GI upset; severe symptoms are uncommon unless large amounts are ingested"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Same toxicity as dogs; cats may be attracted to chewing on the fleshy leaves")
                ],
                preventionTips: [
                    "Keep aloe vera plants out of reach of pets — place on high shelves or in inaccessible rooms",
                    "Be aware that the latex (yellow layer under the skin) is the toxic part, not the clear gel",
                    "Store aloe vera products (gels, lotions, juices) where pets cannot access them",
                    "If using aloe gel topically on yourself, prevent your pet from licking the treated area",
                    "Do not give aloe vera juice or supplements to pets without veterinary guidance",
                    "If your pet ingests aloe vera and develops vomiting or diarrhea, contact your veterinarian — dehydration can become serious if untreated"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Wag Walking Veterinary Resources"],
                relatedEntries: nil
            ),

            // MARK: - Morning Glory
            ToxicItem(
                id: UUID(uuidString: "a0716b51-b922-4b95-b557-a08c5ce9ed86")!,
                name: "Morning Glory",
                alternateNames: ["Ipomoea", "Ipomoea tricolor", "Ipomoea purpurea", "Ipomoea violacea", "heavenly blue", "flying saucers", "pearly gates", "Convolvulus", "bindweed", "morning glory seeds", "LSA", "lysergic acid amide", "ergine"],
                categories: [.plants],
                imageAsset: "morning_glory_flower",
                description: "Morning glories are a large group of flowering vines (several hundred species) known for their trumpet-shaped flowers that open in the morning. They are popular garden plants grown on trellises, fences, and arbors. While the foliage is relatively harmless, the seeds of certain species contain hallucinogenic compounds related to LSD and can cause serious toxicity if consumed in large quantities.",
                toxicityInfo: "Morning glory toxicity depends entirely on which part of the plant is ingested. The leaves and flowers contain minimal toxins and typically cause only mild GI upset if eaten — monitor for vomiting, diarrhea, loss of appetite, and lethargy; treatment is symptomatic and supportive.\n\nThe seeds are a different story. Seeds from some morning glory species (particularly Ipomoea tricolor varieties like 'Heavenly Blue,' 'Pearly Gates,' and 'Flying Saucers') contain lysergic alkaloids, including ergine (LSA — lysergic acid amide), which is chemically related to LSD. When large amounts of seeds are ingested, these alkaloids can cause hallucinations, incoordination, disorientation, and abnormal behavior. In severe cases, diarrhea, anemia, and liver damage have been reported.\n\nCommercially sold morning glory seeds are sometimes treated with pesticides or fungicides that may cause additional toxicity separate from the plant's natural compounds.",
                onsetTime: OnsetTime(
                    early: "Foliage ingestion: Mild GI signs (vomiting, diarrhea) may appear within a few hours. Seed ingestion: Hallucinogenic effects and neurologic signs may develop within 1-4 hours.",
                    delayed: "Most GI symptoms from foliage resolve within 24 hours. Severe seed ingestions may cause prolonged effects; liver damage (if it occurs) may develop over days."
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite",
                    "Lethargy",
                    "Incoordination or ataxia (seed ingestion)",
                    "Disorientation or confusion (seed ingestion)",
                    "Hallucinations or abnormal behavior (seed ingestion)",
                    "Dilated pupils (seed ingestion)",
                    "Agitation or restlessness (seed ingestion)",
                    "Tremors (severe cases)",
                    "Weakness or pale gums (anemia, rare)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Foliage causes only mild GI upset; seed ingestion in large quantities can cause hallucinogenic effects, incoordination, and rarely liver damage — severity depends on amount and species of morning glory"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Same as dogs; cats are less likely to consume large quantities of seeds"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Rabbits and other small mammals: foliage may cause GI upset; monitor for lethargy, anorexia, abdominal pain, or diarrhea")
                ],
                preventionTips: [
                    "Store morning glory seeds securely — the seeds are the most toxic part of the plant",
                    "Be aware that commercially sold seeds may be treated with pesticides or fungicides that add additional toxicity",
                    "If your pet chews on morning glory leaves or flowers, monitor for mild GI upset — this is usually self-limiting",
                    "If your pet eats morning glory seeds, contact your veterinarian — the quantity consumed matters significantly",
                    "Supervise pets in gardens where morning glories are growing, especially when seed pods are forming"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Cyanogenic Glycoside Plants
            ToxicItem(
                id: UUID(uuidString: "3816a23f-40cf-47e7-88e6-158fddc21b71")!,
                name: "Cyanogenic Glycoside Plants",
                alternateNames: ["Nandina", "Nandina domestica", "heavenly bamboo", "sacred bamboo", "nandina berries", "Hydrangea", "Hydrangea macrophylla", "hortensia", "hydrangea leaves", "hydrangea flowers", "Cherry laurel", "Prunus laurocerasus", "English laurel", "Chokecherry", "Prunus virginiana", "Photinia", "red tip photinia", "Photinia fraseri", "cyanide plants", "hydrogen cyanide", "amygdalin", "prunasin"],
                categories: [.plants],
                imageAsset: "nandina_hydrangea",
                description: "Several common ornamental plants contain cyanogenic glycosides — compounds that can release hydrogen cyanide when plant tissue is damaged (chewed). This group includes Nandina (heavenly bamboo), Hydrangea, Prunus ornamentals (cherry laurel, chokecherry), and Photinia (red tip). Despite the theoretical danger of cyanide, severe toxicity is uncommon in dogs and cats because they rarely consume enough plant material. However, some plants in this group are more concerning than others.",
                toxicityInfo: "Cyanogenic glycosides are converted to hydrogen cyanide when plant cells are crushed during chewing. Cyanide blocks cellular oxygen utilization, which can theoretically cause rapid death. However, the reality in small animal practice is more nuanced:\n\n**Nandina (Heavenly Bamboo)** — The most concerning plant in this group. The berries contain the highest concentration of cyanogenic glycosides and have caused documented deaths in birds (cedar waxwings, robins) that gorge on the berries in winter. Dogs and cats that eat Nandina berries can develop cyanide toxicity, though cases are less commonly reported than in birds. The leaves are also toxic but less so than the berries.\n\n**Hydrangea** — Despite widespread concern, severe hydrangea toxicity is rare. According to ASPCA data, most hydrangea ingestions result in only mild GI upset (vomiting, diarrhea, lethargy). Actual cyanide poisoning from hydrangea is uncommon in dogs and cats. The buds and leaves contain the highest concentration of toxins.\n\n**Prunus Ornamentals (Cherry Laurel, Chokecherry)** — The leaves, especially when wilted or damaged, can concentrate cyanogenic glycosides. Fresh, healthy leaves are less dangerous. These plants are more of a concern for livestock that graze on large quantities, but dogs chewing on branches or wilted leaves can be affected.\n\n**Photinia (Red Tip)** — Similar to Prunus; the young red leaves contain cyanogenic glycosides but severe toxicity is uncommon in pets.\n\nClassic signs of cyanide poisoning include bright cherry-red gums (due to inability to use oxygen), rapid breathing, dilated pupils, and collapse. However, most pet exposures to these plants result only in GI upset.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, drooling) typically appear within a few hours. True cyanide poisoning signs (if they occur) can develop within 15-60 minutes of ingestion.",
                    delayed: "Most GI symptoms resolve within 24 hours. Severe cyanide poisoning progresses rapidly — animals either recover quickly with treatment or deteriorate within hours."
                ),
                symptoms: [
                    "Vomiting (most common)",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Abdominal pain",
                    "Bright cherry-red gums (cyanide poisoning — rare)",
                    "Rapid or labored breathing (cyanide poisoning — rare)",
                    "Dilated pupils (cyanide poisoning — rare)",
                    "Weakness or incoordination (cyanide poisoning — rare)",
                    "Seizures (severe cyanide poisoning — rare)",
                    "Collapse (severe cyanide poisoning — rare)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Nandina berries and wilted Prunus leaves pose the highest risk; hydrangea and photinia typically cause only mild GI upset; true cyanide poisoning is uncommon but possible with large ingestions"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Same concerns as dogs; cats are less likely to consume large quantities but smaller body size means less plant material is needed to cause effects"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly susceptible to Nandina berry toxicity — documented mass die-offs of cedar waxwings and robins have occurred; birds should never have access to Nandina")
                ],
                preventionTips: [
                    "Nandina (heavenly bamboo) poses the highest risk in this group — consider removing it from your landscaping if you have pets, especially birds",
                    "Do not allow pets to eat Nandina berries — they are the most toxic part of the plant",
                    "Keep dogs away from wilted or damaged Prunus (cherry laurel, chokecherry) leaves — wilting concentrates the toxin",
                    "Hydrangea, while commonly listed as toxic, rarely causes serious problems — monitor for GI upset if your pet chews on it",
                    "If you see bright cherry-red gums, rapid breathing, or sudden weakness after plant ingestion, seek emergency veterinary care immediately — these are signs of cyanide poisoning"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - GI Irritant Plants
            ToxicItem(
                id: UUID(uuidString: "045fe2d3-3c59-4f15-b72a-09371b675d77")!,
                name: "GI Irritant Plants",
                alternateNames: ["Poinsettia", "Euphorbia pulcherrima", "Christmas flower", "Christmas plant", "Mexican flame leaf", "Iris", "iris rhizome", "flag iris", "bearded iris", "Chrysanthemum", "chrysanthemums", "mums", "garden mums", "florist's mum", "Hosta", "hostas", "plantain lily", "funkia", "Baby's breath", "babys breath", "Gypsophila", "Gypsophila paniculata", "Carnation", "carnations", "Dianthus", "Dianthus caryophyllus", "pinks", "Jade plant", "jade plant", "Crassula ovata", "Crassula argentea", "money plant", "money tree", "lucky plant", "friendship tree", "Mistletoe", "mistletoe", "Phoradendron", "Phoradendron leucarpum", "American mistletoe", "Christmas mistletoe", "Holly", "holly", "Ilex", "Ilex aquifolium", "English holly", "Christmas holly", "holly berries", "Christmas cactus", "Schlumbergera", "Schlumbergera truncata", "crab claw cactus", "Thanksgiving cactus", "Easter cactus", "holiday cactus", "Clematis", "clematis vine", "Clematis spp", "virgin's bower", "leather flower", "leatherflower", "old man's beard", "traveller's joy", "Asparagus fern", "asparagus fern", "Asparagus setaceus", "Asparagus densiflorus", "Asparagus aethiopicus", "sprengeri fern", "foxtail fern", "plumosa fern", "lace fern", "emerald fern", "climbing asparagus", "asparagus fern berries", "Spring crocus", "spring crocus", "Crocus vernus", "Crocus spp", "Dutch crocus", "giant crocus", "snow crocus", "crocus bulb", "crocus corm"],
                categories: [.plants, .holidayHazards],
                imageAsset: "poinsettia_mums",
                description: "Many common houseplants, garden plants, and cut flowers contain substances that can cause mild gastrointestinal irritation when ingested by pets. While these plants are technically 'toxic,' they rarely cause serious illness — symptoms are generally limited to vomiting, diarrhea, drooling, and temporary loss of appetite. This entry covers several frequently searched plants that fall into this mild GI irritant category: Poinsettia, Iris, Chrysanthemums (mums), Hosta, Baby's Breath, Carnations, Jade Plant, Mistletoe, Holly, Christmas Cactus, Clematis, Asparagus Fern, and Spring Crocus.",
                toxicityInfo: "The plants in this group contain various irritating compounds but share a common characteristic: they cause only mild to moderate GI upset in the vast majority of cases. Animals can generally ingest these plants without severe repercussions.\n\n**Poinsettia** — Perhaps the most overhyped 'toxic' plant. The milky sap can cause mild oral irritation and GI upset, but poinsettia is NOT the deadly poison popular culture suggests. Studies have shown that a 50-pound dog would need to eat over 500 poinsettia leaves to approach a potentially toxic dose. Most pets that chew on poinsettia experience mild drooling or vomiting at worst.\n\n**Iris** — The rhizomes (underground stems) are more irritating than the foliage. Contains pentacyclic terpenoids (irisin, iridin) that cause GI upset. Most cases involve only vomiting and diarrhea. Severe bloody diarrhea is primarily a concern in grazing livestock, not household pets.\n\n**Chrysanthemums (Mums)** — Contain pyrethrins, sesquiterpene lactones, and other irritants. While pyrethrins are used in flea products, the concentration in mums is low. Ingestion typically causes drooling, vomiting, and diarrhea. Skin contact may cause mild dermatitis in sensitive animals.\n\n**Hosta** — Contains saponins that cause GI irritation. Very popular shade garden plants that dogs sometimes dig up. Effects are limited to vomiting, diarrhea, and depression.\n\n**Baby's Breath** — Common in floral bouquets. Contains gyposenin (a saponin) that causes mild GI upset. Dried baby's breath in arrangements is less toxic than fresh.\n\n**Carnations** — Contain unknown GI irritants. Ingestion causes mild vomiting, diarrhea, or drooling. Very low toxicity concern.\n\n**Jade Plant** — A popular succulent houseplant. The resins can cause mild GI irritation, but jade plants are considered essentially non-toxic by the ASPCA. Ingestion typically causes only mild vomiting, similar to any other greenery.\n\n**Mistletoe (American)** — The American mistletoe (Phoradendron species) used in holiday decorations contains compounds that are theoretically cardiotoxic (phoratoxins), but clinically significant cardiac effects are extremely rare in dogs and cats. The most common signs reported to ASPCA APCC are depression and vomiting. Much of the 'deadly mistletoe' reputation comes from European mistletoe (Viscum album), which is more toxic but rarely encountered in North America.\n\n**Holly** — The berries and leaves contain saponins that cause GI irritation. Signs include salivation, vomiting, lip smacking, head shaking, and diarrhea. Effects are self-limiting. Serious toxicity is rare despite holly's reputation.\n\n**Christmas Cactus** — Members of the Schlumbergera genus (Christmas, Thanksgiving, and Easter cacti) are not considered toxic. Ingestion may cause mild gastric upset at most. These are among the safest 'holiday plants' to have around pets.\n\n**Clematis** — This popular flowering vine contains irritating glycosides that can cause drooling, vomiting, and diarrhea if ingested. Thankfully, clematis has a very bitter taste that deters most pets from consuming significant amounts. Effects are self-limiting and rarely require more than monitoring.\n\n**Asparagus Fern** — Despite the name, asparagus ferns are not true ferns — they belong to the lily family. The plant contains sapogenins (steroidal saponins) that cause GI irritation. The small red berries are the most toxic part, but the foliage can also cause problems. Ingestion typically results in vomiting, diarrhea, and abdominal discomfort. Additionally, repeated skin contact with the plant can cause allergic dermatitis (skin irritation and rash) in both pets and humans. Effects are generally mild and self-limiting.\n\n**Spring Crocus** — IMPORTANT: Spring crocus (Crocus vernus and related Crocus species) is completely different from Autumn Crocus (Colchicum autumnale) and does NOT contain colchicine. Spring crocus belongs to the Iridaceae family and causes only mild GI upset if ingested — vomiting, diarrhea, and drooling that typically resolves without treatment. Do not confuse this with Autumn Crocus, which is extremely dangerous and can cause multi-organ failure. If you are unsure which type of crocus your pet ingested, treat it as an emergency and contact your veterinarian or poison control immediately.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, drooling, loss of appetite) typically appear within a few hours of ingestion",
                    delayed: "Symptoms are generally self-limiting and resolve within 24 hours without treatment; persistent symptoms beyond 24-48 hours warrant veterinary evaluation"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Loss of appetite",
                    "Lethargy or mild depression",
                    "Oral irritation (pawing at mouth) — especially with poinsettia sap",
                    "Mild skin irritation (chrysanthemums, with direct contact)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "All plants in this group cause only mild GI upset in dogs; serious complications are rare; symptomatic care is usually sufficient"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Same mild effects as dogs; cats may be more likely to chew on cut flowers and houseplants"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Rabbits and other small mammals may experience GI upset; because rabbits cannot vomit, monitor for lethargy, anorexia, abdominal pain, or diarrhea")
                ],
                preventionTips: [
                    "While these plants are low-toxicity, it's still best to keep them out of reach of pets that like to chew on vegetation",
                    "Poinsettia is NOT highly toxic despite its reputation — if your pet nibbles on one, monitor for mild GI upset but don't panic",
                    "If your pet is a plant chewer, consider truly non-toxic alternatives like spider plants, Boston ferns, or African violets",
                    "For cut flower arrangements, place them where curious cats cannot reach",
                    "If vomiting or diarrhea persists beyond 24 hours or your pet seems uncomfortable, contact your veterinarian",
                    "Mistletoe and holly are traditional holiday decorations — hang them high out of pet reach",
                    "Jade plants are low-toxicity but should still be kept away from pets that like to chew on succulents",
                    "Christmas cactus is one of the safest holiday plants — mild GI upset at most if ingested",
                    "Clematis vines have a bitter taste that usually prevents pets from eating significant amounts",
                    "Asparagus fern berries are the most toxic part — remove berries if you keep this plant around pets",
                    "Spring crocus causes only mild GI upset, but if you're unsure whether a crocus is spring or autumn variety, treat any ingestion as an emergency"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "VCA Animal Hospitals"],
                relatedEntries: nil
            ),

            // MARK: - Brunfelsia (Yesterday, Today and Tomorrow)
            ToxicItem(
                id: UUID(uuidString: "4ebc62d6-6f94-4f60-a1cb-58c505450d61")!,
                name: "Brunfelsia (Yesterday, Today and Tomorrow)",
                alternateNames: ["Brunfelsia", "Brunfelsia spp", "Brunfelsia pauciflora", "Brunfelsia australis", "Brunfelsia uniflora", "Brunfelsia calycina", "yesterday today and tomorrow", "yesterday today tomorrow", "morning noon and night", "kiss me quick", "lady of the night", "Paraguay jasmine", "Franciscan rain tree", "brunfelsia berries", "brunfelsia fruit"],
                categories: [.plants],
                imageAsset: "brunfelsia_flower",
                description: "Brunfelsia, commonly known as 'Yesterday, Today and Tomorrow,' is an ornamental shrub popular in tropical and subtropical regions, including Florida, California, Hawaii, and parts of Texas. The plant gets its common name from its flowers, which change color over several days — typically opening purple, fading to lavender, then white. Despite its beauty, Brunfelsia is one of the most dangerous plants to dogs, causing serious neurological toxicity.",
                toxicityInfo: "Brunfelsia contains two toxic compounds: brunfelsamidine (a stimulant) and hopeanine (a depressant), which together cause severe neurotoxicity mimicking strychnine poisoning. All parts of the plant are toxic, but the fruit (berries) are especially dangerous because they are juicy and palatable to dogs.\n\nThe toxic effects on the central nervous system cause uncontrolled muscle contractions, rigidity, and seizures — similar to strychnine. According to ASPCA Animal Poison Control Center data, dogs are the primary species affected. Over a 5-year period, 38 cases were reported involving 42 dogs, with Labrador Retrievers and Golden Retrievers most commonly affected. Cats are also susceptible but less commonly exposed, possibly due to more selective eating habits.\n\nClinical signs may start with agitation, nervousness, or excitement, then progress to tremors, muscular rigidity, and tonic-clonic seizures. Signs can last from a few hours to several days. All Brunfelsia exposures should be considered potentially life-threatening — seek emergency veterinary care immediately if ingestion is suspected.",
                onsetTime: OnsetTime(
                    early: "Signs can appear within minutes to hours of ingestion; early signs include salivation, vomiting, retching, and agitation",
                    delayed: "Neurological signs (tremors, rigidity, seizures) may persist for days even with treatment; recovery depends on the amount ingested and how quickly treatment begins"
                ),
                symptoms: [
                    "Salivation (often profuse)",
                    "Vomiting",
                    "Retching",
                    "Agitation or anxiety",
                    "Nystagmus (abnormal eye movements)",
                    "Decreased motor activity initially",
                    "Tremors",
                    "Muscle rigidity",
                    "Extensor rigidity (stiff, extended limbs)",
                    "Seizures",
                    "Hyperthermia (from muscle activity)",
                    "Coughing",
                    "Death (without treatment)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are the primary species affected; the juicy fruit is particularly attractive to dogs; signs mimic strychnine poisoning and can last for several days"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats appear less commonly affected, possibly due to more selective eating habits; if ingestion occurs, similar severe neurological effects are expected"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available; birds should be kept away from Brunfelsia as a precaution due to small body size")
                ],
                preventionTips: [
                    "Do not plant Brunfelsia in areas accessible to dogs — the berries are especially attractive and dangerous",
                    "If you have existing Brunfelsia, consider removing it or fencing it off completely",
                    "Be aware that Brunfelsia is common in tropical landscaping in Florida, California, Hawaii, and Texas",
                    "The berries (fruit) are the most dangerous part — they are juicy and palatable to dogs",
                    "If you suspect your dog has ingested any part of a Brunfelsia plant, seek emergency veterinary care immediately — do not wait for symptoms to appear"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "dvm360 (ASPCA APCC case review)"],
                relatedEntries: nil
            ),

            // MARK: - Kalanchoe
            ToxicItem(
                id: UUID(uuidString: "dfa90432-20a6-45bb-9e19-f917b50b3765")!,
                name: "Kalanchoe",
                alternateNames: ["Kalanchoe spp", "mother of thousands", "mother of millions", "chandelier plant", "devil's backbone", "cathedral bells", "flaming Katy", "florist kalanchoe", "paddle plant", "flapjacks", "Bryophyllum", "air plant", "palm beachbells", "donkey ears", "kalanchoe daigremontiana", "kalanchoe blossfeldiana"],
                categories: [.plants],
                imageAsset: "kalanchoe_flowers",
                description: "Kalanchoe is a large genus of succulent houseplants known for their thick, waxy leaves and clusters of small, colorful flowers (red, pink, orange, yellow, or white). They are extremely popular due to their low water requirements and long-lasting blooms. Common varieties include the florist kalanchoe (Kalanchoe blossfeldiana), mother of thousands/millions (Kalanchoe daigremontiana), and paddle plant (Kalanchoe thyrsiflora). Kalanchoe plants are also commonly purchased as decorations during the Chinese New Year.",
                toxicityInfo: "Kalanchoe contains bufodienolides, a type of cardiac glycoside that can affect the heart. All parts of the plant contain these toxins, with the flowers having the highest concentration. However, in real-world exposures involving dogs and cats, clinical signs are almost always limited to gastrointestinal upset — pets simply do not eat enough of the plant to cause cardiac effects. According to toxicology specialists, ingestion typically results in vomiting within 1-2 hours, and then symptoms resolve. Large ingestions could theoretically cause changes in heart rate and rhythm, weakness, and collapse, but this is rare in household pet exposures. Birds may be more susceptible due to their smaller body size.",
                onsetTime: OnsetTime(
                    early: "Vomiting typically occurs within 1-2 hours of ingestion and is often the only sign",
                    delayed: "Symptoms usually resolve quickly after vomiting; cardiac effects are rare in dogs and cats but could develop with very large ingestions"
                ),
                symptoms: [
                    "Vomiting (most common)",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Abnormal heart rate or rhythm (rare, large ingestions)",
                    "Weakness (rare, large ingestions)",
                    "Collapse (rare, large ingestions)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Most ingestions cause only vomiting and GI upset; dogs typically do not eat enough to cause cardiac effects"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Same as dogs — GI upset is the primary concern; cardiac effects are rare"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are more susceptible to cardiac glycosides due to small body size; can cause depression, ataxia, tremors, seizures, and cardiac effects")
                ],
                preventionTips: [
                    "Keep kalanchoe plants on high shelves or in rooms inaccessible to pets",
                    "Be aware that all parts of the plant are toxic, with flowers containing the highest concentration",
                    "If your pet vomits after chewing on kalanchoe, contact your veterinarian for guidance",
                    "Consider pet-safe succulent alternatives like Haworthia or Echeveria",
                    "Dispose of fallen flowers and leaves promptly"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Medicine (peer-reviewed journal)"],
                relatedEntries: nil
            ),

            // MARK: - English Ivy
            ToxicItem(
                id: UUID(uuidString: "8ea06fcf-b35d-4049-a73f-8c94752c783d")!,
                name: "English Ivy",
                alternateNames: ["Hedera helix", "common ivy", "European ivy", "ivy", "branching ivy", "glacier ivy", "needlepoint ivy", "sweetheart ivy", "California ivy", "Hahn's ivy", "Irish ivy", "Baltic ivy", "ivy vine"],
                categories: [.plants],
                imageAsset: "english_ivy_vine",
                description: "English ivy (Hedera helix) is an extremely common evergreen climbing vine found both as a houseplant and as outdoor ground cover throughout North America. It is prized for its attractive lobed leaves, ability to climb walls and fences, air-purifying properties, and tolerance of low light conditions. English ivy is widely used in landscaping and can become invasive in many regions. Despite its popularity, it is toxic to pets.",
                toxicityInfo: "English ivy contains triterpenoid saponins (primarily hederagenin), as well as polyacetylene compounds (falcarinol and didehydrofalcarinol). These compounds cause gastrointestinal irritation when ingested. The foliage (leaves) is more toxic than the berries. In most cases, ingestion causes intense GI distress — vomiting, diarrhea, and abdominal pain — but is unlikely to cause serious illness or death unless very large amounts are consumed. According to veterinary toxicologists, vomiting typically occurs within 2-3 hours of ingestion. The sap can also cause contact dermatitis (skin irritation) in both pets and humans who handle the plant. More severe signs (neurological effects, breathing difficulty) have been reported but require ingestion of large quantities and are uncommon in typical household exposures.",
                onsetTime: OnsetTime(
                    early: "Vomiting and GI signs typically appear within 2-3 hours of ingestion",
                    delayed: "Most symptoms resolve with supportive care; severe signs are uncommon unless very large amounts are ingested"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain",
                    "Drooling (hypersalivation)",
                    "Loss of appetite",
                    "Skin irritation or rash (contact with sap)",
                    "Excessive thirst (large ingestions)",
                    "Weakness or incoordination (large ingestions, rare)",
                    "Dilated pupils (large ingestions, rare)",
                    "Difficulty breathing (large ingestions, rare)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Causes intense GI distress (vomiting, diarrhea, abdominal pain); severe effects are unlikely unless very large amounts are ingested"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Same GI effects as dogs; cats may be attracted to trailing vines indoors"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data; birds should be kept away from English ivy")
                ],
                preventionTips: [
                    "Keep indoor English ivy plants in hanging baskets or on high shelves out of pet reach",
                    "Be aware that the leaves are more toxic than the berries",
                    "Wear gloves when pruning or handling English ivy — the sap can cause skin irritation",
                    "If you have English ivy as ground cover outdoors, supervise pets to prevent grazing",
                    "Never burn English ivy clippings — toxins can become airborne",
                    "If your pet develops vomiting after chewing on ivy, contact your veterinarian"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Wisteria
            ToxicItem(
                id: UUID(uuidString: "b2e1e5d4-0d12-410b-83dc-da106bbc2199")!,
                name: "Wisteria",
                alternateNames: ["Wisteria spp", "Wisteria sinensis", "Wisteria floribunda", "Chinese wisteria", "Japanese wisteria", "American wisteria", "wisteria vine", "wisteria pods", "wisteria seeds"],
                categories: [.plants],
                imageAsset: "wisteria_flowers_pods",
                description: "Wisteria is a stunning woody climbing vine known for its cascading clusters of fragrant purple, blue, pink, or white flowers. It is commonly grown on pergolas, arbors, and walls throughout North America. While beautiful, wisteria is significantly more toxic than many common garden plants — the seed pods and seeds are particularly dangerous and have caused fatalities in small animals and children.",
                toxicityInfo: "Wisteria contains two toxic compounds: lectin and wisterin glycoside. All parts of the plant are considered toxic, but the seed pods and seeds contain the highest concentrations and pose the greatest danger. Lectin can cause blood cell clumping, while wisterin glycoside (a saponin) causes severe gastrointestinal effects. According to veterinary toxicologists, as few as two seeds can cause severe illness in small dogs. Symptoms include intense vomiting (sometimes prolonged), abdominal pain, diarrhea, and dehydration. With appropriate supportive care, most dogs become asymptomatic within 24 hours, and liver problems have not been reported. However, without treatment, severe cases can lead to dangerous dehydration and collapse.",
                onsetTime: OnsetTime(
                    early: "Nausea, vomiting, and abdominal pain typically develop within a few hours of ingestion",
                    delayed: "With supportive care, most animals improve within 24 hours; severe dehydration can develop if vomiting and diarrhea are prolonged and untreated"
                ),
                symptoms: [
                    "Vomiting (often severe and prolonged)",
                    "Abdominal pain",
                    "Diarrhea",
                    "Nausea",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Dehydration",
                    "Weakness",
                    "Collapse (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Seeds and pods are most dangerous — as few as two seeds can cause severe illness in small dogs; entire plant is toxic"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Same toxicity concerns as dogs; smaller body size increases risk from even minimal seed ingestion"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are susceptible; small body size makes even small exposures potentially serious")
                ],
                preventionTips: [
                    "Keep dogs away from wisteria vines, especially when seed pods are present",
                    "Remove and dispose of fallen seed pods promptly — they are the most toxic part of the plant",
                    "Do not allow pets to chew on wisteria branches, leaves, or flowers",
                    "Be especially vigilant in late summer and fall when seed pods mature",
                    "If you suspect your pet has eaten any part of a wisteria plant, especially seeds or pods, contact your veterinarian immediately",
                    "Consider fencing off wisteria or choosing non-toxic climbing vines if you have curious pets"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Milkweed
            ToxicItem(
                id: UUID(uuidString: "053d21cd-da83-448d-914d-a230343b35d7")!,
                name: "Milkweed",
                alternateNames: ["Asclepias", "Asclepias syriaca", "Asclepias speciosa", "Asclepias tuberosa", "Asclepias incarnata", "Asclepias verticillata", "common milkweed", "showy milkweed", "butterfly weed", "swamp milkweed", "narrow-leaved milkweed", "whorled milkweed", "tropical milkweed", "blood flower", "milkweed sap", "monarch butterfly plant", "pleurisy root"],
                categories: [.plants],
                imageAsset: "milkweed_monarch",
                description: "Milkweed (Asclepias species) is a native North American plant famous for being the sole food source for monarch butterfly caterpillars. It has become increasingly popular in gardens as part of pollinator conservation efforts. The plant gets its name from the thick, milky white sap that oozes from broken stems and leaves. There are over 100 species of milkweed, with varying levels of toxicity — narrow-leaved species tend to be more toxic than broad-leaved species.",
                toxicityInfo: "Milkweed contains cardiac glycosides (cardenolides), similar to those found in foxglove and oleander. These compounds interfere with the heart's electrical activity and can cause cardiac arrhythmias. Additionally, resinoids in the plant cause gastrointestinal irritation, and some species contain neurotoxins that can cause neurological signs.\n\nThere is significant variation between milkweed species: narrow-leaved milkweeds (like whorled milkweed) tend to cause more neurological signs, while broad-leaved species (like common milkweed) are more likely to cause GI and cardiac effects. According to veterinary toxicologists, in most dog cases, GI signs predominate, followed by cardiac signs. The plant's bitter, unpleasant taste and the irritating milky sap typically deter pets from consuming large amounts.\n\nAll parts of the plant are toxic, including the leaves, stems, roots, and milky sap. The sap can also cause skin and eye irritation on contact.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, drooling) typically appear within a few hours of ingestion",
                    delayed: "Cardiac effects may develop with larger ingestions; neurological signs can occur with certain species"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Weakness",
                    "Incoordination or ataxia",
                    "Dilated pupils",
                    "Abnormal heart rate or rhythm (large ingestions)",
                    "Difficulty breathing (large ingestions)",
                    "Tremors or seizures (with neurotoxic species)",
                    "Collapse (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "GI signs are most common; cardiac effects can occur with larger ingestions; the bitter taste typically limits consumption"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Similar effects to dogs; cats are less likely to consume significant amounts due to taste aversion"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are more susceptible to cardiac glycosides due to small body size; pet birds should be kept away from milkweed")
                ],
                preventionTips: [
                    "If you grow milkweed for monarch butterflies, plant it in an area your pets cannot access",
                    "Supervise pets in gardens where milkweed is growing",
                    "The milky sap can irritate skin and eyes — wash thoroughly if contact occurs",
                    "Be aware that narrow-leaved milkweed species tend to be more toxic than broad-leaved species",
                    "If your pet shows interest in milkweed, redirect them to other areas of the garden",
                    "Contact your veterinarian if you suspect your pet has ingested milkweed"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Larkspur & Delphinium
            ToxicItem(
                id: UUID(uuidString: "ed41fd85-d05e-4797-9f94-5152653df2d1")!,
                name: "Larkspur & Delphinium",
                alternateNames: ["larkspur", "Delphinium", "Delphinium species", "Consolida", "Consolida ajacis", "annual larkspur", "perennial delphinium", "rocket larkspur", "tall larkspur", "low larkspur", "dwarf larkspur"],
                categories: [.plants],
                imageAsset: "larkspur_delphinium",
                description: "Larkspur and Delphinium are closely related flowering plants in the Ranunculaceae (buttercup) family, known for their tall spikes of showy blue, purple, pink, or white flowers. Larkspur typically refers to annual species (Consolida), while Delphinium refers to perennial species — but both contain the same toxic compounds and are often used interchangeably. These are popular cottage garden plants and cut flowers. While poisoning is well-documented in grazing livestock (particularly cattle), cases in household pets are less commonly reported but can occur.",
                toxicityInfo: "Larkspur and Delphinium contain diterpene alkaloids, primarily methyllycaconitine, which act as neuromuscular blocking agents similar to curare. These alkaloids block acetylcholine receptors at the neuromuscular junction, preventing normal nerve-to-muscle communication and causing progressive weakness, paralysis, and potentially respiratory failure.\n\nAll parts of the plant are toxic, but toxicity varies significantly with the plant's growth stage — young, rapidly growing plants (especially new shoots in spring) contain the highest alkaloid concentrations. As the plant matures and flowers, it generally becomes less toxic. The seeds also contain significant levels of toxins.\n\nWhile severe toxicity is well-documented in grazing livestock that consume large quantities, household pets are less commonly affected — likely because dogs and cats typically do not consume enough plant material to cause serious poisoning. However, the potential for neuromuscular paralysis and respiratory compromise means any ingestion should be taken seriously.",
                onsetTime: OnsetTime(
                    early: "GI signs (drooling, vomiting) and early neuromuscular effects (stiffness, tremors) may appear within a few hours of ingestion",
                    delayed: "Progressive weakness and paralysis can develop; signs may persist for 24-48 hours depending on amount ingested"
                ),
                symptoms: [
                    "Drooling (hypersalivation)",
                    "Vomiting",
                    "Constipation or colic",
                    "Muscle stiffness",
                    "Muscle tremors",
                    "Weakness",
                    "Incoordination (ataxia)",
                    "Recumbency (inability to stand)",
                    "Paralysis",
                    "Convulsions",
                    "Difficulty breathing",
                    "Abnormal heart rhythm",
                    "Collapse"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs rarely consume large amounts; GI upset is most likely with smaller ingestions; neuromuscular effects possible with larger amounts; puppies may be more prone to chewing on plants"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats have the same susceptibility as dogs; smaller body size means less plant material is needed to cause effects"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Small body size makes birds more vulnerable to the neurotoxic effects; keep pet birds away from larkspur and delphinium")
                ],
                preventionTips: [
                    "Keep dogs and cats away from larkspur and delphinium, especially during spring when young shoots are most toxic",
                    "Be particularly vigilant with puppies that may be prone to chewing on garden plants",
                    "If you grow these plants, consider fencing them off from pet-accessible areas",
                    "Remove any larkspur or delphinium from areas where pets play unsupervised",
                    "The plants become less toxic as they mature, but all growth stages should be considered potentially dangerous",
                    "If you suspect your pet has ingested any part of these plants, contact your veterinarian immediately"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Horse Chestnut & Buckeye
            ToxicItem(
                id: UUID(uuidString: "c3531735-0e34-448a-82d8-660ed4c22a24")!,
                name: "Horse Chestnut & Buckeye",
                alternateNames: ["buckeye", "horse chestnut", "Aesculus", "Aesculus hippocastanum", "Aesculus glabra", "Aesculus pavia", "Ohio buckeye", "red buckeye", "California buckeye", "European horse chestnut", "conker", "conkers", "fetid buckeye", "aesculin", "buckeye nut", "horse chestnut tree"],
                categories: [.plants],
                imageAsset: "horse_chestnut_buckeye",
                description: "Horse chestnuts and buckeyes (Aesculus species) are deciduous trees found throughout North America and Europe, recognized by their distinctive palmate leaves and spiny-husked nuts. Ohio buckeye, red buckeye, and California buckeye are native to the United States, while European horse chestnut (Aesculus hippocastanum) is commonly planted as an ornamental. The shiny brown nuts that fall in autumn attract curious dogs — and pose both a toxic and a foreign body risk.",
                toxicityInfo: "Horse chestnuts and buckeyes contain glycosidic saponins, primarily aesculin, which cause gastrointestinal irritation and, at higher doses, can affect the central nervous system. All parts of the plant are toxic, including the leaves, bark, flowers, and nuts (seeds). The nuts are the most commonly ingested part.\n\nIn most real-world cases involving dogs in the United States, clinical signs are limited to gastrointestinal upset — vomiting and diarrhea — because American buckeye varieties are generally less toxic than their European counterparts, and the bitter, unpleasant taste discourages consumption of large amounts. European horse chestnut (Aesculus hippocastanum) is considered more toxic.\n\nNeurological signs (incoordination, muscle twitching, dilated pupils, excitement or depression, tremors, seizures) can occur with large ingestions but are uncommon in dogs. Saponins are poorly absorbed from a healthy digestive tract, so significant quantities must be consumed to cause systemic effects.\n\nIn addition to toxicity concerns, the hard, round nuts pose a choking hazard and can cause gastrointestinal obstruction, particularly in smaller dogs.",
                onsetTime: OnsetTime(
                    early: "Gastrointestinal signs (vomiting, diarrhea) typically appear within 1-3 hours of ingestion",
                    delayed: "Neurological signs, if they occur, may peak around 24-28 hours after ingestion; toxins have approximately a 24-hour half-life"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Excitement or agitation",
                    "Dilated pupils",
                    "Incoordination or wobbliness (large ingestions)",
                    "Muscle twitching or tremors (large ingestions)",
                    "Seizures or convulsions (large ingestions, rare)",
                    "Coma (severe cases, rare)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "GI upset is the most common outcome; neurological signs are uncommon in dogs in the US because American varieties are less toxic and dogs rarely eat enough; European horse chestnut is more toxic; nuts also pose foreign body/obstruction risk"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are susceptible but rarely ingest these nuts due to their selective eating habits"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data; birds should be kept away from horse chestnuts as a precaution")
                ],
                preventionTips: [
                    "Rake up fallen horse chestnuts and buckeyes from your yard regularly, especially in autumn",
                    "Do not let dogs play with or chew on the nuts — they pose both a toxicity and choking/obstruction risk",
                    "Be aware that European horse chestnut (commonly planted as ornamental) is more toxic than American buckeye varieties",
                    "Supervise dogs in parks and yards where these trees are present",
                    "The bitter taste usually deters dogs from eating large amounts, but some determined chewers may still be at risk",
                    "If your dog ingests horse chestnuts or buckeyes, contact your veterinarian — monitor for GI upset and potential obstruction"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Clinical Veterinary Toxicology (Plumlee)"],
                relatedEntries: nil
            ),

            // MARK: - Tomato & Potato Plants
            ToxicItem(
                id: UUID(uuidString: "d8d69209-6177-411e-bd92-c541af9fe79d")!,
                name: "Tomato & Potato Plants",
                alternateNames: ["tomato plant", "tomato leaves", "tomato stems", "green tomatoes", "unripe tomatoes", "cherry tomato plant", "Solanum lycopersicum", "potato plant", "potato leaves", "potato stems", "green potatoes", "raw potatoes", "potato skins", "Solanum tuberosum", "nightshade family", "Solanaceae", "solanine", "tomatine", "glycoalkaloids"],
                categories: [.plants, .foods],
                imageAsset: "tomato_potato_plants",
                description: "Tomato and potato plants belong to the Solanaceae (nightshade) family and share the same toxic compounds. These common garden vegetables are safe when ripe and properly prepared, but the green parts of the plants — leaves, stems, unripe fruit, and green-skinned potatoes — contain toxic glycoalkaloids that can harm pets.",
                toxicityInfo: "Tomato and potato plants contain glycoalkaloids, primarily solanine (in both plants) and tomatine (specific to tomatoes). These compounds act as cholinesterase inhibitors, interfering with nerve signal transmission. They also cause direct gastrointestinal irritation.\n\n**What's toxic:** Leaves, stems, unripe green fruit (tomatoes), green-skinned potatoes (from sun exposure), raw potatoes, potato eyes and sprouts. The highest concentrations are in the green parts of the plant.\n\n**What's safe:** Ripe red tomatoes and properly cooked potatoes (peeled, no green portions) are generally safe in moderation. As the tomato ripens, tomatine is metabolized and levels decrease significantly.\n\nIn most cases involving dogs and cats, ingestion causes gastrointestinal upset. However, a documented case involved two young dogs who ate wild green cherry tomatoes and developed severe signs including seizures, hyperesthesia (extreme sensitivity to touch), hypersalivation, tachycardia, and metabolic acidosis — both recovered with veterinary care. Large amounts are typically required for severe toxicity in dogs and cats (more commonly a concern in grazing livestock), but smaller pets and puppies may be affected by smaller quantities.",
                onsetTime: OnsetTime(
                    early: "Gastrointestinal signs (vomiting, diarrhea, drooling, loss of appetite) typically appear within a few hours of ingestion",
                    delayed: "Clinical course is typically rapid, with recovery or progression within 24-38 hours; neurological and cardiac signs may develop with larger ingestions"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Hypersalivation (drooling)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Weakness",
                    "Dilated pupils",
                    "Slow heart rate (bradycardia)",
                    "Confusion or behavioral changes",
                    "Incoordination (ataxia)",
                    "Muscle tremors",
                    "Hyperesthesia (sensitivity to touch)",
                    "Seizures (severe cases)",
                    "Difficulty breathing (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Most cases cause only GI upset; severe toxicity requires ingestion of large amounts of green plant material; puppies and small dogs are at higher risk; documented cases of seizures exist with significant green tomato ingestion"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are susceptible but rarely consume enough plant material to cause severe toxicity; same clinical signs as dogs expected"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Birds may be affected; small body size increases risk from smaller exposures")
                ],
                preventionTips: [
                    "Fence off vegetable gardens or supervise pets around tomato and potato plants",
                    "Never feed pets green (unripe) tomatoes, tomato leaves, or stems",
                    "Never feed pets raw potatoes, green-skinned potatoes, potato skins, or potato plant parts",
                    "Store potatoes in a cool, dark place to prevent greening — green color indicates increased solanine",
                    "Ripe red tomatoes are safe as an occasional treat in small amounts",
                    "Cooked, peeled potatoes (plain, no seasonings) are safe in small amounts",
                    "Dispose of plant trimmings where pets cannot access them",
                    "If your pet shows signs after eating any part of these plants, contact your veterinarian"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Vetlexicon - Plant Poisoning: Solanine and Related Glycoalkaloids"],
                relatedEntries: nil
            ),

            // MARK: - Lantana
            ToxicItem(
                id: UUID(uuidString: "1d9f0989-6d98-4305-ac74-56f6e6e8ca0f")!,
                name: "Lantana",
                alternateNames: ["Lantana camara", "lantana plant", "lantana berries", "shrub verbena", "yellow sage", "red sage", "wild sage", "ham and eggs", "big sage", "tickberry", "white sage", "lantadene", "pentacyclic triterpenoids"],
                categories: [.plants],
                imageAsset: "lantana_flowers_berries",
                description: "Lantana is a flowering shrub popular in gardens and landscaping, known for its clusters of small, colorful flowers that may be yellow, orange, red, pink, purple, or multicolored. It is commonly found in the southwestern United States, Florida, and Gulf Coast states, where it grows both as an ornamental and in the wild. All parts of the plant are toxic, with the unripe (green) berries being the most dangerous.",
                toxicityInfo: "Lantana contains pentacyclic triterpenoids, primarily lantadene A and lantadene B, which are hepatotoxic (liver-damaging). These toxins cause liver damage by interfering with bile flow — they damage bile canalicular membranes, block bile excretion, and cause cholestasis (bile backup). This leads to retention of bilirubin and other compounds, potentially causing jaundice.\n\nAll parts of the plant are toxic, but the unripe green berries contain the highest concentration of toxins. Ripe black berries are less toxic but should still be avoided. In livestock (cattle, sheep, horses), lantana toxicity commonly causes photosensitization (severe skin reactions to sunlight) due to phylloerythrin accumulation — this is less commonly reported in dogs and cats.\n\nMost cases in dogs and cats involve gastrointestinal upset (vomiting, diarrhea, loss of appetite, weakness). Severe cases involving liver damage are possible but less commonly documented in household pets than in grazing livestock. Children have been poisoned by eating the berries, demonstrating that significant toxicity can occur with berry ingestion.",
                onsetTime: OnsetTime(
                    early: "Gastrointestinal signs (vomiting, diarrhea, weakness, loss of appetite) typically appear within hours of ingestion",
                    delayed: "Liver damage may develop over 1-4 days with significant ingestions; jaundice (yellowing of gums, skin, eyes) indicates liver involvement"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite",
                    "Weakness",
                    "Lethargy or depression",
                    "Abdominal pain",
                    "Labored breathing",
                    "Jaundice (yellowing of gums, eyes, or skin)",
                    "Dark urine",
                    "Photosensitization (skin sensitivity to sunlight — more common in livestock)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Most cases involve GI upset; liver damage is possible with significant ingestions, particularly of unripe berries; less commonly reported than in livestock but mechanism of toxicity is the same"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Same concerns as dogs; cats are less likely to consume large amounts but smaller body size means less plant material needed for effects"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds may be attracted to the berries; small body size increases risk of serious toxicity")
                ],
                preventionTips: [
                    "Keep pets away from lantana plants, especially when berries are present",
                    "The unripe green berries are the most toxic — remove or fence off plants with developing berries if pets have access",
                    "Be aware that lantana grows wild in many southern states and may be encountered on walks",
                    "Consider removing lantana from your landscaping if you have pets that like to chew on plants",
                    "Do not let pets eat any part of the lantana plant, including fallen flowers or leaves",
                    "If you suspect your pet has eaten lantana, especially the berries, contact your veterinarian"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Cyclamen
            ToxicItem(
                id: UUID(uuidString: "1669461b-b725-4e4b-a30a-99c26b34e5c1")!,
                name: "Cyclamen",
                alternateNames: ["Cyclamen persicum", "Cyclamen spp", "florist's cyclamen", "Persian violet", "sowbread", "ivy-leaved cyclamen", "hardy cyclamen", "cyclamen tuber", "cyclamen bulb"],
                categories: [.plants, .holidayHazards],
                imageAsset: "cyclamen_flowers",
                description: "Cyclamen is a popular flowering houseplant with distinctive swept-back petals and heart-shaped leaves, often given as a gift during the winter holiday season. It is prized as a winter bloomer that adds color to homes when few other plants are flowering. Despite its delicate appearance, cyclamen is toxic to dogs, cats, horses, and rabbits.",
                toxicityInfo: "Cyclamen contains terpenoid saponins, primarily cyclamine, which are concentrated throughout the plant but are most abundant in the tubers (roots/underground portions). Unlike most saponins, cyclamine is well-absorbed from the gastrointestinal tract. The mechanism of action involves interference with cell membrane lipids, changing their permeability and integrity — this affects mucosal cells locally and, after absorption, can cause lysis (destruction) of red blood cells.\n\nIn most cases, pets only nibble on the leaves, flowers, or stems, which contain lower levels of saponins and cause only mild GI upset (drooling, vomiting, diarrhea). However, if a pet digs up and consumes the tubers — which dogs are more likely to do than cats — serious toxicity can occur, including cardiac arrhythmias (abnormal heart rate and rhythm), seizures, and potentially death.\n\nRabbits are particularly at risk because they cannot vomit to expel the toxin. Cyclamen poisoning can be life-threatening in rabbits.",
                onsetTime: OnsetTime(
                    early: "GI signs (drooling, vomiting, diarrhea) typically appear within a few hours of ingestion",
                    delayed: "Cardiac effects (arrhythmias) and seizures may develop with large ingestions, particularly of tubers; symptoms may persist for 24+ hours in serious cases"
                ),
                symptoms: [
                    "Drooling (hypersalivation)",
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Abdominal discomfort",
                    "Abnormal heart rate (too fast or too slow)",
                    "Cardiac arrhythmias (large ingestions)",
                    "Weakness",
                    "Incoordination",
                    "Dilated pupils",
                    "Seizures (severe cases)",
                    "Collapse (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are more likely than cats to dig up and consume tubers due to their less discriminating eating habits; tuber ingestion can cause cardiac arrhythmias and seizures"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats typically only nibble leaves and flowers (lower toxin levels); GI upset is the most common outcome; serious toxicity is less common but possible with large ingestions"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Rabbits are particularly at risk — cyclamen can be life-threatening because rabbits cannot vomit to expel the toxin")
                ],
                preventionTips: [
                    "Keep cyclamen plants out of reach of pets, especially dogs that may dig in potted plants",
                    "The tubers (roots) are the most toxic part — if you repot cyclamen, dispose of any loose tubers securely",
                    "Consider placing cyclamen in rooms that pets cannot access, especially during the holiday season when these plants are commonly given as gifts",
                    "If you have rabbits, do not keep cyclamen anywhere they can access — it can be life-threatening to them",
                    "If your pet shows signs of poisoning after contact with cyclamen, contact your veterinarian promptly — cardiac monitoring may be needed for large ingestions"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "PMC - Toxicity of House Plants to Pet Animals (peer-reviewed)", "WagWalking Veterinary Resources"],
                relatedEntries: nil
            ),

            // MARK: - Bird of Paradise (Caesalpinia)
            ToxicItem(
                id: UUID(uuidString: "892498a6-3354-4bad-a3e3-1553972d6bae")!,
                name: "Bird of Paradise (Caesalpinia)",
                alternateNames: ["Caesalpinia gilliesii", "Erythrostemon gilliesii", "Poinciana gilliesii", "desert bird of paradise", "yellow bird of paradise", "Mexican bird of paradise", "Barbados pride", "peacock flower", "dwarf poinciana", "red bird of paradise", "pride of Barbados", "Caesalpinia pulcherrima", "bird of paradise shrub"],
                categories: [.plants],
                imageAsset: "bird_of_paradise_caesalpinia",
                description: "The shrub Bird of Paradise (Caesalpinia species) is a flowering plant in the pea family (Fabaceae/Leguminosae) grown as an ornamental in warm climates, particularly the southwestern United States and Gulf Coast regions. It produces showy yellow, red, or orange flowers and leguminous seed pods. This plant should NOT be confused with the tropical houseplant also called Bird of Paradise (Strelitzia reginae), which is a different species with milder toxicity — see the Important Note below.",
                toxicityInfo: "The shrub Bird of Paradise (Caesalpinia gilliesii and related species) contains hydrocyanic acid (hydrogen cyanide), which is released when plant tissue is damaged by chewing. The seed pods and seeds are considered the most toxic parts, though all parts of the plant contain the toxin. Tannins in the plant also contribute to gastrointestinal irritation.\n\nIngestion causes intense oral irritation and burning of the mouth, tongue, and lips, followed by drooling, vomiting, diarrhea, and difficulty swallowing. Incoordination has been reported, likely related to cyanide's effects on cellular respiration. Deaths have been documented in rabbits.\n\n**IMPORTANT:** Do not confuse this plant with the tropical houseplant Strelitzia reginae, which is also commonly called \"Bird of Paradise\" or \"Crane Flower.\" Strelitzia is a completely different plant (family Strelitziaceae) that causes only mild GI upset — it is considered much less toxic than Caesalpinia. The ASPCA specifically warns against confusing these two plants. If you are unsure which type of Bird of Paradise your pet ingested, describe the plant to your veterinarian or poison control — the shrub Caesalpinia has feathery compound leaves and legume-type seed pods, while Strelitzia has large banana-like leaves.",
                onsetTime: OnsetTime(
                    early: "Oral irritation and burning may be immediate; GI signs (drooling, vomiting, diarrhea) can appear within 20 minutes to a few hours",
                    delayed: "Most symptoms resolve with supportive care; incoordination and more serious effects may develop with larger ingestions"
                ),
                symptoms: [
                    "Intense burning and irritation of mouth, tongue, and lips",
                    "Excessive drooling (hypersalivation)",
                    "Vomiting",
                    "Diarrhea",
                    "Difficulty swallowing",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Incoordination (ataxia)",
                    "Weakness"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs may be attracted to the seed pods; causes intense oral irritation and GI upset; incoordination possible with larger ingestions"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Same toxicity concerns as dogs; cats are less likely to consume large amounts due to the intense oral irritation"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Deaths have been documented in rabbits; small mammals are at higher risk due to small body size"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data; birds should be kept away from this plant as a precaution")
                ],
                preventionTips: [
                    "Keep dogs away from Bird of Paradise shrubs, especially when seed pods are present — the pods and seeds are the most toxic parts",
                    "If you have this plant in your landscaping, supervise pets and consider fencing it off",
                    "Do not confuse this shrub (Caesalpinia) with the tropical houseplant Strelitzia — they are different plants with different toxicity levels",
                    "The intense oral irritation usually limits how much a pet will eat, but any ingestion should prompt a call to your veterinarian",
                    "If you have rabbits or other small mammals, keep them completely away from this plant — deaths have been documented"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "WagWalking Veterinary Resources", "Hunker Home & Garden"],
                relatedEntries: nil
            ),

            // MARK: - Cannabis / Marijuana
            ToxicItem(
                id: UUID(uuidString: "e293e8ba-eefc-4fe0-bf93-9e8842873a35")!,
                name: "Cannabis / Marijuana",
                alternateNames: ["Cannabis sativa", "Cannabis indica", "marijuana", "cannabis", "THC", "tetrahydrocannabinol", "delta-9 THC", "delta-8 THC", "pot", "weed", "grass", "ganja", "reefer", "dope", "bud", "chronic", "herb", "skunk", "Mary Jane", "hashish", "hash", "hash oil", "hemp", "CBD", "cannabidiol", "edibles", "marijuana edibles", "THC edibles", "THC gummies", "cannabis gummies", "marijuana brownies", "pot brownies", "cannabutter", "marijuana butter", "THC vape", "cannabis vape", "dronabinol", "nabilone", "devil weed", "Aunt Mary"],
                categories: [.plants, .recreationalSubstances],
                imageAsset: "cannabis_plant",
                description: "Cannabis (marijuana) toxicity has become increasingly common in pets, particularly in regions where marijuana has been legalized. Dogs are affected far more often than cats, typically through accidental ingestion of marijuana edibles (brownies, gummies, cookies, candies), plant material, or concentrated products. The primary psychoactive compound is delta-9-tetrahydrocannabinol (THC). With legalization has come more potent products and more severe toxicity cases.",
                toxicityInfo: "The cannabis plant (Cannabis sativa, Cannabis indica) contains over 480 distinct compounds, including nearly 70 cannabinoids. The primary psychoactive compound is delta-9-tetrahydrocannabinol (THC). THC concentration varies widely: 1-20% in plant material, 3-6% in hashish, and 30-50% in hashish oil. Edibles and concentrated products (vapes, distillates, tinctures) may contain much higher THC levels. Cannabutter (marijuana-infused butter) can have extremely high THC concentrations because THC is lipophilic (fat-soluble).\n\nTHC is absorbed rapidly after inhalation and more slowly after ingestion. A lethal dose has not been definitively established in dogs and cats — one study found no fatalities in dogs given oral THC doses of 3,000-9,000 mg/kg. However, clinical disease can occur at doses 1/1000th of the estimated lethal dose, and deaths have been reported, particularly with highly concentrated products or marijuana butter.\n\n**Common exposure routes:**\n• Ingestion of edibles (most common) — brownies, gummies, cookies, candies, infused beverages\n• Ingestion of plant material (dried leaves, flowers, stems)\n• Ingestion of concentrated products (vape cartridge liquid, hashish, hash oil)\n• Secondhand smoke exposure (usually causes mild effects)\n• Intentional smoke blown into pet's face\n• Ingestion of human feces containing THC (documented in case reports)\n\n**IMPORTANT — Compound toxicity with edibles:** Many marijuana edibles also contain chocolate, xylitol, raisins, macadamia nuts, or other ingredients toxic to pets. If your pet ingests a marijuana edible, consider ALL ingredients when assessing toxicity risk.\n\n**Delta-8 THC:** This THC isomer (approximately 50-75% as psychoactive as delta-9 THC) is increasingly appearing in legal marketplaces. Products may contain harmful by-products from the synthetic conversion process used to produce higher concentrations.",
                onsetTime: OnsetTime(
                    early: "Clinical signs typically appear within 1-3 hours of ingestion; effects from inhalation may appear more quickly",
                    delayed: "Signs can last 12-72+ hours depending on dose; severe cases may take several days to fully recover"
                ),
                symptoms: [
                    "CNS depression (lethargy, sedation, somnolence)",
                    "Ataxia (unsteady, wobbly gait)",
                    "Disorientation or appearing 'dazed'",
                    "Urinary incontinence (dribbling urine)",
                    "Hypothermia (low body temperature)",
                    "Bradycardia (slow heart rate) — or tachycardia in some cases",
                    "Mydriasis (dilated pupils) — or miosis (constricted pupils)",
                    "Scleral congestion (red/bloodshot eyes)",
                    "Hyperesthesia (exaggerated response to stimuli)",
                    "Vomiting",
                    "Hypersalivation (drooling)",
                    "Tremors",
                    "Vocalization",
                    "Recumbency (inability to stand)",
                    "Agitation or hyperactivity (severe cases)",
                    "Seizures (severe cases)",
                    "Obtundation or coma (severe cases)",
                    "Hyperthermia (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are most commonly affected. Classic presentation: depressed/somnolent, hypothermic, bradycardic, and dribbling urine. External stimulation causes brief hyperesthesia followed by return to somnolence. With legalization, more severe cases (seizures, coma, death) are being reported — whether from more potent products or adulterants is unknown. Deaths have occurred, particularly with concentrated products or cannabutter."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats may show different signs than dogs, including increased locomotor activity (wandering aimlessly, spontaneous jumping), head bobbing/weaving, swaying, anxiety, aggression, polydipsia, polyuria, polyphagia, and difficulty swallowing. Sedation and depression also occur. Seizures and coma are possible with large exposures."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Limited data available; small body size means even small exposures could cause significant effects. Seek veterinary care for any cannabis exposure in small mammals."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available; birds are susceptible to respiratory irritants from smoke. Seek veterinary care for any suspected exposure.")
                ],
                preventionTips: [
                    "Store all cannabis products (edibles, plant material, vapes, concentrates) in pet-proof containers and locations your pet cannot access",
                    "Edibles are the most common source of pet poisoning — never leave brownies, gummies, candies, or other edibles where pets can reach them",
                    "Be aware that marijuana butter (cannabutter) can contain extremely high THC concentrations",
                    "Do not blow marijuana smoke in your pet's face — this is not amusing, it is poisoning",
                    "Inform your veterinarian honestly about potential marijuana exposure — this information is confidential and essential for proper treatment",
                    "If your pet ingests an edible, also consider toxicity from other ingredients (chocolate, xylitol, raisins, macadamia nuts)",
                    "With legalization, highly concentrated products are more available — even small amounts of vape liquid or concentrates can cause severe toxicity"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Partner"],
                relatedEntries: nil
            ),

            // MARK: - Bleeding Heart
            ToxicItem(
                id: UUID(uuidString: "fc5744df-f6a1-4464-97b0-7de82f9c299a")!,
                name: "Bleeding Heart",
                alternateNames: ["Dicentra spectabilis", "Dicentra spp", "Dicentra eximia", "Dicentra formosa", "Lamprocapnos spectabilis", "bleeding heart plant", "Dutchman's breeches", "squirrel corn", "white eardrops", "steer's head", "soldier's cap", "butterfly banner", "kitten breeches", "staggerweed", "locks and keys", "Asian bleeding heart", "Japanese bleeding heart", "fringed bleeding heart", "western bleeding heart", "old-fashioned bleeding heart"],
                categories: [.plants],
                imageAsset: "bleeding_heart_plant",
                description: "Bleeding Heart is a popular shade-garden perennial known for its distinctive heart-shaped pink or white flowers that dangle from arching stems. Native to Asia (Japan, Korea, China, Siberia), it thrives in cooler climates and is commonly planted in North American gardens. Despite its delicate appearance, all parts of this plant are toxic to dogs, cats, horses, and livestock. The plant belongs to the poppy family (Papaveraceae) and contains alkaloids similar to those found in other members of this family.",
                toxicityInfo: "Bleeding Heart contains a variety of isoquinoline alkaloids, including apomorphine, cularine, and protoberberine alkaloids, depending on the species. These alkaloids exert neurologic effects through their antagonistic action on the neurotransmitter GABA (gamma-aminobutyric acid). Some alkaloids also interfere with sodium/potassium pumps and normal liver function.\n\n**All parts of the plant are toxic** — flowers, fruit, leaves, roots, sap, seeds, and stems. However, the **roots contain the highest concentration of toxins**, followed by the foliage. The plant has a bitter taste that often deters animals from consuming large quantities, but curious pets may still ingest enough to cause problems.\n\n**Skin contact warning:** The sap can cause contact dermatitis (skin irritation and rash) in both pets and humans. Handle with gloves.\n\n**Liver and kidney damage:** If toxins are not eliminated from the body quickly, they can cause permanent liver and kidney damage. Small dogs are especially vulnerable due to their size — they require a much smaller amount to reach toxic levels.\n\n**Related toxic plants:** Similar isoquinoline alkaloids are found in Corydalis (fitweed, fumeroot), Fumaria (fumitory), and Bloodroot (Sanguinaria).",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within a few hours of ingestion; trembling and staggering gait are often the first signs noticed",
                    delayed: "With significant ingestion, signs can progress to recumbency, seizures, and respiratory depression; liver/kidney damage may develop over 24-72 hours"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Excessive salivation (drooling)",
                    "Trembling or muscle tremors",
                    "Staggering gait (ataxia)",
                    "Weakness",
                    "Disorientation",
                    "Recumbency (inability to stand)",
                    "Seizures or convulsions",
                    "Labored breathing (respiratory depression)",
                    "Paralysis (severe cases)",
                    "Skin irritation (from contact with sap)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are commonly affected. Small dogs are at particular risk — they can suffer liver and kidney damage with relatively limited exposure. Progression: trembling → staggering → recumbency → tetanus-like seizures. Liver and kidney damage can be permanent if not treated promptly."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are susceptible to the same neurologic and organ toxicity as dogs. The bitter taste may limit ingestion, but any exposure should be taken seriously."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Limited data in small mammals; small body size increases risk. Seek veterinary care for any ingestion.")
                ],
                preventionTips: [
                    "The roots are the most toxic part — if you grow bleeding heart, ensure dogs cannot dig up the roots",
                    "Consider fencing off garden areas where bleeding heart is planted, especially if you have curious dogs",
                    "Wear gloves when handling bleeding heart plants — the sap can cause skin irritation in both humans and pets",
                    "Small dogs are especially at risk for serious toxicity — even small amounts can cause liver damage",
                    "If you see your pet eating any part of this plant, seek veterinary care immediately — do not wait for symptoms to appear",
                    "Bring a piece of the plant to the veterinarian if possible to confirm identification"
                ],
                sources: ["IVIS - Guide to Poisonous House and Garden Plants (Colorado State University)", "Pet Poison Helpline", "WagWalking Veterinary Resources", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Nicotine & Tobacco Products
            ToxicItem(
                id: UUID(uuidString: "fd98d3c0-368c-4b20-9192-c98dd3c17f14")!,
                name: "Nicotine & Tobacco Products",
                alternateNames: ["nicotine", "tobacco", "cigarette", "cigarettes", "cigarette butt", "cigarette butts", "cigar", "cigars", "e-cigarette", "e-cigarettes", "electronic cigarette", "electronic cigarettes", "vape", "vaping", "vape juice", "vape liquid", "e-juice", "e-liquid", "e juice", "e liquid", "nicotine liquid", "nicotine solution", "nicotine patch", "nicotine patches", "nicotine gum", "nicotine lozenge", "nicotine lozenges", "nicotine inhaler", "nicotine nasal spray", "nicotine replacement", "nicotine replacement therapy", "NRT", "chewing tobacco", "smokeless tobacco", "snuff", "snus", "dip", "dipping tobacco", "pipe tobacco", "Nicotiana", "tobacco plant", "nicotine poisoning", "nicotine toxicosis", "nicotine intoxication", "tobacco poisoning", "tobacco toxicosis", "e-juice poisoning", "e-liquid poisoning", "ashtray", "ash tray", "cigarette pack", "Juul", "vape pen", "vape pod", "Nicorette", "Nicoderm", "Habitrol", "Commit lozenge"],
                categories: [.recreationalSubstances, .plants],
                imageAsset: "nicotine_tobacco",
                description: "Nicotine is a highly toxic alkaloid produced by tobacco plants (Nicotiana species). Pets can be poisoned by ingesting tobacco products, nicotine replacement therapies, or liquid nicotine used in electronic cigarettes. Nicotine acts on the nervous system, initially causing stimulation followed by dangerous depression and paralysis at higher exposures. Death can occur rapidly in severe cases. E-cigarette liquids and nicotine patches pose the greatest danger due to their concentrated nicotine content and rapid absorption.",
                toxicityInfo: "Nicotine is extremely dangerous to pets. It is rapidly absorbed across mucous membranes (mouth, nose) and skin, meaning exposure doesn't require swallowing. Nicotine is poorly absorbed in the stomach due to stomach acid, but once it reaches the small intestine, absorption is rapid.\n\n**Highest-Risk Products:**\n• E-cigarette liquids (e-juice/e-liquid): Concentrated nicotine (0-200+ mg/mL) with rapid oral and dermal absorption; flavored varieties may be attractive to pets\n• Nicotine patches: Contain far more nicotine than the daily release amount listed on the label; used patches can retain up to 80% of original nicotine; chewing releases a gel that absorbs rapidly through the mouth\n• Nicotine gum and lozenges: Some products contain xylitol, which is separately toxic to dogs\n• Cigarette butts: Filtered butts actually contain MORE nicotine because the filter traps it; ashtrays are a common source of exposure\n\nTobacco products (cigarettes, cigars, chewing tobacco, pipe tobacco, snuff) release nicotine more slowly from the plant material, which may delay but does not prevent toxicosis.\n\nAt low doses, nicotine stimulates nicotinic receptors throughout the nervous system, causing stimulation. At higher doses, persistent receptor activation leads to blockade, causing progressive nervous system depression. Paralysis of respiratory muscles, respiratory arrest, and death may follow. Nicotine also stimulates the emetic (vomiting) center and can cause excessive vagal stimulation, resulting in bradycardia and potentially cardiac arrest.\n\nNicotine is eliminated rapidly (half-life less than 1 hour in dogs), so pets that survive the initial hours generally have a good prognosis with supportive care.",
                onsetTime: OnsetTime(
                    early: "Signs can appear within minutes, especially with liquid nicotine products or chewed patches; tobacco products may have delayed onset due to slower nicotine release from plant material",
                    delayed: "Death can occur within minutes to hours in severe cases; survivors typically recover within 24 hours due to rapid elimination"
                ),
                symptoms: [
                    "Vomiting (often the first sign)",
                    "Hypersalivation (drooling)",
                    "Diarrhea",
                    "Agitation or restlessness",
                    "Dilated pupils (mydriasis)",
                    "Incoordination (ataxia)",
                    "Tachycardia (rapid heart rate)",
                    "Hypertension (high blood pressure)",
                    "Bradycardia (slow heart rate — from vagal stimulation)",
                    "Hypotension (low blood pressure)",
                    "Cardiac arrhythmias",
                    "Tremors",
                    "Seizures",
                    "Weakness and collapse",
                    "Central nervous system depression",
                    "Flaccid paralysis",
                    "Difficulty breathing (dyspnea)",
                    "Respiratory arrest",
                    "Cardiac arrest"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are most commonly affected due to their scavenging behavior. Cigarette butts in ashtrays, discarded chewing tobacco, and e-liquids are frequent exposure sources. Nicotine gum and lozenges containing xylitol pose a double toxicity risk. Even small exposures to concentrated nicotine liquids can be rapidly fatal."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are highly susceptible to nicotine toxicity. Exposure is less common than in dogs but equally dangerous. Dermal exposure can occur if cats walk through spilled e-liquids and groom themselves."),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Rabbits, guinea pigs, ferrets, and other small mammals are extremely susceptible to nicotine toxicity due to their small body size. Even minimal exposure can be life-threatening."),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly sensitive to nicotine and respiratory irritants. Their small size and rapid metabolism make even minor exposures potentially fatal. Secondhand smoke exposure is also harmful to birds."),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "Limited data available, but nicotine is expected to be highly toxic to reptiles. Avoid any exposure and seek veterinary care immediately if exposure occurs.")
                ],
                preventionTips: [
                    "Store all tobacco products, nicotine replacement products, and e-cigarette supplies in secure, pet-proof containers",
                    "Never leave cigarettes, cigars, or ashtrays where pets can reach them",
                    "Dispose of cigarette butts securely — do not leave ashtrays accessible or discard butts where pets can find them outdoors",
                    "Keep e-liquids and vape supplies locked away; even small spills can be dangerous",
                    "Remember that used nicotine patches still contain significant amounts of nicotine — dispose of them in sealed containers",
                    "Be aware that some nicotine gums and lozenges contain xylitol, which is separately toxic to dogs",
                    "Clean up any spilled e-liquid immediately and keep pets away from the area; nicotine absorbs through skin",
                    "If you use nicotine patches, ensure pets cannot access them on your body or after removal"
                ],
                sources: ["Veterinary Information Network (VIN) — Nicotine Toxicosis", "ASPCA Animal Poison Control Center", "Pet Poison Helpline — Nicotine", "Merck Veterinary Manual — Tobacco and Nicotine Toxicosis", "Tilley and Smith, The 5-Minute Veterinary Consult: Canine and Feline"],
                relatedEntries: nil
            ),

            // MARK: - Monkshood
            ToxicItem(
                id: UUID(uuidString: "7e3f5e24-a4ef-4356-9445-16b8f37d6ab4")!,
                name: "Monkshood",
                alternateNames: ["Aconitum", "Aconite", "Wolfsbane", "Wolf's bane", "Leopard's bane", "Devil's helmet", "Blue rocket", "Friar's cap", "Queen of poisons", "Helmet flower", "Aconitum napellus", "Aconitum columbianum", "Western monkshood", "Garden monkshood"],
                categories: [.plants],
                imageAsset: "monkshood",
                description: "Monkshood (Aconitum species) is a perennial garden ornamental with distinctive hooded blue, purple, or white flowers. All parts of the plant are highly toxic. Historically used as a poison for humans and pest animals, monkshood affects the heart and nervous system. There is no antidote — treatment is supportive only. Poisoning is uncommon but can be fatal.",
                toxicityInfo: "Monkshood contains aconitine and related alkaloids that affect sodium channels in nerve and cardiac tissue. All parts of the plant are toxic, including roots, leaves, and flowers. The alkaloids cause both neurological and cardiac effects, including dangerous arrhythmias and bradycardia. Even handling the plant can cause skin numbness and tingling in some cases.\n\nThere is no specific antidote for aconitine poisoning. Treatment is symptomatic and supportive, focusing on managing cardiac arrhythmias and supporting vital functions.\n\n**Note:** Monkshood is sometimes confused with Larkspur (Delphinium), another tall garden plant with showy flower spikes. However, they contain different alkaloids and have different clinical presentations. Larkspur primarily causes neuromuscular effects, while Monkshood has prominent cardiac toxicity.",
                onsetTime: OnsetTime(
                    early: "Signs can develop within minutes to a few hours of ingestion; oral numbness and tingling may occur rapidly",
                    delayed: "Cardiac arrhythmias may develop or worsen over several hours; death can occur within hours in severe cases"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Oral irritation and numbness",
                    "Nausea and vomiting",
                    "Restlessness or agitation",
                    "Weakness",
                    "Impaired vision",
                    "Incoordination (ataxia)",
                    "Bradycardia (slow heart rate)",
                    "Cardiac arrhythmias",
                    "Difficulty breathing (dyspnea)",
                    "Recumbency (inability to rise)",
                    "Collapse",
                    "Death (in severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs may be attracted to dig up roots or chew on plants. Cardiac and neurological effects can be life-threatening. There is no antidote — all exposure should be treated as an emergency."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats are susceptible to aconitine toxicity. Any ingestion warrants immediate veterinary care. Cardiac arrhythmias are the primary concern."),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size increases risk of severe toxicity. Limited data available — treat any exposure as potentially life-threatening."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available. Assume toxicity and seek veterinary care for any suspected exposure."),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Limited data available. Avoid exposure and seek veterinary care if ingestion is suspected.")
                ],
                preventionTips: [
                    "Do not plant monkshood in areas accessible to pets",
                    "Remove any existing monkshood from pet-accessible gardens",
                    "Wear gloves when handling the plant — alkaloids can absorb through skin and cause numbness",
                    "Dispose of plant material (including prunings) securely where pets cannot access it",
                    "Be aware that dried plant material remains toxic",
                    "Learn to identify monkshood — it has distinctive hooded flowers on tall spikes"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Tilley and Smith, The 5-Minute Veterinary Consult: Canine and Feline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Datura (Angel's Trumpet & Jimsonweed)
            ToxicItem(
                id: UUID(uuidString: "058dbd41-6a45-4486-ab20-bc2929c251a0")!,
                name: "Datura (Angel's Trumpet & Jimsonweed)",
                alternateNames: ["Datura", "Angel's trumpet", "Angels trumpet", "Devil's trumpet", "Jimsonweed", "Jimson weed", "Thorn apple", "Moonflower", "Locoweed", "Devil's weed", "Devil's cucumber", "Hell's bells", "Stinkweed", "Tolguacha", "Toloache", "Datura stramonium", "Datura metel", "Datura inoxia", "Datura wrightii", "Brugmansia", "Brugmansia suaveolens", "Trumpet flower", "Sacred datura", "Indian apple", "Mad apple"],
                categories: [.plants],
                imageAsset: "datura",
                description: "Datura species (including jimsonweed and angel's trumpet) are plants with distinctive large, trumpet-shaped flowers. Two genera are commonly called \"angel's trumpet\": Datura (typically with upward-facing flowers) and Brugmansia (typically with pendulous flowers). Both contain tropane alkaloids that cause effects similar to atropine poisoning, including rapid heart rate, dilated pupils, dry mouth, hyperthermia, and CNS effects such as disorientation and agitation. Datura is generally more toxic than Brugmansia. These plants have historically been used as hallucinogens, often with tragic results.",
                toxicityInfo: "Datura and Brugmansia contain tropane alkaloids including hyoscyamine, scopolamine (also called hyoscine), and atropine. These alkaloids block acetylcholine at muscarinic receptors, causing anticholinergic effects throughout the body.\n\n**Datura** is the more toxic of the two genera. Alkaloids are concentrated in the flowers and seeds, with lower levels in leaves. Ingestion of flowers or seeds is far more dangerous than leaf ingestion alone.\n\n**Brugmansia** contains alkaloids in all parts of the plant but generally at lower concentrations than Datura.\n\nThe clinical syndrome resembles atropine poisoning: rapid heart rate, dry mucous membranes, dilated pupils, elevated body temperature, decreased gut motility, and CNS effects including hallucinations, disorientation, and agitation. Death typically results from depression of central respiratory centers or complications of hyperthermia.\n\nThere is considerable species variation in susceptibility — rabbits and some herbivores show relative resistance to tropane alkaloids.\n\n**Note:** Jimsonweed (Datura stramonium) is a common weed in many areas and may grow uninvited in yards and fields.",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within 30 minutes to several hours of ingestion",
                    delayed: "CNS effects and hyperthermia may persist for 24-48 hours or longer; full recovery may take several days"
                ),
                symptoms: [
                    "Dilated pupils (mydriasis)",
                    "Dry mucous membranes (dry mouth, nose)",
                    "Rapid heart rate (tachycardia)",
                    "Elevated body temperature (hyperthermia)",
                    "Decreased gut sounds and constipation",
                    "Thirst",
                    "Disorientation or confusion",
                    "Agitation or restlessness",
                    "Behavioral changes (hallucinations)",
                    "Incoordination (ataxia)",
                    "Weakness",
                    "CNS depression (severe cases)",
                    "Respiratory depression",
                    "Seizures (rare)",
                    "Coma (severe cases)",
                    "Death (from respiratory failure)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs may ingest plant material while exploring. Leaf ingestion may cause mild or no signs; flowers and seeds are significantly more dangerous. Monitor for anticholinergic signs (dilated pupils, dry mouth, rapid heart rate, agitation)."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats ingesting flowers or seeds are at higher risk for significant toxicity. CNS effects and hyperthermia can be severe. Seek veterinary care promptly for any suspected ingestion."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Rabbits and some herbivores show relative resistance to tropane alkaloids. However, ferrets and other small mammals may be more susceptible. Seek veterinary care for any suspected exposure."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available. Assume susceptibility and seek veterinary care for any suspected exposure."),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Limited data available. Seek veterinary care for any suspected exposure.")
                ],
                preventionTips: [
                    "Learn to identify jimsonweed (Datura stramonium) — it commonly grows as a weed in yards, fields, and disturbed areas",
                    "Remove jimsonweed from yards and areas where pets roam",
                    "If growing ornamental angel's trumpet (Brugmansia), keep pets away from the plant, especially fallen flowers and seed pods",
                    "Seeds are particularly dangerous — do not allow pets access to seed pods",
                    "Be aware that all parts of these plants are toxic, but flowers and seeds contain the highest alkaloid concentrations",
                    "Educate family members about the toxicity of these attractive but dangerous plants"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Tilley and Smith, The 5-Minute Veterinary Consult: Canine and Feline", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Golden Chain Tree
            ToxicItem(
                id: UUID(uuidString: "e4b28653-d4b2-42a0-ac67-f22e53fc1673")!,
                name: "Golden Chain Tree",
                alternateNames: ["Laburnum", "Laburnum anagyroides", "Laburnum alpinum", "Laburnum × watereri", "golden chain", "golden chain tree", "golden rain tree", "bean tree", "false ebony", "laburnum tree", "common laburnum", "Scotch laburnum", "alpine laburnum"],
                categories: [.plants],
                imageAsset: "golden_chain_tree",
                description: "Golden Chain Tree (Laburnum species) is an ornamental landscape tree prized for its spectacular hanging clusters of bright yellow flowers that resemble wisteria. All parts of the plant are toxic, with the highest concentration of toxins in the seeds (found in bean-like pods). The plant contains cytisine, a nicotine-like alkaloid that affects the nervous system. While fatal poisonings in dogs are rare, even relatively small exposures can cause significant gastrointestinal upset.",
                toxicityInfo: "Golden chain tree contains cytisine and other quinolizidine alkaloids. Cytisine has nicotine-like effects — it binds to nicotinic acetylcholine receptors, initially causing stimulation followed by blockade at higher doses. The seeds contain the highest concentration of toxins, but all parts of the plant (bark, leaves, flowers, and seed pods) are toxic. Dogs have been poisoned simply by chewing on laburnum sticks.\n\nCytisine also has cardiac effects — it causes a reduction in intracellular potassium, which can lead to atrioventricular (AV) block and other cardiac conduction abnormalities.\n\nWhile it generally takes a large ingestion to cause severe or fatal toxicosis, smaller exposures can still cause significant gastrointestinal upset including intense vomiting and diarrhea. Fatal poisonings in dogs have been documented in veterinary literature, though they are uncommon. The long-term effects of chronic low-level exposure are not well understood.\n\n**Important for breeders:** Cytisine is teratogenic (can cause birth defects). Pregnant animals should be kept away from this plant.\n\nThe seed pods resemble bean pods, which may make them attractive to curious dogs. Children have also been poisoned after eating the seeds, mistaking them for peas or beans.",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within 15 minutes to 2 hours of ingestion",
                    delayed: "Severe cases may progress over several hours; neurological signs may develop after initial GI upset"
                ),
                symptoms: [
                    "Vomiting (often intense/repeated)",
                    "Nausea",
                    "Abdominal pain",
                    "Diarrhea",
                    "Drooling (hypersalivation)",
                    "Weakness",
                    "Incoordination (ataxia)",
                    "Depression or lethargy",
                    "Dilated pupils (mydriasis)",
                    "Rapid heart rate (tachycardia)",
                    "Irregular pulse",
                    "Atrioventricular (AV) block (severe cases)",
                    "Tremors",
                    "Seizures (severe cases)",
                    "Collapse",
                    "Coma (severe cases)",
                    "Respiratory depression (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Fatal poisonings in dogs are rare, but even small ingestions can cause significant GI upset. Dogs may be attracted to the bean-like seed pods. The nicotine-like effects can cause neurological signs in larger ingestions."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are susceptible to cytisine toxicity. Any ingestion should be evaluated by a veterinarian. GI upset is the most common presentation."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size may increase risk of more severe effects. Rabbits and guinea pigs with access to outdoor areas where golden chain trees grow should be supervised. Keep pregnant animals away — cytisine is teratogenic."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available. Birds may be attracted to the seeds. Assume susceptibility and seek veterinary care for any suspected ingestion."),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Limited data available. Ingestion is unlikely but seek veterinary care if suspected.")
                ],
                preventionTips: [
                    "Do not plant golden chain trees in areas accessible to pets",
                    "If you have an existing golden chain tree, promptly remove fallen seed pods before pets can access them",
                    "The bean-like seed pods may be attractive to dogs — be especially vigilant during and after the seeding season",
                    "Do not allow dogs to chew on fallen branches or sticks from golden chain trees — dogs have been poisoned this way",
                    "Keep pregnant animals away from golden chain trees — the alkaloid cytisine is teratogenic (can cause birth defects)",
                    "Educate children that the seeds are not edible peas or beans — human poisonings have occurred",
                    "Consider removing golden chain trees from your property if you have pets, especially dogs that tend to chew on things"
                ],
                sources: ["Veterinary Information Network (VIN)", "Pet Poison Helpline — Golden Chain Tree", "Clarke ML, Clarke EG, King T. Fatal laburnum poisoning in a dog. Vet Rec. 1971;88(7):199-200", "Clinical Veterinary Toxicology (Plumlee KH, ed.)", "Vetlexicon Canis — Cardiotoxic Plant Poisoning"],
                relatedEntries: nil
            ),

            // MARK: - Lupine
            ToxicItem(
                id: UUID(uuidString: "71347450-35e9-4be4-b472-eedc6b9cef7a")!,
                name: "Lupine",
                alternateNames: ["Lupinus", "Lupinus spp", "bluebonnet", "Texas bluebonnet", "wild lupine", "sundial lupine", "garden lupine", "Russell lupine", "Russell hybrid", "tree lupine", "yellow bush lupine", "silver lupine", "bigleaf lupine", "lupine seeds", "lupine beans", "lupini", "tarwi", "lupine hay", "quinolizidine alkaloids", "lupin", "lupins"],
                categories: [.plants],
                imageAsset: "lupine",
                description: "Lupines (Lupinus spp.) are a large genus of flowering plants with over 200 species found throughout North America, the Mediterranean, and South America. They are prized for their tall spikes of colorful flowers (blue, purple, pink, white, yellow) and are popular in wildflower meadows and cottage gardens. Texas bluebonnets (Lupinus texensis) are the state flower of Texas. While livestock poisoning from lupines grazing on rangeland is well documented ('crooked calf disease' in cattle), pet poisonings are less common but do occur — particularly when dogs ingest seeds or seed pods from ornamental lupines in home gardens.",
                toxicityInfo: "Lupines contain quinolizidine alkaloids, the same class of toxins found in golden chain tree (Laburnum). The primary alkaloids include lupinine, sparteine, and anagyrine, which affect the nervous system and can cause nicotinic receptor stimulation followed by blockade. **The seeds contain the highest concentration of alkaloids** — concentrations vary significantly between species and even between individual plants of the same species. 'Sweet' lupine varieties bred for low-alkaloid content (used for human consumption) are less toxic but should still be considered potentially harmful to pets. Note that anagyrine is a known teratogen — exposure during pregnancy can cause skeletal deformities in offspring (crooked calf disease in cattle, 'crooked lamb' in sheep). While this primarily affects livestock, pregnant pets should be kept away from lupines.",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within 1-4 hours of ingestion — early effects include hypersalivation, vomiting, and excitability",
                    delayed: "Neurological signs (tremors, incoordination, seizures) may develop over several hours with significant ingestions. Recovery usually occurs within 24-48 hours with supportive care"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite",
                    "Lethargy and depression",
                    "Excitability or nervousness (early)",
                    "Tremors",
                    "Muscle weakness",
                    "Incoordination (ataxia)",
                    "Dilated pupils (mydriasis)",
                    "Difficulty breathing (dyspnea)",
                    "Seizures (rare, with large ingestions)",
                    "Collapse"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs may be attracted to lupine seed pods. Seeds have the highest toxin concentration. Most ingestions cause GI upset and mild neurological signs. Large seed ingestions warrant veterinary evaluation."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are less likely to ingest lupine but should be monitored if exposure is suspected. Seek veterinary care for any ingestion."),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size increases risk of serious toxicity. Rabbits and guinea pigs are susceptible. Keep pregnant animals away — quinolizidine alkaloids are teratogenic."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available. Assume susceptibility and seek veterinary care for any suspected ingestion.")
                ],
                preventionTips: [
                    "If you grow ornamental lupines, remove spent flower stalks before seed pods develop — the seeds are the most toxic part",
                    "Do not allow dogs to chew on lupine seed pods — they may find the bean-like pods interesting",
                    "Keep pregnant pets away from lupines — the alkaloid anagyrine is teratogenic (causes birth defects)",
                    "Be aware of wild lupines on hiking trails, especially in western North America where they are abundant",
                    "Do not feed lupini beans (even prepared human-food varieties) to pets"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Veterinary Information Network (VIN)", "Merck Veterinary Manual — Quinolizidine Alkaloid Toxicosis", "Pet Poison Helpline", "Panter KE, et al. Natural toxins of plant origin. In: Toxins and Other Harmful Compounds in Foods. RSC Publishing. 2017"],
                relatedEntries: nil
            ),

            // MARK: - Christmas Rose & Hellebores
            ToxicItem(
                id: UUID(uuidString: "165617f0-7aa5-47a2-b62c-21adb49e42ca")!,
                name: "Christmas Rose & Hellebores",
                alternateNames: ["Helleborus", "Helleborus niger", "Helleborus orientalis", "Christmas rose", "Lenten rose", "black hellebore", "winter rose", "snow rose", "hellebore", "stinking hellebore", "Helleborus foetidus", "bear's foot", "setterwort", "green hellebore", "Helleborus viridis", "hellebore root", "Corsican hellebore", "Helleborus argutifolius", "oriental hellebore", "hellebore hybrids", "Helleborus x hybridus", "hellebore protoanemonin", "hellebore glycosides"],
                categories: [.plants, .holidayHazards],
                imageAsset: "christmas_rose",
                description: "Hellebores (Helleborus spp.) are a genus of about 20 species of evergreen perennials prized for their winter and early spring blooms. The Christmas rose (Helleborus niger) blooms around Christmas in mild climates, while Lenten roses (Helleborus orientalis and hybrids) bloom during Lent (February-April). Their ability to flower in winter when little else blooms makes them popular garden plants. They are frequently used in holiday arrangements and winter container gardens. All parts of the plant are toxic, with the roots containing the highest concentration of toxins.",
                toxicityInfo: "Hellebores contain multiple toxins including **cardiac glycosides** (hellebrin, helleborein) and **protoanemonin** (a vesicant also found in buttercups and clematis). The cardiac glycosides can affect heart rhythm and contractility, while protoanemonin causes irritation to mucous membranes and skin. The roots are most toxic, followed by leaves and flowers. The sap can cause contact dermatitis in humans and skin/oral irritation in pets. Historical note: In ancient times, hellebore root was used medicinally (and for poisoning) — the name derives from Greek words meaning 'to kill' and 'food.' Despite their toxicity, severe poisonings in pets are uncommon because the bitter taste and irritating sap usually limit the amount consumed.",
                onsetTime: OnsetTime(
                    early: "GI signs (hypersalivation, vomiting, abdominal pain) typically appear within 30 minutes to 2 hours of ingestion due to the irritant effects of protoanemonin",
                    delayed: "Cardiac effects from glycoside toxicity, if they occur, may develop over several hours — monitor for irregular heartbeat, weakness, or collapse"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Oral irritation and pain",
                    "Vomiting",
                    "Diarrhea (may be bloody)",
                    "Abdominal pain",
                    "Lethargy",
                    "Depression",
                    "Weakness",
                    "Cardiac arrhythmias (irregular heartbeat)",
                    "Bradycardia (slow heart rate)",
                    "Collapse (severe cases)",
                    "Contact dermatitis (skin exposure to sap)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs may dig up and chew hellebore roots when investigating garden beds. The bitter taste usually limits ingestion. Cardiac glycoside effects are possible with large ingestions — seek veterinary care."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are less likely to ingest hellebores but may chew on leaves. GI upset is the most common presentation. Contact your veterinarian for any ingestion."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size may increase risk. Keep rabbits and guinea pigs away from hellebore plants in the garden."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available. Assume susceptibility and seek veterinary care for any suspected ingestion.")
                ],
                preventionTips: [
                    "Wear gloves when handling hellebores — the sap can cause skin irritation",
                    "If you have dogs that dig in flower beds, consider protecting hellebore plantings with barriers",
                    "Be cautious with hellebore trimmings and roots — dispose of them where pets cannot access",
                    "Keep hellebore holiday arrangements out of reach of pets",
                    "If your pet is attracted to chewing plants, hellebores are not a good choice for accessible garden areas"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Veterinary Information Network (VIN)", "Pet Poison Helpline", "Merck Veterinary Manual", "Plants of the Pacific Northwest Coast (Pojar & MacKinnon)"],
                relatedEntries: nil
            ),

            // MARK: - Bittersweet
            ToxicItem(
                id: UUID(uuidString: "03a94b12-a160-4244-a3b0-a8050554a062")!,
                name: "Bittersweet",
                alternateNames: ["American bittersweet", "Celastrus scandens", "climbing bittersweet", "false bittersweet", "waxwork", "shrubby bittersweet", "Oriental bittersweet", "Celastrus orbiculatus", "Asian bittersweet", "round-leaved bittersweet", "staff vine", "staff tree", "bittersweet vine", "bittersweet berries", "decorative bittersweet", "bittersweet wreath", "Euonymus alkaloids", "bittersweet nightshade", "Solanum dulcamara", "woody nightshade", "climbing nightshade", "European bittersweet"],
                categories: [.plants, .holidayHazards],
                imageAsset: "bittersweet",
                description: "The name 'bittersweet' refers to two different groups of plants: the **Celastrus** species (American bittersweet, Oriental bittersweet) — woody vines prized for their showy orange-red berries used in fall/winter wreaths and holiday decorations, and **bittersweet nightshade** (Solanum dulcamara) — a weedy vine in the nightshade family with purple flowers and red berries. Both are toxic to pets, but through different mechanisms. This entry covers both since the common name overlap causes confusion. American bittersweet (Celastrus scandens) is native to North America; Oriental bittersweet (Celastrus orbiculatus) is an invasive species from Asia. Both produce the orange-red berry clusters used in decorative arrangements.",
                toxicityInfo: "**Celastrus (American & Oriental Bittersweet)** — These vines contain alkaloids and possibly cardiac glycoside-like compounds, though the exact toxins have not been fully characterized. All parts are considered toxic, with the berries being of particular concern because they are attractive and accessible in holiday decorations. Ingestion typically causes GI upset, but larger amounts may cause more significant effects including possible cardiac effects. The bright orange-yellow fruit capsules split open to reveal red berry-like seeds (arils) that may attract pets.\n\n**Bittersweet Nightshade (Solanum dulcamara)** — This unrelated plant contains solanine and other glycoalkaloids (the same toxin class found in green potatoes and tomato plants). The unripe (green) berries have the highest toxin concentration; ripe red berries are less toxic but still potentially harmful. Symptoms include GI upset, CNS depression, and in severe cases, cardiac effects. The berries may be mistaken for edible wild berries.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, diarrhea, hypersalivation) typically appear within 1-6 hours of ingestion",
                    delayed: "CNS effects (lethargy, weakness, incoordination, seizures) may develop with larger ingestions over 6-24 hours"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Depression",
                    "Incoordination (ataxia)",
                    "Dilated pupils (mydriasis)",
                    "Slow heart rate (bradycardia)",
                    "Tremors",
                    "Seizures (rare, with large ingestions)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs may chew on bittersweet wreaths and decorations, ingesting the berries. Most cases result in GI upset. Large ingestions warrant veterinary evaluation for potential cardiac or neurological effects."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats may be attracted to swinging bittersweet decorations as play objects. Contact your veterinarian for any ingestion."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size may increase risk of more significant effects. Keep decorations out of reach of rabbits, guinea pigs, and other small pets."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data available. Wild birds do eat bittersweet berries, but pet birds may be more sensitive. Seek veterinary care for any suspected ingestion.")
                ],
                preventionTips: [
                    "Keep bittersweet wreaths, garlands, and centerpieces out of reach of pets",
                    "Be aware that dried bittersweet decorations remain toxic — the berries do not become safe when dried",
                    "If you have outdoor bittersweet vines (especially the invasive Oriental bittersweet), consider removing them or ensuring pets cannot access the berries",
                    "Do not allow pets to chew on bittersweet decorations — the berries can detach and be swallowed",
                    "Learn to identify bittersweet nightshade, which may grow as a weed in gardens and wooded areas"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Cornell University Poisonous Plants Database", "USDA Plant Database"],
                relatedEntries: nil
            ),

            // MARK: - Daphne
            ToxicItem(
                id: UUID(uuidString: "0352eba9-25a1-4a99-a850-a22052c2f176")!,
                name: "Daphne",
                alternateNames: ["Daphne mezereum", "mezereum", "mezereon", "February daphne", "spurge laurel", "Daphne laureola", "spurge flax", "spurge olive", "dwarf bay", "dwarf laurel", "lady laurel", "paradise plant", "wild pepper", "winter daphne", "Daphne odora", "garland daphne", "rose daphne", "Daphne cneorum", "copse laurel", "flax olive", "olive spurge"],
                categories: [.plants],
                imageAsset: "daphne_berries",
                description: "Daphne is a genus of about 70-95 species of fragrant, flowering shrubs in the family Thymelaeaceae, native to Europe, Asia, and North Africa. They are prized for their sweetly scented flowers that bloom in late winter to early spring, and their attractive red berries. Common species include February daphne (Daphne mezereum), spurge laurel (Daphne laureola), winter daphne (Daphne odora), and rose daphne (Daphne cneorum). Despite their ornamental appeal, all parts of daphne plants are highly toxic to humans, dogs, cats, and other animals.",
                toxicityInfo: "Daphne plants contain potent diterpene toxins, primarily mezerein and daphnin (a glycoside), as well as prostratin (a diterpene acetate). These compounds are found throughout the plant but are most concentrated in the berries and bark.\n\nThe toxins cause severe irritation and vesication (blistering) of the mucous membranes. When ingested, they produce intense burning and swelling of the lips, mouth, tongue, and throat — often described as a 'scalding' sensation. This progresses to severe gastrointestinal damage with vomiting, abdominal pain, and bloody diarrhea. The hemorrhagic diarrhea results from direct irritation and ulceration of the GI tract lining.\n\nFortunately, the extremely bitter taste of daphne usually prevents animals from consuming large quantities. However, only a few berries can be dangerous — in children, as few as 10-12 berries have been reported to cause fatal poisoning.\n\nSevere poisoning (rare due to bitter taste) can progress to weakness, seizures, kidney inflammation, liver damage, coma, and death. Additionally, skin or eye contact with daphne sap can cause blistering, redness, and severe irritation — wear gloves when handling these plants.",
                onsetTime: OnsetTime(
                    early: "Oral pain, burning, and swelling begin within minutes of chewing. GI signs (vomiting, diarrhea) typically appear within 1-2 hours.",
                    delayed: "Bloody diarrhea may develop over several hours. Severe systemic effects (seizures, organ damage) are rare but can develop within 12-24 hours in cases of large ingestion."
                ),
                symptoms: [
                    "Intense burning sensation in mouth and throat",
                    "Swelling of the lips, tongue, and oral cavity (vesication/blistering)",
                    "Excessive drooling (hypersalivation)",
                    "Difficulty swallowing (dysphagia)",
                    "Extreme thirst",
                    "Vomiting",
                    "Severe abdominal pain",
                    "Diarrhea (may be bloody/hemorrhagic)",
                    "Weakness",
                    "Lethargy or depression",
                    "Seizures (severe cases)",
                    "Irregular heartbeat (rare)",
                    "Skin blistering (with dermal contact)",
                    "Eye irritation and pain (with ocular exposure)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "All parts are toxic; berries are most dangerous; bitter taste usually limits ingestion but even a few berries can cause serious illness; hemorrhagic diarrhea is a hallmark sign"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Same concerns as dogs; cats may be attracted to the plant's fragrant flowers"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Small body size makes birds extremely vulnerable; berries may be attractive to caged birds if accessible")
                ],
                preventionTips: [
                    "Consider removing daphne plants from areas where pets have unsupervised access — the berries are particularly attractive and dangerous",
                    "If keeping daphne in your garden, fence off the area or place plants where pets cannot reach",
                    "Wear gloves when pruning or handling daphne plants — the sap can cause skin blistering",
                    "Be aware that daphne blooms in late winter/early spring when pets may be more active outdoors",
                    "Teach children not to eat any berries from garden plants",
                    "If your pet shows signs of oral pain or bloody diarrhea after being in the garden, seek veterinary care immediately"
                ],
                sources: ["Veterinary Information Network (VIN)", "Pet Poison Helpline", "ASPCA Animal Poison Control Center", "Animal Poisons Helpline (Australia)"],
                relatedEntries: nil
            ),

            // MARK: - Chinaberry Tree
            ToxicItem(
                id: UUID(uuidString: "52bd87dd-b94f-4c72-9dfa-ff1f8b689193")!,
                name: "Chinaberry Tree",
                alternateNames: ["Melia azedarach", "chinaberry", "china berry", "Texas umbrella tree", "Texas umbrella", "umbrella tree", "bead tree", "China ball tree", "paradise tree", "Persian lilac", "Indian lilac", "white cedar", "pride of India", "pride-of-India", "China tree", "Chinese umbrella", "hoop tree", "cape lilac", "cape syringa", "Japanese bead tree", "chinaberry berries"],
                categories: [.plants],
                imageAsset: "chinaberry_tree_berries",
                description: "The chinaberry tree (Melia azedarach) is a deciduous tree in the mahogany family, native to Asia and Australia. It was introduced to North America in the early 1800s as an ornamental and is now considered an invasive species in many southern states. The tree produces fragrant purple flowers in spring followed by yellow, berry-like fruits (drupes) that persist through winter. Dogs appear to be particularly susceptible to chinaberry poisoning, and fatalities have been documented.",
                toxicityInfo: "Chinaberry trees contain tetranortriterpene neurotoxins called meliatoxins (A1, A2, B1, and B2). These toxins are concentrated in the ripe fruit (berries) but are also present in the bark, leaves, and flowers. The meliatoxins act as both enterotoxins (affecting the GI tract) and neurotoxins (affecting the nervous system).\n\n**Clinical progression:** Poisoning typically begins with gastrointestinal signs — drooling, vomiting, and diarrhea — within hours of ingestion. If sufficient berries are consumed, neurological signs follow: ataxia (incoordination), mental confusion, weakness, and in severe cases, seizures. Dogs appear particularly susceptible to fatal poisoning, with multiple case reports documenting death within 24-36 hours despite treatment.\n\n**Toxicity variability:** The toxicity of chinaberry berries varies significantly by geographic location and climate. Some trees may produce more toxic fruit than others. This unpredictability makes all exposures potentially serious.\n\n**Critical note:** The meliatoxin in chinaberry fruit is often fatal within 24 hours without aggressive supportive care. Early veterinary intervention is essential for the best chance of survival.\n\nDo not confuse with the neem tree (Azadirachta indica), which is related but much less toxic.",
                onsetTime: OnsetTime(
                    early: "GI signs (drooling, vomiting, diarrhea) typically appear within 2-4 hours of ingestion. Neurological signs may develop within several hours.",
                    delayed: "Severe cases may progress to seizures, respiratory depression, and death within 24-36 hours. Survivors may show signs for 1-2 days."
                ),
                symptoms: [
                    "Excessive drooling (hypersalivation)",
                    "Vomiting",
                    "Diarrhea",
                    "Faintness or weakness",
                    "Loss of appetite",
                    "Abdominal pain",
                    "Incoordination (ataxia)",
                    "Mental confusion or disorientation",
                    "Depression or lethargy",
                    "Tremors",
                    "Seizures",
                    "Respiratory depression (labored breathing)",
                    "Paralysis (severe cases)",
                    "Collapse"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are particularly susceptible to fatal chinaberry poisoning; multiple documented fatalities within 24-36 hours; ALL chinaberry ingestions should be treated as emergencies"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Similar toxicity concerns as dogs; cats are less likely to consume fallen berries but should be monitored if exposure occurs"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Some birds appear more resistant to chinaberry toxicity and may spread seeds; pet birds should still be kept away from these trees")
                ],
                preventionTips: [
                    "If you have a chinaberry tree in your yard, consider removing it — especially if you have dogs",
                    "At minimum, fence off the area under chinaberry trees to prevent pets from accessing fallen berries",
                    "Regularly rake up fallen berries, particularly in late summer and fall when fruit is abundant",
                    "Be aware that chinaberry is invasive and may volunteer in yards where it wasn't planted",
                    "If your dog eats chinaberry berries, contact your veterinarian immediately — do not wait for symptoms to develop",
                    "Bring a sample of the berries or a photo of the tree to help your veterinarian identify the exposure"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "IVIS - Guide to Poisonous House and Garden Plants", "Clinical Veterinary Toxicology (Plumlee)"],
                relatedEntries: nil
            ),

            // MARK: - Rosary Pea
            ToxicItem(
                id: UUID(uuidString: "57801263-b55c-4c20-b12c-cff832a15077")!,
                name: "Rosary Pea",
                alternateNames: ["Abrus precatorius", "jequirity bean", "jequirity pea", "precatory bean", "crab's eye", "crab's eye vine", "love bean", "lucky bean", "prayer beads", "rosary beads", "Indian licorice", "gidee-gidee", "jumbie bead", "red bead vine", "weather plant", "abrus", "abrin"],
                categories: [.plants],
                imageAsset: "rosary_pea_seeds",
                description: "Rosary pea (Abrus precatorius) is a tropical climbing vine in the legume family, native to India and tropical Asia. It has spread to warm regions worldwide including Florida, Hawaii, and the Caribbean, where it is considered an invasive species. The plant is infamous for its strikingly beautiful seeds — small, shiny, bright red with a black spot at one end — which have historically been used in jewelry, rosaries, and musical instruments. These attractive seeds contain one of the most potent plant toxins known: abrin, which is chemically similar to ricin from castor beans.",
                toxicityInfo: "Rosary pea seeds contain abrin, an extremely toxic protein (toxalbumin or lectin) that is one of the most poisonous naturally occurring substances known. Abrin works by stopping protein synthesis in cells, leading to cell death. Rapidly dividing cells — such as those lining the gastrointestinal tract — are most severely affected.\n\n**Critical safety feature:** The abrin is contained within the seed's hard outer coat. Intact seeds that are swallowed whole typically pass through the digestive system without releasing the toxin. However, if the seed coat is broken (by chewing, drilling, or damage), the abrin is released and can cause fatal poisoning.\n\n**Toxicity level:** Abrin is approximately 3-4 times more toxic than ricin. In theory, a single well-chewed seed can be lethal to an adult human. The estimated lethal dose is 0.1-1 microgram of abrin per kilogram of body weight.\n\n**There is NO ANTIDOTE for abrin poisoning.** Treatment is entirely supportive.\n\n**Clinical syndrome:** Symptoms may be delayed 1-3 days after ingestion. Severe hemorrhagic gastroenteritis develops, with bloody vomiting and diarrhea leading to severe dehydration. Multi-organ failure (liver, kidneys) can follow. Death typically results from circulatory collapse.\n\n**Important note:** Rosary pea seeds are sometimes used in imported jewelry, toys, and crafts. Be cautious about foreign-made beaded items — they may contain these deadly seeds.",
                onsetTime: OnsetTime(
                    early: "Symptoms may be delayed; GI signs (nausea, vomiting, abdominal pain, diarrhea) typically begin within hours but can be delayed up to 1-3 days after ingestion of chewed/broken seeds.",
                    delayed: "Hemorrhagic diarrhea and systemic effects (fever, tremors, organ failure) develop over 1-3 days. Death, if it occurs, typically happens within 3-5 days due to multi-organ failure."
                ),
                symptoms: [
                    "Nausea",
                    "Severe vomiting",
                    "Severe abdominal pain",
                    "Diarrhea (may become bloody/hemorrhagic)",
                    "Excessive drooling",
                    "Dehydration (from fluid loss)",
                    "Weakness",
                    "Tremors",
                    "Rapid heart rate (tachycardia)",
                    "Fever",
                    "Lethargy progressing to unresponsiveness",
                    "Seizures (severe cases)",
                    "Bleeding from eyes, gums, or other sites (severe cases)",
                    "Shock",
                    "Multi-organ failure (liver, kidneys)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "EXTREMELY TOXIC if seeds are chewed; intact seeds may pass without harm but ANY suspected ingestion should be treated as an emergency; NO ANTIDOTE exists"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Same extreme toxicity as dogs; cats may encounter seeds if brought into the home as jewelry or crafts"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Wild birds appear immune and spread the seeds, but pet birds are likely susceptible; the attractive red seeds may be appealing to caged birds")
                ],
                preventionTips: [
                    "Learn to identify rosary pea vines if you live in warm climates (Florida, Hawaii, Caribbean, Gulf Coast) — the distinctive red and black seeds are unmistakable",
                    "Remove rosary pea vines from your property — wear gloves and do not burn the plant",
                    "Be extremely cautious about foreign-made beaded jewelry, toys, and crafts — they may contain rosary pea seeds",
                    "Do not allow children to play with or wear jewelry made from natural seeds unless you can confirm they are not rosary peas",
                    "If your pet is exposed to rosary pea seeds, contact your veterinarian or poison control immediately — even if the seeds appear intact",
                    "Time is critical: early decontamination (inducing vomiting, activated charcoal) offers the best chance of preventing absorption"
                ],
                sources: ["ASPCA Animal Poison Control Center", "National Poison Control Center (Poison.org)", "IVIS - Guide to Poisonous House and Garden Plants", "Veterinary Information Network (VIN)", "International Programme on Chemical Safety (INCHEM)"],
                relatedEntries: nil
            ),

            // MARK: - Moonseed
            ToxicItem(
                id: UUID(uuidString: "d15976a7-a615-4d2d-a828-2f3e0e666500")!,
                name: "Moonseed",
                alternateNames: ["Menispermum canadense", "Canadian moonseed", "common moonseed", "yellow parilla", "moonseed vine", "Texas sarsaparilla"],
                categories: [.plants],
                imageAsset: "moonseed_berries",
                description: "Moonseed (Menispermum canadense) is a woody climbing vine native to eastern North America, found from southern Canada to northern Florida. It grows in moist woods, thickets, and along stream banks. The plant is named for its distinctive crescent-moon-shaped seeds. Moonseed produces clusters of purple-black berries in fall that closely resemble wild grapes — this resemblance is dangerous because the fruit is highly toxic. All parts of moonseed are poisonous.",
                toxicityInfo: "Moonseed contains the alkaloid dauricine, which is the principal toxin responsible for its poisonous effects. All parts of the plant are toxic, with the fruit (berries) being the most dangerous.\n\n**Clinical effects:** The primary toxicity concern is neurological — convulsions are the hallmark sign of moonseed poisoning. Other effects may include GI upset and potentially fatal poisoning if significant amounts are consumed.\n\n**Critical identification concern:** Moonseed berries ripen in September-October, the same time as wild grapes, and look remarkably similar. However, there are key differences:\n- Moonseed has a single crescent-shaped seed; grapes have round seeds\n- Moonseed vines lack tendrils; grape vines have forked tendrils\n- Moonseed berries have a bitter, unpleasant taste\n\nBecause pets (and humans) can mistake moonseed for wild grapes, this plant poses a significant poisoning risk in areas where both grow. Birds appear to tolerate the berries and spread the seeds, but the fruit is toxic to mammals.",
                onsetTime: OnsetTime(
                    early: "Neurological signs (convulsions) and GI upset may develop within hours of ingestion",
                    delayed: "Severe poisoning can progress over hours to days; fatalities have been reported"
                ),
                symptoms: [
                    "Convulsions or seizures",
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain",
                    "Weakness",
                    "Incoordination",
                    "Depression or lethargy",
                    "Collapse (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Convulsions are the hallmark sign; can be fatal; dogs may mistake berries for grapes and consume them"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Same toxicity concerns as dogs; cats are less likely to consume berries but should be monitored if exposure occurs"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Toxic to all mammals; small body size increases vulnerability")
                ],
                preventionTips: [
                    "Learn to identify moonseed — it grows as a climbing vine in moist woodlands and along stream banks in eastern North America",
                    "If you have both moonseed and wild grapes on your property, consider removing moonseed to prevent confusion",
                    "Never allow pets to eat wild berries unless you are absolutely certain of the plant's identity",
                    "Remember the key difference: moonseed has a single crescent-shaped seed, while grapes have round seeds",
                    "If your pet eats unknown berries and develops convulsions, seek veterinary care immediately"
                ],
                sources: ["Veterinary Information Network (VIN)", "Cornell University Poisonous Plants Informational Database", "Missouri Department of Conservation", "USDA Forest Service"],
                relatedEntries: nil
            ),

            // MARK: - Stinging Nettle
            ToxicItem(
                id: UUID(uuidString: "8cd181bc-9ac5-492b-9085-aa51b6b92e44")!,
                name: "Stinging Nettle",
                alternateNames: ["Urtica dioica", "Urtica", "common nettle", "nettle", "nettles", "stinging nettles", "burn hazel", "burn nettle", "Urtica urens", "dwarf nettle", "small nettle", "dog nettle", "Urtica ferox", "New Zealand tree nettle"],
                categories: [.plants],
                imageAsset: "stinging_nettle_plant",
                description: "Stinging nettles (Urtica species) are common herbaceous plants found throughout North America, Europe, and other temperate regions. They grow in moist, disturbed soils along trails, in fields, ditches, and woodland edges. The plants are covered in fine, hollow hairs (trichomes) that act like tiny hypodermic needles — when touched, the tips break off and inject irritating chemicals into the skin. Hunting dogs and active outdoor dogs are most commonly affected when running through nettle patches.",
                toxicityInfo: "Stinging nettle's toxicity comes from its unique delivery mechanism. The hollow stinging hairs (trichomes) contain a cocktail of irritating compounds including histamine, acetylcholine, serotonin, and formic acid. When an animal brushes against the plant, the silica-tipped hairs break off and inject these chemicals into the skin, causing immediate burning pain, redness, and swelling.\n\n**Contact exposure (most common):** Results in immediate stinging, itching, and localized swelling. In dogs, the face, muzzle, paw pads, and belly (less-furred areas) are most affected. Symptoms typically resolve within hours to a day.\n\n**Ingestion:** If the plant is chewed or swallowed, the stinging hairs can affect the mouth, throat, and GI tract, causing hypersalivation, retching, vomiting, and oral discomfort.\n\n**Severe exposures:** Working and hunting dogs running through dense nettle patches can experience more significant reactions. Severe cases may include respiratory distress, persistent vomiting, epistaxis (nosebleeds), depression, ataxia, muscle fasciculations (twitching), and pelvic limb paresis (weakness). Anaphylactoid reactions are possible. Signs may persist for several days.\n\n**Species variation:** Toxicity varies by nettle species. The New Zealand tree nettle (Urtica ferox) has caused severe, prolonged neurotoxicosis lasting weeks in humans and dogs — this species is far more dangerous than common nettles found in the US.\n\n**Important note:** Dried or processed nettle loses its stinging properties and is actually used as a nutritional supplement for pets. The danger is only from contact with or ingestion of the living plant.",
                onsetTime: OnsetTime(
                    early: "Skin reactions (stinging, redness, swelling) occur immediately upon contact. Oral/GI symptoms from ingestion appear within minutes to hours.",
                    delayed: "Most symptoms resolve within hours to 1-2 days. Severe exposures may cause symptoms lasting several days. New Zealand tree nettle (Urtica ferox) can cause effects lasting weeks."
                ),
                symptoms: [
                    "Intense itching and scratching",
                    "Rubbing or pawing at face",
                    "Licking at paws",
                    "Redness and swelling of skin (especially muzzle, paw pads, belly)",
                    "Hives or wheals (urticaria)",
                    "Hypersalivation (drooling)",
                    "Retching or vomiting",
                    "Pawing at mouth (if ingested)",
                    "Respiratory distress (severe cases)",
                    "Nosebleeds (epistaxis — severe cases)",
                    "Depression or lethargy (severe cases)",
                    "Incoordination (ataxia — severe cases)",
                    "Muscle twitching (fasciculations — severe cases)",
                    "Weakness of hind legs (pelvic limb paresis — severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Most cases involve localized skin irritation that resolves within hours; hunting and working dogs with heavy exposure may develop more serious symptoms; hair coat provides some protection"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Similar to dogs; cats are less likely to have heavy exposure due to lifestyle; localized skin reaction is most common"),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Rabbits and small mammals may be more vulnerable due to smaller size; outdoor rabbits in nettle-prone areas should be protected")
                ],
                preventionTips: [
                    "Learn to identify stinging nettle — it has serrated, heart-shaped leaves and grows in clusters in moist areas",
                    "Avoid walking dogs through dense nettle patches, especially in summer when plants are tall",
                    "Hunting dogs are at highest risk — scout areas before allowing dogs to run through vegetation",
                    "If your dog contacts nettles, rinse the affected area with cool water to remove any remaining stinging hairs",
                    "Keep outdoor rabbit hutches away from areas where nettles grow",
                    "Dock leaves (Rumex species), which often grow near nettles, contain compounds that may help soothe nettle stings — crush and apply to affected skin"
                ],
                sources: ["Veterinary Information Network (VIN)", "Pet Poison Helpline", "Burrows & Tyrl's Toxic Plants of North America", "Animal Poisons Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Yellow Jessamine
            ToxicItem(
                id: UUID(uuidString: "f96f5ad9-369a-413e-a899-971f6423a683")!,
                name: "Yellow Jessamine",
                alternateNames: ["Carolina jessamine", "Carolina jasmine", "Gelsemium sempervirens", "Gelsemium", "yellow jasmine", "false jasmine", "evening trumpet", "evening trumpet flower", "woodbine", "poor man's rope", "wild jessamine", "gelsemium vine"],
                categories: [.plants],
                imageAsset: "yellow_jessamine_flowers",
                description: "Yellow jessamine (Gelsemium sempervirens) is an evergreen climbing vine native to the southeastern United States, from Virginia to Florida and west to Texas. It is also found in Central America and the Caribbean. The plant produces fragrant, bright yellow trumpet-shaped flowers from late winter to early spring and is the state flower of South Carolina. Despite its beauty and popularity in landscaping, yellow jessamine is one of the most dangerous plants for pets — ALL parts contain potent neurotoxins, and even minimal ingestion can be fatal.",
                toxicityInfo: "Yellow jessamine contains highly toxic indole alkaloids, primarily gelsemine, gelseminine, and sempervirine. These neurotoxins affect the nervous system and can cause rapid, severe, and potentially fatal poisoning.\n\n**Mechanism:** The alkaloids act on the central and peripheral nervous system, causing progressive muscle weakness, paralysis, and respiratory failure. Unlike many plant toxins that require large amounts to cause harm, yellow jessamine is toxic in very small doses.\n\n**Recent fatalities:** In April 2025, a dog in Washington, D.C. died within minutes after eating flower petals from a yellow jessamine vine in an apartment courtyard. This case highlights the extreme danger of this plant in landscaping accessible to pets.\n\n**ALL parts are toxic:** Flowers, leaves, stems, roots, and even the nectar contain the deadly alkaloids. Children have been poisoned by sucking nectar from the flowers (which resemble honeysuckle).\n\n**Clinical progression:** Early signs include muscle weakness and dry mouth. This progresses to difficulty swallowing and breathing, bradycardia (slow heart rate), hypothermia, vision problems, paralysis, seizures, and death from respiratory failure.\n\n**Important distinction:** Yellow jessamine (Gelsemium) is NOT related to true jasmine (Jasminum), which is non-toxic. The similar names cause confusion. Do not confuse with night-blooming jessamine (Cestrum) or star jasmine (Trachelospermum), which have different toxicity profiles.\n\n**There is NO ANTIDOTE. Treatment is supportive only.**",
                onsetTime: OnsetTime(
                    early: "Signs may begin within minutes to hours — muscle weakness, difficulty swallowing, vision changes, and respiratory depression can develop rapidly",
                    delayed: "Death can occur within hours in severe cases; survivors may have prolonged recovery"
                ),
                symptoms: [
                    "Muscle weakness (often first sign)",
                    "Difficulty swallowing (dysphagia)",
                    "Dry mouth",
                    "Vision problems or dilated pupils",
                    "Drooping eyelids (ptosis)",
                    "Slow heart rate (bradycardia)",
                    "Low body temperature (hypothermia)",
                    "Decreased respiratory rate",
                    "Difficulty breathing",
                    "Paralysis (progressive)",
                    "Seizures",
                    "Collapse",
                    "Respiratory failure",
                    "Death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "EXTREMELY TOXIC — documented fatalities from eating flowers or minimal plant material; bright flowers may attract curious dogs; treat ANY exposure as a life-threatening emergency"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Same extreme toxicity as dogs; all exposures should be treated as emergencies"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Highly toxic to birds; nectar is toxic to honey bees as well")
                ],
                preventionTips: [
                    "Do NOT plant yellow jessamine in areas accessible to pets — this plant is too dangerous for pet-friendly landscaping",
                    "If you have existing yellow jessamine, consider removing it or fencing it off completely from pet areas",
                    "Even overhead trellises are dangerous — fallen petals and leaves remain toxic and must be promptly removed",
                    "Learn to distinguish yellow jessamine from similar vines: it has yellow trumpet-shaped flowers, opposite leaves, and blooms in late winter/early spring",
                    "Do not confuse with true jasmine (Jasminum) which is non-toxic — yellow jessamine is NOT a jasmine despite similar names",
                    "If your pet eats ANY part of this plant, seek emergency veterinary care IMMEDIATELY — do not wait for symptoms"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Colorado State University Guide to Poisonous Plants"],
                relatedEntries: nil
            ),

            // MARK: - Antifreeze / Ethylene Glycol
            ToxicItem(
                id: UUID(uuidString: "61b259ac-d3af-4451-a1a4-b050fb70d455")!,
                name: "Antifreeze & Coolant (Ethylene Glycol)",
                alternateNames: ["antifreeze", "engine coolant", "radiator fluid", "radiator coolant", "ethylene glycol", "EG", "car coolant", "automotive coolant", "vehicle coolant", "coolant poisoning", "antifreeze poisoning", "radiator poisoning", "de-icer", "aircraft de-icer", "windshield de-icer", "brake fluid", "hydraulic brake fluid", "snow globe liquid", "snow globe fluid", "toilet winterizer", "RV antifreeze", "winterizing fluid", "heat exchanger fluid", "solar panel fluid", "portable basketball hoop base", "rust remover", "Prestone", "Peak antifreeze", "Zerex", "green antifreeze", "orange antifreeze", "pink antifreeze", "Dex-Cool"],
                categories: [.garageGarden],
                imageAsset: "antifreeze_container",
                description: "Ethylene glycol is the primary toxic ingredient in most automotive antifreeze and engine coolant products. It is also found in certain brake fluids, aircraft de-icers, heat exchangers, home solar thermal units, toilet winterizing treatments, some fire extinguishers, portable basketball hoop bases, rust removers, and even snow globes. Antifreeze products are typically bright green, orange, or pink in color.\n\nContrary to popular belief, studies have shown that animals are not actually attracted to the sweet taste of ethylene glycol—toxicosis typically occurs when pets encounter spills, open containers, or leaking vehicles. Many modern antifreeze products contain a bitter additive to discourage ingestion, and some 'pet-safer' products use propylene glycol instead, which is significantly less toxic.\n\n**Important:** Many antifreeze products contain a fluorescent dye (used to detect engine leaks). If you suspect your pet has ingested antifreeze, a black light may reveal fluorescent residue around the mouth or on vomit, which can help confirm exposure. However, do not delay seeking veterinary care to perform this check.",
                toxicityInfo: "Ethylene glycol itself causes gastrointestinal irritation and acts as a central nervous system depressant. However, its severe—often fatal—effects result from toxic metabolites produced when the liver breaks down the compound. These metabolites cause profound metabolic acidosis and form calcium oxalate crystals that deposit in the kidneys, causing severe acute kidney failure. Crystals can also form in the brain, heart, and blood vessels.\n\nEthylene glycol toxicosis progresses through three overlapping stages:\n\n**Stage 1 — \"Inebriation\" (30 minutes to 12 hours):** Pets appear \"drunk\" with wobbling, disorientation, and depression. Vomiting, excessive thirst, and urination are common. This stage can be mistaken for alcohol intoxication.\n\n**Stage 2 — Metabolic Crisis (12-24 hours):** Dogs may briefly appear to improve before rapid deterioration. Cats typically remain depressed and progress directly to Stage 3. Severe metabolic acidosis develops, causing rapid breathing, weakness, and cardiovascular effects.\n\n**Stage 3 — Kidney Failure (24-72 hours in dogs; as early as 12 hours in cats):** The kidneys shut down, urine production stops, and uremic signs develop. By this stage, prognosis is extremely poor.\n\n**Cats are especially vulnerable** — they can progress to irreversible kidney failure within 12-24 hours of ingestion. The mortality rate for untreated cats approaches 100%.\n\n⚠️ **THIS IS A VETERINARY EMERGENCY.** Treatment is most effective when started within hours of ingestion—before kidney damage occurs. If you suspect ANY exposure to antifreeze, seek emergency veterinary care immediately. Do not wait for symptoms to appear.",
                onsetTime: OnsetTime(
                    early: "30 minutes to 3 hours — CNS depression, wobbling, vomiting, excessive thirst/urination",
                    delayed: "12-72 hours — Kidney failure develops; cats can reach this stage within 12 hours"
                ),
                symptoms: [
                    "Appearing 'drunk' or intoxicated",
                    "Wobbling, stumbling, loss of coordination (ataxia)",
                    "Disorientation or confusion",
                    "Lethargy or depression",
                    "Nausea and vomiting",
                    "Excessive thirst (polydipsia)",
                    "Excessive urination followed by decreased/no urination",
                    "Drooling or hypersalivation",
                    "Rapid breathing (tachypnea)",
                    "Rapid heart rate",
                    "Muscle twitching or tremors",
                    "Weakness or collapse",
                    "Seizures",
                    "Coma",
                    "Sudden death"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Mortality rate of 59-70% even with treatment. Dogs may appear to briefly improve before rapid deterioration. Kidney failure typically develops 24-72 hours after ingestion."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "EXTREMELY DANGEROUS — mortality rate approaches 96-100%. Cats are more sensitive than dogs and can develop irreversible kidney failure within 12-24 hours. Any suspected exposure requires immediate emergency care."),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Small body size makes even tiny amounts potentially lethal. Seek immediate veterinary care for any suspected exposure."),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly susceptible due to small body size and rapid metabolism. Any exposure should be treated as an emergency.")
                ],
                preventionTips: [
                    "Clean up any antifreeze spills immediately and thoroughly",
                    "Check vehicles regularly for coolant leaks, including under parked cars",
                    "Store antifreeze in clearly labeled, sealed containers in locked cabinets",
                    "Never leave antifreeze containers open or unattended",
                    "Keep pets away from garages and driveways when working on vehicles",
                    "Consider using 'pet-safer' antifreeze products containing propylene glycol instead of ethylene glycol",
                    "Check snow machines, ATVs, and recreational vehicles for leaks",
                    "Be aware that snow globes contain ethylene glycol — keep out of pet's reach",
                    "When winterizing RVs or toilets, prevent pet access to treated areas",
                    "Note: Fully dried antifreeze spills pose minimal risk, but wet spills are extremely dangerous"
                ],
                sources: ["VIN Toxicology Resources — Ethylene Glycol Toxicosis", "ASPCA Animal Poison Control Center", "Pet Poison Helpline — Antifreeze Poisoning", "Merck Veterinary Manual — Ethylene Glycol Toxicosis"],
                relatedEntries: nil
            ),

            // MARK: - Petroleum Products
            ToxicItem(
                id: UUID(uuidString: "edfcb0ed-52aa-44fb-a71f-060551350513")!,
                name: "Petroleum Products (Gasoline, Motor Oil, Diesel)",
                alternateNames: ["gasoline", "gas", "petrol", "motor oil", "engine oil", "car oil", "used motor oil", "diesel", "diesel fuel", "kerosene", "kerosine", "paraffin oil", "lamp oil", "tiki torch fuel", "lighter fluid", "charcoal lighter", "paint thinner", "paint solvent", "mineral spirits", "turpentine", "petroleum distillates", "hydrocarbons", "crude oil", "heating oil", "fuel oil", "jet fuel", "naphtha", "benzene", "toluene", "xylene", "transmission fluid", "gear oil", "hydraulic fluid", "penetrating oil", "WD-40", "lubricating oil", "grease", "automotive grease", "wood stain", "wood stripper", "asphalt", "roofing tar", "Castrol", "Mobil 1", "Valvoline", "Pennzoil", "Quaker State"],
                categories: [.garageGarden],
                imageAsset: "petroleum_products",
                description: "Petroleum products include a wide range of hydrocarbon-based substances found in garages, workshops, and homes. These range from highly volatile fuels like gasoline and kerosene to thick, viscous lubricants like motor oil and grease. Pets can be exposed through ingestion (licking spills or contaminated fur), inhalation (fumes in poorly ventilated areas), or skin contact.\n\n**Toxicity varies significantly by product type:**\n\n• **High-volatility products (MORE DANGEROUS):** Gasoline, kerosene, diesel fuel, lighter fluid, paint thinners, and solvents. These have low viscosity and are easily aspirated into the lungs, causing severe chemical pneumonia.\n\n• **Low-volatility products (less dangerous but still concerning):** Motor oil, transmission fluid, lubricating greases. These are less likely to be aspirated but can still cause GI upset and, if vomited, may be inhaled.\n\nSmall amounts of petroleum products used as carriers in some insecticides or medications typically cause minimal harm. However, direct exposure to fuels and solvents can be serious.",
                toxicityInfo: "**Aspiration pneumonia is the most serious risk** with petroleum product exposure. When low-viscosity, volatile hydrocarbons like gasoline or kerosene are inhaled into the lungs—either directly or during vomiting—they cause severe chemical damage to lung tissue. This can progress rapidly to life-threatening pneumonia.\n\n**Mechanisms of toxicity:**\n\n• **Respiratory:** Volatile hydrocarbons damage lung tissue directly and displace oxygen in the airways. Aspiration pneumonia may not show symptoms for several days after exposure.\n\n• **Gastrointestinal:** Most petroleum products irritate the stomach and intestines, causing vomiting, diarrhea, drooling, and loss of appetite. Motor oil and heavier products have a laxative effect similar to mineral oil.\n\n• **Neurological:** Absorbed hydrocarbons can cause CNS depression ranging from lethargy to severe depression, wobbling, tremors, and rarely coma. Some aromatic compounds (benzene, toluene) are particularly neurotoxic.\n\n• **Dermal:** Prolonged skin contact causes irritation, drying, cracking, and chemical burns. Pets will often lick contaminated fur, converting a skin exposure into an ingestion.\n\n**Product-specific concerns:**\n\n• **Gasoline:** Highly volatile and dangerous. Even small ingested amounts can cause severe lung damage if aspirated. Skin exposure causes irritation; small amounts can usually be managed with bathing.\n\n• **Motor oil:** Less acutely dangerous than gasoline. Main concerns are GI upset (diarrhea) and aspiration if vomiting occurs. **Used motor oil may contain lead and other contaminants.**\n\n• **Kerosene/lamp oil/tiki torch fuel:** Similar to gasoline in aspiration risk. Commonly involved in pet exposures due to accessible containers.\n\n⚠️ **CRITICAL: Do NOT induce vomiting.** Vomiting dramatically increases the risk of aspiration pneumonia. If your pet has ingested any petroleum product, contact your veterinarian or poison control immediately for guidance.",
                onsetTime: OnsetTime(
                    early: "Minutes to hours — GI irritation, drooling, vomiting, CNS depression",
                    delayed: "1-3 days — Aspiration pneumonia may not be apparent until days after exposure"
                ),
                symptoms: [
                    "Petroleum/chemical odor on breath or fur",
                    "Drooling or hypersalivation",
                    "Pawing at mouth",
                    "Vomiting",
                    "Diarrhea (may be oily)",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Wobbling or incoordination",
                    "Coughing or gagging",
                    "Difficulty breathing",
                    "Rapid or shallow breathing",
                    "Blue-tinged gums (cyanosis)",
                    "Skin irritation or redness",
                    "Eye irritation if splashed",
                    "Tremors (with significant absorption)",
                    "Collapse (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Severity depends on product type: gasoline/kerosene exposure is HIGH risk; motor oil exposure is MODERATE risk. Dogs may ingest petroleum products from spills or by chewing containers. Aspiration pneumonia is the primary concern with volatile products."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats are frequently exposed through grooming contaminated fur. Even small amounts of gasoline on fur can cause irritation; prompt bathing with dish soap is important. Respiratory signs warrant immediate veterinary evaluation."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are extremely sensitive to inhaled fumes. Keep birds away from areas where petroleum products are used or stored. Even fume exposure without direct contact can be dangerous.")
                ],
                preventionTips: [
                    "Store all petroleum products in sealed, labeled containers out of pet's reach",
                    "Clean up gasoline and oil spills immediately",
                    "Keep pets out of garages and workshops when working with fuels or solvents",
                    "Ensure adequate ventilation when using petroleum-based products",
                    "Dispose of used motor oil properly—never leave in open containers",
                    "Keep tiki torch fuel, lamp oil, and lighter fluid stored securely",
                    "Check vehicles regularly for oil and fuel leaks",
                    "If petroleum product gets on pet's fur, bathe immediately with dish soap (like Dawn) and cool water",
                    "Never store gasoline or solvents in food/drink containers",
                    "Keep birds in well-ventilated areas away from any petroleum fumes"
                ],
                sources: ["Merck Veterinary Manual — Petroleum Product Poisoning in Animals", "VIN Toxicology Resources — Hydrocarbon Toxicosis", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Windshield Washer Fluid (Methanol)
            ToxicItem(
                id: UUID(uuidString: "286ff548-979a-45c1-853b-3cc87ccbcaa1")!,
                name: "Windshield Washer Fluid (Methanol)",
                alternateNames: ["windshield washer fluid", "washer fluid", "wiper fluid", "windshield wiper fluid", "screen wash", "windscreen washer", "methanol", "methyl alcohol", "wood alcohol", "windshield de-icer", "washer fluid antifreeze", "bug wash", "Rain-X washer fluid", "Prestone washer fluid", "gas line antifreeze", "HEET", "model airplane fuel", "glow fuel", "RC fuel", "canned heat", "Sterno fuel", "fondue fuel", "chafing fuel"],
                categories: [.garageGarden],
                imageAsset: "washer_fluid",
                description: "Windshield washer fluid typically contains 20-30% methanol (methyl alcohol), though concentrations can be higher in de-icing formulas designed for very cold climates. Methanol is also found in gas line antifreeze products (like HEET), model airplane/RC car fuel ('glow fuel'), canned heat fuels (Sterno), some paint removers, varnishes, and certain solvents.\n\nMethanol is a colorless alcohol with a slightly sweet odor. Pets are most commonly exposed by drinking from puddles of spilled washer fluid, licking residue from containers, or accessing open jugs in garages.\n\n**Important:** Some windshield washer fluids may also contain ethylene glycol as an additive. If you're unsure which type of antifreeze is in a product, treat the exposure as potentially involving ethylene glycol (see Antifreeze entry) and seek immediate veterinary care.",
                toxicityInfo: "In dogs and cats, methanol behaves similarly to ethanol (drinking alcohol), causing intoxication-like symptoms. This is different from methanol poisoning in humans, where it causes blindness and severe neurological damage — these effects do NOT occur in dogs and cats.\n\n**How methanol affects pets:**\n\nMethanol is rapidly absorbed from the gastrointestinal tract, with effects typically appearing within 30-60 minutes of ingestion. The central nervous system and GI tract are most commonly affected. Pets appear 'drunk' — wobbly, disoriented, and lethargic. Low blood sugar (hypoglycemia) and low body temperature can also occur.\n\n**Key points:**\n\n• **Rapid onset:** If your pet shows no symptoms within 60 minutes of exposure, significant toxicity is unlikely to develop.\n\n• **No specific antidote:** Unlike ethylene glycol antifreeze, there is no antidote for methanol. Fomepizole (the antifreeze antidote) does NOT work for methanol poisoning.\n\n• **No blindness in pets:** While methanol causes blindness in humans and primates, this does not occur in dogs and cats.\n\n• **Activated charcoal is ineffective:** Charcoal does not bind to alcohol molecules.\n\n• **Prognosis is generally good** if veterinary care is sought promptly.\n\n⚠️ **Contact your veterinarian or poison control immediately** if your pet ingests windshield washer fluid. Even though methanol is less dangerous than ethylene glycol, veterinary evaluation is still important — especially since some products contain both.",
                onsetTime: OnsetTime(
                    early: "30-60 minutes — Intoxication signs (wobbling, disorientation, lethargy)",
                    delayed: "If no signs develop within 60 minutes of ingestion, significant toxicity is unlikely"
                ),
                symptoms: [
                    "Appearing 'drunk' or intoxicated",
                    "Wobbling or incoordination (ataxia)",
                    "Disorientation or confusion",
                    "Lethargy or depression",
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain",
                    "Drooling",
                    "Tremors",
                    "Low body temperature (hypothermia)",
                    "Low blood sugar (weakness, trembling)",
                    "Difficulty breathing (rare, severe cases)",
                    "Seizures (rare)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Methanol causes alcohol-like intoxication. Signs typically appear within 30-60 minutes. Prognosis is generally good with prompt veterinary care. Does NOT cause blindness or kidney failure like ethylene glycol antifreeze."),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Similar to dogs — causes intoxication symptoms. Cats may be exposed by grooming washer fluid residue from fur. If no signs within 60 minutes of exposure, significant problems are unlikely."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size means even small exposures can cause symptoms. Seek veterinary care for any suspected ingestion."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Birds may be affected by both ingestion and inhalation of methanol fumes. Keep birds away from areas where washer fluid is used or stored.")
                ],
                preventionTips: [
                    "Store windshield washer fluid in sealed containers out of pet's reach",
                    "Clean up spills immediately — do not leave puddles accessible to pets",
                    "Keep pets away when refilling your vehicle's washer fluid reservoir",
                    "Do not leave open containers in garages or driveways",
                    "Rinse empty washer fluid containers before recycling",
                    "Store gas line antifreeze (HEET) and similar products securely",
                    "Keep model airplane fuel and canned heat fuels away from pets",
                    "Be aware that washer fluid may pool under parked vehicles in cold weather"
                ],
                sources: ["VIN Toxicology Resources — Methanol Toxicosis", "Pet Poison Helpline — Windshield Wiper Fluid", "Pet Poison Helpline — Methanol Poisoning in Dogs and Cats", "American College of Veterinary Pharmacists — Methanol"],
                relatedEntries: nil
            ),

            // MARK: - Lead (Batteries, Paint, Fishing Weights)
            ToxicItem(
                id: UUID(uuidString: "3b605ff6-df0c-426f-8687-70226969f7c0")!,
                name: "Lead (Batteries, Paint, Fishing Weights)",
                alternateNames: ["lead poisoning", "lead toxicosis", "plumbism", "heavy metal poisoning", "lead-acid battery", "car battery", "automotive battery", "battery acid", "lead-based paint", "paint chips", "paint dust", "renovation dust", "fishing sinker", "fishing weight", "lead sinker", "split shot", "curtain weight", "drapery weight", "wheel weight", "tire weight", "lead shot", "ammunition", "bullets", "pellets", "bird shot", "buckshot", "solder", "soldering", "plumbing solder", "lead pipe", "golf ball", "golf balls", "stained glass", "ceramic glaze", "imported toys", "lead figurines", "lead weights"],
                categories: [.garageGarden],
                imageAsset: "lead_sources",
                description: "Lead is a toxic heavy metal found in numerous household and garage items. Common sources of pet lead exposure include:\n\n• **Batteries:** Lead-acid automotive batteries contain lead plates and lead compounds\n• **Paint:** Lead-based paint was used in buildings constructed before 1978; renovation or weathering can release toxic paint chips and dust\n• **Fishing tackle:** Lead sinkers and split shot weights\n• **Ammunition:** Lead shot, bullets, and pellets (including lead embedded in prey animals)\n• **Household items:** Curtain/drapery weights, wheel weights, solder, stained glass, certain ceramic glazes\n• **Other:** Some imported toys, decorative items, golf balls (lead core), and older bird cages\n\nLead poisoning is more common in dogs than cats, and most affected dogs are under 2 years old — likely due to their tendency to chew on objects. In up to 90% of lead toxicosis cases, the exact source is never identified.\n\n**Renovation hazard:** Home renovation projects in older buildings are a major risk. Sanding or scraping painted surfaces releases lead dust that pets can inhale or ingest during grooming. A paint chip the size of a thumbnail can poison a dog weighing up to 20 pounds.",
                toxicityInfo: "Lead affects multiple body systems, with the gastrointestinal tract and nervous system most commonly involved. Once absorbed, lead binds to red blood cells and distributes throughout the body, with bone serving as a long-term storage site for up to 97% of absorbed lead.\n\n**How lead affects pets:**\n\n• **Gastrointestinal:** Vomiting, diarrhea, abdominal pain, loss of appetite, weight loss\n\n• **Neurological:** Seizures (often intermittent), behavioral changes, lethargy, hysteria, blindness, tremors, head pressing, weakness, incoordination. Lead is one of the few causes of intermittent seizures in cats.\n\n• **Blood:** Lead interferes with red blood cell production, causing anemia\n\n• **Other:** Kidney damage, bone abnormalities (pathologic fractures, delayed healing)\n\n**Key characteristics:**\n\n• Signs are often vague and intermittent, especially with chronic exposure\n• Symptoms may be primarily GI, primarily neurological, or a combination\n• Young animals absorb lead more readily than adults (except dogs, which absorb lead well at any age)\n• Blood lead levels do not always correlate with severity of signs\n• Lead has an extremely long half-life in the body (months to years)\n\n⚠️ **Lead poisoning requires veterinary treatment.** If you suspect your pet has been exposed to lead — especially if showing GI upset, seizures, or behavioral changes — seek veterinary care promptly. X-rays can reveal lead objects in the digestive tract, and blood tests can confirm lead exposure.",
                onsetTime: OnsetTime(
                    early: "Hours to days — GI signs (vomiting, diarrhea, abdominal pain) often appear first",
                    delayed: "Days to weeks — Neurological signs may develop with continued exposure or delayed presentation"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Abdominal pain or colic",
                    "Loss of appetite (anorexia)",
                    "Weight loss",
                    "Lethargy or depression",
                    "Behavioral changes",
                    "Seizures or convulsions (often intermittent)",
                    "Tremors",
                    "Wobbling or incoordination (ataxia)",
                    "Weakness in limbs",
                    "Head pressing",
                    "Blindness",
                    "Hysteria or anxiety",
                    "Excessive drooling",
                    "Regurgitation",
                    "Increased thirst and urination",
                    "Pale gums (from anemia)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are most commonly affected, especially those under 2 years old. Dogs absorb lead readily at any age (unlike most species where young animals absorb more). Chewing behavior increases exposure risk. GI and neurological signs are most common."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Less common than in dogs — cats are more fastidious and less likely to chew on objects or lick painted surfaces. However, cats can be exposed through grooming dust from renovations. Lead is one of few causes of intermittent seizures in cats."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are highly susceptible to lead poisoning. Common sources include lead weights, stained glass solder, and older cages with lead-based paint or lead components. Wild birds may ingest lead shot from the environment."),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small mammals can be exposed through chewing on lead-containing objects or ingesting contaminated materials. Their small body size makes even small exposures potentially serious.")
                ],
                preventionTips: [
                    "Keep pets away from areas undergoing renovation, especially in homes built before 1978",
                    "Store automotive batteries securely out of pet's reach",
                    "Keep fishing tackle boxes closed and stored away from pets",
                    "Do not allow pets to chew on or play with fishing sinkers, curtain weights, or similar objects",
                    "Dispose of old batteries properly — do not leave accessible to pets",
                    "If renovating an older home, contain dust and debris; do not allow pets in work areas",
                    "Wet-mop floors in renovation areas rather than sweeping (reduces airborne dust)",
                    "Be cautious with imported toys, figurines, and decorative items that may contain lead",
                    "If your pet is diagnosed with lead poisoning, have family members (especially children) tested for lead exposure",
                    "Consider lead test kits (available at home improvement stores) for paint in older buildings"
                ],
                sources: ["VIN Toxicology Resources — Lead Toxicosis", "ASPCA Animal Poison Control Center — Lead Toxicosis", "Veterinary Partner (VIN) — Lead Poisoning in Dogs and Cats", "VCA Animal Hospitals — Paint and Varnish Poison Alert"],
                relatedEntries: nil
            ),

            // MARK: - Anticoagulant Rodenticides
            ToxicItem(
                id: UUID(uuidString: "304c1824-e0b2-48bb-9991-3803d1ae87d0")!,
                name: "Anticoagulant Rodenticides",
                alternateNames: ["rat poison", "mouse poison", "rodent bait", "warfarin", "brodifacoum", "bromadiolone", "difethialone", "difenacoum", "diphacinone", "chlorophacinone", "D-Con", "d-CON", "Havoc", "Jaguar", "Just One Bite", "Tomcat", "Boot Hill", "Maki", "Hawk", "Enforcer", "superwarfarin", "anticoagulant bait", "blood thinner poison", "coumarin rodenticide", "indandione rodenticide"],
                categories: [.garageGarden],
                imageAsset: "anticoagulant_rodenticide",
                description: "Anticoagulant rodenticides are the most common type of rat and mouse poison. They work by preventing blood from clotting, leading to internal bleeding. These products come in pellets, blocks, and bars, often dyed green or blue—but color and shape do NOT indicate the active ingredient. There are two generations: first-generation (warfarin, diphacinone, chlorophacinone) require multiple feedings to kill rodents, while second-generation 'superwarfarins' (brodifacoum, bromadiolone, difethialone) are lethal after a single feeding and remain in the body much longer. Dogs are more commonly poisoned than cats.",
                toxicityInfo: "Anticoagulant rodenticides inhibit vitamin K recycling in the liver, which prevents the body from producing essential blood clotting factors (II, VII, IX, X). As existing clotting factors become depleted over 1-2 days, the animal loses the ability to control bleeding. Unlike other rodenticide types, an antidote (vitamin K1) is available, and survival rates with prompt treatment are excellent. Secondary poisoning from eating a single poisoned rodent is unlikely, but animals that regularly consume poisoned rodents (such as barn cats) may be at risk.",
                onsetTime: OnsetTime(
                    early: "No signs typically appear in the first 1-3 days—the animal may appear completely normal",
                    delayed: "Bleeding signs develop 3-7 days after ingestion once clotting factors are depleted"
                ),
                symptoms: [
                    "Lethargy or weakness",
                    "Pale gums",
                    "Exercise intolerance",
                    "Difficulty breathing",
                    "Coughing (may produce blood)",
                    "Nosebleeds (epistaxis)",
                    "Bleeding from gums or mouth",
                    "Bloody or dark tarry stool",
                    "Blood in urine",
                    "Bruising or swelling under skin",
                    "Distended abdomen",
                    "Lameness or joint swelling",
                    "Collapse",
                    "Sudden death (if bleeding occurs in critical areas)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Most commonly affected species; second-generation products remain in the body for 3-4 weeks requiring prolonged treatment"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Less commonly exposed than dogs but equally susceptible; outdoor cats hunting poisoned rodents may have cumulative exposure"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Highly susceptible; small body size means even small amounts can be toxic"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "All birds are susceptible; raptors and scavengers at risk from secondary poisoning"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Susceptible; limited data available but bleeding complications expected")
                ],
                preventionTips: [
                    "Use tamper-resistant bait stations if rodenticides must be used",
                    "Place bait in areas completely inaccessible to pets",
                    "Keep ALL packaging—the product appearance does NOT indicate the active ingredient",
                    "Write down the exact product name, active ingredient, and amount placed",
                    "Check bait stations regularly to ensure bait hasn't been moved or accessed",
                    "Consider pet-safe alternatives like snap traps or electronic traps",
                    "If you suspect ingestion, contact a veterinarian immediately—do not wait for symptoms"
                ],
                sources: ["VIN Toxicology Resources", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual — Anticoagulant Rodenticide Poisoning", "Pet Poison Helpline", "Veterinary Partner (VIN)"],
                relatedEntries: ["049e1259-f968-4e23-aa8c-5110cb52a08c"]
            ),

            // MARK: - Bromethalin
            ToxicItem(
                id: UUID(uuidString: "bdd489ee-bb6e-47c3-9b2f-b63d9fb7de21")!,
                name: "Bromethalin",
                alternateNames: ["bromethalin rodenticide", "neurotoxic rodenticide", "Tomcat", "Fastrac", "Talpirid", "Assault", "Vengeance", "Top Gun", "Gunslinger", "rat poison", "mouse poison", "mole bait", "mole poison"],
                categories: [.garageGarden],
                imageAsset: "bromethalin",
                description: "Bromethalin is a neurotoxic rodenticide that causes fatal brain swelling (cerebral edema). It has become the most common rodenticide in consumer products since EPA restrictions on anticoagulant rodenticides. Bromethalin is available as blocks, bars, pellets, and worm-shaped baits for moles. It is frequently confused with anticoagulant rodenticides that have similar-sounding names (brodifacoum, bromadiolone)—but bromethalin works completely differently and has NO ANTIDOTE. Color, size, and shape of the bait do NOT indicate the active ingredient. The European Union banned bromethalin in 2010.",
                toxicityInfo: "Bromethalin stops energy production in brain cells by uncoupling oxidative phosphorylation in mitochondria. Without energy, the brain cannot control water balance in neurons, leading to swelling of the brain and spinal cord. The poison is converted in the liver to an even more toxic form (desmethylbromethalin). Cats are extremely sensitive—approximately 5-10 times more sensitive than dogs. Puppies, ferrets, and potbellied pigs are also highly sensitive. Unlike anticoagulant rodenticides, there is NO ANTIDOTE for bromethalin. Relay toxicity (poisoning from eating a poisoned rodent) is unlikely because of the relatively high amounts needed to cause toxicosis.",
                onsetTime: OnsetTime(
                    early: "High doses: severe signs within 2-24 hours (convulsant syndrome)",
                    delayed: "Lower doses: signs develop over 1-5 days and progress over 1-2 weeks (paralytic syndrome)"
                ),
                symptoms: [
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Vomiting",
                    "Hind leg weakness progressing to paralysis",
                    "Unsteady gait (ataxia)",
                    "Muscle tremors",
                    "Hyperexcitability or agitation",
                    "Hypersensitivity to touch or sound",
                    "Abnormal eye movements (nystagmus)",
                    "Unequal pupil size (anisocoria)",
                    "Head pressing",
                    "Abnormal body posturing",
                    "Seizures",
                    "Coma",
                    "Sudden death (with high doses)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Two syndromes possible: rapid convulsant form (high dose) or delayed paralytic form (lower dose); puppies more sensitive than adults"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "EXTREMELY sensitive—approximately 5-10 times more sensitive than dogs; typically develop paralytic syndrome regardless of dose"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Ferrets highly sensitive; guinea pigs uniquely resistant due to differences in metabolism"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Susceptible; limited data available"),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "Susceptible; limited data available")
                ],
                preventionTips: [
                    "Avoid using bromethalin products if pets are in the household—there is NO ANTIDOTE",
                    "Keep ALL packaging—bromethalin is often confused with anticoagulant rodenticides",
                    "Do not rely on bait appearance to identify the active ingredient",
                    "Use tamper-resistant bait stations if rodenticides must be used",
                    "Consider safer alternatives like snap traps or electronic traps",
                    "If ingestion is suspected, contact a veterinarian IMMEDIATELY—early decontamination is critical",
                    "Do NOT wait for symptoms to develop—once severe signs appear, the outcome is often poor"
                ],
                sources: ["VIN Toxicology Resources", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual — Bromethalin Poisoning in Animals", "Pet Poison Helpline", "VCA Animal Hospitals"],
                relatedEntries: ["049e1259-f968-4e23-aa8c-5110cb52a08c"]
            ),

            // MARK: - Cholecalciferol (Vitamin D3) Rodenticide
            ToxicItem(
                id: UUID(uuidString: "3c40b99c-5653-4195-a821-19dde4e1c8f8")!,
                name: "Cholecalciferol (Vitamin D3) Rodenticide",
                alternateNames: ["vitamin D3 rodenticide", "vitamin D poison", "vitamin D3 poison", "cholecalciferol bait", "d-CON", "Quintox", "Rampage", "True Grit Rampage", "Ortho Rat-B-Gone", "Selontra", "rat poison", "mouse poison", "vitamin D rodenticide"],
                categories: [.garageGarden],
                imageAsset: "cholecalciferol_rodenticide",
                description: "Cholecalciferol (vitamin D3) rodenticides are among the most dangerous rat and mouse poisons available. In 2018, d-CON—one of the most common rodenticide brands—switched from anticoagulants to cholecalciferol, making this type increasingly common in homes. These products are formulated as pellets, soft baits, granules, and blocks at 0.075% concentration. Despite being a vitamin, cholecalciferol in rodenticide amounts is extremely toxic—a very small amount can cause life-threatening poisoning. When first marketed in the 1980s, these products were advertised as safe around dogs, but this was proven dangerously wrong. Color, size, and shape of the bait do NOT indicate the active ingredient.",
                toxicityInfo: "Cholecalciferol causes life-threatening elevations in blood calcium (hypercalcemia) and phosphorus. The body cannot excrete excess calcium quickly, leading to mineralization (calcium deposits) in kidneys, heart, blood vessels, and other soft tissues. Kidney failure is the most common fatal outcome. The poison is highly fat-soluble and stored in body fat, causing effects that persist for weeks to months even after a single exposure. There is NO ANTIDOTE—treatment requires weeks of hospitalization, frequent blood monitoring, and expensive therapy. For vitamin D toxicity from supplements or medications, see the separate 'Vitamin D Overdose' entry in Human Medications.",
                onsetTime: OnsetTime(
                    early: "Increased thirst and urination may appear within 12-24 hours",
                    delayed: "Kidney failure and severe signs typically develop 1-3 days after ingestion; damage may already be significant before obvious signs appear"
                ),
                symptoms: [
                    "Increased thirst (polydipsia)",
                    "Increased urination (polyuria)",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Vomiting",
                    "Constipation or diarrhea",
                    "Bloody vomit (hematemesis)",
                    "Dark or bloody stool (melena)",
                    "Drooling",
                    "Abdominal pain",
                    "Uremic breath (ammonia odor)",
                    "Oral ulcers",
                    "Hind leg weakness",
                    "Difficulty breathing",
                    "Decreased or absent urination (in kidney failure)",
                    "Seizures (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Extremely narrow margin of safety; even approximately half a tablespoon of bait can cause life-threatening hypercalcemia in a 40-pound dog"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Equally susceptible; any ingestion should be treated as an emergency"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Highly susceptible due to small body size"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Susceptible; relay toxicity theoretically possible"),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "Susceptible; limited data available")
                ],
                preventionTips: [
                    "Avoid using cholecalciferol rodenticides—there is NO ANTIDOTE and treatment is difficult and expensive",
                    "Keep ALL packaging—many rodenticide brands now contain cholecalciferol instead of anticoagulants",
                    "Do not assume vitamin-based rodenticides are safer—they are among the most dangerous",
                    "Use tamper-resistant bait stations if rodenticides must be used",
                    "Consider safer alternatives like snap traps or electronic traps",
                    "If ingestion is suspected, contact a veterinarian IMMEDIATELY—do not wait for symptoms",
                    "Do not rely on bait appearance to identify the product"
                ],
                sources: ["VIN Toxicology Resources", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual — Cholecalciferol Poisoning in Animals", "Pet Poison Helpline", "VCA Animal Hospitals", "Purdue University College of Veterinary Medicine"],
                relatedEntries: ["049e1259-f968-4e23-aa8c-5110cb52a08c"]
            ),

            // MARK: - Vitamin D Overdose (Supplements & Medications)
            ToxicItem(
                id: UUID(uuidString: "c492d990-4222-44a0-8546-634118f68f71")!,
                name: "Vitamin D Overdose (Supplements & Medications)",
                alternateNames: ["vitamin D toxicity", "vitamin D3 overdose", "vitamin D2 overdose", "cholecalciferol overdose", "ergocalciferol overdose", "vitamin D supplements", "vitamin D3 supplements", "calcipotriene", "calcipotriol", "tacalcitol", "calcitriol", "Dovonex", "Taclonex", "Sorilux", "Enstilar", "Wynzora", "Rocaltrol", "Vectical", "psoriasis cream", "dog ate vitamins", "pet ate supplements"],
                categories: [.medications],
                imageAsset: "vitamin_d_overdose",
                description: "Vitamin D toxicity occurs when pets ingest human vitamin D supplements or topical medications containing vitamin D analogues. Most standard multivitamins contain low amounts of vitamin D (100-400 IU) and pose minimal risk unless a very small dog eats a large quantity. However, high-dose vitamin D3 supplements (5,000-50,000 IU per capsule) have become increasingly popular and can cause serious toxicity if multiple capsules are ingested. Topical psoriasis medications containing calcipotriene (Dovonex, Taclonex, Enstilar) or tacalcitol are also dangerous—dogs can be poisoned by licking the cream from a person's skin or directly from the tube. Vitamin D2 (ergocalciferol, from plants) has a wider margin of safety than vitamin D3 (cholecalciferol, from animals).",
                toxicityInfo: "Vitamin D increases calcium absorption from the gut and bones while decreasing excretion through the kidneys. Excessive vitamin D causes dangerously high blood calcium (hypercalcemia) and phosphorus levels, leading to mineralization (calcium deposits) in kidneys, heart, blood vessels, and other soft tissues. Kidney failure is the most serious consequence. Vitamin D and its metabolites are fat-soluble and stored in body fat, so effects can persist for weeks to months. There is NO ANTIDOTE—treatment focuses on lowering calcium levels and may require weeks of monitoring. For vitamin D toxicity from rodenticides, see the separate 'Cholecalciferol Rodenticide' entry.",
                onsetTime: OnsetTime(
                    early: "Increased thirst and urination may appear within 12-24 hours",
                    delayed: "Kidney damage and severe signs typically develop 1-3 days after ingestion"
                ),
                symptoms: [
                    "Increased thirst (polydipsia)",
                    "Increased urination (polyuria)",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Vomiting",
                    "Constipation or diarrhea",
                    "Bloody vomit (hematemesis)",
                    "Dark or bloody stool (melena)",
                    "Drooling",
                    "Abdominal pain",
                    "Uremic breath (ammonia odor)",
                    "Oral ulcers",
                    "Hind leg weakness",
                    "Difficulty breathing",
                    "Decreased or absent urination (in kidney failure)",
                    "Seizures (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Severity depends on product and amount; standard multivitamins are low risk, but high-dose D3 supplements (5,000+ IU) or psoriasis creams can cause severe toxicity"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Equally susceptible to vitamin D toxicity; cats may lick psoriasis cream from owners' skin"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size increases risk from even small amounts"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Susceptible; limited data available"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Susceptible; note that reptiles have specific vitamin D requirements for calcium metabolism")
                ],
                preventionTips: [
                    "Store all vitamin supplements in secure, pet-proof containers",
                    "Keep high-dose vitamin D3 supplements (5,000+ IU) in closed cabinets",
                    "Do not leave supplement bottles within pet reach—dogs may chew through plastic",
                    "If using psoriasis cream (Dovonex, Taclonex, etc.), cover treated areas or keep pets away until cream is absorbed",
                    "Store topical medication tubes securely—small amounts can be toxic if a pet chews the tube",
                    "If ingestion is suspected, note the product name and strength, and contact a veterinarian immediately"
                ],
                sources: ["VIN Toxicology Resources", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual — Cholecalciferol Poisoning in Animals", "Pet Poison Helpline", "VCA Animal Hospitals"],
                relatedEntries: nil
            ),

            // MARK: - Zinc Phosphide
            ToxicItem(
                id: UUID(uuidString: "c8ebc592-fbe3-4e06-9e8d-63399dfce710")!,
                name: "Zinc Phosphide",
                alternateNames: ["zinc phosphide rodenticide", "aluminum phosphide", "aluminium phosphide", "magnesium phosphide", "metal phosphide", "phosphide rodenticide", "gopher bait", "gopher poison", "mole bait", "mole poison", "Gopha-rid", "ZP Rodent Bait", "Prozap", "Ridall", "Zinc-tox", "Arrex", "Phosvin", "Ratol", "Fumitoxin", "Phostoxin", "Phosfume", "Magtoxin", "grain fumigant", "ground squirrel bait", "vole poison", "field mouse poison"],
                categories: [.garageGarden],
                imageAsset: "zinc_phosphide",
                description: "Zinc phosphide is a highly toxic rodenticide primarily used against gophers, moles, voles, ground squirrels, and field mice. Related compounds—aluminum phosphide and magnesium phosphide—are used as fumigants in grain storage and shipping containers. All metal phosphides work the same way: when they contact stomach acid or moisture, they release phosphine gas—an extremely toxic gas that causes rapid, severe poisoning. Zinc phosphide is formulated as dark gray pellets, powders, or grain-based baits at concentrations of 2-10%. CRITICAL SAFETY WARNING: The vomit from a poisoned animal also releases phosphine gas and is dangerous to humans and other animals. If your pet has ingested any phosphide product, seek veterinary care immediately and inform staff about the potential phosphine exposure hazard.",
                toxicityInfo: "All metal phosphides (zinc, aluminum, magnesium) react with stomach acid and moisture to produce phosphine gas, which is rapidly absorbed and causes widespread cellular damage by blocking energy production in cells. Phosphine damages the heart, lungs, liver, kidneys, and nervous system. Aluminum and magnesium phosphides can release phosphine even at neutral pH, while zinc phosphide requires acidic conditions. Animals that cannot vomit (such as rabbits and horses) are at even greater risk because they cannot expel the poison. There is NO ANTIDOTE—treatment is supportive only. Unlike some other rodenticides, zinc phosphide loses potency when exposed to moisture over time, so old or weathered bait may be less toxic. Secondary (relay) toxicosis from eating a poisoned rodent is possible, especially in dogs.",
                onsetTime: OnsetTime(
                    early: "With food in the stomach: signs can begin within 15 minutes to 4 hours (food increases acid production, speeding phosphine release)",
                    delayed: "On an empty stomach: signs may be delayed up to 12 hours"
                ),
                symptoms: [
                    "Rapid onset of vomiting (often bloody)",
                    "Anxiety, restlessness, or agitation",
                    "Vocalization",
                    "Aggression or abnormal behavior",
                    "Running fits",
                    "Loss of appetite",
                    "Weakness and depression",
                    "Difficulty breathing (dyspnea)",
                    "Rapid breathing (tachypnea)",
                    "Coughing",
                    "Bluish gums (cyanosis)",
                    "Unsteady gait (ataxia)",
                    "Muscle tremors",
                    "Seizures",
                    "Coma",
                    "Sudden death (can occur within hours)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Most commonly affected species; vomiting may limit absorption but releases toxic gas; relay toxicosis from eating poisoned rodents has been reported"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Equally susceptible; less commonly exposed than dogs"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Rabbits and horses are at extreme risk because they cannot vomit and cannot expel the poison"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Highly susceptible; granivorous birds may consume grain-based baits"),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "Susceptible; limited data available")
                ],
                preventionTips: [
                    "Avoid using metal phosphide products where pets have access—there is NO ANTIDOTE",
                    "If you must use gopher or mole bait, apply it deep in burrows where pets cannot reach",
                    "Never leave bait on the soil surface",
                    "Keep pets away from areas being fumigated with aluminum or magnesium phosphide",
                    "Consider pet-safe alternatives such as traps or vibration deterrents",
                    "Keep pets away from areas where rodents may have been poisoned (relay toxicosis risk)",
                    "CRITICAL: If your pet ingests any phosphide product, warn veterinary staff that the vomit releases toxic phosphine gas",
                    "If your pet vomits at home after suspected ingestion, ventilate the area immediately and avoid breathing the fumes"
                ],
                sources: ["VIN Toxicology Resources", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual — Phosphide Poisoning in Animals", "Pet Poison Helpline", "CDC MMWR — Occupational Phosphine Gas Poisoning at Veterinary Hospitals (2012)", "National Pesticide Information Center"],
                relatedEntries: ["049e1259-f968-4e23-aa8c-5110cb52a08c"]
            ),

            // MARK: - Slug & Snail Bait (Metaldehyde)
            ToxicItem(
                id: UUID(uuidString: "a7d3e8f2-6b4c-4a1e-9f5d-2c8b7a3e6d1f")!,
                name: "Slug & Snail Bait (Metaldehyde)",
                alternateNames: ["slug bait", "snail bait", "slug pellets", "snail pellets", "slug killer", "snail killer", "metaldehyde", "metaldehyde poisoning", "molluscicide", "slug poison", "snail poison", "garden slug bait", "slug and snail bait", "Deadline", "Slug-Tox", "Bug-Geta", "Sluggo Plus", "Corry's Slug & Snail Killer", "camping stove fuel", "solid fuel tablets", "camp stove fuel", "Esbit fuel tablets"],
                categories: [.garageGarden],
                imageAsset: "slug_snail_bait",
                description: "Metaldehyde is the primary toxic ingredient in most commercial slug and snail baits used in gardens. It is extremely toxic to dogs, cats, birds, and wildlife. The baits are typically formulated as pellets, granules, powders, or liquids, and often contain bran or molasses to attract slugs and snails—unfortunately, these additives also make the bait highly attractive to pets, especially dogs.\n\nMetaldehyde is also found in solid fuel tablets used for camping stoves and lamps, particularly products from Europe where concentrations can be much higher than in garden baits.\n\nThis poisoning is classically described as \"shake and bake\" because affected animals develop severe muscle tremors or seizures combined with dangerously elevated body temperature. There is NO specific antidote for metaldehyde poisoning. Very small amounts can cause life-threatening toxicosis—ingestion of less than a teaspoon of bait can be fatal in small dogs.\n\nDogs are far more commonly affected than cats, likely due to their less discriminating eating habits, but cats can also be poisoned if they walk through treated areas and groom the product off their paws.",
                toxicityInfo: "Metaldehyde is a neurotoxin that affects the central nervous system. The exact mechanism is not fully understood, but it appears to affect GABA (an inhibitory neurotransmitter) and lower the seizure threshold. After ingestion, metaldehyde readily crosses the blood-brain barrier.\n\nThe severe muscle tremors and seizures cause body temperature to rise to dangerous levels (hyperthermia), which can lead to organ damage, metabolic acidosis, and multi-organ failure. Even pets that survive the initial neurological crisis may develop liver failure days later, though this is uncommon.\n\nThere is NO specific antidote. Treatment focuses on controlling tremors, managing body temperature, and supportive care. Early veterinary intervention dramatically improves outcomes.",
                onsetTime: OnsetTime(
                    early: "30 minutes to 3 hours — anxiety, muscle twitching, hypersalivation, vomiting",
                    delayed: "Rapid progression to severe tremors, seizures, hyperthermia, and potentially coma"
                ),
                symptoms: [
                    "Anxious behavior and restlessness",
                    "Muscle twitching progressing to severe tremors",
                    "Seizures and convulsions",
                    "Hyperthermia (dangerously elevated body temperature)",
                    "Rapid heart rate (tachycardia)",
                    "Rapid breathing or panting",
                    "Excessive drooling (hypersalivation)",
                    "Vomiting",
                    "Diarrhea",
                    "Incoordination and wobbly gait (ataxia)",
                    "Hypersensitivity to touch, light, or sound",
                    "Dilated pupils (mydriasis)",
                    "Rapid eye movements (nystagmus) — especially in cats",
                    "Rigid body posture (opisthotonos)",
                    "Depression progressing to coma",
                    "Respiratory failure"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs are most commonly affected due to their indiscriminate eating habits. The bran and molasses in baits are highly attractive to dogs. Even very small amounts can be fatal."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Less commonly affected than dogs, but equally susceptible to toxicity. Cats may be exposed by walking through treated areas and grooming metaldehyde off their paws. Nystagmus (rapid eye movements) is particularly noted in cats."),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly susceptible to metaldehyde poisoning. Backyard poultry and wild birds can be affected by consuming bait pellets or poisoned slugs/snails.")
                ],
                preventionTips: [
                    "Store all slug and snail baits in sealed containers in locked cabinets inaccessible to pets",
                    "Consider using iron phosphate-based molluscicides (such as Sluggo) instead—these are much less toxic to pets",
                    "Never apply bait in piles or lines; scatter sparingly as directed",
                    "Keep pets out of treated garden areas for the duration recommended on the product label",
                    "Clean up any spills immediately and thoroughly",
                    "Be aware that your neighbor may use metaldehyde baits even if you don't",
                    "Remember that solid fuel tablets for camping stoves may contain high concentrations of metaldehyde",
                    "Use non-chemical slug deterrents: copper bands around plants, crushed eggshells, lava rock, or beer traps",
                    "If your pet has access to areas where slugs are common, inspect regularly for any bait products"
                ],
                sources: ["VIN Toxicology Resources: Metaldehyde Toxicosis", "ASPCA Animal Poison Control Center: Tips for Treating Metaldehyde Poisoning", "Merck Veterinary Manual: Metaldehyde Poisoning in Animals", "Pet Poison Helpline / VCA Hospitals: Metaldehyde Toxicity (Slug Bait Poisoning)", "Bates NS, et al. Suspected metaldehyde slug bait poisoning in dogs: a retrospective analysis. Vet Rec. 2012"],
                relatedEntries: nil
            ),

            // MARK: - Expanding Glues (Gorilla Glue)
            ToxicItem(
                id: UUID(uuidString: "b2e4f7a1-8c3d-4e6f-a9b2-1d5c8e3f7a2b")!,
                name: "Expanding Glues (Gorilla Glue)",
                alternateNames: ["Gorilla Glue", "polyurethane glue", "expanding glue", "foaming glue", "wood glue", "construction glue", "diisocyanate glue", "isocyanate glue", "Elmer's ProBond", "Titebond polyurethane", "expanding adhesive", "foaming adhesive", "polyurethane adhesive", "Grizzly glue", "expanding wood glue", "Loctite polyurethane", "MDI glue", "diphenylmethane diisocyanate"],
                categories: [.garageGarden],
                imageAsset: "expanding_glue",
                description: "Expanding polyurethane glues—sold under brand names like Gorilla Glue, Elmer's ProBond, and Titebond—contain diisocyanates that react with moisture to create an expanding foam that hardens into an extremely strong bond. These glues are commonly labeled as \"expanding\" or \"foaming\" adhesives and are popular for woodworking and construction projects.\n\nWhen a dog chews on a bottle and swallows even a small amount of liquid glue, the warm, moist environment of the stomach triggers rapid expansion. The glue can expand to many times its original volume—sometimes filling the entire stomach—and then hardens into a rock-solid mass within minutes. This mass cannot be vomited up because it becomes too large to pass through the esophagus, and it cannot pass into the intestines. The result is a complete gastrointestinal obstruction.\n\nAccording to the ASPCA Animal Poison Control Center, cases of expanding glue ingestion have increased over 300% since 2002. Dogs are overwhelmingly the most common victims, often attracted by the sweet smell or taste of these products. Cats are rarely affected.\n\n**Critical:** Do NOT induce vomiting and do NOT give water or any fluids—this will cause the glue to expand faster and larger. Surgery is almost always required to remove the mass.",
                toxicityInfo: "The danger from expanding glues is physical obstruction, not chemical toxicity. The diisocyanates in these products react with water and stomach acid to produce an expanding foam that hardens rapidly. Heat and carbon dioxide are byproducts of this reaction, which accelerates in the warm stomach environment.\n\nAs little as half an ounce (about 15 mL) of glue has been sufficient to cause gastric obstruction in dogs. The hardened mass rubs against the stomach lining, causing irritation and potentially ulceration. If the glue expands in the esophagus or small intestine rather than the stomach, the risk of perforation and rupture is higher due to the limited space.\n\nThe glue mass does not break down in the stomach and cannot be digested. Without surgical removal, the obstruction will persist indefinitely. Some dogs have survived for weeks with a glue mass in the stomach before the obstruction became critical, but most require emergency surgery.",
                onsetTime: OnsetTime(
                    early: "15 minutes to several hours — vomiting, retching, drooling, abdominal discomfort",
                    delayed: "Hours to days — progressive obstruction signs: loss of appetite, bloating, inability to keep food down"
                ),
                symptoms: [
                    "Vomiting (may contain blood)",
                    "Retching and gagging",
                    "Loss of appetite (anorexia)",
                    "Abdominal pain",
                    "Distended or bloated abdomen",
                    "Lethargy and weakness",
                    "Weight loss",
                    "Excessive thirst (polydipsia)",
                    "Drooling",
                    "Inability to keep food or water down",
                    "Diarrhea (early)",
                    "Absence of stool (later, as obstruction progresses)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are overwhelmingly the most commonly affected species, typically from chewing on glue bottles. The sweet smell and taste of these products attracts dogs. Surgery is almost always required to remove the hardened mass."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Expanding glue ingestion has not been reported in cats in the veterinary literature, but the same mechanism would apply if a cat ingested the product. Cats may be exposed if they groom glue off their fur.")
                ],
                preventionTips: [
                    "Store all expanding glues in locked cabinets or sturdy toolboxes completely inaccessible to pets",
                    "Never leave glue bottles unattended during projects—dogs can grab them in seconds",
                    "Keep pets out of the work area entirely when using these products",
                    "Clean up any spills immediately and thoroughly",
                    "Be aware that contractors or handymen may bring these products into your home",
                    "Remember that the sweet smell attracts dogs—don't assume your dog won't be interested",
                    "Not all Gorilla Glue products contain expanding diisocyanates—check labels, but treat all as potentially dangerous",
                    "If you see your dog with a chewed glue bottle, contact your veterinarian immediately even if you're not sure any was swallowed"
                ],
                sources: ["VIN Toxicology Resources: Expanding Wood Glue Ingestion", "ASPCA Animal Poison Control Center: Polyurethane Glue Ingestion Statistics", "Pet Poison Helpline / VCA Hospitals: Expanding Glues", "Veterinary Partner (VIN): Expandable Foaming Glues Cause Obstructions in Pets", "PetMD: Gorilla Glue Poisoning in Dogs"],
                relatedEntries: nil
            ),

            // MARK: - Fertilizers
            ToxicItem(
                id: UUID(uuidString: "c3f5a8b2-7d4e-4f1a-b6c9-2e8d7f4a5b3c")!,
                name: "Fertilizers",
                alternateNames: ["lawn fertilizer", "garden fertilizer", "plant food", "plant fertilizer", "bone meal", "blood meal", "fish meal", "feather meal", "organic fertilizer", "rose fertilizer", "Miracle-Gro", "Scotts fertilizer", "lawn food", "garden soil", "potting soil with fertilizer", "slow release fertilizer", "granular fertilizer", "liquid fertilizer", "NPK fertilizer", "nitrogen fertilizer", "iron fertilizer", "compost fertilizer"],
                categories: [.garageGarden],
                imageAsset: "fertilizer_bag",
                description: "Lawn and garden fertilizers are among the most common products pets are exposed to. Basic fertilizers containing nitrogen, phosphorus, and potassium (N-P-K) generally have a wide margin of safety and typically cause only mild gastrointestinal upset. However, certain types of fertilizers and additives pose more serious risks.\n\n**Organic fertilizers** such as bone meal and blood meal are highly palatable to dogs—they will often tear open bags to eat large quantities. Bone meal can form a cement-like mass (bezoar) in the stomach that may require surgical removal. Blood meal can cause severe pancreatitis and may contain added iron.\n\n**Combination products** are a major concern: some fertilizers (especially rose fertilizers) contain organophosphate insecticides like disulfoton, which are extremely toxic—as little as one teaspoon of 1% disulfoton can kill a large dog.\n\nAlways check product labels carefully, as fertilizers are often mixed with herbicides, insecticides, or other additives that significantly increase toxicity.",
                toxicityInfo: "The toxicity of fertilizers varies greatly by type:\n\n**Basic N-P-K fertilizers:** Low toxicity; cause mild GI irritation. Once properly applied and dried, treated lawns pose minimal risk.\n\n**Bone meal:** Forms a hard, cement-like mass in the stomach that cannot be digested or vomited. Can cause gastrointestinal obstruction requiring surgery. Also associated with pancreatitis.\n\n**Blood meal:** Contains approximately 12% nitrogen. Can cause vomiting, diarrhea, and severe pancreatitis. Some products are fortified with iron, adding risk of iron toxicity.\n\n**Iron-containing fertilizers:** Elemental iron can cause iron toxicity with vomiting, bloody diarrhea, and potential cardiac and liver effects.\n\n**Organophosphate-containing products:** Rose and systemic fertilizers may contain disulfoton or other organophosphates that cause severe cholinergic toxicity (salivation, urination, defecation, tremors, seizures, death).\n\n**Moldy fertilizers:** Old or improperly stored fertilizers can develop mold that produces tremorgenic mycotoxins.",
                onsetTime: OnsetTime(
                    early: "Few hours — vomiting, diarrhea, muscle stiffness with basic fertilizers; minutes to hours with organophosphates",
                    delayed: "24-48 hours — bone meal obstructions become apparent as material hardens"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea (may be bloody)",
                    "Drooling",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Lethargy",
                    "Excessive thirst",
                    "Muscle stiffness or soreness",
                    "Hind limb rigidity",
                    "Tremors",
                    "Bloated or distended abdomen (with large ingestions)",
                    "Signs of pancreatitis (severe abdominal pain, hunched posture)",
                    "SLUD signs with organophosphates: Salivation, Lacrimation (tearing), Urination, Defecation",
                    "Seizures (with organophosphate or moldy products)",
                    "Difficulty breathing (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Dogs are most commonly affected because they find organic fertilizers (bone meal, blood meal) highly palatable and will often eat large quantities directly from bags. Risk increases significantly with combination products containing organophosphates."),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats are less commonly affected as they are typically less interested in eating fertilizers. However, they can be exposed by walking through treated areas and grooming their paws."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Birds may be exposed to fertilizers in outdoor environments. Small body size increases risk from smaller exposures.")
                ],
                preventionTips: [
                    "Store all fertilizer bags in sealed containers in locked cabinets or areas completely inaccessible to pets",
                    "Never leave open bags of fertilizer unattended—dogs can tear them open in seconds",
                    "Keep pets off treated lawns until products are completely dry (at least 24-48 hours)",
                    "Read labels carefully to identify any added herbicides, insecticides, or organophosphates",
                    "Be especially cautious with rose fertilizers, which may contain highly toxic disulfoton",
                    "Bone meal is often used to dust spring bulbs—prevent dogs from digging in newly planted areas",
                    "Consider pet-safer alternatives to bone meal and blood meal for organic gardening",
                    "Dispose of old or moldy fertilizers properly—do not leave them where pets can access them",
                    "Wipe pets' paws after walks if you suspect they've walked through treated areas",
                    "If your pet ingests fertilizer, try to identify the specific product and ingredients before calling your veterinarian"
                ],
                sources: ["VIN Toxicology Resources: Fertilizers and Bone/Blood Meal", "ASPCA Animal Poison Control Center: Fertilizers: A Growing Problem for Pets", "Pet Poison Helpline: Bone Meal & Blood Meal Toxicity", "PetMD: My Dog Ate Fertilizer", "DVM360: Spring Toxin - Fertilizers"],
                relatedEntries: nil
            ),

            // MARK: - Pyrethrins & Pyrethroids (Permethrin)
            ToxicItem(
                id: UUID(uuidString: "d4e5f6a7-8b9c-4d0e-a1b2-3c4d5e6f7a8b")!,
                name: "Pyrethrins & Pyrethroids (Permethrin)",
                alternateNames: ["permethrin", "pyrethrin", "pyrethroid", "flea treatment poisoning", "flea product toxicity", "spot-on poisoning", "flea collar toxicosis", "flea dip toxicosis", "flea spray toxicosis", "tick treatment poisoning", "dog flea product on cat", "cypermethrin", "deltamethrin", "allethrin", "bifenthrin", "cyfluthrin", "cyhalothrin", "cyphenothrin", "etofenprox", "fenvalerate", "flumethrin", "fluvalinate", "phenothrin", "resmethrin", "sumithrin", "tetramethrin", "tefluthrin", "tralomethrin", "Advantix", "K9 Advantix", "Bio Spot", "Hartz flea", "Sentry flea", "Zodiac flea", "Sergeant's flea", "Adams flea", "chrysanthemum insecticide"],
                categories: [.garageGarden, .medications],
                imageAsset: "pyrethrins_pyrethroids",
                description: "Pyrethrins are natural insecticides extracted from chrysanthemum flowers. Pyrethroids (such as permethrin, cypermethrin, and deltamethrin) are synthetic derivatives designed for greater stability and effectiveness. These are among the most commonly used household and pet insecticides worldwide.\n\n⚠️ CATS ARE EXTREMELY SENSITIVE to pyrethroids, particularly permethrin. Dogs tolerate these products well, but products designed for dogs contain concentrations that are potentially fatal to cats. Dog spot-on flea products typically contain 40-65% permethrin, while cat-safe products contain less than 1%.\n\nThe most common cause of pyrethroid poisoning in cats is the accidental or intentional application of a dog flea product. Cats can also be poisoned by grooming a recently treated dog or by close contact (sleeping together, rubbing against each other) before the product has dried.\n\nThis species difference exists because cats lack efficient liver glucuronidation enzymes needed to metabolize and eliminate pyrethroids. Without proper treatment, this poisoning can be fatal within hours.\n\nDog toxicosis is rare but can occur with significant overdose (using a large-dog product on a small puppy) or ingestion of flea collars.",
                toxicityInfo: "Pyrethroids work by disrupting voltage-gated sodium channels in nerve cells, causing prolonged nerve excitation. In cats, the deficiency of glucuronyl transferase enzyme in the liver prevents efficient breakdown of these compounds, leading to dangerous accumulation.\n\nOver 96% of cats exposed to concentrated permethrin products develop toxic signs. Clinical signs can range from mild (tremors, ear twitching) to severe (seizures, hyperthermia, respiratory failure). Mortality rates range from 2-10% with appropriate treatment, but can be much higher without veterinary care.\n\nThere is NO specific antidote. Treatment focuses on decontamination, controlling muscle tremors, and supportive care. Early and aggressive treatment dramatically improves outcomes.\n\nNOTE: Low-concentration products (household sprays at less than 1%, cat-approved flea products, properly applied flea collars) are generally well-tolerated by cats when used according to label directions.",
                onsetTime: OnsetTime(
                    early: "Signs typically appear within a few hours of exposure but can begin within 30 minutes in severe cases",
                    delayed: "Signs may be delayed up to 72 hours; symptoms typically persist for 2-3 days with treatment, sometimes up to 5-7 days"
                ),
                symptoms: [
                    "Muscle tremors (especially face and ears)",
                    "Muscle twitching and fasciculations",
                    "Ear flicking",
                    "Paw flicking or shaking",
                    "Excessive drooling (hypersalivation)",
                    "Vomiting",
                    "Hyperexcitability or agitation",
                    "Hiding or unusual behavior",
                    "Hypersensitivity to touch or sound",
                    "Incoordination (ataxia)",
                    "Weakness",
                    "Seizures or convulsions",
                    "Elevated body temperature (hyperthermia from muscle activity)",
                    "Low body temperature (hypothermia in some cases)",
                    "Rapid breathing (tachypnea)",
                    "Difficulty breathing (dyspnea)",
                    "Rapid heart rate (tachycardia)",
                    "Dilated pupils (mydriasis)",
                    "Temporary blindness (rare)",
                    "Depression or lethargy",
                    "Paralysis (severe cases)",
                    "Coma (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .cat, severity: .severe, notes: "EXTREMELY SENSITIVE. Cats lack the liver enzymes to efficiently metabolize pyrethroids. Over 96% of cats exposed to concentrated products develop toxic signs. Dog flea products should NEVER be applied to cats. Cats should also be separated from treated dogs for 72 hours after application."),
                    SpeciesRisk(species: .dog, severity: .low, notes: "Dogs tolerate pyrethroids well when used according to label directions. Toxicosis is rare but can occur with significant overdose (large-dog product on small puppy), ingestion of flea collars, or ingestion of large amounts of yard/garden products. Very young or very small dogs may be more susceptible."),
                    SpeciesRisk(species: .bird, severity: .low, notes: "Birds generally have low sensitivity to pyrethrins and pyrethroids. However, products should still be used according to label directions and birds should not be exposed to concentrated applications."),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Reptiles can be safely treated with pyrethrin/pyrethroid products for parasites when used correctly, but care must be taken to avoid the eyes and mouth. Excessive exposure can cause toxicosis. Fish in the same environment are extremely sensitive and may die from minimal exposure.")
                ],
                preventionTips: [
                    "NEVER apply dog flea or tick products to cats—even in smaller amounts",
                    "Always read product labels completely before application",
                    "Verify the product is appropriate for your pet's species, weight, and age",
                    "Keep cats separated from dogs for 72 hours after applying permethrin-based spot-on treatments to dogs",
                    "Do not allow cats to groom dogs that have recently been treated",
                    "Store flea and tick products securely away from pets",
                    "If you have cats, consider using non-permethrin flea products for dogs in the same household",
                    "Cat-safe flea products typically contain less than 0.1% permethrin and should be used as directed",
                    "Cover or remove aquariums when using any pyrethroid sprays in the home—fish are extremely sensitive",
                    "When using household insect sprays, remove all pets and allow the area to dry completely before allowing pets back"
                ],
                sources: ["VIN Toxicology Resources: Pyrethrins and Pyrethroids", "ASPCA Animal Poison Control Center: Permethrin Spot-On Toxicoses in Cats", "Merck Veterinary Manual: Plant-Derived Insecticide Toxicosis in Animals", "Pet Poison Helpline / VCA Hospitals: Pyrethrin/Pyrethroid Poisoning in Cats", "International Cat Care: Permethrin Poisoning", "American Association of Feline Practitioners (AAFP): Permethrin Poisoning Campaign", "Boland LA, Angles JM. Feline permethrin toxicity: Retrospective study of 42 cases. J Feline Med Surg. 2010", "Sutton NM, et al. Clinical effects and outcome of feline permethrin spot-on poisonings. J Feline Med Surg. 2007"],
                relatedEntries: ["c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - Organophosphates & Carbamates
            ToxicItem(
                id: UUID(uuidString: "e5f6a7b8-9c0d-4e1f-b2a3-4c5d6e7f8a9b")!,
                name: "Organophosphates & Carbamates",
                alternateNames: ["organophosphate", "organophosphate poisoning", "carbamate", "carbamate poisoning", "cholinesterase inhibitor", "acetylcholinesterase poisoning", "SLUDGE syndrome", "systemic rose care", "rose fertilizer poison", "disulfoton", "Di-Syston", "acephate", "Orthene", "chlorpyrifos", "Dursban", "Lorsban", "diazinon", "malathion", "parathion", "phosmet", "dichlorvos", "DDVP", "fenthion", "coumaphos", "terbufos", "carbaryl", "Sevin", "carbofuran", "Furadan", "methomyl", "Lannate", "propoxur", "Baygon", "aldicarb", "Temik", "fly bait poisoning", "cattle ear tag poisoning", "livestock ear tag"],
                categories: [.garageGarden, .medications],
                imageAsset: "organophosphates_carbamates",
                description: "Organophosphates (OPs) and carbamates (CMs) are cholinesterase-inhibiting insecticides that were once commonly used for pest control on animals and in agriculture. While their use has declined significantly due to the availability of safer modern insecticides, they remain in some garden products, agricultural applications, livestock treatments, and older stored pesticides.\n\n⚠️ SYSTEMIC ROSE CARE PRODUCTS are a major source of poisoning. Products containing disulfoton or acephate are extremely toxic—just ONE TEASPOON of some rose care products can exceed the lethal dose for a 25 kg (55 lb) dog. These are often applied with bone meal or blood meal fertilizers that dogs find highly attractive, leading to accidental ingestion.\n\nOther common exposure sources include fly baits (especially methomyl, which is formulated with sugar to attract flies—and dogs), cattle ear tags containing OPs, older flea/tick products, and agricultural/lawn pesticides.\n\nThese toxins cause the classic \"SLUDGE\" syndrome: Salivation, Lacrimation (tearing), Urination, Defecation, GI distress, and Emesis (vomiting). Additional neurological signs include muscle tremors, seizures, and weakness.\n\n**Key difference between OPs and carbamates:** Organophosphates irreversibly bind to acetylcholinesterase, so effects can persist for days to weeks. Carbamates bind reversibly, so effects typically resolve within 4 hours if the animal survives.",
                toxicityInfo: "These insecticides work by inhibiting acetylcholinesterase (AChE), the enzyme that breaks down the neurotransmitter acetylcholine. This causes acetylcholine to accumulate at nerve endings, leading to continuous, uncontrolled nerve stimulation.\n\nEffects are classified as:\n• MUSCARINIC (smooth muscle/glands): SLUDGE signs—excessive secretions, GI hypermotility, slow heart rate, constricted pupils\n• NICOTINIC (skeletal muscle): Fasciculations, tremors, weakness, paralysis\n• CNS: Anxiety, seizures, depression, coma\n\nOPs can also cause \"Intermediate Syndrome\" (IMS) 1-4 days after apparent recovery, characterized by profound muscle weakness especially in the neck, face, and respiratory muscles. Delayed neuropathy (weeks after exposure) has been reported in cats with lipophilic OPs like chlorpyrifos.\n\nAntidotes exist (atropine for muscarinic signs; pralidoxime for OPs), but treatment must be aggressive and early. Even with treatment, mortality rates of 15-17% have been reported.",
                onsetTime: OnsetTime(
                    early: "Signs typically develop within minutes to hours of exposure; carbamate effects usually resolve within 4 hours",
                    delayed: "OP effects may persist for days to weeks; Intermediate Syndrome may develop 1-4 days after apparent recovery; delayed neuropathy possible weeks later with some OPs"
                ),
                symptoms: [
                    "Excessive salivation/drooling",
                    "Tearing (lacrimation)",
                    "Frequent urination",
                    "Diarrhea",
                    "Vomiting",
                    "Abdominal cramping",
                    "Constricted pupils (miosis) — or dilated in severe cases",
                    "Slow heart rate (bradycardia)",
                    "Difficulty breathing (dyspnea)",
                    "Excessive airway secretions",
                    "Muscle twitching and fasciculations",
                    "Muscle tremors",
                    "Seizures/convulsions",
                    "Weakness progressing to paralysis",
                    "Incoordination (ataxia)",
                    "Depression or lethargy",
                    "Anorexia (not eating)",
                    "Hypothermia or hyperthermia",
                    "Bluish gums (cyanosis)",
                    "Collapse",
                    "Respiratory failure"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are frequently poisoned by ingesting rose care products mixed with attractive fertilizers (bone meal, blood meal), fly baits, or cattle ear tags. In one study of 102 dogs, 17% died despite treatment. Signs associated with death included weakness, mental dullness, and respiratory failure."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats are particularly sensitive to many OPs, especially chlorpyrifos. Exposure often occurs through grooming after walking through treated areas or from topical flea products. Cats may show chronic toxicosis from fat-stored OPs. Muscarinic signs (SLUDGE) are often LESS prominent in cats. One study reported 15% mortality."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are highly susceptible. Carbofuran (Furadan) has been documented as extremely toxic to birds including poultry, ducks, pheasants, and wild birds, with oral LD50 values as low as 0.4 mg/kg in some species.")
                ],
                preventionTips: [
                    "Store all insecticides securely out of reach of pets",
                    "NEVER mix systemic rose care products (containing disulfoton or acephate) with organic fertilizers like bone meal or blood meal",
                    "Keep pets away from treated garden areas until products have been watered in and soil has dried",
                    "Place fly baits (especially methomyl-based) completely out of reach of pets—the sugar base is highly attractive to dogs",
                    "Properly dispose of used pesticide-impregnated livestock ear tags",
                    "Consider using modern, lower-toxicity alternatives for pest control",
                    "Be aware that banned products may still exist in older households, garages, or outbuildings",
                    "If using any OP/CM product, read labels carefully and follow all safety precautions",
                    "Outdoor cats may be exposed by walking through treated areas—consider keeping cats indoors during and after pesticide applications"
                ],
                sources: ["VIN Toxicology Resources: Organophosphate and Carbamate Toxicosis", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual: Carbamate Toxicosis in Animals", "Pet Poison Helpline: Organophosphates", "Klainbart S, et al. Clinical manifestations, laboratory findings, treatment and outcome of acute organophosphate or carbamate intoxication in 102 dogs. Vet J. 2019"],
                relatedEntries: ["c3f5a8b2-7d4e-4f1a-b6c9-2e8d7f4a5b3c", "c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - Neonicotinoids (Imidacloprid)
            ToxicItem(
                id: UUID(uuidString: "f6a7b8c9-0d1e-4f2a-b3c4-5d6e7f8a9b0c")!,
                name: "Neonicotinoids (Imidacloprid)",
                alternateNames: ["imidacloprid", "neonicotinoid", "Advantage", "Advantage II", "Advantage Multi", "Advocate", "Seresto", "K9 Advantix", "flea treatment licked", "cat licked flea medicine", "dog licked flea treatment", "spot-on flea treatment", "dinotefuran", "nitenpyram", "Capstar", "clothianidin", "acetamiprid", "thiamethoxam", "thiacloprid"],
                categories: [.medications],
                imageAsset: "neonicotinoids_imidacloprid",
                description: "Neonicotinoids (including imidacloprid, the active ingredient in Advantage® and Seresto®) are modern insecticides commonly used in flea and tick products for dogs and cats. They have a very favorable safety profile for mammals.\n\nThese products work by targeting nicotinic acetylcholine receptors in insect nervous systems. Neonicotinoids bind much more strongly to insect receptors than mammalian receptors, and they do not easily cross the blood-brain barrier in mammals. This makes them much safer for pets than older insecticides like organophosphates.\n\n**Common concern:** \"My pet licked the flea treatment!\" This is very common and usually causes only mild, self-limiting effects such as drooling (from the bitter taste) or mild stomach upset. These typically resolve without treatment.\n\nImidacloprid has been extensively studied: dogs given 41 mg/kg daily by mouth for an entire year showed no adverse effects. Topical application at 5 times the recommended dose causes no adverse effects in dogs or cats.\n\nThese products are approved for use in pregnant and nursing dogs and cats.",
                toxicityInfo: "Neonicotinoids have very low mammalian toxicity. Imidacloprid preferentially binds to insect nicotinic receptors (not mammalian receptors) and does not readily cross the blood-brain barrier in mammals.\n\nMost \"toxicity\" reports are actually taste reactions from licking the application site. The bitter taste causes hypersalivation (drooling), and ingestion may cause mild vomiting or diarrhea that is typically self-limiting.\n\nThere is NO specific antidote because one is rarely needed. For oral exposure, dilution with water or milk is usually sufficient. Vomiting is typically self-limiting; antiemetics are only needed if persistent.\n\nSerious toxicity requiring veterinary intervention is rare and would only occur with massive ingestion of product (far exceeding normal use).",
                onsetTime: OnsetTime(
                    early: "Taste reaction (drooling) occurs immediately after licking; mild GI upset within a few hours if ingested",
                    delayed: "Symptoms are typically self-limiting and resolve within hours; persistent symptoms beyond 24 hours warrant veterinary evaluation"
                ),
                symptoms: [
                    "Hypersalivation/drooling (taste reaction — most common)",
                    "Vomiting (usually mild and self-limiting)",
                    "Diarrhea (usually mild)",
                    "Decreased appetite",
                    "Skin redness or irritation at application site",
                    "Itching/scratching at application site",
                    "Lethargy (uncommon)",
                    "Hyperactivity (uncommon, reported in dogs)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Very well tolerated. Dogs given 5 times the topical dose or 41 mg/kg/day orally for one year showed no adverse effects. Main concern is taste reaction from licking. Safe for pregnant and nursing dogs."),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Very well tolerated when using CAT-SPECIFIC products. Cats are more prone to licking and may show more drooling. Do not use products containing permethrin on cats (some combination products like K9 Advantix contain permethrin and are for dogs only)."),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Imidacloprid is approved for use on rabbits and ferrets at appropriate doses. It is the only flea product authorized for rabbits in many countries."),
                    SpeciesRisk(species: .bird, severity: .low, notes: "Low toxicity to birds based on available data.")
                ],
                preventionTips: [
                    "Apply spot-on treatments to the back of the neck where pets cannot lick",
                    "Prevent pets from grooming each other immediately after application",
                    "Wait until the product has dried before allowing close contact between pets",
                    "Always use the correct product for the species (dog products for dogs, cat products for cats)",
                    "Follow label age and weight restrictions",
                    "Do not use on puppies under 7 weeks or kittens under 8 weeks of age",
                    "Store flea products securely away from pets"
                ],
                sources: ["VIN Prescriber Highlights: Imidacloprid", "Merck Veterinary Manual: Neonicotinoid Toxicosis in Animals", "VCA Hospitals: Imidacloprid - Topical", "Parasitipedia: Imidacloprid Safety Summary"],
                relatedEntries: ["c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - Fipronil (Frontline)
            ToxicItem(
                id: UUID(uuidString: "a7b8c9d0-1e2f-4a3b-c4d5-6e7f8a9b0c1d")!,
                name: "Fipronil (Frontline)",
                alternateNames: ["fipronil", "Frontline", "Frontline Plus", "Frontline Gold", "Frontline Spray", "phenylpyrazole", "flea treatment toxicity", "dog licked Frontline", "cat licked Frontline", "fipronil poisoning", "spot-on flea medicine", "pyriprole"],
                categories: [.medications],
                imageAsset: "fipronil_frontline",
                description: "Fipronil is a phenylpyrazole insecticide and the active ingredient in Frontline® flea and tick products for dogs and cats. It has a wide margin of safety in dogs and cats when used according to label directions.\n\nFipronil works by blocking GABA-regulated chloride channels in insect nervous systems, causing hyperexcitation and death. It has greater than 500-fold selective toxicity toward insects over mammals because it preferentially binds to insect GABA receptors.\n\n**Common concern:** \"My pet licked the flea treatment!\" Licking typically causes only a taste reaction (drooling from the bitter taste) and possibly mild stomach upset. These effects are usually self-limiting.\n\nIn safety studies, dogs and cats given 5 times the recommended topical dose showed no adverse effects. Dogs given 0.5 mg/kg/day orally for 13 weeks showed no adverse signs.\n\n⚠️ **EXCEPTION — RABBITS:** Fipronil has been associated with deaths in rabbits and should NEVER be used on them. Use imidacloprid-based products for rabbits instead.\n\nFipronil may be used on breeding, pregnant, and lactating dogs and cats.",
                toxicityInfo: "Fipronil has low mammalian toxicity when used as directed. After topical application, less than 1% is absorbed through the skin. The product spreads through skin lipids and hair follicles, providing residual activity for about one month.\n\nMost \"toxicity\" cases are taste reactions from licking the application site. The bitter taste causes hypersalivation, and ingestion may cause mild GI upset.\n\nTrue toxicity (convulsions, tremors, hyperexcitability) requires ingestion of amounts far exceeding normal topical use. There is NO specific antidote. Treatment is supportive: anticonvulsants for seizures, confinement for ataxic patients.\n\n**Bird sensitivity:** Fipronil is more toxic to birds than mammals. Keep treated pets away from pet birds during application.",
                onsetTime: OnsetTime(
                    early: "Taste reaction (drooling) occurs immediately after licking; local skin irritation may develop within hours of application",
                    delayed: "Serious neurological signs (if they occur at all) would develop within hours of massive ingestion; symptoms typically self-limiting"
                ),
                symptoms: [
                    "Hypersalivation/drooling (taste reaction — most common)",
                    "Vomiting (usually mild)",
                    "Mild skin irritation at application site",
                    "Temporary redness at application site",
                    "At toxic doses only: hyperactivity",
                    "At toxic doses only: hyperexcitability",
                    "At toxic doses only: tremors",
                    "At toxic doses only: convulsions/seizures",
                    "At toxic doses only: ataxia (incoordination)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Very well tolerated. Dogs given 5 times the topical dose or 0.5 mg/kg/day orally for 13 weeks showed no adverse effects. Main concern is taste reaction from licking. Safe for pregnant and nursing dogs."),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Very well tolerated at label doses. Cats given 5 times the topical dose showed no adverse effects. Do not use on kittens under 8 weeks of age."),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "⚠️ DANGEROUS TO RABBITS. Fipronil has been associated with deaths in rabbits and should NEVER be used on them. Use imidacloprid-based products (Advantage) for rabbits instead."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are significantly more sensitive to fipronil than mammals. Oral LD50 values are 31 mg/kg in pheasants and 11.3 mg/kg in bobwhite quail (compared to 97 mg/kg in rats). Keep pet birds away from treated animals.")
                ],
                preventionTips: [
                    "Apply spot-on treatments to the back of the neck where pets cannot lick",
                    "Prevent pets from grooming each other immediately after application",
                    "Apply only to intact, healthy skin — not to broken or irritated skin",
                    "NEVER use fipronil products on rabbits",
                    "Keep treated pets away from pet birds during and immediately after application",
                    "Do not use on puppies or kittens under 8 weeks of age",
                    "Follow label weight restrictions",
                    "Store flea products securely away from pets"
                ],
                sources: ["VIN Prescriber Highlights: Fipronil", "Merck Veterinary Manual: Phenylpyrazole (Fipronil) Toxicosis in Animals", "EPA: Fipronil Safety Determination for Dogs and Cats"],
                relatedEntries: ["c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - DEET (Insect Repellent)
            ToxicItem(
                id: UUID(uuidString: "b8c9d0e1-2f3a-4b5c-d6e7-8f9a0b1c2d3e")!,
                name: "DEET (Insect Repellent)",
                alternateNames: ["DEET", "N,N-diethyl-meta-toluamide", "diethyltoluamide", "bug spray", "insect repellent", "mosquito repellent", "Off!", "Off spray", "Deep Woods Off", "Cutter", "Repel", "Sawyer", "bug repellent", "mosquito spray", "tick repellent"],
                categories: [.garageGarden],
                imageAsset: "deet_insect_repellent",
                description: "DEET (N,N-diethyl-meta-toluamide) is the active ingredient in many popular insect repellent products designed for humans, including Off!®, Cutter®, and Repel®. It is found in over 500 products at concentrations ranging from 5% to 100%.\n\n⚠️ DEET SHOULD NEVER BE APPLIED TO PETS. Some pet owners mistakenly spray their dogs or cats with human bug spray to protect them from mosquitoes or ticks. This can cause significant toxicity.\n\nDEET is readily absorbed through the skin and can cause neurological effects including tremors, seizures, and incoordination. The higher the concentration of DEET in the product, the greater the risk to pets.\n\nPets can be exposed by:\n• Direct application by owners (most common cause)\n• Licking treated human skin\n• Getting into containers of repellent\n• Being sprayed in the face (causes serious eye damage)\n• Inhaling spray in enclosed areas\n\nCats appear to be more sensitive than dogs. There is no established safe threshold—all exposures should be reported to a veterinarian or poison control.",
                toxicityInfo: "DEET affects the nervous system in pets. The exact mechanism is not fully understood, but it can cause a toxic encephalopathy (brain dysfunction) characterized by tremors, seizures, and behavioral changes.\n\nThe concentration of DEET in the product directly correlates with risk—products with higher concentrations (30-100%) pose greater danger than lower concentration products (5-15%).\n\nEye exposure is particularly serious and can cause conjunctivitis, uveitis (inflammation inside the eye), and corneal ulceration. Eyes should be flushed with saline for at least 15 minutes if exposure occurs.\n\nInhalation can cause airway inflammation and difficulty breathing.\n\nThere is NO specific antidote. Treatment is symptomatic and supportive, including decontamination (bathing for skin exposure, eye flushing, oral dilution), anticonvulsants for seizures, and supportive care.\n\nThe good news: DEET toxicosis in companion animals is generally of short duration when treated promptly.",
                onsetTime: OnsetTime(
                    early: "Signs can appear within minutes to hours of exposure depending on route and concentration",
                    delayed: "Most cases resolve within 24-72 hours with appropriate treatment; severe cases may have prolonged recovery"
                ),
                symptoms: [
                    "Skin irritation or redness",
                    "Excessive drooling (hypersalivation)",
                    "Vomiting",
                    "Diarrhea",
                    "Tremors",
                    "Muscle twitching",
                    "Incoordination (ataxia)",
                    "Difficulty walking (staggering gait)",
                    "Hyperexcitability or agitation",
                    "Behavioral changes",
                    "Seizures",
                    "Eye irritation, redness, squinting (if sprayed in face)",
                    "Corneal ulceration (eye exposure)",
                    "Difficulty breathing (inhalation exposure)",
                    "Lethargy or depression"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Should never have DEET applied. Neurological signs (tremors, ataxia, seizures) can occur. Higher concentration products pose greater risk. Generally short duration with treatment."),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats are reported to be MORE SENSITIVE than dogs to DEET. Never apply any DEET product to cats. Seek veterinary care immediately for any exposure."),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Do not use DEET products on small mammals. Their small body size increases risk of toxicity."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Avoid using DEET sprays around birds. Inhalation in enclosed spaces is a concern.")
                ],
                preventionTips: [
                    "NEVER apply human insect repellent containing DEET to dogs, cats, or other pets",
                    "Store DEET products securely out of reach of pets",
                    "If you apply DEET to yourself, prevent pets from licking your skin until it has dried completely",
                    "Do not spray DEET products near pets—especially avoid their face and eyes",
                    "Use only veterinarian-approved flea, tick, and mosquito preventatives for pets",
                    "If using DEET sprays indoors, ensure good ventilation and keep pets out of the area",
                    "Consider DEET-free alternatives for personal use if you have pets that frequently lick you"
                ],
                sources: ["ASPCA Animal Poison Control Center: Don't DEET That Dog!", "American College of Veterinary Pharmacists: Pet Poison Control - DEET", "Dorman DC, et al. Diethyltoluamide (DEET) insect repellent toxicosis. Vet Hum Toxicol. 1990", "Cornell University College of Veterinary Medicine: Small Animal Toxins"],
                relatedEntries: ["c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - Ant & Roach Bait Stations
            ToxicItem(
                id: UUID(uuidString: "d0e1f2a3-4b5c-6d7e-f8a9-0b1c2d3e4f5a")!,
                name: "Ant & Roach Bait Stations",
                alternateNames: ["ant bait", "ant trap", "ant killer", "roach bait", "roach trap", "roach killer", "cockroach bait", "Raid ant bait", "Terro", "Combat", "Hot Shot", "Ortho", "Amdro", "bait station", "bug bait", "insect bait", "borax ant killer", "boric acid bait"],
                categories: [.garageGarden],
                imageAsset: "ant_roach_bait",
                description: "Household ant and roach bait stations are common pest control products found in kitchens, bathrooms, and garages. Dogs are frequently attracted to these baits because many contain peanut butter or other food attractants designed to lure insects.\n\nThe good news: Most household ant and roach baits have LOW toxicity to pets. The insecticide concentrations are very low, and serious poisoning is uncommon.\n\nCommon active ingredients include:\n• **Abamectin** — A macrocyclic lactone (related to ivermectin) at very low concentrations\n• **Borates/Boric acid** — At bait concentrations, not enough to cause significant toxicity\n• **Fipronil** — Low concentration; generally well-tolerated\n• **Hydramethylnon** — Low toxicity at bait levels\n• **Indoxacarb** — Low toxicity to mammals\n\n⚠️ THE MAIN CONCERN IS THE PLASTIC HOUSING, NOT THE BAIT. If a dog chews up and swallows pieces of the plastic bait station, this can cause:\n• Gastrointestinal irritation\n• Vomiting or diarrhea\n• Potential intestinal obstruction (if large pieces are swallowed)\n\nMost exposures result in no signs or mild, self-limiting GI upset.",
                toxicityInfo: "WHY ANT BAITS ARE GENERALLY SAFE\n\nThe concentration of insecticide in household bait stations is designed to kill tiny insects—the dose is far too low to harm a much larger mammal in most cases.\n\nFor example:\n• Abamectin in ant baits is typically <0.05% concentration\n• Boric acid in baits is not concentrated enough to cause corrosive injury\n• Most dogs experience no symptoms or only mild GI upset\n\nIMPORTANT EXCEPTIONS\n\n**MDR-1 Gene Mutation Dogs:** Certain breeds with the MDR-1 gene mutation (ABCB1-1Δ polymorphism) may be more sensitive to abamectin-containing baits, especially if large amounts are ingested. Affected breeds include:\n• Collies and Collie mixes\n• Border Collies\n• Australian Shepherds\n• Old English Sheepdogs\n• Shetland Sheepdogs\n• Other herding breeds\n\nIf you have an MDR-1 sensitive breed and your dog ate multiple bait stations, contact your veterinarian.\n\nFOREIGN BODY RISK\n\nThe plastic housing is often the bigger concern. Watch for:\n• Repeated vomiting\n• Inability to keep food/water down\n• Abdominal pain\n• Lethargy\n• Loss of appetite\n• Straining to defecate\n\nThese could indicate a gastrointestinal obstruction requiring veterinary care.\n\nWHAT TO TELL YOUR VETERINARIAN\n\n• Brand name and product name\n• Active ingredient (if known)\n• How many bait stations were eaten\n• Whether the plastic housing was consumed\n• Your dog's breed (for MDR-1 consideration)",
                onsetTime: OnsetTime(
                    early: "GI upset (vomiting, diarrhea) typically occurs within a few hours if it occurs at all",
                    delayed: "Foreign body obstruction signs may develop over 24-72 hours if plastic housing was swallowed"
                ),
                symptoms: [
                    "Vomiting (often from plastic irritation)",
                    "Diarrhea",
                    "Drooling",
                    "Decreased appetite",
                    "Abdominal discomfort",
                    "Lethargy (uncommon)",
                    "Tremors (rare, mainly with large ingestions in MDR-1 dogs)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Most common species to eat bait stations due to food attractants. Generally only causes mild GI upset. Main concern is foreign body risk from plastic housing. MDR-1 gene dogs may be more sensitive to abamectin-containing baits."),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Less commonly affected (less attracted to baits). Same low toxicity concerns apply."),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size increases relative dose. Contact veterinarian for any known exposure."),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data. Avoid exposure.")
                ],
                preventionTips: [
                    "Place bait stations in areas inaccessible to pets (behind appliances, inside cabinets)",
                    "Use enclosed bait stations that pets cannot easily chew open",
                    "Consider pet-safe pest control alternatives",
                    "Check bait stations regularly and replace any that show signs of pet tampering",
                    "Store unused bait stations securely out of pet reach"
                ],
                sources: ["VIN (Veterinary Information Network): Insect Bait Station Toxicology", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: ["c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - Pesticides & Insecticides (Umbrella)
            ToxicItem(
                id: UUID(uuidString: "c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f")!,
                name: "Pesticides & Insecticides",
                alternateNames: ["pesticide", "insecticide", "bug killer", "bug spray", "flea product poisoning", "tick product poisoning", "flea medicine toxicity", "garden pesticide", "lawn insecticide", "ant killer", "roach killer", "wasp spray", "insect poison"],
                categories: [.garageGarden, .medications],
                imageAsset: "pesticides_insecticides",
                description: "Pesticides and insecticides are chemicals designed to kill or repel insects and other pests. They are found in garden products, household bug sprays, flea and tick preventatives, and agricultural applications. Pet exposure is common and toxicity varies dramatically depending on the type of product.\n\nThere are several major classes of pesticides, each with different mechanisms, toxicity levels, and treatment approaches:\n\n• **Pyrethrins/Pyrethroids** (including permethrin) — EXTREMELY TOXIC TO CATS. Found in many flea products. Dog products should never be used on cats.\n\n• **Organophosphates & Carbamates** — Cholinesterase inhibitors causing \"SLUDGE\" signs. Found in some garden products and older flea treatments. Declining in use but still encountered.\n\n• **Neonicotinoids** (imidacloprid) — LOW TOXICITY to mammals. Found in Advantage®, Seresto®. Generally very safe for dogs and cats.\n\n• **Fipronil** — LOW TOXICITY to dogs and cats but DANGEROUS TO RABBITS. Found in Frontline®.\n\n• **Ant & Roach Baits** — LOW TOXICITY. Main concern is foreign body risk from plastic housing, not the insecticide.\n\n• **DEET** — Human insect repellent. Should NEVER be applied to pets.\n\nIdentifying the specific product is critical for appropriate treatment. Different pesticide classes require different approaches.",
                toxicityInfo: "WHY IDENTIFICATION MATTERS\n\nPesticides are not a single poison—they are a category containing multiple distinct chemical classes that work in completely different ways:\n\n**Pyrethrins/Pyrethroids (e.g., permethrin)**\n• Mechanism: Sodium channel disruption\n• Key concern: EXTREMELY TOXIC TO CATS due to deficient liver metabolism\n• Dog flea products on cats = most common serious exposure\n• No specific antidote\n\n**Organophosphates & Carbamates**\n• Mechanism: Cholinesterase inhibition\n• Key signs: SLUDGE (Salivation, Lacrimation, Urination, Defecation, GI distress, Emesis)\n• Antidotes exist (atropine, pralidoxime for OPs)\n• 15-17% mortality even with treatment\n\n**Neonicotinoids (e.g., imidacloprid)**\n• Mechanism: Insect-selective nicotinic receptor binding\n• Key point: VERY LOW mammalian toxicity\n• \"My pet licked the flea treatment\" — usually causes only mild, self-limiting effects\n\n**Fipronil**\n• Mechanism: GABA receptor blocker (insect-selective)\n• Key point: Safe for dogs and cats; DANGEROUS TO RABBITS\n• Generally very well tolerated\n\n**Ant & Roach Bait Stations**\n• Active ingredients: Abamectin, borates, fipronil, hydramethylnon, indoxacarb\n• Key point: LOW TOXICITY—concentrations too low to harm pets\n• Main concern: Plastic housing can cause GI irritation or obstruction\n• MDR-1 gene dogs (Collies, etc.) may be more sensitive to abamectin\n\n**DEET**\n• Mechanism: Neurological (not fully understood)\n• Key point: Human product—NEVER apply to pets\n• Causes tremors, ataxia, seizures\n\nBring product packaging to the veterinary clinic whenever possible.",
                onsetTime: OnsetTime(
                    early: "Varies by type: DEET and pyrethroids may cause signs within minutes to hours; organophosphates within minutes to hours; neonicotinoids and fipronil typically cause only mild, immediate taste reactions",
                    delayed: "Organophosphate effects can persist for days to weeks; pyrethroid effects in cats typically last 2-3 days with treatment"
                ),
                symptoms: [
                    "Excessive drooling (hypersalivation)",
                    "Vomiting",
                    "Diarrhea",
                    "Muscle tremors",
                    "Muscle twitching/fasciculations",
                    "Seizures",
                    "Incoordination (ataxia)",
                    "Weakness",
                    "Hyperexcitability",
                    "Depression or lethargy",
                    "Difficulty breathing",
                    "Constricted or dilated pupils",
                    "Excessive tearing",
                    "Frequent urination"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Risk varies by pesticide type. Dogs generally tolerate most modern flea products well. Main concerns are organophosphates (HIGH risk) and accidental massive ingestion of any product."),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "CATS ARE EXTREMELY SENSITIVE TO PYRETHROIDS (especially permethrin). Never use dog flea products on cats. Keep cats separated from treated dogs for 72 hours. Other modern flea products (imidacloprid, fipronil) are generally safe for cats."),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "FIPRONIL IS DANGEROUS TO RABBITS. Use only imidacloprid-based products on rabbits. Small body size increases risk for all pesticide types."),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are sensitive to many pesticides, particularly fipronil and organophosphates. Avoid using pesticide sprays around birds.")
                ],
                preventionTips: [
                    "Always read product labels completely before use",
                    "NEVER use dog flea/tick products on cats",
                    "Keep cats separated from dogs for 72 hours after applying permethrin-based products to dogs",
                    "Store all pesticides securely out of reach of pets",
                    "Do not mix garden insecticides with fertilizers that attract pets (bone meal, blood meal)",
                    "NEVER apply human insect repellent (DEET) to pets",
                    "Use veterinarian-recommended flea and tick preventatives",
                    "Keep records of all pesticide products used in and around your home",
                    "Cover or remove fish tanks when using any pesticide sprays indoors"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual: Insecticide Toxicosis", "VIN Toxicology Resources"],
                relatedEntries: ["d4e5f6a7-8b9c-4d0e-a1b2-3c4d5e6f7a8b", "e5f6a7b8-9c0d-4e1f-b2a3-4c5d6e7f8a9b", "f6a7b8c9-0d1e-4f2a-b3c4-5d6e7f8a9b0c", "a7b8c9d0-1e2f-4a3b-c4d5-6e7f8a9b0c1d", "d0e1f2a3-4b5c-6d7e-f8a9-0b1c2d3e4f5a", "b8c9d0e1-2f3a-4b5c-d6e7-8f9a0b1c2d3e", "b4c5d6e7-8f9a-0b1c-2d3e-4f5a6b7c8d9e"]
            ),

            // MARK: - Rodenticides (Overview)
            ToxicItem(
                id: UUID(uuidString: "049e1259-f968-4e23-aa8c-5110cb52a08c")!,
                name: "Rodenticides (Overview)",
                alternateNames: ["rat poison", "mouse poison", "rodent bait", "rodent poison", "rodenticide", "rat bait", "mouse bait", "gopher poison", "mole poison", "vole poison", "rodent killer"],
                categories: [.garageGarden],
                imageAsset: "rodenticides_overview",
                description: "Rodenticides are poisons designed to kill rodents such as rats, mice, gophers, moles, and voles. These products are a leading cause of pet poisoning—the ASPCA Animal Poison Control Center receives thousands of rodenticide-related calls annually. Four main types of rodenticides are used in the United States, each working through a completely different mechanism. Identifying the exact product is critical because treatment varies dramatically between types. Product appearance (color, shape, size) does NOT reliably indicate the active ingredient—always check the packaging or contact poison control.",
                toxicityInfo: "The four major rodenticide types are: (1) Anticoagulant rodenticides (warfarin, brodifacoum, bromadiolone) prevent blood clotting and have an antidote (vitamin K1); (2) Bromethalin causes fatal brain swelling with NO ANTIDOTE; (3) Cholecalciferol (vitamin D3) causes fatal calcium elevation with NO ANTIDOTE; (4) Zinc phosphide releases toxic phosphine gas in the stomach with NO ANTIDOTE. Treatment success depends heavily on knowing the specific product and acting quickly. For detailed information on each type, see the related entries below.",
                onsetTime: OnsetTime(
                    early: "Varies by type: Anticoagulants show no signs for 1-3 days; Bromethalin and cholecalciferol may show signs within 12-24 hours; Zinc phosphide can cause signs within 15 minutes to 4 hours",
                    delayed: "Anticoagulants: bleeding 3-7 days after ingestion; Bromethalin: paralysis over 1-2 weeks; Cholecalciferol: kidney failure 1-3 days; Zinc phosphide: multi-organ failure within hours to days"
                ),
                symptoms: [
                    "Varies dramatically by rodenticide type",
                    "Anticoagulants: bleeding, pale gums, weakness, difficulty breathing",
                    "Bromethalin: hind leg weakness, paralysis, seizures, tremors",
                    "Cholecalciferol: increased thirst/urination, vomiting, kidney failure signs",
                    "Zinc phosphide: rapid vomiting, anxiety, difficulty breathing, collapse"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Most commonly poisoned species; dogs often find and consume bait or poisoned rodents"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Less commonly exposed but equally susceptible; outdoor cats may consume poisoned rodents"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Extremely susceptible due to small body size; ferrets, rabbits, and guinea pigs at high risk"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "All birds susceptible; raptors and scavengers at risk from eating poisoned rodents"),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "Susceptible; limited data available")
                ],
                preventionTips: [
                    "If you must use rodenticides, keep ALL packaging—product appearance does NOT indicate the active ingredient",
                    "Write down the exact product name, active ingredient, EPA registration number, and amount used",
                    "Use tamper-resistant bait stations and place them where pets cannot access",
                    "Consider pet-safe alternatives: snap traps, electronic traps, or professional pest control",
                    "If you suspect ANY rodenticide ingestion, contact a veterinarian or poison control immediately",
                    "Have product information ready when you call—treatment varies dramatically by type",
                    "Time is critical for all types—do not wait for symptoms to appear"
                ],
                sources: ["VIN Toxicology Resources", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: ["304c1824-e0b2-48bb-9991-3803d1ae87d0", "bdd489ee-bb6e-47c3-9b2f-b63d9fb7de21", "3c40b99c-5653-4195-a821-19dde4e1c8f8", "c8ebc592-fbe3-4e06-9e8d-63399dfce710"]
            ),

            // MARK: - Pool Chemicals
            ToxicItem(
                id: UUID(uuidString: "a3b4c5d6-7e8f-9a0b-1c2d-3e4f5a6b7c8d")!,
                name: "Pool Chemicals",
                alternateNames: ["Chlorine tablets", "Chlorine tabs", "Pool chlorine", "Pool shock", "Calcium hypochlorite", "Sodium hypochlorite", "Trichlor", "Dichlor", "Pool algaecide", "Algicide", "Muriatic acid", "Pool acid", "Brominating tablets", "Bromine tablets", "Pool sanitizer", "Spa chemicals", "Hot tub chemicals"],
                categories: [.garageGarden],
                imageAsset: "pool_chemicals",
                description: "Pool chemicals include chlorine tablets, pool shock, algaecides, muriatic acid, and pH balancers used to maintain safe swimming conditions. While properly diluted pool water poses minimal risk to pets beyond mild stomach upset, the concentrated chemicals used to treat pools are extremely corrosive. Chlorine tablets and pool shock contain high concentrations of oxidizing agents that can cause severe chemical burns to the mouth, throat, and digestive tract if ingested.",
                toxicityInfo: "Concentrated pool chemicals are corrosive and can cause severe ulceration of the mouth, esophagus, and stomach if ingested. Chlorine tablets taste unpleasant, but dogs may mistake them for treats when owners are adding them to pools. Diluted pool water (1-4 ppm chlorine) typically causes only mild GI upset if consumed in small amounts, but overchlorinated water or large amounts can cause more serious effects. Inhalation of chlorine fumes from concentrated products can cause respiratory distress. Muriatic acid (hydrochloric acid) is particularly dangerous and can cause severe chemical burns.\n\nIMPORTANT: Do NOT induce vomiting if a pet has ingested concentrated pool chemicals—the corrosive substance will cause additional burns on the way back up. Contact a veterinarian or poison control immediately.",
                onsetTime: OnsetTime(
                    early: "Signs of corrosive injury (drooling, pawing at mouth, difficulty swallowing) appear immediately to within minutes",
                    delayed: "Ulceration and tissue damage may worsen over 24-48 hours; respiratory signs from fume inhalation may develop within hours"
                ),
                symptoms: [
                    "Excessive drooling",
                    "Pawing at mouth or face",
                    "Difficulty swallowing",
                    "Oral burns or ulcers (visible redness or white patches in mouth)",
                    "Vomiting (may contain blood)",
                    "Refusal to eat or drink",
                    "Abdominal pain",
                    "Coughing or gagging (if fumes inhaled)",
                    "Difficulty breathing",
                    "Eye irritation or redness (if splashed)",
                    "Skin irritation or burns (if contact with concentrated product)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Most likely to ingest tablets or drink from pools; corrosive burns can be severe—do NOT induce vomiting"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Less likely to consume but equally susceptible to corrosive injury and fumes"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Small body size makes any exposure more dangerous; cannot vomit to expel"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Extremely sensitive to fumes; even minor inhalation exposure can be fatal"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Sensitive to chemical exposure; fumes and water contamination pose risks")
                ],
                preventionTips: [
                    "Store all pool chemicals in original containers in a locked area pets cannot access",
                    "Never leave chlorine tablets or containers unattended while treating the pool",
                    "Keep pets away from the pool area when adding chemicals",
                    "Provide fresh drinking water near the pool so pets don't drink pool water",
                    "Wait until chemicals are fully diluted before allowing pets near the pool",
                    "Rinse pets with fresh water after swimming to remove chlorine from fur",
                    "Consider alternatives like bromine which is slightly less irritating to pets"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "American Kennel Club", "VCA Animal Hospitals"],
                relatedEntries: nil
            ),

            // MARK: - Herbicides
            ToxicItem(
                id: UUID(uuidString: "b4c5d6e7-8f9a-0b1c-2d3e-4f5a6b7c8d9e")!,
                name: "Herbicides",
                alternateNames: ["Weed killer", "Weed killers", "Roundup", "Glyphosate", "2,4-D", "Dicamba", "Triclopyr", "Weed-B-Gon", "Weed and feed", "Lawn herbicide", "Brush killer", "Vegetation killer", "Grass killer", "Crabgrass killer", "Dandelion killer", "Broadleaf weed killer", "Pre-emergent herbicide", "Post-emergent herbicide"],
                categories: [.garageGarden],
                imageAsset: "herbicides",
                description: "Herbicides are chemicals used to control unwanted plants and weeds. Over 200 active ingredients are used in herbicide products, with varying levels of toxicity. Common active ingredients include glyphosate (Roundup), 2,4-D, dicamba, and triclopyr. Most modern herbicides have relatively low acute toxicity to mammals when used as directed, but exposure to concentrated products or recently treated vegetation can cause gastrointestinal upset and, in some cases, more serious effects. Pets are typically exposed by walking on treated lawns and then licking their paws, or by eating treated grass.",
                toxicityInfo: "Most household herbicides have a wide safety margin, and serious poisoning is uncommon when products are used as directed. Glyphosate (found in Roundup) is generally considered low toxicity but can cause GI upset, especially when vegetation is still wet. The 2,4-D family of herbicides can cause more significant effects including vomiting, diarrhea, loss of appetite, muscle weakness, and incoordination; severe exposures may cause seizures. The surfactants and other 'inert' ingredients in herbicide formulations can be more irritating than the active ingredients themselves. The greatest risk is from exposure to concentrated products or freshly sprayed vegetation before it has dried.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, drooling, diarrhea) typically appear within 30 minutes to a few hours of exposure",
                    delayed: "Neurological signs from 2,4-D or paraquat exposure may develop 24-48 hours after ingestion; liver or kidney effects may take days to manifest"
                ),
                symptoms: [
                    "Drooling or excessive salivation",
                    "Vomiting",
                    "Diarrhea",
                    "Loss of appetite",
                    "Lethargy or depression",
                    "Eye irritation (if direct contact)",
                    "Skin irritation or redness",
                    "Weakness, particularly in hind legs",
                    "Incoordination or difficulty walking",
                    "Muscle twitching or stiffness",
                    "Seizures (severe or paraquat exposure)",
                    "Difficulty breathing (paraquat exposure)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Most common exposure through eating grass or licking paws; most products cause only GI upset unless large amounts consumed"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Exposure through grooming after walking on treated areas; less likely to eat grass but still at risk"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Rabbits and guinea pigs may consume treated grass or vegetation; smaller body size increases risk"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "May consume treated seeds or forage on treated lawns; more sensitive to toxic effects"),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Risk from contaminated water or prey items; limited direct data available")
                ],
                preventionTips: [
                    "Keep pets off treated lawns until the product has completely dried (typically 24-48 hours)",
                    "Store all herbicides in original containers in a secure location",
                    "Read and follow all label directions—many specify when it's safe for pets to re-enter treated areas",
                    "Rinse your pet's paws after walks if you suspect they've crossed treated areas",
                    "Consider pet-safe or organic alternatives like vinegar-based herbicides",
                    "If using a lawn care service, ask about products used and re-entry intervals",
                    "Never let pets drink from puddles in areas that may have been treated"
                ],
                sources: ["Merck Veterinary Manual", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "PetMD", "National Pesticide Information Center"],
                relatedEntries: ["c9d0e1f2-3a4b-5c6d-e7f8-9a0b1c2d3e4f"]
            ),

            // MARK: - Mothballs
            ToxicItem(
                id: UUID(uuidString: "e1f2a3b4-5c6d-7e8f-9a0b-1c2d3e4f5a6b")!,
                name: "Mothballs",
                alternateNames: ["Moth balls", "Moth repellent", "Moth crystals", "Moth flakes", "Moth cakes", "Naphthalene balls", "Paradichlorobenzene", "PDB mothballs", "Camphor balls", "Camphor mothballs", "Urinal cake", "Urinal cakes", "Urinal deodorizer", "Toilet deodorizer block", "Closet deodorizer"],
                categories: [.garageGarden],
                imageAsset: "mothballs",
                description: "Mothballs are solid pesticides that slowly release vapor to kill and repel moths, their larvae, and other insects in stored clothing and fabric. They contain either naphthalene (older formulations, more toxic), paradichlorobenzene/PDB (modern formulations, less toxic), or camphor (rare in the US but may be found in products imported from Asia, particularly India and China). Paradichlorobenzene is also used in urinal deodorizing cakes. Mothballs are sometimes misused to repel snakes, mice, or other animals, which increases the risk of pet exposure. Fresh mothballs typically weigh 2.5-5 grams each.",
                toxicityInfo: "Naphthalene mothballs are significantly more toxic than paradichlorobenzene (PDB) types—approximately twice as toxic. A single paradichlorobenzene mothball is generally well tolerated by most dogs, while naphthalene ingestion can cause serious illness even from one mothball in smaller pets. Camphor mothballs, though less common, can cause severe CNS effects including seizures. Naphthalene damages red blood cells through oxidative injury, causing methemoglobinemia, Heinz body formation, and hemolytic anemia. It can also affect the liver and kidneys. PDB primarily causes gastrointestinal upset and trembling; large ingestions may cause hepatic or renal injury. Mothballs dissolve slowly in the digestive tract, so toxicity may be delayed. Cats are more sensitive to mothball toxicity than dogs, but dogs are more likely to ingest them.",
                onsetTime: OnsetTime(
                    early: "GI signs (vomiting, loss of appetite) typically appear within hours of ingestion",
                    delayed: "Hemolytic anemia and organ damage may develop 1-5 days after naphthalene ingestion; signs can persist due to slow dissolution"
                ),
                symptoms: [
                    "Vomiting",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Mothball-scented breath",
                    "Pale or brown mucous membranes (indicating anemia or methemoglobinemia)",
                    "Icterus (jaundice/yellowing of gums, skin, or eyes)",
                    "Labored or rapid breathing",
                    "Disorientation or depression",
                    "Tremors or muscle twitching",
                    "Difficulty walking or incoordination",
                    "Excessive drooling",
                    "Abdominal pain",
                    "Seizures (severe cases)",
                    "Dark or discolored urine",
                    "Collapse or coma (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are more likely to ingest mothballs; naphthalene causes hemolytic anemia; one PDB mothball is generally tolerated but naphthalene is more dangerous"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Cats are more sensitive to toxic effects; even one mothball can cause serious illness"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Small body size increases risk; rabbits and rodents cannot vomit to expel toxin"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Highly sensitive to both ingestion and fumes; respiratory exposure especially dangerous"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Limited data; avoid any exposure")
                ],
                preventionTips: [
                    "Store mothballs only in sealed, airtight containers as directed on the label",
                    "Never place mothballs in open areas, closets, or yards where pets can access them",
                    "Do not use mothballs to repel wildlife—this is not their intended use and increases pet exposure risk",
                    "Consider safer alternatives like cedar products or lavender sachets",
                    "If you must use mothballs, choose PDB formulations over naphthalene (check label)",
                    "Keep storage containers locked and out of pet reach"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "VCA Animal Hospitals", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"],
                relatedEntries: nil
            ),

            // MARK: - Cocoa Mulch
            ToxicItem(
                id: UUID(uuidString: "f2a3b4c5-6d7e-8f9a-0b1c-2d3e4f5a6b7c")!,
                name: "Cocoa Mulch",
                alternateNames: ["Cocoa bean mulch", "Cocoa shell mulch", "Cocoa bean shell mulch", "Cocoa hull mulch", "Chocolate mulch", "Cacao mulch", "Cocoa bean hulls"],
                categories: [.garageGarden],
                imageAsset: "cocoa_mulch",
                description: "Cocoa mulch is a garden product made from the discarded shells of cocoa beans, a byproduct of chocolate production. It is popular with gardeners for its rich brown color, pleasant chocolate aroma, and ability to retain moisture. However, cocoa shells contain theobromine and caffeine—the same compounds that make chocolate toxic to pets. The chocolate scent can attract dogs, making this mulch particularly hazardous in yards where dogs have access.",
                toxicityInfo: "Cocoa mulch contains theobromine concentrations that can exceed those found in dark or even baker's chocolate—some products contain up to 300-1200 mg of theobromine per ounce. Dogs are most at risk because they may be attracted to the chocolate scent and eat the mulch. A 60-pound dog could potentially be poisoned by consuming less than 3 ounces of cocoa mulch. The methylxanthines (theobromine and caffeine) affect the heart, nervous system, and kidneys. Theobromine has an 18-hour half-life in dogs, meaning effects can be prolonged.",
                onsetTime: OnsetTime(
                    early: "Vomiting, restlessness, and increased thirst typically appear within 1-4 hours",
                    delayed: "Cardiac effects and seizures may develop 6-12 hours after ingestion; symptoms can persist up to 36 hours"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Restlessness or hyperactivity",
                    "Increased thirst and urination",
                    "Panting or rapid breathing",
                    "Rapid or abnormal heart rate",
                    "Elevated blood pressure",
                    "Muscle tremors",
                    "Hyperthermia (elevated body temperature)",
                    "Seizures (severe cases)",
                    "Cardiac arrhythmias (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are most at risk—attracted to chocolate scent and more likely to consume mulch; theobromine is poorly metabolized"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are less likely to eat cocoa mulch; no documented cases of feline cocoa mulch poisoning, but cats are sensitive to theobromine"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size means less mulch needed to reach toxic levels; rabbits and rodents are at risk if they forage in garden beds"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Highly sensitive to methylxanthines; avoid any exposure"),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Limited data; generally less likely to consume plant material")
                ],
                preventionTips: [
                    "Avoid using cocoa mulch if you have dogs that have access to garden areas",
                    "Choose pet-safe alternatives like cedar, pine, or rubber mulch",
                    "If cocoa mulch is already in your garden, fence off the area or supervise pets closely",
                    "Look for 'pet-safe' or 'pet-friendly' mulch products that have had theobromine removed through heat treatment",
                    "Be aware that the chocolate scent is strongest when mulch is fresh—this is when it's most attractive to dogs",
                    "Store unused mulch in sealed containers in areas pets cannot access"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Michigan State University Extension", "National Capital Poison Center", "RSPCA Australia"],
                relatedEntries: ["d8c34930-fe78-414c-a182-49521dbfc266"]
            ),

            // MARK: - Button Batteries
            ToxicItem(
                id: UUID(uuidString: "a1b2c3d4-5e6f-7a8b-9c0d-1e2f3a4b5c6d")!,
                name: "Button Batteries",
                alternateNames: [
                    "Disc batteries",
                    "Disc battery",
                    "Button cell",
                    "Button cell batteries",
                    "Coin batteries",
                    "Coin cell batteries",
                    "Lithium button battery",
                    "Lithium disc battery",
                    "Lithium coin battery",
                    "Watch battery",
                    "Watch batteries",
                    "Hearing aid battery",
                    "Hearing aid batteries",
                    "Calculator battery",
                    "Remote battery",
                    "Small round battery",
                    "CR2032",
                    "CR2025",
                    "CR2016",
                    "LR44",
                    "AG13",
                    "Keyless entry battery",
                    "Key fob battery"
                ],
                categories: [.householdItems],
                imageAsset: "button_batteries",
                description: "Button batteries (also called disc or coin batteries) are small, round batteries found in watches, hearing aids, remote controls, key fobs, calculators, musical greeting cards, and many children's toys. Lithium button batteries are particularly dangerous because they generate an electrical current when in contact with moist tissue, causing severe burns within minutes. These batteries can become lodged in the esophagus, where they cause rapid, life-threatening injury through a combination of electrical current, chemical leakage, and pressure necrosis.",
                toxicityInfo: "Button battery ingestion is a TIME-CRITICAL EMERGENCY. Lithium button batteries (3-volt) are the most dangerous—a single battery can cause severe esophageal burns within 15-30 minutes of becoming lodged. The battery generates an electrical current through tissue (current-induced necrosis), creates alkaline hydroxide at the negative pole, and causes pressure injury. This can lead to esophageal perforation, tracheoesophageal fistula, or erosion into major blood vessels. Even 'dead' batteries retain enough charge to cause tissue damage. Smaller button batteries may pass through the GI tract but can still cause burns wherever they contact tissue for prolonged periods. Non-lithium button batteries (silver oxide, zinc-air) are less dangerous but still pose risks if lodged.",
                onsetTime: OnsetTime(
                    early: "Tissue damage begins within 15-30 minutes of a lithium battery lodging in the esophagus; drooling, difficulty swallowing, or vomiting may appear quickly",
                    delayed: "Perforation and severe complications can develop within 2-4 hours; some injuries may not be apparent for days"
                ),
                symptoms: [
                    "Drooling or hypersalivation",
                    "Difficulty swallowing (dysphagia)",
                    "Refusal to eat or drink",
                    "Gagging or retching",
                    "Vomiting (may contain blood)",
                    "Pawing at mouth or throat",
                    "Restlessness or signs of pain",
                    "Lethargy or depression",
                    "Fever",
                    "Abdominal pain",
                    "Black or tarry stools (indicating GI bleeding)",
                    "Coughing or respiratory distress (if esophageal perforation occurs)",
                    "Collapse (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "Dogs commonly ingest button batteries; esophageal lodgment causes rapid, severe burns; immediate veterinary care essential"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "Less common than dogs but equally dangerous if ingested; cats' smaller esophagus increases lodgment risk"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Extremely dangerous due to small body size; battery is more likely to lodge; rabbits and ferrets at risk"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Critical emergency; small GI tract makes lodgment likely; tissue damage occurs rapidly"),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "Limited data but presumed highly dangerous; seek immediate veterinary care")
                ],
                preventionTips: [
                    "Store devices containing button batteries out of pet reach",
                    "Secure battery compartments with tape if the cover is loose or missing",
                    "Dispose of used batteries immediately in a sealed container",
                    "Be especially careful with musical greeting cards, remote controls, and key fobs—common sources of button batteries",
                    "Keep new batteries in original packaging until use",
                    "Check children's toys and holiday decorations for accessible battery compartments"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Merck Veterinary Manual", "National Capital Poison Center"],
                relatedEntries: ["b2c3d4e5-6f7a-8b9c-0d1e-2f3a4b5c6d7e"]
            ),

            // MARK: - Alkaline Batteries
            ToxicItem(
                id: UUID(uuidString: "b2c3d4e5-6f7a-8b9c-0d1e-2f3a4b5c6d7e")!,
                name: "Alkaline Batteries",
                alternateNames: [
                    "AA battery",
                    "AAA battery",
                    "C battery",
                    "D battery",
                    "9-volt battery",
                    "9V battery",
                    "Dry cell battery",
                    "Dry cell batteries",
                    "Household batteries",
                    "Flashlight battery",
                    "Flashlight batteries",
                    "Remote control battery",
                    "Toy batteries",
                    "Duracell",
                    "Energizer",
                    "Standard batteries",
                    "Cylindrical batteries"
                ],
                categories: [.householdItems],
                imageAsset: "alkaline_batteries",
                description: "Alkaline batteries are the standard household batteries (AA, AAA, C, D, and 9-volt) found in flashlights, remote controls, toys, and countless other devices. These batteries contain potassium hydroxide or sodium hydroxide, which are strongly alkaline (basic) substances. When a battery is punctured or chewed, these caustic contents can leak and cause chemical burns to the mouth, esophagus, and stomach. Dogs are most commonly affected, often chewing on batteries found in discarded or accessible devices.",
                toxicityInfo: "When alkaline batteries are punctured, the caustic contents (potassium or sodium hydroxide) cause liquefactive necrosis—a type of chemical burn that penetrates deeply into tissue. Unlike acid burns that create a protective barrier, alkaline burns continue to damage tissue until the chemical is removed or neutralized. The presence of black or gray powdery material in the mouth indicates the battery has been punctured. If swallowed intact, small batteries relative to the pet's size often pass through the GI tract without incident, though radiographic monitoring is recommended. Batteries that remain in the stomach for more than 48 hours may require removal. Heavy metal toxicity from battery contents is theoretically possible but has not been reported in clinical veterinary cases.",
                onsetTime: OnsetTime(
                    early: "Burns and oral ulceration may appear within 1-2 hours of exposure to battery contents; some ulcers take several hours to become visible",
                    delayed: "Full extent of caustic injury may take up to 24 hours to develop; esophageal strictures can develop 4-6 weeks post-exposure (rare)"
                ),
                symptoms: [
                    "Drooling or hypersalivation",
                    "Oral pain or pawing at mouth",
                    "Black or gray discoloration of teeth, gums, or tongue",
                    "Visible burns or ulcers in the mouth",
                    "Difficulty swallowing",
                    "Vomiting",
                    "Loss of appetite or refusal to eat",
                    "Abdominal pain",
                    "Lethargy",
                    "Fever (if secondary infection develops)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Most commonly affected species; caustic burns if battery is punctured; intact batteries often pass without issue in larger dogs"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Less likely to chew batteries than dogs; same caustic burn risk if battery contents are released"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size increases risk; even small batteries may cause obstruction; caustic burns more dangerous"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Caustic injury is serious; battery casing can cause crop or GI obstruction"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Limited data; caustic burns and obstruction risk; seek veterinary care")
                ],
                preventionTips: [
                    "Store batteries in a closed drawer or container out of pet reach",
                    "Dispose of used batteries promptly—don't leave them on counters or in trash cans pets can access",
                    "Check that battery compartments on devices are secure",
                    "Supervise pets around battery-operated toys",
                    "If a device is chewed, immediately check whether the batteries are intact or missing",
                    "Never leave remotes, flashlights, or other battery-containing items where pets can chew them"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Merck Veterinary Manual", "Vetlexicon"],
                relatedEntries: ["a1b2c3d4-5e6f-7a8b-9c0d-1e2f3a4b5c6d"]
            ),

            // MARK: - Silica Gel Packets
            ToxicItem(
                id: UUID(uuidString: "c3d4e5f6-7a8b-9c0d-1e2f-3a4b5c6d7e8f")!,
                name: "Silica Gel Packets",
                alternateNames: [
                    "Silica gel",
                    "Silica packets",
                    "Desiccant packets",
                    "Desiccant packs",
                    "Do not eat packets",
                    "Moisture absorber packets",
                    "Freshness packets",
                    "Shoe box packets",
                    "Electronics packets",
                    "Beef jerky packets",
                    "Medication packets"
                ],
                categories: [.householdItems],
                imageAsset: "silica_gel",
                description: "Silica gel packets are small paper or plastic sachets containing silica gel beads, used as desiccants (drying agents) to absorb moisture and protect products from humidity damage. They are commonly found in shoe boxes, electronics packaging, vitamin bottles, food products, leather goods, and pet treat bags. Despite the alarming 'DO NOT EAT' warning label, silica gel itself is essentially non-toxic. The warning exists because it is not a food product, not because it is poisonous. These packets are one of the most common reasons pet owners contact poison control, but they rarely cause significant problems.",
                toxicityInfo: "Silica gel is considered non-toxic to pets. The beads are inert, do not expand in the stomach, and pass through the digestive tract without being absorbed. At most, ingestion may cause mild, self-limiting gastrointestinal upset such as vomiting or diarrhea. The soft outer packaging poses minimal obstruction risk in most pets, though very small animals ingesting large or intact packets could theoretically develop a blockage. IMPORTANT: Some silica gel contains color-indicating beads (blue, orange, pink, or green) that may be coated with cobalt chloride—these are potentially more concerning in large quantities but still pose low risk. CRITICAL DISTINCTION: Do not confuse silica gel with iron-based oxygen absorbers found in jerky and food packages. Oxygen absorbers contain elemental iron, appear dark brown or rust-colored, and are MAGNETIC. Iron-containing packets are toxic and require veterinary attention.",
                onsetTime: OnsetTime(
                    early: "Mild vomiting or diarrhea may occur within a few hours if at all",
                    delayed: "Symptoms typically resolve within 24 hours; persistent signs are uncommon"
                ),
                symptoms: [
                    "Mild vomiting (uncommon)",
                    "Mild diarrhea (uncommon)",
                    "Decreased appetite (transient)",
                    "Drooling (if packet material irritates mouth)",
                    "Most pets show no symptoms at all"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Generally non-toxic; mild GI upset possible; no treatment usually needed for standard white/clear silica gel"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Non-toxic; cats less likely to ingest; monitor for mild GI upset"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Non-toxic; small risk of obstruction if large packet swallowed whole by very small pet"),
                    SpeciesRisk(species: .bird, severity: .low, notes: "Silica gel itself is non-toxic; physical obstruction possible if large pieces ingested"),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Non-toxic; unlikely to cause problems")
                ],
                preventionTips: [
                    "Discard silica gel packets when unpacking new products—don't leave them where pets can find them",
                    "Be especially careful with packets from food products, as they retain appealing food odors",
                    "Know the difference: silica gel (white/clear beads, non-toxic) vs. oxygen absorbers (dark brown, magnetic, contains iron—potentially toxic)",
                    "If your pet ingests a packet from a food product and you're unsure what it is, use a magnet to test—if it sticks, the packet may contain iron",
                    "Store pet treats in containers rather than original bags to avoid packet ingestion"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "PetMD", "Veterinary Information Network (VIN)"],
                relatedEntries: ["f6a7b8c9-0d1e-2f3a-4b5c-6d7e8f9a0b1c"]
            ),

            // MARK: - Glow Sticks
            ToxicItem(
                id: UUID(uuidString: "d4e5f6a7-8b9c-0d1e-2f3a-4b5c6d7e8f9a")!,
                name: "Glow Sticks",
                alternateNames: [
                    "Glow stick",
                    "Glow jewelry",
                    "Glow necklace",
                    "Glow necklaces",
                    "Glow bracelet",
                    "Glow bracelets",
                    "Glow-in-the-dark jewelry",
                    "Glow-in-the-dark sticks",
                    "Light sticks",
                    "Lightsticks",
                    "Chemiluminescent sticks",
                    "Rave sticks",
                    "Party glow sticks",
                    "Halloween glow sticks",
                    "Fourth of July glow sticks"
                ],
                categories: [.householdItems],
                imageAsset: "glow_sticks",
                description: "Glow sticks and glow jewelry (necklaces, bracelets) are popular novelty items sold at fairs, carnivals, concerts, and around holidays like Halloween and the Fourth of July. They contain dibutyl phthalate (DBP), an oily liquid that produces the characteristic glow through a chemical reaction. Despite the dramatic symptoms pets may display after biting into these products, glow sticks are considered low toxicity. The extremely bitter taste of dibutyl phthalate typically limits how much a pet will ingest.",
                toxicityInfo: "Dibutyl phthalate is the primary luminescent agent in glow products. It has low systemic toxicity (LD50 >8,000 mg/kg in rats), so serious poisoning is unlikely from the amounts in glow sticks. However, the intensely bitter taste causes dramatic immediate reactions—especially in cats. Signs appear within seconds of biting into the product and are primarily a taste aversion response rather than true poisoning. Cats tend to have much more exaggerated reactions than dogs, displaying profuse drooling, foaming, head shaking, and behavioral changes (hyperactivity, aggression, hiding). Dogs typically show milder reactions or none at all. The liquid can also irritate the skin and eyes on contact.",
                onsetTime: OnsetTime(
                    early: "Signs appear within seconds to minutes of biting into the glow stick—drooling, gagging, and behavioral changes occur almost immediately",
                    delayed: "Signs are self-limiting and typically resolve within 30-60 minutes once the taste is diluted; no delayed systemic effects expected"
                ),
                symptoms: [
                    "Profuse drooling and salivation",
                    "Foaming at the mouth",
                    "Gagging or retching",
                    "Vomiting (occasional)",
                    "Head shaking",
                    "Pawing at mouth",
                    "Hyperactivity or agitation (especially cats)",
                    "Aggression (especially cats)",
                    "Hiding behavior (especially cats)",
                    "Eye irritation if splashed (redness, pawing at eyes)",
                    "Skin irritation if liquid contacts fur"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Dogs may show mild drooling or no reaction at all; behavioral effects are rare; low toxicity"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Cats have more dramatic reactions to the bitter taste—profuse drooling, hyperactivity, aggression—but actual toxicity is still low; cats may re-expose themselves while grooming contaminated fur"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Expected to have taste aversion similar to cats; low toxicity"),
                    SpeciesRisk(species: .bird, severity: .low, notes: "Low toxicity; plastic casing could pose foreign body risk if ingested"),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Limited data; low toxicity expected")
                ],
                preventionTips: [
                    "Keep glow sticks and glow jewelry out of pet reach, especially around holidays",
                    "Dispose of used glow products in a secure trash container",
                    "Supervise children using glow products around pets—cats in particular are attracted to the movement",
                    "If a glow stick breaks, take the pet to a dark room to identify glowing residue on fur and clean it off",
                    "Remember that the dramatic drooling and behavioral signs look scary but are not dangerous"
                ],
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "PetMD", "Vetstreet"],
                relatedEntries: nil
            ),

            // MARK: - Electrical Cords & Electrocution
            ToxicItem(
                id: UUID(uuidString: "e5f6a7b8-9c0d-1e2f-3a4b-5c6d7e8f9a0b")!,
                name: "Electrical Cords & Electrocution",
                alternateNames: [
                    "Electrical cord",
                    "Electric cord",
                    "Electric cord injury",
                    "Electrical injury",
                    "Electrocution",
                    "Electrocution burn",
                    "Electric shock",
                    "Electrical shock",
                    "Power cord",
                    "Charging cable",
                    "Phone charger cord",
                    "Christmas light cords",
                    "Extension cord",
                    "Lamp cord",
                    "Appliance cord",
                    "Wire chewing",
                    "Cord chewing"
                ],
                categories: [.householdItems],
                imageAsset: "electrical_cords",
                description: "Electrical cord injuries occur when pets—most commonly puppies and kittens—chew on live electrical cords. This is the most common type of electrical injury in companion animals. When a pet bites through the protective covering of an energized wire, electrical current passes through their body, causing burns at the contact point (usually the mouth) and potentially affecting the heart, lungs, and nervous system. While oral burns are the most visible injury, the most serious complication is non-cardiogenic pulmonary edema (fluid in the lungs), which can be life-threatening and may not develop until hours after the incident.",
                toxicityInfo: "Electrical injury severity depends on the voltage, current type, duration of contact, and path through the body. Standard household current in the US is 110-120 volts (low voltage), which typically causes localized thermal burns where the electricity enters the body—usually the lips, tongue, gums, and palate. The current can also disrupt the heart's electrical activity, causing arrhythmias or cardiac arrest, and stimulate the nervous system in ways that lead to non-cardiogenic pulmonary edema (NCPE). NCPE occurs when the electrical shock triggers a massive sympathetic nervous system response, causing fluid to leak into the lungs. This is the most common life-threatening complication and may develop 12-36 hours after the incident—even in pets that initially appear fine. High-voltage electrocution (>1000 volts) from sources like power lines is usually immediately fatal.",
                onsetTime: OnsetTime(
                    early: "Burns and pain at the contact site are immediate; collapse, seizures, or cardiac arrest may occur at the time of shock",
                    delayed: "Non-cardiogenic pulmonary edema (fluid in lungs) may develop 12-36 hours after the incident; pets that seem fine initially can deteriorate"
                ),
                symptoms: [
                    "Burns on lips, tongue, gums, or palate (pale, yellow, tan, gray, or charred/black)",
                    "Singed whiskers or facial hair",
                    "Drooling or hypersalivation",
                    "Reluctance to eat or drink",
                    "Pain or crying when mouth is touched",
                    "Bad breath (halitosis)",
                    "Difficulty breathing or rapid breathing",
                    "Coughing (may produce frothy or blood-tinged fluid)",
                    "Blue or pale gums (cyanosis)",
                    "Weak or irregular pulse",
                    "Muscle stiffness or tremors",
                    "Collapse or loss of consciousness",
                    "Seizures",
                    "Sudden death (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Puppies are most commonly affected due to chewing behavior; oral burns common; pulmonary edema is the main life-threatening risk"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Kittens and young cats are most at risk; same concerns as dogs—oral burns and delayed pulmonary edema"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Rabbits and rodents may chew cords; small body size increases severity of electrical injury"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds may chew cords; small body size makes any electrical injury potentially fatal"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Less likely to chew cords but contact with faulty heating elements or lights in enclosures can cause electrical injury")
                ],
                preventionTips: [
                    "Keep electrical cords out of reach or cover them with protective tubing or cord covers",
                    "Unplug devices when not in use, especially around teething puppies and kittens",
                    "Provide appropriate chew toys to redirect chewing behavior",
                    "Supervise young pets closely and train them to avoid cords",
                    "Inspect cords regularly for damage and replace frayed or exposed wires immediately",
                    "Use cord management systems to bundle and hide cables",
                    "Be especially vigilant with holiday lights and decorations"
                ],
                sources: ["Veterinary Information Network (VIN)", "MSPCA-Angell Emergency Service", "PetMD", "Preventive Vet", "Vets Now UK", "Critical Care DVM"],
                relatedEntries: nil
            ),

            // MARK: - Iron-Containing Oxygen Absorbers
            ToxicItem(
                id: UUID(uuidString: "f6a7b8c9-0d1e-2f3a-4b5c-6d7e8f9a0b1c")!,
                name: "Iron-Containing Oxygen Absorbers",
                alternateNames: [
                    "Oxygen absorber",
                    "Oxygen absorber packet",
                    "Oxygen absorber sachet",
                    "Oxygen scavenger",
                    "Iron packet",
                    "Iron oxygen absorber",
                    "Freshness packet",
                    "Food preservative packet",
                    "Jerky packet",
                    "Beef jerky packet",
                    "Pet treat packet",
                    "Dog treat packet",
                    "Deoxidizer",
                    "Deoxidizer packet",
                    "Do not eat packet",
                    "Hand warmer",
                    "Hand warmers",
                    "Hand warmer packet",
                    "Disposable hand warmer",
                    "Hot Hands",
                    "HotHands",
                    "Grabber hand warmer",
                    "Toe warmer",
                    "Toe warmers",
                    "Body warmer packet",
                    "Heat pack",
                    "Heating packet"
                ],
                categories: [.householdItems],
                imageAsset: "oxygen_absorbers",
                description: "Iron-containing oxygen absorbers are small packets found in packages of dried foods such as beef jerky, pepperoni, dried fruits, and pet treats. Disposable hand warmers and toe warmers also contain elemental iron powder—when exposed to air, the iron oxidizes and generates heat. These products contain 50-70% elemental iron, which can cause serious iron poisoning if ingested. The packets are commonly confused with non-toxic silica gel desiccants, making identification difficult. While silica gel is essentially non-toxic, iron-containing packets can cause iron poisoning, particularly in small dogs. Hand warmers pose a seasonal risk during cold months when they are commonly carried in pockets, bags, and outdoor gear accessible to pets.",
                toxicityInfo: "Elemental iron can cause severe poisoning even in the small amounts contained in a single oxygen absorber packet. The iron content of these packets ranges from 50-70% total iron. Iron is highly irritating to the gastrointestinal tract and has direct corrosive effects, causing bloody vomiting and diarrhea. If a toxic dose is absorbed, iron overwhelms the body's protein carriers (transferrin and ferritin), and free iron causes oxidative damage to the liver and other organs. Severe metabolic acidosis, shock, and hepatic failure can develop 1-5 days after ingestion. Small dogs (<15 pounds) are at greatest risk—the most severe poisoning cases reported have occurred in small breed dogs. Larger dogs ingesting a single small packet are less likely to develop serious toxicity. Once iron has fully oxidized ('spent' absorbers), it becomes iron oxide, which has poor bioavailability and is less toxic—but the degree of oxidation cannot be determined by appearance.",
                onsetTime: OnsetTime(
                    early: "Vomiting (often with blood) typically occurs within 1-6 hours of ingestion; absence of vomiting suggests a non-toxic dose was ingested",
                    delayed: "Hepatic toxicity, metabolic acidosis, and shock may develop 1-5 days after exposure; a 'latent period' of apparent improvement may precede organ failure"
                ),
                symptoms: [
                    "Vomiting (often bloody or containing dark material)",
                    "Diarrhea (may be bloody or black/tarry)",
                    "Abdominal pain",
                    "Loss of appetite",
                    "Lethargy and weakness",
                    "Drooling",
                    "Pale gums",
                    "Rapid heart rate",
                    "Shock or collapse",
                    "Jaundice/icterus (yellowing of gums, skin, eyes—indicates liver damage)",
                    "Coagulopathy (bleeding disorders)",
                    "Seizures (severe cases)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs are most commonly affected—they get into treat bags containing these packets; small dogs (<15 lbs) at highest risk for serious poisoning"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Less commonly affected than dogs but equally susceptible to iron toxicity if ingested"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Small body size means even small amounts of iron can be dangerous; ferrets may be exposed via meat-based treats"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Highly susceptible to iron toxicity; small body size increases risk"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Limited data but presumed susceptible to iron toxicity")
                ],
                preventionTips: [
                    "Remove and discard oxygen absorber packets immediately when opening pet treats or human jerky products",
                    "Store treats in a separate container after removing the packet",
                    "Keep packages containing these packets out of pet reach—especially around holidays when treats may be wrapped as gifts",
                    "Learn to distinguish oxygen absorbers (dark brown/rust-colored contents, MAGNETIC) from silica gel (white/clear beads, not magnetic)",
                    "If your pet ingests a packet from food packaging, check with a magnet—if it sticks, the packet likely contains iron",
                    "Store hand warmers and toe warmers out of pet reach, especially during winter months",
                    "Dispose of used hand warmers in a sealed trash container—even 'spent' warmers may still contain some unoxidized iron",
                    "Keep outdoor gear containing hand warmers (gloves, jacket pockets, boots) away from curious pets"
                ],
                sources: ["Pet Poison Helpline", "Veterinary Information Network (VIN)", "Journal of Medical Toxicology (Brutlag et al., 2012)", "dvm360", "Animal Poisons Helpline (Australia)"],
                relatedEntries: ["c3d4e5f6-7a8b-9c0d-1e2f-3a4b5c6d7e8f"]
            ),

            // MARK: - Pennies & Zinc Objects
            ToxicItem(
                id: UUID(uuidString: "a7b8c9d0-1e2f-3a4b-5c6d-7e8f9a0b1c2d")!,
                name: "Pennies & Zinc Objects",
                alternateNames: [
                    "Penny",
                    "Pennies",
                    "Zinc penny",
                    "Zinc pennies",
                    "Coins",
                    "US penny",
                    "US pennies",
                    "Canadian penny",
                    "Canadian pennies",
                    "Zinc toxicity",
                    "Zinc poisoning",
                    "Zinc toxicosis",
                    "Zinc nuts",
                    "Zinc bolts",
                    "Zinc hardware",
                    "Galvanized metal",
                    "Galvanized nails",
                    "Galvanized screws",
                    "Zinc oxide",
                    "Diaper rash cream",
                    "Zinc supplement",
                    "Board game pieces",
                    "Monopoly pieces",
                    "Game tokens",
                    "Zipper pulls",
                    "Jewelry"
                ],
                categories: [.householdItems],
                imageAsset: "pennies_zinc",
                description: "US pennies minted after 1982 contain 97.5% zinc with a thin copper coating, making them a significant source of zinc toxicity when ingested by pets. Canadian pennies minted from 1997-2001 also contain 96% zinc. Dogs are most commonly affected due to their tendency to swallow foreign objects. Other zinc sources include galvanized hardware (nuts, bolts, nails), board game pieces, zippers, jewelry, and zinc-containing ointments (diaper rash creams, sunscreen). In the acidic environment of the stomach, zinc rapidly dissolves and is absorbed into the bloodstream, causing destruction of red blood cells (intravascular hemolysis).",
                toxicityInfo: "Zinc toxicosis causes intravascular hemolysis—destruction of red blood cells within the bloodstream. The acidic gastric environment promotes rapid dissolution and absorption of zinc from metallic sources. Once absorbed, zinc interferes with red blood cell metabolism, leading to oxidative damage and cell rupture. This releases hemoglobin into the bloodstream, which can damage the kidneys (acute renal failure) and cause severe anemia. A single post-1982 US penny contains enough zinc to be potentially fatal to dogs weighing less than 24 kg (about 53 lbs). Small dogs are at greatest risk because zinc-containing objects are more likely to remain in their stomachs rather than passing through. In up to 90% of zinc toxicosis cases, the source of zinc is never identified—diagnosis may occur without finding the offending object. Chronic low-level exposure from zinc-containing ointments can also cause toxicosis over time.",
                onsetTime: OnsetTime(
                    early: "Vomiting, depression, and loss of appetite typically appear within 1-2 days of ingestion",
                    delayed: "Hemolytic anemia and icterus (jaundice) may develop 2-4 days after ingestion; kidney failure can follow; signs resolve within 48-72 hours once the zinc source is removed"
                ),
                symptoms: [
                    "Vomiting",
                    "Diarrhea",
                    "Depression and lethargy",
                    "Loss of appetite (anorexia)",
                    "Weakness",
                    "Collapse",
                    "Pale gums (pallor)",
                    "Jaundice/icterus (yellow discoloration of gums, skin, whites of eyes)",
                    "Orange or red-brown urine (hemoglobinuria)",
                    "Increased thirst (polydipsia)",
                    "Increased urination (polyuria)",
                    "Rapid breathing",
                    "Rapid heart rate (tachycardia)",
                    "Abdominal pain",
                    "Seizures (severe cases)",
                    "Kidney failure signs (decreased urination, vomiting)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Most commonly affected species; dogs frequently swallow coins and small objects; small dogs (<24 kg) at greatest risk because objects more likely to remain in stomach"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Rare due to more selective eating habits, but equally susceptible to zinc toxicosis if ingestion occurs"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Small body size increases risk; ferrets may be attracted to shiny objects; very small amounts of zinc can be toxic"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Birds are highly susceptible to heavy metal toxicosis; zinc from cage hardware (galvanized wire) is a known cause of toxicity in pet birds"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Limited data; presumed susceptible to zinc toxicity")
                ],
                preventionTips: [
                    "Keep loose change in containers with secure lids, not in open dishes or jars",
                    "Be especially vigilant with small dogs—they are most at risk for serious zinc poisoning from a single penny",
                    "Supervise children during activities involving coins (piggy banks, coin-counting, magic tricks)",
                    "Check that galvanized hardware in bird cages is coated or replaced with stainless steel",
                    "Store zinc-containing ointments (diaper cream, sunscreen) out of pet reach and prevent licking when applied to people",
                    "Keep board games stored securely—game pieces and tokens often contain zinc",
                    "If your pet is diagnosed with zinc toxicosis from an unknown source, carefully search your home for accessible zinc objects"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Journal of Veterinary Emergency and Critical Care"],
                relatedEntries: nil
            ),

            // MARK: - Liquid Potpourri & Scented Products
            ToxicItem(
                id: UUID(uuidString: "b8c9d0e1-2f3a-4b5c-6d7e-8f9a0b1c2d3e")!,
                name: "Liquid Potpourri & Scented Products",
                alternateNames: [
                    "Liquid potpourri",
                    "Potpourri oil",
                    "Simmering potpourri",
                    "Scented oil",
                    "Fragrance oil",
                    "Room fragrance",
                    "Wax melts",
                    "Wax tarts",
                    "Candle melts",
                    "Scented wax",
                    "Wax warmer",
                    "Candle warmer",
                    "Oil warmer",
                    "Oil diffuser liquid",
                    "Reed diffuser oil",
                    "Dryer sheets",
                    "Fabric softener sheets",
                    "Scented sachets",
                    "Air freshener liquid",
                    "Plug-in air freshener refill",
                    "Scentsy",
                    "Glade plugins"
                ],
                categories: [.householdItems],
                imageAsset: "liquid_potpourri",
                description: "Liquid potpourri and similar scented products (wax melts, fragrance oils, dryer sheets) can cause significant injury to pets, particularly cats. These products typically contain a combination of essential oils and cationic detergents—both of which can cause tissue damage. Cats are especially vulnerable because they are attracted to warm, aromatic liquids and may drink from simmering potpourri pots or walk through spilled oils and then groom themselves. The cationic detergents in these products cause severe corrosive burns to mucous membranes, similar to alkaline injuries. Unlike dried potpourri (which primarily poses a foreign body risk), liquid forms cause direct chemical injury.",
                toxicityInfo: "Liquid potpourri and scented products cause injury through two mechanisms: essential oil toxicity and cationic detergent burns. Essential oils irritate mucous membranes and the GI tract, and can cause CNS depression, dermal hypersensitivity, and liver damage in cats. Cationic detergents (also found in fabric softeners and dryer sheets) are far more dangerous—they cause severe corrosive burns similar to alkaline injuries, with tissue necrosis of the mouth, tongue, esophagus, and stomach. Even small exposures can cause intense pain, ulceration, and difficulty eating or drinking. Dermal exposure (walking through spilled product, then grooming) can cause burns to the paws, skin ulceration, and systemic effects when groomed. Cats are at significantly higher risk than dogs due to their grooming behavior and sensitivity to essential oils. Solid candle wax, by contrast, is relatively non-toxic and primarily poses a GI upset or obstruction risk rather than chemical injury.",
                onsetTime: OnsetTime(
                    early: "Oral burns and pain occur immediately upon contact; drooling, pawing at mouth, and distress appear within minutes",
                    delayed: "Full extent of tissue damage may take 12-24 hours to develop; esophageal strictures can develop weeks later in severe cases"
                ),
                symptoms: [
                    "Intense drooling (hypersalivation)",
                    "Pawing at mouth or face",
                    "Oral ulcers and burns (tongue, gums, palate)",
                    "Difficulty swallowing (dysphagia)",
                    "Refusal to eat or drink",
                    "Vomiting",
                    "Vocalization or signs of pain",
                    "Red, ulcerated skin (if dermal exposure)",
                    "Eye irritation or corneal ulcers (if eye exposure)",
                    "Depression or lethargy",
                    "Difficulty breathing (if aspirated or severe swelling)",
                    "Tremors (if significant essential oil absorption)",
                    "Weakness or wobbliness (CNS depression from essential oils)",
                    "Fever"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .cat, severity: .high, notes: "Most commonly and severely affected; attracted to warm liquids; groom contaminated fur causing repeated exposure; sensitive to essential oils; cationic detergent burns are particularly severe"),
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Less commonly affected than cats; similar risk of corrosive burns if product is ingested; less likely to groom contaminated fur"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size increases risk; rabbits and ferrets that groom extensively are at higher risk from dermal exposure"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Respiratory system is sensitive to aerosolized oils; direct ingestion would cause crop and GI burns"),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Limited data; presumed at risk for corrosive injury if ingested")
                ],
                preventionTips: [
                    "Avoid using liquid potpourri simmers in homes with cats—cats are attracted to the warm, fragrant liquid and may attempt to drink it",
                    "Place wax warmers and oil diffusers in locations completely inaccessible to pets",
                    "Clean up any spilled fragrance oils immediately and thoroughly",
                    "Store dryer sheets in closed containers; dispose of used sheets in covered trash cans",
                    "If using plug-in air fresheners, ensure pets cannot reach or chew on the units",
                    "Consider switching to pet-safer alternatives like baking soda for odor control",
                    "If a pet walks through spilled product, wash paws immediately with mild dish soap and water to prevent grooming exposure",
                    "Keep reed diffusers out of reach—cats may knock them over and walk through the spilled oil"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Ice Packs
            ToxicItem(
                id: UUID(uuidString: "c9d0e1f2-3a4b-5c6d-7e8f-9a0b1c2d3e4f")!,
                name: "Ice Packs",
                alternateNames: [
                    "Ice pack",
                    "Gel ice pack",
                    "Reusable ice pack",
                    "Cold pack",
                    "Cold compress",
                    "Freezer pack",
                    "Lunch box ice pack",
                    "Cooler pack",
                    "Blue ice",
                    "Soft ice pack",
                    "Flexible ice pack",
                    "Instant cold pack",
                    "Chemical cold pack"
                ],
                categories: [.householdItems],
                imageAsset: "ice_packs",
                description: "Ice packs are a common source of concern when pets chew into them, but most household ice packs have low toxicity. Reusable gel ice packs typically contain water, cellulose (a starch-based thickener), urea, and propylene glycol. Propylene glycol is much less toxic than ethylene glycol (antifreeze) and generally does not cause serious problems unless consumed in very large quantities. Instant or 'chemical' cold packs that activate when squeezed contain ammonium nitrate, which can cause GI irritation and, rarely, chemical burns. Most ice pack ingestions result in mild GI upset or no symptoms at all.",
                toxicityInfo: "The primary ingredients in most reusable ice packs—cellulose, urea, and propylene glycol—are of low toxicity in dogs and cats. Propylene glycol can cause mild CNS depression (appearing 'drunk') at high doses, but this is uncommon with typical ice pack exposures. Urea is not a significant concern in monogastric animals like dogs and cats. In most cases, pets that chew into ice packs experience only mild vomiting or no symptoms at all. Instant cold packs containing ammonium nitrate are slightly more concerning—the chemical can cause GI irritation and, in rare cases, mucosal burns if a large amount is ingested. The physical gel material itself may cause mild GI upset but is not absorbed. This is generally a reassurance call for pet owners.",
                onsetTime: OnsetTime(
                    early: "Vomiting may occur within a few hours of ingestion, if at all",
                    delayed: "Symptoms are typically self-limiting; signs of inebriation from propylene glycol are rare but would appear within a few hours"
                ),
                symptoms: [
                    "Vomiting (most common, often mild)",
                    "Diarrhea (mild)",
                    "Drooling",
                    "Loss of appetite (transient)",
                    "Lethargy (uncommon)",
                    "Wobbliness or 'drunken' gait (rare, with large propylene glycol ingestion)",
                    "Most pets show no symptoms at all"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Most common species to chew into ice packs; usually only mild GI upset or no symptoms; monitor for vomiting"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Less likely to chew ice packs; same low risk profile as dogs"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Low toxicity expected; small body size means closer monitoring is prudent"),
                    SpeciesRisk(species: .bird, severity: .low, notes: "Unlikely exposure; low toxicity if small amount ingested"),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Unlikely exposure; limited data but low toxicity expected")
                ],
                preventionTips: [
                    "Store ice packs in the freezer or in closed coolers—don't leave them out where pets can chew on them",
                    "Discard damaged ice packs that are leaking gel",
                    "Supervise pets around coolers and lunch boxes containing ice packs",
                    "Consider using frozen water bottles as a pet-proof alternative to gel packs"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Sunscreen
            ToxicItem(
                id: UUID(uuidString: "d0e1f2a3-4b5c-6d7e-8f9a-0b1c2d3e4f5a")!,
                name: "Sunscreen",
                alternateNames: [
                    "Sunblock",
                    "Sun lotion",
                    "Sun cream",
                    "SPF lotion",
                    "UV protection",
                    "Zinc oxide sunscreen",
                    "Mineral sunscreen",
                    "Baby sunscreen",
                    "Sport sunscreen",
                    "Spray sunscreen",
                    "Tanning lotion",
                    "After sun lotion"
                ],
                categories: [.householdItems],
                imageAsset: "sunscreen",
                description: "Sunscreen ingestion is a common concern when dogs chew on tubes or lick sunscreen off skin. Most sunscreen exposures cause only mild GI upset. However, some sunscreens contain ingredients that can cause more significant effects in large ingestions: zinc oxide (found in mineral/physical sunscreens) can potentially cause zinc toxicity, and salicylates (found in some chemical sunscreens as octisalate or homosalate) are aspirin-related compounds that can cause GI irritation or ulceration at high doses. In practice, most pets that ingest sunscreen vomit, which limits absorption and prevents serious toxicity.",
                toxicityInfo: "Sunscreen toxicity depends on the specific ingredients and amount ingested. Zinc oxide-based sunscreens could theoretically cause zinc toxicity, but in most cases the product irritates the stomach so much that pets vomit and self-decontaminate before absorbing a toxic dose. Salicylate-containing sunscreens (those with octisalate, homosalate, or other salicylate UV filters) pose a risk of aspirin-like toxicity at high doses—this can cause GI ulceration, but systemic effects (metabolic acidosis, bleeding disorders) typically require very large ingestions. The emollient base of sunscreens can cause mild GI upset, vomiting, and diarrhea. Ingestion of a small amount licked off skin is unlikely to cause problems. Ingestion of a significant portion of a tube warrants veterinary consultation to assess the specific ingredients and amount.",
                onsetTime: OnsetTime(
                    early: "Vomiting and GI upset typically occur within a few hours of ingestion",
                    delayed: "If salicylate toxicity occurs, GI ulceration signs may develop over 1-3 days; zinc toxicity (rare) would show hemolytic signs over 2-4 days"
                ),
                symptoms: [
                    "Vomiting (most common)",
                    "Diarrhea",
                    "Drooling",
                    "Loss of appetite",
                    "Abdominal discomfort",
                    "Lethargy",
                    "Black or tarry stools (indicates GI bleeding—seek veterinary care)",
                    "Pale gums (rare, with zinc toxicity)",
                    "Orange or dark urine (rare, with zinc toxicity)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Most commonly affected; usually only GI upset; large ingestions of zinc oxide or salicylate-containing products warrant veterinary consultation"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Cats are more sensitive to salicylates than dogs; even moderate ingestion warrants veterinary consultation"),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size increases relative dose; veterinary consultation recommended for any significant ingestion"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Limited data; small body size means even small amounts could be significant"),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Unlikely exposure; limited data available")
                ],
                preventionTips: [
                    "Store sunscreen tubes and bottles out of pet reach, especially at the beach or pool",
                    "Don't leave sunscreen in bags or beach totes accessible to dogs",
                    "Prevent pets from licking sunscreen off your skin after application—distract them until it absorbs",
                    "Be especially careful with spray sunscreens around pets to avoid inhalation",
                    "If using sunscreen on pets (as sometimes recommended for hairless or light-skinned dogs), use only pet-safe products approved by your veterinarian"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: ["a7b8c9d0-1e2f-3a4b-5c6d-7e8f9a0b1c2d"]
            ),

            // MARK: - Magnets
            ToxicItem(
                id: UUID(uuidString: "e1f2a3b4-5c6d-7e8f-9a0b-1c2d3e4f5a6b")!,
                name: "Magnets",
                alternateNames: [
                    "Magnet",
                    "Rare earth magnet",
                    "Neodymium magnet",
                    "Refrigerator magnet",
                    "Fridge magnet",
                    "Magnetic toys",
                    "Magnetic building blocks",
                    "Magnetic balls",
                    "Buckyballs",
                    "Magnetic beads",
                    "Magnetic jewelry",
                    "Magnetic clasps"
                ],
                categories: [.householdItems],
                imageAsset: "magnets",
                description: "Magnet ingestion is a physical hazard rather than a toxicity concern. A single magnet that is swallowed will often pass through the GI tract without incident. However, ingestion of multiple magnets—or a magnet plus a metallic object—creates a serious and potentially life-threatening situation. If two or more magnets are in different loops of intestine, they can attract each other through the intestinal walls, trapping tissue between them. This causes pressure necrosis, leading to tissue death, perforation, and potentially fatal peritonitis. Small, powerful rare earth magnets (neodymium) found in toys, jewelry, and household items are particularly dangerous because of their strong attractive force.",
                toxicityInfo: "Magnets do not cause chemical toxicity—the danger is purely mechanical. When multiple magnets (or a magnet and a metal object) are swallowed, they may attract each other while in different sections of the intestine. The tissue caught between them undergoes pressure necrosis, which can lead to perforation within hours to days. This is a surgical emergency. A single magnet is much less concerning and will often pass on its own, though monitoring (and sometimes induced vomiting if recent and the magnet is still in the stomach) is recommended. The strength of rare earth magnets makes them especially hazardous—even small magnets can exert enough force to cause tissue damage. X-rays cannot always distinguish between a single magnet and multiple stacked magnets, so the history of how many magnets are missing is critically important.",
                onsetTime: OnsetTime(
                    early: "If multiple magnets attract across bowel walls, signs of abdominal pain may develop within hours",
                    delayed: "Perforation and peritonitis can develop over 1-3 days; a single magnet may pass without any symptoms over 1-5 days"
                ),
                symptoms: [
                    "Vomiting",
                    "Loss of appetite",
                    "Abdominal pain (hunched posture, reluctance to move)",
                    "Lethargy and depression",
                    "Diarrhea or absence of stool",
                    "Fever (if perforation occurs)",
                    "Abdominal distension",
                    "Signs of shock (pale gums, rapid heart rate, weakness)",
                    "Single magnet ingestion may cause no symptoms"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "High risk if MULTIPLE magnets ingested; single magnet often passes without issue; small dogs at higher risk for obstruction"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Same risk as dogs; less likely to ingest magnets but serious if multiple are swallowed"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "Small GI tract increases perforation risk; even small magnets can cause obstruction; ferrets are curious and may ingest small objects"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Very high risk due to small body size and delicate GI tract; multiple magnets would likely cause rapid perforation"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Limited data; presumed high risk with multiple magnets due to risk of intestinal trapping")
                ],
                preventionTips: [
                    "Keep magnetic toys, building sets, and craft supplies stored securely away from pets",
                    "Supervise children playing with magnetic toys—dropped magnets can be quickly grabbed by curious dogs",
                    "Be aware that some jewelry and bag clasps contain small but powerful magnets",
                    "If a magnet goes missing during play, search thoroughly before assuming it wasn't ingested",
                    "If you suspect your pet swallowed magnets, try to determine exactly how many are missing—this information is critical for your veterinarian",
                    "Rare earth magnets (small, silver, very strong) are more dangerous than traditional ceramic refrigerator magnets"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Journal of Veterinary Emergency and Critical Care", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Superglue
            ToxicItem(
                id: UUID(uuidString: "f2a3b4c5-6d7e-8f9a-0b1c-2d3e4f5a6b7c")!,
                name: "Superglue",
                alternateNames: [
                    "Super glue",
                    "Cyanoacrylate",
                    "Cyanoacrylate glue",
                    "Krazy Glue",
                    "Crazy Glue",
                    "Instant glue",
                    "CA glue",
                    "Nail glue",
                    "Eyelash glue",
                    "Surgical glue",
                    "Skin glue",
                    "Loctite",
                    "Quick bond glue"
                ],
                categories: [.householdItems],
                imageAsset: "superglue",
                description: "Superglue (cyanoacrylate) is a fast-bonding adhesive found in households, craft supplies, and even medical settings. When pets bite into superglue tubes or get glue on their fur or paws, the glue rapidly hardens upon contact with moisture (including saliva). Once solidified, cyanoacrylate is chemically inert and non-toxic—if swallowed, the hardened glue typically passes through the GI tract without issue. The primary concern is not toxicity but physical adhesion: superglue can bond body parts together, most commonly gluing eyelids shut or adhering the tongue to the roof of the mouth. These situations require veterinary care for safe separation.",
                toxicityInfo: "Cyanoacrylate glue has very low toxicity. Upon contact with saliva or other moisture, it solidifies almost instantly into an inert, non-absorbable mass. If a pet swallows hardened superglue, it will typically pass through the digestive tract without causing harm. The real danger is mechanical, not chemical: wet glue can bond skin to skin, eyelids shut, lips together, or the tongue to the roof of the mouth. Liquid glue may also cause mild irritation to mucous membranes before it hardens. Importantly, superglue is very different from polyurethane expanding glues (like Gorilla Glue Original)—expanding glues are far more dangerous because they foam and expand in the stomach, requiring surgical removal.",
                onsetTime: OnsetTime(
                    early: "Adhesion occurs within seconds of contact with moist tissue; mild oral irritation may be noted immediately",
                    delayed: "No delayed toxicity expected; hardened glue passes through GI tract over 1-3 days if swallowed"
                ),
                symptoms: [
                    "Pawing at mouth or face",
                    "Difficulty opening mouth (if tongue or lips adhered)",
                    "Unable to open eyes (if eyelids glued shut)",
                    "Drooling",
                    "Distress or vocalization",
                    "Gagging (if glue hardens in mouth)",
                    "Mild oral irritation",
                    "Fur matting (if glue on coat)",
                    "Most pets show no symptoms if glue was swallowed after hardening"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Low toxicity; main concern is adhesion of eyelids, lips, or tongue; hardened glue passes safely if swallowed"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Same low toxicity as dogs; may get glue on paws and transfer to face during grooming; eyelid adhesion possible"),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Low toxicity but small mouth size increases risk of significant adhesion problems; veterinary care recommended if mouth or eyes involved"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Low toxicity but beak or eye adhesion could impair eating or vision; small body size warrants closer monitoring"),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Low toxicity; adhesion to scales or eyes is the primary concern")
                ],
                preventionTips: [
                    "Store superglue in closed drawers or containers—small tubes are easy for pets to chew",
                    "Work with superglue in areas where pets cannot access",
                    "Dispose of used or dried-out glue tubes in covered trash cans",
                    "Be especially careful with nail glue and eyelash glue, which are often left on countertops",
                    "Know the difference: superglue (cyanoacrylate) is low toxicity; expanding glues like Gorilla Glue Original are dangerous and require emergency care"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Soaps & Mild Detergents
            ToxicItem(
                id: UUID(uuidString: "11223344-5566-7788-99aa-bbccddeeff00")!,
                name: "Soaps & Mild Detergents",
                alternateNames: [
                    "Dish soap",
                    "Dishwashing liquid",
                    "Hand soap",
                    "Body wash",
                    "Shampoo",
                    "Pet shampoo",
                    "Liquid hand soap",
                    "Bar soap",
                    "Castile soap",
                    "Dawn dish soap",
                    "Palmolive",
                    "Ivory soap",
                    "Body soap",
                    "Bubble bath",
                    "Hand wash",
                    "Shower gel",
                    "Anionic detergent",
                    "Non-ionic detergent",
                    "Mild detergent",
                    "Surfactant"
                ],
                categories: [.cleaningProducts],
                imageAsset: "soaps_detergents",
                description: "Soaps and mild detergents—including hand soap, dish soap, shampoo, and body wash—are among the most common household products pets encounter. These products contain anionic or non-ionic surfactants, which are gastrointestinal irritants but have very low systemic toxicity. While ingestion typically causes only mild, self-limiting symptoms like drooling, vomiting, or diarrhea, these products can also cause eye irritation if splashed into the eyes. Mild detergents are very different from cationic detergents (found in fabric softeners and some disinfectants), which are more corrosive and dangerous.",
                toxicityInfo: "Anionic and non-ionic detergents found in most household soaps and dish detergents have low toxicity. They work by disrupting surface tension, which can irritate the gastrointestinal tract and cause vomiting or diarrhea. However, these effects are typically mild and self-limiting. Large ingestions may cause more significant vomiting (occasionally with blood) and can lead to dehydration if vomiting is prolonged. A more serious concern is aspiration—if a pet inhales liquid detergent during vomiting, it can cause chemical pneumonitis with respiratory distress. Eye exposure causes mild irritation but rarely results in corneal injury. These products are fundamentally different from concentrated detergent pods, automatic dishwasher detergent, or cationic detergents—all of which are more dangerous.",
                onsetTime: OnsetTime(
                    early: "Drooling, vomiting, and mild GI upset typically appear within 15-30 minutes of ingestion",
                    delayed: "Symptoms usually resolve within a few hours; prolonged vomiting may cause dehydration"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vomiting",
                    "Diarrhea",
                    "Decreased appetite",
                    "Lethargy",
                    "Pawing at mouth (due to taste)",
                    "Eye redness or squinting (if eye exposure)",
                    "Coughing or difficulty breathing (if aspirated—seek immediate veterinary care)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .low, notes: "Low toxicity; most cases involve only mild, self-limiting GI upset; large ingestions or aspiration warrant veterinary consultation"),
                    SpeciesRisk(species: .cat, severity: .low, notes: "Same low toxicity as dogs; may develop respiratory sounds after grooming sodium lauryl sulfate from fur; monitor breathing"),
                    SpeciesRisk(species: .smallMammal, severity: .low, notes: "Low toxicity; small body size means even mild dehydration from vomiting warrants closer monitoring"),
                    SpeciesRisk(species: .bird, severity: .moderate, notes: "Low toxicity but birds are more sensitive to respiratory irritants; any breathing difficulty requires immediate veterinary care"),
                    SpeciesRisk(species: .reptile, severity: .low, notes: "Limited data; GI irritation expected; monitor for lethargy or appetite changes")
                ],
                preventionTips: [
                    "Store dish soap and hand soap in cabinets rather than on counter edges pets can reach",
                    "Rinse pet bowls thoroughly after washing with soap",
                    "Don't leave buckets of soapy water unattended—curious pets may drink from them",
                    "If soap contacts your pet's eyes, flush gently with water and contact your veterinarian if irritation persists"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Pet Poison Helpline"],
                relatedEntries: ["b8c9d0e1-2f3a-4b5c-6d7e-8f9a0b1c2d3e"]
            ),

            // MARK: - Bleach
            ToxicItem(
                id: UUID(uuidString: "22334455-6677-8899-aabb-ccddeeff0011")!,
                name: "Bleach",
                alternateNames: [
                    "Sodium hypochlorite",
                    "Household bleach",
                    "Chlorine bleach",
                    "Clorox",
                    "Liquid bleach",
                    "Laundry bleach",
                    "Disinfecting bleach",
                    "Ultra bleach",
                    "Concentrated bleach",
                    "Color-safe bleach",
                    "Oxygen bleach",
                    "Non-chlorine bleach",
                    "Sodium perborate",
                    "Sodium percarbonate",
                    "Hydrogen peroxide bleach",
                    "OxiClean",
                    "Pool chlorine",
                    "Calcium hypochlorite",
                    "Pool shock"
                ],
                categories: [.cleaningProducts],
                imageAsset: "bleach",
                description: "Bleach is one of the most common household cleaning products, used for disinfection and stain removal. Household liquid bleach typically contains 3-6% sodium hypochlorite with a pH around 11, making it a mild-to-moderate irritant. Most pet exposures involve diluted bleach (from mopping water or cleaned surfaces) and cause only mild symptoms. However, concentrated bleach products, 'ultra' bleach (>6% concentration), and pool chlorination products (up to 70-80% concentration) can cause significant corrosive injury. Color-safe or 'oxygen' bleaches contain hydrogen peroxide or percarbonates instead of chlorine and tend to cause more vomiting but are generally less corrosive.",
                toxicityInfo: "The severity of bleach exposure depends on concentration, pH, and the amount ingested. Diluted household bleach typically causes only mild gastrointestinal irritation—drooling, vomiting, and possibly diarrhea. Concentrated products with sodium hypochlorite above 10% or pH above 11 can cause burns to the mouth, esophagus, and stomach. Color-safe bleaches release hydrogen peroxide on contact with water, often causing protracted vomiting but rarely serious injury at household concentrations. Inhalation of bleach fumes can irritate the respiratory tract, causing coughing, wheezing, and difficulty breathing. A critical safety note: mixing bleach with ammonia-containing products produces toxic chloramine gas, which can cause severe respiratory distress in both pets and humans.",
                onsetTime: OnsetTime(
                    early: "Drooling, vomiting, and oral irritation typically appear within minutes of ingestion; eye or skin irritation is immediate",
                    delayed: "Respiratory symptoms from fume inhalation may develop over several hours; esophageal strictures are a rare late complication of severe burns"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vomiting",
                    "Pawing at mouth",
                    "Oral redness or irritation",
                    "Strong bleach odor on breath or fur",
                    "Decreased appetite",
                    "Coughing or wheezing (if fumes inhaled)",
                    "Difficulty breathing (seek immediate veterinary care)",
                    "Eye redness, squinting, or tearing (if eye exposure)",
                    "Skin irritation or redness (if dermal exposure)",
                    "Mouth or esophageal burns (concentrated products—seek immediate veterinary care)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .moderate, notes: "Diluted bleach causes mild GI upset; concentrated products can cause burns; dogs may drink from mop buckets or lick cleaned floors"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Similar to dogs; cats may walk on bleached surfaces and ingest during grooming; some cats are attracted to the chlorine smell"),
                    SpeciesRisk(species: .smallMammal, severity: .moderate, notes: "Small body size increases relative exposure; respiratory effects may be more pronounced; keep away from freshly cleaned areas"),
                    SpeciesRisk(species: .bird, severity: .high, notes: "Birds are extremely sensitive to inhaled irritants including bleach fumes; never use bleach near birds without thorough ventilation; respiratory distress can be life-threatening"),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Bleach is commonly used to disinfect reptile enclosures; must be thoroughly rinsed and dried before returning animal; fume sensitivity less studied")
                ],
                preventionTips: [
                    "Never leave buckets of bleach solution unattended—pets may drink from them",
                    "Keep pets out of rooms while cleaning with bleach and until surfaces are dry and fumes have dissipated",
                    "Store bleach in secured cabinets; dogs can chew through plastic bottles",
                    "Never mix bleach with ammonia or other cleaners—the resulting fumes are toxic",
                    "Rinse pet bowls, toys, and bedding thoroughly after disinfecting with bleach",
                    "Use extra caution with birds—even diluted bleach fumes can cause respiratory distress"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Pet Poison Helpline"],
                relatedEntries: nil
            ),

            // MARK: - Drain Cleaners & Caustic Alkalis
            ToxicItem(
                id: UUID(uuidString: "33445566-7788-99aa-bbcc-ddeeff001122")!,
                name: "Drain Cleaners & Caustic Alkalis",
                alternateNames: [
                    "Drain opener",
                    "Drano",
                    "Liquid-Plumr",
                    "Lye",
                    "Caustic soda",
                    "Sodium hydroxide",
                    "Potassium hydroxide",
                    "Oven cleaner",
                    "Easy-Off",
                    "Industrial cleaner",
                    "Pipe cleaner",
                    "Clog remover",
                    "Alkaline cleaner",
                    "Caustic cleaner",
                    "Hair relaxer",
                    "Hair straightener",
                    "Ammonium hydroxide",
                    "Cement",
                    "Wet concrete"
                ],
                categories: [.cleaningProducts],
                imageAsset: "drain_cleaner",
                description: "Drain cleaners and other strongly alkaline products are among the most dangerous household chemicals pets can encounter. Products containing sodium hydroxide (lye), potassium hydroxide, or ammonium hydroxide with pH greater than 11 can cause severe, penetrating chemical burns. Unlike acids, which cause immediate pain that often limits exposure, alkaline products cause little pain on initial contact—allowing pets to swallow more before realizing something is wrong. The alkali rapidly penetrates deep into tissue, causing liquefactive necrosis (tissue dissolution). Damage continues for hours after exposure, and the full extent of injury may not be apparent for up to 12 hours. Esophageal burns, perforation, and stricture formation are serious risks.",
                toxicityInfo: "Strongly alkaline substances (pH >11) cause liquefactive necrosis—they dissolve fats, denature proteins, and penetrate deeply into tissue layers. This is fundamentally different from acidic burns, which cause surface coagulation that somewhat limits penetration. Because alkaline products are often tasteless and cause little immediate pain, pets may swallow significant amounts before showing distress. The initial injury can worsen for up to 12 hours as the alkali continues to penetrate tissue. Esophageal involvement is more common with alkaline products than with acids. Burns may initially appear white or gray, then turn black. Potential complications include esophageal or gastric perforation, secondary infection, and esophageal stricture formation during healing. CRITICAL: Do not induce vomiting—this re-exposes the esophagus to the caustic material. Do not attempt to neutralize with acids—this produces an exothermic reaction causing thermal burns.",
                onsetTime: OnsetTime(
                    early: "Drooling, vocalization, and difficulty swallowing may appear immediately or within minutes; however, significant pain and visible oral burns may be delayed",
                    delayed: "Full extent of tissue damage may not be apparent for 12 hours; esophageal strictures can develop weeks later during healing"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vocalization or crying (pain)",
                    "Pawing at mouth or face",
                    "Difficulty swallowing (dysphagia)",
                    "Refusal to eat or drink",
                    "Vomiting (may contain blood)",
                    "Oral redness, swelling, or ulceration",
                    "White, gray, or black lesions in mouth",
                    "Fever",
                    "Abdominal pain",
                    "Dark, tarry stool (melena)",
                    "Depression or lethargy",
                    "Difficulty breathing (if esophageal swelling or aspiration)",
                    "Skin burns or ulceration (if dermal exposure)",
                    "Eye pain, redness, or cloudiness (if eye exposure—emergency)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .severe, notes: "EMERGENCY—caustic burns to mouth, esophagus, and stomach can be life-threatening; do NOT induce vomiting; seek immediate veterinary care"),
                    SpeciesRisk(species: .cat, severity: .severe, notes: "EMERGENCY—same severe risk as dogs; cats may also be exposed by walking through spills and grooming; seek immediate veterinary care"),
                    SpeciesRisk(species: .smallMammal, severity: .severe, notes: "EMERGENCY—small body size makes any exposure extremely serious; esophageal and gastric burns can be rapidly fatal"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "EMERGENCY—crop and esophageal burns can be fatal; birds are also extremely sensitive to caustic fumes; immediate veterinary care essential"),
                    SpeciesRisk(species: .reptile, severity: .severe, notes: "EMERGENCY—caustic burns affect all species; contact with skin or mucous membranes requires immediate veterinary evaluation")
                ],
                preventionTips: [
                    "Store drain cleaners, oven cleaners, and other caustic products in locked cabinets—these are among the most dangerous household chemicals",
                    "Never leave open containers unattended, even briefly",
                    "Keep pets completely away from areas where these products are being used",
                    "Clean up any spills immediately and thoroughly",
                    "Consider using enzymatic or mechanical drain cleaning methods as safer alternatives",
                    "If working with wet concrete or cement, keep pets away from the work area until fully cured"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Pet Poison Helpline", "MSD Veterinary Manual"],
                relatedEntries: nil
            ),

            // MARK: - Automatic Dishwasher Detergent
            ToxicItem(
                id: UUID(uuidString: "44556677-8899-aabb-ccdd-eeff00112233")!,
                name: "Automatic Dishwasher Detergent",
                alternateNames: [
                    "Dishwasher detergent",
                    "Dishwasher soap",
                    "Dishwasher pods",
                    "Dishwasher tablets",
                    "Dishwasher pacs",
                    "Cascade",
                    "Finish",
                    "Finish Powerball",
                    "Cascade Platinum",
                    "Cascade ActionPacs",
                    "Electrasol",
                    "Electric dishwasher detergent",
                    "Machine dishwasher soap",
                    "Dishwasher powder",
                    "Rinse aid"
                ],
                categories: [.cleaningProducts],
                imageAsset: "dishwasher_detergent",
                description: "Automatic dishwasher detergent is fundamentally different from the mild dish soap used for hand-washing dishes. While hand dish soap contains gentle anionic surfactants, automatic dishwasher detergents are highly alkaline (pH often greater than 11) and can cause corrosive burns similar to drain cleaners. This is one of the most important distinctions pet owners need to understand: the 'dish soap' on your counter for hand-washing is low toxicity, but the detergent in your dishwasher (whether powder, gel, or pod) is a caustic product that can cause serious injury. Dishwasher pods are particularly concerning because their bright colors and compact size make them attractive to pets.",
                toxicityInfo: "Automatic dishwasher detergents have a pH greater than 11, placing them in the same caustic/corrosive category as drain cleaners and oven cleaners. At this pH, the product can cause liquefactive necrosis—deep, penetrating burns to the mouth, esophagus, and stomach. Unlike acidic products that cause immediate pain (limiting how much is consumed), alkaline products may not cause pain on initial contact, allowing pets to swallow more before showing distress. The full extent of tissue damage may not be apparent for up to 12 hours. Dishwasher pods pose additional risks: they are attractively colored, fit easily in a pet's mouth, and when bitten, the pressurized contents can be forcefully expelled and aspirated into the lungs. Do NOT induce vomiting after dishwasher detergent ingestion—this re-exposes damaged tissue to the caustic material.",
                onsetTime: OnsetTime(
                    early: "Drooling and oral discomfort may appear within minutes; alkaline burns may initially cause little pain despite significant injury",
                    delayed: "Full extent of tissue damage may not be apparent for 12 hours; esophageal strictures can develop weeks later"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Pawing at mouth",
                    "Difficulty swallowing (dysphagia)",
                    "Refusal to eat",
                    "Vomiting (may contain blood)",
                    "Oral redness, swelling, or ulceration",
                    "White or gray lesions in mouth",
                    "Abdominal pain",
                    "Lethargy or depression",
                    "Fever (may accompany oral inflammation)",
                    "Coughing or difficulty breathing (if aspirated—seek immediate veterinary care)",
                    "Eye irritation or injury (if splashed in eyes)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Caustic burns to mouth, esophagus, and stomach possible; dogs may bite into pods or lick residue from open dishwashers; do NOT induce vomiting"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Same caustic risk as dogs; cats may walk through spills and ingest during grooming; less likely to bite pods but still at risk"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size makes any exposure serious; caustic burns can be rapidly life-threatening"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Crop and esophageal burns can be fatal; respiratory system extremely sensitive to any aspirated material; immediate veterinary care essential"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Caustic injury affects all species; contact with oral mucosa requires immediate veterinary evaluation")
                ],
                preventionTips: [
                    "Store dishwasher detergent in a locked cabinet—this product is caustic, not just an irritant",
                    "Never leave dishwasher pods where pets can reach them; their bright colors make them attractive",
                    "Keep the dishwasher door closed; pets may lick detergent residue from racks or the door",
                    "Understand the difference: hand dish soap (Dawn, Palmolive) = low toxicity; automatic dishwasher detergent = caustic",
                    "If ingestion occurs, do NOT induce vomiting; contact your veterinarian immediately"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Pet Poison Helpline"],
                relatedEntries: ["11223344-5566-7788-99aa-bbccddeeff00", "33445566-7788-99aa-bbcc-ddeeff001122"]
            ),

            // MARK: - Laundry Detergent Pods
            ToxicItem(
                id: UUID(uuidString: "55667788-99aa-bbcc-ddee-ff0011223344")!,
                name: "Laundry Detergent Pods",
                alternateNames: [
                    "Laundry pods",
                    "Detergent pods",
                    "Laundry pacs",
                    "Laundry packets",
                    "Tide Pods",
                    "Tide Pacs",
                    "Gain Flings",
                    "All Mighty Pacs",
                    "Arm & Hammer pods",
                    "Persil discs",
                    "Single-use laundry detergent",
                    "Laundry capsules",
                    "Concentrated laundry detergent",
                    "Laundry sachets"
                ],
                categories: [.cleaningProducts],
                imageAsset: "laundry_pods",
                description: "Laundry detergent pods are single-use packets containing highly concentrated liquid detergent. While traditional liquid or powder laundry detergent typically causes only mild gastrointestinal upset if ingested, pods pose significantly greater risks. The concentrated formula, combined with the pressure inside the sealed pod, creates a dangerous situation when a pet bites into one: the contents can be forcefully expelled into the mouth and airway, leading to aspiration into the lungs. Dogs account for over 90% of pod poisoning cases, likely because they tend to bite down on objects with force. The bright colors and toy-like appearance of pods make them particularly attractive to curious pets.",
                toxicityInfo: "Laundry pods contain the same types of anionic and nonionic surfactants found in traditional laundry detergent, but in a much more concentrated form. When a pet bites a pod, two factors combine to increase danger: first, the concentrated detergent causes more severe irritation than diluted product; second, the pressurized contents burst out forcefully and can be aspirated into the lungs or swallowed in large amounts before the pet can spit it out. According to Pet Poison Helpline data, dogs exposed to laundry pods are nearly twice as likely to develop vomiting and coughing compared to those exposed to traditional laundry detergent. Approximately 20% of symptomatic pets develop respiratory signs including coughing, wheezing, and difficulty breathing. Aspiration pneumonia is the most serious complication. Ingestion of multiple pods also creates a risk of foreign body obstruction from the plastic casings.",
                onsetTime: OnsetTime(
                    early: "Vomiting, drooling, and oral irritation typically begin within minutes of biting into a pod",
                    delayed: "Respiratory symptoms (coughing, wheezing, difficulty breathing) may develop over 12-24 hours as aspiration pneumonia progresses"
                ),
                symptoms: [
                    "Profuse vomiting",
                    "Hypersalivation (drooling)",
                    "Pawing at mouth",
                    "Gagging or retching",
                    "Decreased appetite",
                    "Lethargy",
                    "Coughing",
                    "Wheezing",
                    "Difficulty breathing (dyspnea)",
                    "Rapid breathing",
                    "Eye irritation (if splashed in eyes)",
                    "Skin irritation (if on fur)",
                    "Diarrhea"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs account for >90% of pod poisonings; tendency to bite with force causes pressurized release; ~20% develop respiratory symptoms; monitor for aspiration pneumonia"),
                    SpeciesRisk(species: .cat, severity: .moderate, notes: "Less likely to bite into pods than dogs (~7% of cases); more likely to be exposed by walking through spills and grooming; monitor for respiratory signs"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size increases impact of concentrated detergent; respiratory system vulnerable to aspiration; prompt veterinary care recommended"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Extremely sensitive respiratory system; any aspiration can be rapidly fatal; immediate veterinary care essential if exposure suspected"),
                    SpeciesRisk(species: .reptile, severity: .moderate, notes: "Limited data; GI irritation expected; less risk of aspiration compared to mammals and birds")
                ],
                preventionTips: [
                    "Store laundry pods in a closed, secure container on a high shelf or in a locked cabinet",
                    "Never leave pods on top of the washing machine or in open containers—their bright colors attract pets",
                    "Keep laundry room doors closed if pods are accessible",
                    "If a pod falls on the floor, pick it up immediately—don't assume your pet won't be interested",
                    "Consider using traditional liquid or powder detergent if you have curious pets who get into things",
                    "If your pet bites into a pod, contact your veterinarian even if symptoms seem mild—respiratory problems can develop hours later"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Journal of Veterinary Emergency and Critical Care (Handley & Hovda, 2021)"],
                relatedEntries: ["11223344-5566-7788-99aa-bbccddeeff00", "44556677-8899-aabb-ccdd-eeff00112233"]
            ),

            // MARK: - Toilet Bowl Cleaners
            ToxicItem(
                id: UUID(uuidString: "66778899-aabb-ccdd-eeff-001122334455")!,
                name: "Toilet Bowl Cleaners",
                alternateNames: [
                    "Toilet cleaner",
                    "Toilet bowl cleaner",
                    "Toilet bowl drop-in",
                    "Toilet tank tablet",
                    "Toilet puck",
                    "Lysol Toilet Bowl Cleaner",
                    "Clorox Toilet Bowl Cleaner",
                    "The Works toilet cleaner",
                    "Lime-A-Way",
                    "Kaboom",
                    "Scrubbing Bubbles",
                    "2000 Flushes",
                    "Vanish drop-in",
                    "Blue toilet tablets",
                    "Toilet freshener",
                    "Acidic toilet cleaner",
                    "Hydrochloric acid cleaner"
                ],
                categories: [.cleaningProducts],
                imageAsset: "toilet_cleaner",
                description: "Toilet bowl cleaners are a variable hazard because they can be either strongly acidic OR strongly alkaline, depending on the product. Acidic cleaners (often containing hydrochloric acid or phosphoric acid) are designed to remove mineral deposits and rust stains. Alkaline cleaners (containing sodium hypochlorite or sodium hydroxide) are designed for disinfection and organic stain removal. Both types can cause corrosive burns in concentrated form. Toilet tank drop-ins and tablets are a common source of exposure—pets drink from toilet bowls, and while the diluted water usually causes only mild GI upset, some pets chew on or swallow the tablets themselves, which are much more concentrated and dangerous.",
                toxicityInfo: "The danger of toilet bowl cleaners depends on whether the product is acidic or alkaline, its concentration, and whether the pet ingested diluted toilet water or the concentrated product itself. Acidic toilet cleaners (pH <3.5) cause coagulative necrosis and immediate pain on contact—this pain often limits how much is consumed but can still cause serious burns. Alkaline toilet cleaners (pH >11) cause liquefactive necrosis that penetrates deeply into tissue; they may cause little initial pain, allowing larger ingestions. If a pet drinks from a toilet bowl containing a dissolved drop-in tablet, the diluted solution typically causes only mild GI upset. However, if a pet chews on or swallows an undissolved tablet or drinks undiluted cleaner left in the bowl, corrosive injury to the mouth, esophagus, and stomach is possible. Some toilet cleaners also contain bleach (sodium hypochlorite) or cationic detergents, adding additional toxic mechanisms.",
                onsetTime: OnsetTime(
                    early: "Acidic products: immediate pain, vocalization, drooling; Alkaline products: may have delayed pain despite tissue damage occurring",
                    delayed: "Full extent of alkaline burns may not be apparent for 12 hours; esophageal strictures can develop weeks later with severe burns"
                ),
                symptoms: [
                    "Hypersalivation (drooling)",
                    "Vocalization or crying (pain—especially with acidic products)",
                    "Pawing at mouth",
                    "Vomiting (may contain blood)",
                    "Diarrhea",
                    "Refusal to eat or drink",
                    "Difficulty swallowing",
                    "Oral redness, ulceration, or burns",
                    "White, gray, or black lesions in mouth (corrosive burns)",
                    "Abdominal pain",
                    "Lethargy",
                    "Blue or colored staining around mouth (if product contained dye)"
                ],
                speciesRisks: [
                    SpeciesRisk(species: .dog, severity: .high, notes: "Dogs commonly drink from toilets; diluted water causes mild GI upset, but concentrated product or tablets can cause corrosive burns; do NOT induce vomiting"),
                    SpeciesRisk(species: .cat, severity: .high, notes: "Cats also drink from toilets; same corrosive risk as dogs with concentrated products; may be attracted to blue dye in some products"),
                    SpeciesRisk(species: .smallMammal, severity: .high, notes: "Small body size makes any corrosive exposure serious; seek veterinary care promptly"),
                    SpeciesRisk(species: .bird, severity: .severe, notes: "Corrosive injury to crop and esophagus can be fatal; birds should never have access to bathrooms"),
                    SpeciesRisk(species: .reptile, severity: .high, notes: "Corrosive injury possible; limited data on specific effects")
                ],
                preventionTips: [
                    "Keep toilet lids closed at all times if your pet drinks from the toilet",
                    "If using drop-in tablets, ensure pets cannot access the toilet bowl",
                    "Store toilet bowl cleaners in locked cabinets—both acidic and alkaline products are corrosive",
                    "Never leave cleaner sitting in the bowl; rinse thoroughly after cleaning",
                    "If your pet chews on a toilet tablet or drinks undiluted cleaner, contact your veterinarian immediately—do NOT induce vomiting",
                    "Consider using pet-safe toilet cleaning alternatives if keeping pets out of bathrooms is difficult"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Pet Poison Helpline", "MSD Veterinary Manual"],
                relatedEntries: ["22334455-6677-8899-aabb-ccddeeff0011", "33445566-7788-99aa-bbcc-ddeeff001122"]
            )
        ]
    }

    func allToxicItems() -> [ToxicItem] {
        allItems
    }

    func items(for category: Category) -> [ToxicItem] {
        allItems.filter { $0.categories.contains(category) }
    }

    func item(withId id: UUID) -> ToxicItem? {
        allItems.first { $0.id == id }
    }

    func item(withIdString idString: String) -> ToxicItem? {
        guard let uuid = UUID(uuidString: idString) else { return nil }
        return item(withId: uuid)
    }

    func search(query: String, species: [Species]?) -> [ToxicItem] {
        let lowercasedQuery = query.lowercased()

        var results = allItems.filter { item in
            item.name.lowercased().contains(lowercasedQuery) ||
            item.alternateNames.contains { $0.lowercased().contains(lowercasedQuery) }
        }

        if let species = species, !species.isEmpty {
            results = results.filter { item in
                item.speciesRisks.contains { species.contains($0.species) }
            }
        }

        return results
    }
}
