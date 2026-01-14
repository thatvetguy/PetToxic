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
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "Veterinary Information Network (VIN)", "VCA Animal Hospitals"]
            ),

            // MARK: - Grapes & Raisins
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"]
            ),

            // MARK: - Xylitol
            ToxicItem(
                id: UUID(),
                name: "Xylitol",
                alternateNames: ["birch sugar", "wood sugar", "birch bark extract", "sugar alcohol", "E967"],
                categories: [.foods],
                imageAsset: "xylitol",
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"]
            ),

            // MARK: - Onions
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"]
            ),

            // MARK: - Garlic
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "Veterinary Information Network (VIN)"]
            ),

            // MARK: - Macadamia Nuts
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Alcohol
            ToxicItem(
                id: UUID(),
                name: "Alcohol",
                alternateNames: ["ethanol", "ethyl alcohol", "beer", "wine", "liquor", "spirits", "vodka", "whiskey", "rum", "cocktail", "isopropanol", "isopropyl alcohol", "rubbing alcohol", "methanol", "methyl alcohol", "wood alcohol", "hand sanitizer"],
                categories: [.foods, .recreationalSubstances],
                imageAsset: "alcohol",
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "VCA Animal Hospitals"]
            ),

            // MARK: - Raw Yeast Dough
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual", "VCA Animal Hospitals"]
            ),

            // MARK: - Caffeine
            ToxicItem(
                id: UUID(),
                name: "Caffeine",
                alternateNames: ["coffee", "coffee beans", "coffee grounds", "espresso", "tea", "tea bags", "green tea", "black tea", "energy drinks", "Red Bull", "Monster", "soda", "cola", "diet pills", "caffeine pills", "NoDoz", "Vivarin", "pre-workout", "guarana"],
                categories: [.foods],
                imageAsset: "caffeine",
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "VCA Animal Hospitals"]
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
