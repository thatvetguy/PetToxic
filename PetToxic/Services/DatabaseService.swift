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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "VCA Animal Hospitals"]
            ),

            // MARK: - Avocado
            ToxicItem(
                id: UUID(),
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
                sources: ["Merck Veterinary Manual", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),

            // MARK: - Nutmeg
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "Pet Poison Helpline", "PetMD"]
            ),

            // MARK: - Salt
            ToxicItem(
                id: UUID(),
                name: "Salt",
                alternateNames: ["sodium chloride", "table salt", "rock salt", "de-icing salt", "road salt", "sea salt", "homemade play dough", "salt dough", "playdough", "paint balls", "sea water", "ocean water", "salty snacks"],
                categories: [.foods],
                imageAsset: "salt_playdough",
                description: "While small amounts of salt are a normal part of a pet's diet, excessive salt intake can cause sodium poisoning. Common sources include homemade play dough, rock salt (de-icers), sea water at the beach, paint balls, table salt, and very salty snacks like chips or pretzels.",
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
                    "Store rock salt and de-icing products securely; rinse pet paws after winter walks",
                    "Avoid sharing salty snacks like chips, pretzels, or salted popcorn with pets",
                    "Never use salt to induce vomiting—this can cause salt poisoning"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),

            // MARK: - Fatty Foods & Grease
            ToxicItem(
                id: UUID(),
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
                sources: ["Pet Poison Helpline", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual", "American Veterinary Medical Association (JAVMA)"]
            ),

            // MARK: - Cooked Bones
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "American Kennel Club", "FDA (U.S. Food and Drug Administration)"]
            ),

            // MARK: - Milk & Dairy Products
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "PetMD", "VCA Animal Hospitals", "Merck Veterinary Manual"]
            ),

            // MARK: - Black Walnuts
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN) - ASPCA APCC Case Series Study", "ASPCA Animal Poison Control Center", "Merck Veterinary Manual"]
            ),

            // MARK: - Fruit Pits & Seeds
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)"]
            ),

            // MARK: - Moldy Foods
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Lilies (True Lilies)
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Sago Palm
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Azalea & Rhododendron
            ToxicItem(
                id: UUID(),
                name: "Azalea & Rhododendron",
                alternateNames: ["azalea", "rhododendron", "Rhododendron spp", "rosebay", "great laurel", "wild honeysuckle", "azalea bush", "rhododendron bush"],
                categories: [.plants],
                imageAsset: "azalea",
                description: "Azaleas and rhododendrons are popular flowering shrubs found in gardens and landscaping throughout the United States, with particularly high concentrations in the Southeast. Azaleas are actually a subgroup of the Rhododendron genus — they share the same toxic compounds. These shrubs produce showy clusters of flowers in spring and are commonly used as ornamental plants in yards and gardens.",
                toxicityInfo: "All parts of the azalea and rhododendron plant are toxic, including the leaves, flowers, nectar, and pollen. The toxic compounds are grayanotoxins, which affect the heart and nervous system by interfering with sodium channels in cells. In most real-world cases, pets do not eat enough to cause severe toxicity — ASPCA data from 1,000 canine cases showed 29% developed vomiting and only 2% developed cardiac arrhythmias. However, large ingestions can cause serious cardiovascular effects including dangerous heart rhythm abnormalities, low blood pressure, and collapse. The toxin is not cumulative (repeated small exposures do not build up), but clinical signs — particularly cardiac effects — may persist for several days.",
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
                    "If you see your pet chewing on azalea, contact your veterinarian even if no symptoms are present yet"
                ],
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Tulips & Hyacinths
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "DVM360"]
            ),

            // MARK: - Oleander
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "DVM360"]
            ),

            // MARK: - Autumn Crocus
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Insoluble Calcium Oxalate Plants
            ToxicItem(
                id: UUID(),
                name: "Insoluble Calcium Oxalate Plants",
                alternateNames: ["Dieffenbachia", "dumbcane", "dumb cane", "Philodendron", "heartleaf philodendron", "split-leaf philodendron", "Pothos", "golden pothos", "devil's ivy", "Peace lily", "Spathiphyllum", "Calla lily", "Zantedeschia", "Caladium", "angel wings", "Elephant ear", "Alocasia", "Colocasia", "Arrowhead vine", "Syngonium", "Monstera", "Swiss cheese plant", "Chinese evergreen", "Aglaonema", "Anthurium", "flamingo flower", "flamingo lily", "Araceae", "aroid", "arum family", "calcium oxalate crystals", "raphides", "ZZ plant", "Zamioculcas zamiifolia", "Zanzibar gem", "eternity plant", "aroid palm", "emerald palm", "Raven ZZ", "ZZ Raven", "Schefflera", "Schefflera actinophylla", "Schefflera arboricola", "umbrella tree", "umbrella plant", "dwarf umbrella tree", "octopus tree", "starleaf", "Queensland umbrella tree", "Australian ivy palm"],
                categories: [.plants],
                imageAsset: "pothos_philodendron",
                description: "The Araceae (aroid) family includes many of the most popular houseplants: Dieffenbachia (dumbcane), Philodendron, Pothos (devil's ivy), Peace lily, Calla lily, Caladium, Elephant ear, Monstera, Chinese evergreen, Anthurium, and Arrowhead vine. These plants are favored because they tolerate low light and infrequent watering, making them common in homes and offices. According to the ASPCA Animal Poison Control Center, the Araceae family is the most common plant exposure reported in pets. Also included in this family is the increasingly popular ZZ plant (Zamioculcas zamiifolia), known for its glossy, dark green leaves and extreme tolerance of neglect. Schefflera (umbrella tree), while belonging to a different plant family (Araliaceae), also contains insoluble calcium oxalate crystals and causes the same localized oral irritation.",
                toxicityInfo: "These plants contain insoluble calcium oxalate crystals called raphides — microscopic needle-sharp structures bundled inside specialized cells. When a pet bites or chews the plant, these crystals are forcibly ejected into the mouth and throat tissues, causing immediate intense pain. The crystals also contain irritating compounds like proteases that worsen local inflammation. Importantly, because the crystals are insoluble, they are NOT absorbed into the bloodstream and do NOT cause kidney damage — the effects are limited to the mouth, tongue, and throat. While symptoms can look alarming to pet owners (dramatic drooling, pawing at the mouth), the condition is generally self-limiting. The concentration of calcium oxalate varies between plants, so some cause more irritation than others. Note: 'Mother-in-law's tongue' can refer to both Dieffenbachia (covered here) and Snake Plant (Sansevieria), which contains different toxins — see separate entry for Snake Plant.\n\n**ZZ Plant (Zamioculcas zamiifolia)** — Despite sometimes being marketed as 'pet-safe,' ZZ plants are members of the Araceae family and contain the same insoluble calcium oxalate crystals. Chewing on the leaves or stems causes the same immediate oral pain and irritation as other plants in this group. The sap can also cause skin irritation on contact. Effects are localized and self-limiting — no systemic toxicity occurs.\n\n**Schefflera (Umbrella Tree)** — This popular indoor tree contains insoluble calcium oxalate crystals identical to those found in Araceae plants. Chewing on the leaves causes immediate oral pain, drooling, and pawing at the mouth. Effects are localized and self-limiting — no systemic toxicity occurs. The dwarf variety (Schefflera arboricola) is more common as a houseplant than the larger Queensland umbrella tree (Schefflera actinophylla).",
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
                sources: ["ASPCA Animal Poison Control Center", "Veterinary Information Network (VIN)", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Soluble Calcium Oxalate Plants
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Daffodils
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Canadian Veterinary Journal (case report)"]
            ),

            // MARK: - Foxglove
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "VETgirl"]
            ),

            // MARK: - Lily of the Valley
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "JAVMA (case report)"]
            ),

            // MARK: - Castor Beans
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "PubMed (case studies)"]
            ),

            // MARK: - Wild Mushrooms
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "North American Mycological Association (NAMA)", "VCA Animal Hospitals", "UC Davis School of Veterinary Medicine"]
            ),

            // MARK: - Blue-Green Algae (Cyanobacteria)
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "EPA (Environmental Protection Agency)"]
            ),

            // MARK: - Yew
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Snake Plant & Dracaena
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "University of North Carolina Department of Horticultural Science", "Wag Walking Veterinary Resources"]
            ),

            // MARK: - Aloe Vera
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Wag Walking Veterinary Resources"]
            ),

            // MARK: - Morning Glory
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - Cyanogenic Glycoside Plants
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Merck Veterinary Manual"]
            ),

            // MARK: - GI Irritant Plants
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "VCA Animal Hospitals"]
            ),

            // MARK: - Brunfelsia (Yesterday, Today and Tomorrow)
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "dvm360 (ASPCA APCC case review)"]
            ),

            // MARK: - Kalanchoe
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Medicine (peer-reviewed journal)"]
            ),

            // MARK: - English Ivy
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),

            // MARK: - Wisteria
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),

            // MARK: - Milkweed
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline"]
            ),

            // MARK: - Larkspur & Delphinium
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)"]
            ),

            // MARK: - Horse Chestnut & Buckeye
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Clinical Veterinary Toxicology (Plumlee)"]
            ),

            // MARK: - Tomato & Potato Plants
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Vetlexicon - Plant Poisoning: Solanine and Related Glycoalkaloids"]
            ),

            // MARK: - Lantana
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Information Network (VIN)", "Merck Veterinary Manual"]
            ),

            // MARK: - Cyclamen
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "PMC - Toxicity of House Plants to Pet Animals (peer-reviewed)", "WagWalking Veterinary Resources"]
            ),

            // MARK: - Bird of Paradise (Caesalpinia)
            ToxicItem(
                id: UUID(),
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
                sources: ["ASPCA Animal Poison Control Center", "Pet Poison Helpline", "WagWalking Veterinary Resources", "Hunker Home & Garden"]
            ),

            // MARK: - Cannabis / Marijuana
            ToxicItem(
                id: UUID(),
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
                sources: ["Veterinary Information Network (VIN)", "ASPCA Animal Poison Control Center", "Pet Poison Helpline", "Veterinary Partner"]
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
