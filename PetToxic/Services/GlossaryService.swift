//
//  GlossaryService.swift
//  PetToxic
//
//  Created by Claude Code on 2/2/26.
//

import Foundation

class GlossaryService {
    static let shared = GlossaryService()

    private(set) var terms: [GlossaryTerm] = []

    private init() {
        loadTerms()
    }

    // MARK: - Computed Properties

    /// All terms sorted alphabetically by term name
    var sortedTerms: [GlossaryTerm] {
        terms.sorted { $0.term.lowercased() < $1.term.lowercased() }
    }

    /// Terms grouped by first letter for section headers
    var termsByLetter: [String: [GlossaryTerm]] {
        Dictionary(grouping: sortedTerms) { term in
            String(term.term.prefix(1)).uppercased()
        }
    }

    /// Sorted array of letters that have terms (for section headers)
    var availableLetters: [String] {
        termsByLetter.keys.sorted()
    }

    /// Terms filtered by category
    func terms(in category: GlossaryCategory) -> [GlossaryTerm] {
        sortedTerms.filter { $0.category == category }
    }

    // MARK: - Search

    /// Search terms by term name, definition, and search keywords
    func search(_ query: String) -> [GlossaryTerm] {
        guard !query.isEmpty else { return sortedTerms }

        let lowercased = query.lowercased()
        return sortedTerms.filter { term in
            term.term.lowercased().contains(lowercased) ||
            term.definition.lowercased().contains(lowercased) ||
            (term.searchKeywords?.contains { $0.lowercased().contains(lowercased) } ?? false)
        }
    }

    /// Get a specific term by name (for related terms linking)
    func term(named name: String) -> GlossaryTerm? {
        terms.first { $0.term.lowercased() == name.lowercased() }
    }

    // MARK: - Data Loading

    private func loadTerms() {
        terms = Self.allTerms
    }

    // MARK: - Glossary Terms Data

    static let allTerms: [GlossaryTerm] = [

        // ══════════════════════════════════════════════════════════════
        // MARK: - Symptoms & Signs
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000001")!,
            term: "Ataxia",
            pronunciation: "ah-TAK-see-ah",
            definition: "Loss of coordination and balance caused by nervous system dysfunction. Affected pets may stumble, sway, or walk as if drunk. This is often one of the first visible signs of neurological toxicity and warrants immediate veterinary attention.",
            category: .symptoms,
            relatedTerms: ["Tremors", "Seizures", "CNS Depression"],
            searchKeywords: ["wobbly", "uncoordinated", "stumbling", "drunk walking", "balance"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000002")!,
            term: "Bradycardia",
            pronunciation: "brad-ee-KAR-dee-ah",
            definition: "Abnormally slow heart rate. In pets, this can indicate serious toxicity affecting the heart's electrical system. Signs may include weakness, lethargy, and collapse. Common with certain plant toxins (oleander, foxglove) and some medications.",
            category: .symptoms,
            relatedTerms: ["Tachycardia", "Arrhythmia"],
            searchKeywords: ["slow heart", "slow pulse", "heart rate"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000003")!,
            term: "Tachycardia",
            pronunciation: "tak-ee-KAR-dee-ah",
            definition: "Abnormally fast heart rate. Can occur with stimulant toxins (caffeine, chocolate, amphetamines) or as a response to pain, fever, or anxiety. Severe tachycardia can lead to heart failure if untreated.",
            category: .symptoms,
            relatedTerms: ["Bradycardia", "Arrhythmia"],
            searchKeywords: ["fast heart", "rapid heart", "racing heart", "heart rate"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000004")!,
            term: "Seizures",
            pronunciation: "SEE-zhurz",
            definition: "Uncontrolled electrical disturbances in the brain causing convulsions, muscle twitching, or loss of consciousness. Seizures are a medical emergency requiring immediate veterinary care. Many toxins can cause seizures, including certain plants, medications, and rodenticides.",
            category: .symptoms,
            relatedTerms: ["Tremors", "Ataxia"],
            searchKeywords: ["convulsions", "fits", "epilepsy", "convulsing"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000005")!,
            term: "Tremors",
            pronunciation: "TREM-orz",
            definition: "Involuntary, rhythmic shaking movements of the body or limbs. Unlike seizures, the pet typically remains conscious during tremors. Can indicate neurotoxicity from substances like mycotoxins (moldy food), certain medications, or organophosphate pesticides.",
            category: .symptoms,
            relatedTerms: ["Seizures", "Ataxia"],
            searchKeywords: ["twitching", "muscle tremors"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Conditions
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000006")!,
            term: "Methemoglobinemia",
            pronunciation: "met-HEE-moh-glo-bin-EE-mee-ah",
            definition: "A condition where hemoglobin in red blood cells is converted to methemoglobin, which cannot carry oxygen effectively. The blood may appear chocolate-brown. Affected animals show blue or gray gums (cyanosis), weakness, and difficulty breathing. Common causes include acetaminophen (especially in cats), onions, garlic, and benzocaine.",
            category: .conditions,
            relatedTerms: ["Heinz Body Anemia", "Cyanosis"],
            searchKeywords: ["brown blood", "chocolate blood", "oxygen", "met-hgb"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000007")!,
            term: "Hypoglycemia",
            pronunciation: "hy-poh-gly-SEE-mee-ah",
            definition: "Dangerously low blood sugar levels. Signs include weakness, trembling, disorientation, seizures, and collapse. In toxicology, most commonly seen with xylitol ingestion in dogs (causes massive insulin release) or overdose of diabetes medications. Small breed dogs and puppies are particularly vulnerable.",
            category: .conditions,
            relatedTerms: ["Seizures"],
            searchKeywords: ["low blood sugar", "low glucose", "insulin"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000008")!,
            term: "Hepatotoxicity",
            pronunciation: "hep-ah-toh-tok-SIS-ih-tee",
            definition: "Liver damage or poisoning caused by toxic substances. The liver processes many toxins, making it vulnerable to injury. Signs may include jaundice (yellow gums/eyes), vomiting, lethargy, and loss of appetite. Common causes include sago palm, acetaminophen, certain mushrooms, and blue-green algae.",
            category: .conditions,
            relatedTerms: ["Nephrotoxicity", "Jaundice", "Ascites"],
            searchKeywords: ["liver damage", "liver failure", "liver toxicity", "hepatic"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000009")!,
            term: "Nephrotoxicity",
            pronunciation: "nef-roh-tok-SIS-ih-tee",
            definition: "Kidney damage or poisoning. The kidneys filter waste from the blood and are vulnerable to many toxins. Signs include changes in urination (increased or decreased), vomiting, lethargy, and loss of appetite. Common causes include grapes/raisins (dogs), lilies (cats), NSAIDs, and antifreeze.",
            category: .conditions,
            relatedTerms: ["Hepatotoxicity", "Acute Kidney Injury"],
            searchKeywords: ["kidney damage", "kidney failure", "renal", "kidney toxicity"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000010")!,
            term: "Coagulopathy",
            pronunciation: "koh-ag-yoo-LOP-ah-thee",
            definition: "A disorder affecting the blood's ability to clot properly, leading to excessive bleeding. In toxicology, most commonly caused by anticoagulant rodenticides (rat poison), which deplete vitamin K. Signs may not appear for 2-5 days and include bruising, bloody urine or stool, pale gums, and difficulty breathing.",
            category: .conditions,
            relatedTerms: ["Hemostasis"],
            searchKeywords: ["bleeding disorder", "clotting", "anticoagulant", "rat poison", "vitamin K"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Anatomy & Physiology
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000011")!,
            term: "CNS",
            pronunciation: nil,
            definition: "Central Nervous System — the brain and spinal cord. Many toxins affect the CNS, causing symptoms like ataxia, tremors, seizures, or depression. \"CNS depression\" means reduced brain activity, causing drowsiness, weakness, or unresponsiveness.",
            category: .anatomy,
            relatedTerms: ["Ataxia", "Seizures"],
            searchKeywords: ["central nervous system", "brain", "spinal cord", "neurological"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000012")!,
            term: "GI Tract",
            pronunciation: nil,
            definition: "Gastrointestinal tract — the digestive system including the stomach and intestines. Most ingested toxins first affect the GI tract, causing vomiting, diarrhea, drooling, or abdominal pain. \"GI upset\" refers to these digestive symptoms.",
            category: .anatomy,
            relatedTerms: nil,
            searchKeywords: ["gastrointestinal", "intestines", "digestive"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Treatment Terms
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000013")!,
            term: "Decontamination",
            pronunciation: "dee-kon-tam-ih-NAY-shun",
            definition: "The process of removing a toxic substance from the body before it can be fully absorbed. Methods include inducing vomiting (emesis), administering activated charcoal, bathing to remove skin contaminants, or flushing eyes. Decontamination is most effective when performed soon after exposure and should only be done under veterinary guidance.",
            category: .treatment,
            relatedTerms: ["Emesis", "Activated Charcoal"],
            searchKeywords: ["removing poison", "first aid"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000014")!,
            term: "Emesis",
            pronunciation: "EM-eh-sis",
            definition: "The medical term for vomiting, often referring to intentionally induced vomiting to remove a swallowed toxin. Emesis must only be induced by a veterinarian — it is contraindicated (dangerous) for caustic substances, petroleum products, or when the pet is already showing neurological symptoms.",
            category: .treatment,
            relatedTerms: ["Decontamination", "Regurgitation"],
            searchKeywords: ["vomiting", "induce vomiting", "throwing up"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000015")!,
            term: "Supportive Care",
            pronunciation: nil,
            definition: "Treatment focused on managing symptoms and maintaining body functions while the toxin is eliminated, rather than targeting the toxin directly. May include IV fluids, anti-nausea medications, temperature regulation, and monitoring. Many poisonings have no specific antidote and rely entirely on supportive care.",
            category: .treatment,
            relatedTerms: nil,
            searchKeywords: ["symptomatic treatment", "IV fluids", "hospitalization"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Symptoms & Signs (continued)
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000016")!,
            term: "Cyanosis",
            pronunciation: "sy-ah-NO-sis",
            definition: "A bluish or grayish discoloration of the gums, tongue, or skin caused by insufficient oxygen in the blood. In pets, check the gums — healthy gums are pink, while cyanotic gums appear blue, gray, or muddy. This is a medical emergency indicating severe respiratory or circulatory compromise.",
            category: .symptoms,
            relatedTerms: ["Methemoglobinemia", "Dyspnea"],
            searchKeywords: ["blue gums", "gray gums", "purple gums", "blue tongue"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000017")!,
            term: "Dyspnea",
            pronunciation: "DISP-nee-ah",
            definition: "Difficult or labored breathing. Affected pets may breathe with their mouth open, extend their neck, use abdominal muscles to breathe, or make wheezing/gasping sounds. Dyspnea indicates the pet is not getting enough oxygen and requires immediate veterinary attention.",
            category: .symptoms,
            relatedTerms: ["Cyanosis", "Tachypnea", "Effusion"],
            searchKeywords: ["trouble breathing", "difficulty breathing", "labored breathing", "can't breathe", "gasping"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000018")!,
            term: "Tachypnea",
            pronunciation: "tak-ip-NEE-ah",
            definition: "Abnormally rapid breathing. While panting is normal in dogs after exercise or heat, rapid breathing at rest can indicate pain, fever, anxiety, or toxicity affecting the respiratory or cardiovascular system. Cats rarely pant, so rapid breathing in cats is always concerning.",
            category: .symptoms,
            relatedTerms: ["Dyspnea", "Tachycardia"],
            searchKeywords: ["rapid breathing", "fast breathing", "panting", "breathing fast"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000019")!,
            term: "Lethargy",
            pronunciation: "LETH-ar-jee",
            definition: "Abnormal drowsiness, sluggishness, or lack of energy. A lethargic pet may be slow to respond, reluctant to move, or sleep more than usual. While subtle, lethargy is often one of the first signs that something is wrong and should prompt veterinary evaluation if it persists.",
            category: .symptoms,
            relatedTerms: ["CNS Depression"],
            searchKeywords: ["no energy", "sluggish", "not moving"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000020")!,
            term: "Hypersalivation",
            pronunciation: "hy-per-sal-ih-VAY-shun",
            definition: "Excessive drooling or salivation. Often indicates nausea, oral irritation, or pain. Common with toxins that irritate the mouth (such as calcium oxalate plants) or cause GI upset. Also called ptyalism. Some drooling is normal in certain breeds, but sudden onset is concerning.",
            category: .symptoms,
            relatedTerms: nil,
            searchKeywords: ["drooling", "excessive drool", "ptyalism", "salivating", "foaming"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000021")!,
            term: "Mydriasis",
            pronunciation: "mid-RY-ah-sis",
            definition: "Abnormal dilation (widening) of the pupils. The pupils appear unusually large and may not constrict normally in bright light. Can indicate neurological toxicity, certain drug effects, or eye problems. The opposite of miosis (constricted pupils).",
            category: .symptoms,
            relatedTerms: ["Miosis"],
            searchKeywords: ["dilated pupils", "big pupils", "wide pupils", "enlarged pupils"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000022")!,
            term: "Miosis",
            pronunciation: "my-OH-sis",
            definition: "Abnormal constriction (narrowing) of the pupils. The pupils appear unusually small, even in dim light. Can indicate certain toxicities (especially organophosphate pesticides) or opioid effects. The opposite of mydriasis (dilated pupils).",
            category: .symptoms,
            relatedTerms: ["Mydriasis"],
            searchKeywords: ["constricted pupils", "small pupils", "pinpoint pupils", "tiny pupils"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000023")!,
            term: "Arrhythmia",
            pronunciation: "ah-RITH-mee-ah",
            definition: "An irregular heartbeat — the heart may beat too fast, too slow, or with an irregular rhythm. Many toxins affect heart rhythm, including chocolate, cardiac glycoside plants (oleander, foxglove), and certain medications. Arrhythmias can be life-threatening and require immediate care.",
            category: .symptoms,
            relatedTerms: ["Bradycardia", "Tachycardia"],
            searchKeywords: ["irregular heartbeat", "heart rhythm", "irregular pulse", "abnormal heartbeat"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000024")!,
            term: "Vomiting",
            pronunciation: nil,
            definition: "Forceful expulsion of stomach contents through the mouth. Unlike regurgitation (passive), vomiting involves active abdominal contractions. It's the body's way of expelling toxins but can also lead to dehydration and electrolyte imbalances. Bloody vomit or persistent vomiting requires urgent care.",
            category: .symptoms,
            relatedTerms: ["Emesis", "Hematemesis", "Regurgitation"],
            searchKeywords: ["throwing up", "vomit", "puking"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000025")!,
            term: "Diarrhea",
            pronunciation: "dy-ah-REE-ah",
            definition: "Loose, watery, or frequent bowel movements. Common with GI toxins and irritants. Can lead to dehydration, especially in small pets. Bloody diarrhea (bright red or dark/tarry) is more serious and indicates GI bleeding that requires prompt veterinary attention.",
            category: .symptoms,
            relatedTerms: ["Melena", "Hematochezia", "Dehydration"],
            searchKeywords: ["loose stool", "watery stool", "runny poop", "bloody stool"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Conditions (continued)
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000026")!,
            term: "Heinz Body Anemia",
            pronunciation: "HINZ body ah-NEE-mee-ah",
            definition: "A type of anemia caused by oxidative damage to red blood cells, forming clumps called Heinz bodies that lead to cell destruction. Cats are especially susceptible. Common causes include onions, garlic, acetaminophen, and certain other toxins. Signs include weakness, pale gums, and dark urine.",
            category: .conditions,
            relatedTerms: ["Methemoglobinemia", "Hemolysis", "Anemia"],
            searchKeywords: ["red blood cell damage", "oxidative anemia"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000027")!,
            term: "Anemia",
            pronunciation: "ah-NEE-mee-ah",
            definition: "A condition where there are not enough healthy red blood cells to carry adequate oxygen to tissues. Signs include pale gums, weakness, rapid breathing, and lethargy. Can result from blood loss, red blood cell destruction (hemolysis), or decreased production. Many toxins can cause anemia.",
            category: .conditions,
            relatedTerms: ["Heinz Body Anemia", "Hemolysis"],
            searchKeywords: ["low red blood cells", "pale gums", "blood loss"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000028")!,
            term: "Hemolysis",
            pronunciation: "hee-MOL-ih-sis",
            definition: "The destruction or rupture of red blood cells, releasing hemoglobin into the bloodstream. Can cause anemia, dark red or brown urine, and jaundice. Toxins that cause hemolysis include onions, garlic, zinc (from pennies), and copper. Severe hemolysis is life-threatening.",
            category: .conditions,
            relatedTerms: ["Anemia", "Heinz Body Anemia"],
            searchKeywords: ["red blood cell destruction", "blood cell rupture", "hemolytic"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000029")!,
            term: "Pancreatitis",
            pronunciation: "pan-kree-ah-TY-tis",
            definition: "Inflammation of the pancreas, often triggered by high-fat foods, certain medications, or toxins. Signs include vomiting, abdominal pain (hunched posture, reluctance to move), loss of appetite, and diarrhea. Can range from mild to severe and life-threatening. Requires veterinary treatment.",
            category: .conditions,
            relatedTerms: nil,
            searchKeywords: ["pancreas inflammation", "fatty food", "abdominal pain"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000030")!,
            term: "Acute Kidney Injury",
            pronunciation: nil,
            definition: "Sudden loss of kidney function, often abbreviated as AKI. The kidneys filter waste from the blood — when they fail, toxins build up rapidly. Signs include decreased urination, vomiting, lethargy, and loss of appetite. Common causes include grapes/raisins (dogs), lilies (cats), antifreeze, and NSAIDs.",
            category: .conditions,
            relatedTerms: ["Nephrotoxicity", "Azotemia", "Oliguria", "Anuria"],
            searchKeywords: ["AKI", "kidney failure", "renal failure", "acute renal failure"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000031")!,
            term: "Jaundice",
            pronunciation: "JAWN-dis",
            definition: "Yellowing of the skin, gums, and whites of the eyes caused by a buildup of bilirubin (a yellow pigment from broken-down red blood cells). Indicates liver disease, bile duct obstruction, or excessive red blood cell destruction. Also called icterus. Requires veterinary evaluation.",
            category: .conditions,
            relatedTerms: ["Hepatotoxicity", "Hemolysis"],
            searchKeywords: ["yellow gums", "yellow eyes", "yellow skin", "icterus", "liver disease"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000032")!,
            term: "Hyperthermia",
            pronunciation: "hy-per-THER-mee-ah",
            definition: "Dangerously elevated body temperature not caused by fever. Can result from heat stroke, certain toxins (like hops or stimulants), or seizures. Normal temperature for dogs and cats is 101-102.5°F. Hyperthermia above 104°F is an emergency requiring immediate cooling and veterinary care.",
            category: .conditions,
            relatedTerms: ["Hypothermia"],
            searchKeywords: ["high temperature", "overheating", "heat stroke", "fever"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000033")!,
            term: "Hypothermia",
            pronunciation: "hy-poh-THER-mee-ah",
            definition: "Dangerously low body temperature. Can occur with certain toxins that cause sedation or cardiovascular depression, or from environmental cold exposure. Signs include shivering (early), lethargy, weakness, and cold ears/paws. Severe hypothermia causes muscle stiffness and unresponsiveness.",
            category: .conditions,
            relatedTerms: ["Hyperthermia"],
            searchKeywords: ["low temperature"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Toxic Mechanisms
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000034")!,
            term: "Oxidative Damage",
            pronunciation: nil,
            definition: "Cell injury caused by reactive oxygen species (free radicals) that overwhelm the body's antioxidant defenses. Particularly affects red blood cells, leading to Heinz body formation and hemolysis. Toxins causing oxidative damage include onions, garlic, acetaminophen, naphthalene (mothballs), and zinc.",
            category: .mechanisms,
            relatedTerms: ["Heinz Body Anemia", "Hemolysis", "Methemoglobinemia"],
            searchKeywords: ["free radicals", "oxidative stress", "antioxidant"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000035")!,
            term: "Cardiotoxicity",
            pronunciation: "kar-dee-oh-tok-SIS-ih-tee",
            definition: "Damage or poisoning affecting the heart. Can cause arrhythmias (irregular heartbeat), heart muscle weakness, or heart failure. Cardiotoxic substances include chocolate/caffeine, cardiac glycoside plants (oleander, foxglove, lily of the valley), certain medications, and some recreational drugs.",
            category: .conditions,
            relatedTerms: ["Arrhythmia", "Bradycardia", "Tachycardia"],
            searchKeywords: ["heart damage", "heart toxicity", "heart poison", "cardiac"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000036")!,
            term: "Neurotoxicity",
            pronunciation: "noor-oh-tok-SIS-ih-tee",
            definition: "Damage or poisoning affecting the nervous system (brain, spinal cord, or nerves). Signs include tremors, seizures, ataxia, paralysis, behavior changes, or altered consciousness. Many toxins are neurotoxic, including certain pesticides, plants, medications, and recreational drugs.",
            category: .conditions,
            relatedTerms: ["CNS", "Ataxia", "Seizures", "Tremors"],
            searchKeywords: ["nerve damage", "brain damage", "neurological", "nervous system toxicity"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Treatment Terms (continued)
        // ══════════════════════════════════════════════════════════════

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000037")!,
            term: "Activated Charcoal",
            pronunciation: nil,
            definition: "A specially processed charcoal given by mouth to absorb toxins in the stomach and intestines, preventing their absorption into the bloodstream. Must be given by a veterinarian — it's not effective for all toxins and can be dangerous if given incorrectly or aspirated into the lungs.",
            category: .treatment,
            relatedTerms: ["Decontamination"],
            searchKeywords: ["charcoal", "absorb toxin", "poison treatment"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000038")!,
            term: "Antidote",
            pronunciation: "AN-tih-dote",
            definition: "A substance that counteracts or neutralizes a specific poison. Only a few toxins have true antidotes — for example, vitamin K for anticoagulant rodenticides, or fomepizole for antifreeze. Most poisonings are treated with supportive care rather than specific antidotes.",
            category: .treatment,
            relatedTerms: ["Supportive Care"],
            searchKeywords: ["counteract poison"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000039")!,
            term: "IV Fluids",
            pronunciation: nil,
            definition: "Fluids given directly into a vein (intravenous) to maintain hydration, support blood pressure, and help flush toxins from the body through the kidneys. A cornerstone of supportive care for most poisonings. The type and rate of fluids are tailored to each patient's needs.",
            category: .treatment,
            relatedTerms: ["Supportive Care"],
            searchKeywords: ["intravenous fluids", "fluid therapy"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000040")!,
            term: "Gastric Lavage",
            pronunciation: "GAS-trik lah-VAZH",
            definition: "A procedure where the stomach is washed out (\"pumped\") to remove ingested toxins. Performed under anesthesia with a tube passed into the stomach. Rarely used today as it's invasive and carries risks. May be considered for recent ingestion of severe toxins when emesis isn't appropriate.",
            category: .treatment,
            relatedTerms: ["Emesis", "Decontamination"],
            searchKeywords: ["stomach pumping", "stomach wash", "lavage"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Batch 2 (Session 101)
        // ══════════════════════════════════════════════════════════════

        // 41. CNS Depression
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000041")!,
            term: "CNS Depression",
            pronunciation: nil,
            definition: "A slowing of brain and nervous system activity. Signs include drowsiness, reduced alertness, slow or shallow breathing, weakness, and in severe cases, loss of consciousness. Many toxins cause CNS depression, including sedatives, alcohol, and certain plants.",
            category: .symptoms,
            relatedTerms: ["CNS", "Lethargy", "Ataxia"],
            searchKeywords: ["sedation", "drowsy", "unresponsive", "depressed"]
        ),

        // 42. Hematemesis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000042")!,
            term: "Hematemesis",
            pronunciation: "hee-mah-TEM-eh-sis",
            definition: "Vomiting blood. The blood may appear bright red (fresh bleeding) or look like dark coffee grounds (partially digested blood). This is a serious sign indicating bleeding in the stomach or upper digestive tract and requires immediate veterinary attention.",
            category: .symptoms,
            relatedTerms: ["Vomiting", "GI Tract", "Melena"],
            searchKeywords: ["bloody vomit", "vomiting blood", "coffee ground vomit"]
        ),

        // 43. Melena
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000043")!,
            term: "Melena",
            pronunciation: "meh-LEE-nah",
            definition: "Dark, tarry, black stool caused by digested blood from bleeding in the upper digestive tract. The dark color comes from blood being broken down as it passes through the intestines. This is different from bright red blood in stool (hematochezia), which indicates lower intestinal bleeding.",
            category: .symptoms,
            relatedTerms: ["GI Tract", "Hematemesis", "Coagulopathy", "Hematochezia"],
            searchKeywords: ["black stool", "tarry stool", "blood in stool", "dark feces"]
        ),

        // 44. Hypotension
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000044")!,
            term: "Hypotension",
            pronunciation: "hy-poh-TEN-shun",
            definition: "Abnormally low blood pressure. Signs may include weakness, pale gums, cold extremities, rapid heart rate (as the body tries to compensate), and collapse. Severe hypotension can lead to shock and organ damage if not treated promptly.",
            category: .conditions,
            relatedTerms: ["Collapse", "Tachycardia", "Bradycardia"],
            searchKeywords: ["low blood pressure", "weak pulse"]
        ),

        // 45. Hypertension
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000045")!,
            term: "Hypertension",
            pronunciation: "hy-per-TEN-shun",
            definition: "Abnormally high blood pressure. While not always visible to pet owners, severe hypertension can cause sudden blindness, nosebleeds, disorientation, or seizures. Some toxins (like certain decongestants and stimulants) can cause dangerous spikes in blood pressure.",
            category: .conditions,
            relatedTerms: ["Tachycardia", "Seizures", "Mydriasis"],
            searchKeywords: ["high blood pressure", "elevated blood pressure"]
        ),

        // 46. Collapse
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000046")!,
            term: "Collapse",
            pronunciation: nil,
            definition: "Sudden inability to stand or walk, often falling to the ground. May be caused by heart problems, severe weakness, low blood pressure, blood loss, or neurological issues. Collapse is always an emergency requiring immediate veterinary care.",
            category: .symptoms,
            relatedTerms: ["Hypotension", "Bradycardia", "Lethargy"],
            searchKeywords: ["falling down", "can't stand", "fainting", "syncope"]
        ),

        // 47. Mucous Membranes
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000047")!,
            term: "Mucous Membranes",
            pronunciation: nil,
            definition: "The moist, pink tissues lining body openings. In pets, veterinarians commonly check the gums, inner lips, and inner eyelids. Healthy membranes are pink and moist. Color changes can indicate problems: pale (blood loss, shock), blue/purple (low oxygen), yellow (liver issues), or brick red (some toxins).",
            category: .anatomy,
            relatedTerms: ["Cyanosis", "Jaundice", "Anemia"],
            searchKeywords: ["gums", "gum color", "pale gums", "blue gums", "yellow gums"]
        ),

        // 48. Toxicosis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000048")!,
            term: "Toxicosis",
            pronunciation: "tok-sih-KOH-sis",
            definition: "The condition of being poisoned; illness caused by exposure to a toxic substance. Often used interchangeably with 'poisoning' or 'intoxication.' The severity depends on the toxin, amount, and how quickly treatment is provided.",
            category: .general,
            relatedTerms: ["Acute", "Chronic"],
            searchKeywords: ["poisoning", "intoxication", "toxic exposure"]
        ),

        // 49. Acute
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000049")!,
            term: "Acute",
            pronunciation: "ah-KYOOT",
            definition: "Describing something that develops quickly and is typically short-term but often severe. Acute toxicosis means symptoms appear rapidly after exposure (within minutes to hours). Contrast with chronic, which develops slowly over time.",
            category: .general,
            relatedTerms: ["Chronic", "Toxicosis"],
            searchKeywords: ["sudden", "rapid onset", "short-term"]
        ),

        // 50. Chronic
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000050")!,
            term: "Chronic",
            pronunciation: "KRON-ik",
            definition: "Describing something that develops slowly over a long period, often from repeated low-level exposures. Chronic toxicosis may take weeks, months, or years to show symptoms. Examples include lead poisoning from repeated small exposures or liver damage from ongoing medication use.",
            category: .general,
            relatedTerms: ["Acute", "Toxicosis"],
            searchKeywords: ["long-term", "gradual", "ongoing", "repeated exposure"]
        ),

        // 51. Prognosis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000051")!,
            term: "Prognosis",
            pronunciation: "prog-NOH-sis",
            definition: "The expected outcome or course of a condition. A 'good prognosis' means recovery is likely with proper treatment. A 'guarded prognosis' means the outcome is uncertain. Prognosis depends on many factors including the toxin, amount, time to treatment, and the pet's overall health.",
            category: .general,
            relatedTerms: ["Supportive Care", "Antidote"],
            searchKeywords: nil
        ),

        // 52. Ingestion
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000052")!,
            term: "Ingestion",
            pronunciation: nil,
            definition: "Taking a substance into the body by swallowing (eating or drinking). This is the most common route of poisoning in pets. The substance then enters the digestive system where it may be absorbed into the bloodstream.",
            category: .general,
            relatedTerms: ["GI Tract", "Decontamination", "Emesis"],
            searchKeywords: ["swallowed", "ate", "eaten", "chewed", "consumed"]
        ),

        // 53. Dermal Exposure
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000053")!,
            term: "Dermal Exposure",
            pronunciation: nil,
            definition: "Contact with a toxic substance through the skin. Some toxins can be absorbed through skin, causing local irritation or systemic (whole-body) effects. Pets may also ingest the substance when grooming contaminated fur. Bathing is often recommended to remove the substance.",
            category: .general,
            relatedTerms: ["Decontamination"],
            searchKeywords: ["skin contact", "skin exposure", "topical", "fur contamination", "touched"]
        ),

        // 54. Inhalation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000054")!,
            term: "Inhalation",
            pronunciation: nil,
            definition: "Breathing a substance into the lungs. Inhaled toxins can cause respiratory irritation, difficulty breathing, or systemic effects after being absorbed into the bloodstream through the lungs. Birds are especially sensitive to inhaled toxins. Moving the pet to fresh air is an important first step.",
            category: .general,
            relatedTerms: ["Dyspnea", "Tachypnea"],
            searchKeywords: ["breathing in", "breathed", "fumes", "smoke", "vapors", "airborne"]
        ),

        // 55. Aspiration
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000055")!,
            term: "Aspiration",
            pronunciation: "as-pih-RAY-shun",
            definition: "Accidentally breathing a substance into the airways and lungs instead of swallowing it. This can happen during vomiting or with oily/petroleum substances. Aspiration pneumonia (lung infection from inhaled material) is a serious complication. This is one reason why inducing vomiting at home can be dangerous.",
            category: .conditions,
            relatedTerms: ["Emesis", "Inhalation", "Dyspnea"],
            searchKeywords: ["aspiration pneumonia", "breathed into lungs", "inhaled vomit"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Batch 3 (Session 101)
        // ══════════════════════════════════════════════════════════════

        // 56. Hemoglobin
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000056")!,
            term: "Hemoglobin",
            pronunciation: "HEE-moh-gloh-bin",
            definition: "The protein in red blood cells that carries oxygen throughout the body, giving blood its red color. Some toxins damage hemoglobin or prevent it from carrying oxygen properly (as in methemoglobinemia), leading to weakness, pale or blue gums, and breathing difficulty.",
            category: .anatomy,
            relatedTerms: ["Methemoglobinemia", "Anemia", "Cyanosis", "Heinz Body Anemia"],
            searchKeywords: ["red blood cells"]
        ),

        // 57. Platelets
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000057")!,
            term: "Platelets",
            pronunciation: "PLAYT-lets",
            definition: "Tiny blood cells that help form clots to stop bleeding. Some toxins (like certain rodenticides) interfere with platelet function or clotting factors, causing uncontrolled bleeding. Low platelet counts can lead to bruising, bloody urine or stool, and prolonged bleeding from minor injuries.",
            category: .anatomy,
            relatedTerms: ["Coagulopathy", "Hematemesis", "Melena"],
            searchKeywords: ["blood clotting", "thrombocytes"]
        ),

        // 58. Anorexia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000058")!,
            term: "Anorexia",
            pronunciation: "an-oh-REK-see-ah",
            definition: "Loss of appetite or refusal to eat. In veterinary medicine, this simply means the pet isn't eating—it's one of the most common signs that something is wrong. Anorexia lasting more than 24 hours (or less in small pets) warrants veterinary attention.",
            category: .symptoms,
            relatedTerms: ["Lethargy", "Vomiting", "GI Tract"],
            searchKeywords: ["not eating", "won't eat", "loss of appetite", "refusing food", "off food"]
        ),

        // 59. Polyuria
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000059")!,
            term: "Polyuria",
            pronunciation: "pol-ee-YOO-ree-ah",
            definition: "Producing abnormally large amounts of urine. Often seen alongside increased thirst (polydipsia). Can be caused by kidney damage, certain toxins, diabetes, or other conditions. You may notice more frequent urination, larger wet spots, or accidents in housetrained pets.",
            category: .symptoms,
            relatedTerms: ["Polydipsia", "Nephrotoxicity", "Acute Kidney Injury", "Oliguria"],
            searchKeywords: ["frequent urination", "peeing a lot", "excessive urination", "PU/PD"]
        ),

        // 60. Polydipsia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000005A")!,
            term: "Polydipsia",
            pronunciation: "pol-ee-DIP-see-ah",
            definition: "Excessive thirst and drinking. Often occurs with increased urination (polyuria). Can indicate kidney problems, toxin exposure, diabetes, or other conditions. You may notice the water bowl emptying faster than usual or your pet seeking water constantly.",
            category: .symptoms,
            relatedTerms: ["Polyuria", "Nephrotoxicity", "Dehydration"],
            searchKeywords: ["excessive thirst", "drinking a lot", "increased thirst", "PU/PD"]
        ),

        // 61. Edema
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000005B")!,
            term: "Edema",
            pronunciation: "eh-DEE-mah",
            definition: "Swelling caused by fluid buildup in body tissues. May appear as puffiness in the face, limbs, or belly. Pulmonary edema (fluid in the lungs) causes breathing difficulty and is life-threatening. Various toxins can cause edema through different mechanisms.",
            category: .symptoms,
            relatedTerms: ["Dyspnea", "Hypotension", "Ascites", "Effusion"],
            searchKeywords: ["fluid retention"]
        ),

        // 62. Shock
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000005C")!,
            term: "Shock",
            pronunciation: nil,
            definition: "A life-threatening condition where the body's organs don't receive enough blood flow and oxygen. Signs include pale or white gums, rapid heart rate, weak pulse, cold extremities, collapse, and altered consciousness. Shock requires immediate emergency veterinary care.",
            category: .conditions,
            relatedTerms: ["Hypotension", "Collapse", "Tachycardia", "Mucous Membranes"],
            searchKeywords: ["circulatory shock", "going into shock"]
        ),

        // 63. Dehydration
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000005D")!,
            term: "Dehydration",
            pronunciation: nil,
            definition: "Dangerous loss of body fluids, often from vomiting, diarrhea, or not drinking. Signs include dry or tacky gums, skin that stays 'tented' when pinched, sunken eyes, lethargy, and decreased urination. Dehydration can quickly become serious, especially in small pets.",
            category: .conditions,
            relatedTerms: ["Vomiting", "Diarrhea", "IV Fluids", "Lethargy"],
            searchKeywords: ["fluid loss", "not drinking"]
        ),

        // 64. Renal
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000005E")!,
            term: "Renal",
            pronunciation: "REE-nal",
            definition: "Relating to the kidneys. 'Renal failure' means the kidneys are not working properly. 'Renal toxicity' means a substance is harmful to the kidneys. The kidneys filter waste from the blood, so damage affects the whole body.",
            category: .anatomy,
            relatedTerms: ["Nephrotoxicity", "Acute Kidney Injury", "Polyuria"],
            searchKeywords: ["kidney", "kidneys"]
        ),

        // 65. Hepatic
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000005F")!,
            term: "Hepatic",
            pronunciation: "heh-PAT-ik",
            definition: "Relating to the liver. 'Hepatic failure' means the liver is not working properly. 'Hepatic toxicity' means a substance is harmful to the liver. The liver processes nutrients and filters toxins, so damage can cause widespread problems including jaundice.",
            category: .anatomy,
            relatedTerms: ["Hepatotoxicity", "Jaundice"],
            searchKeywords: ["liver"]
        ),

        // 66. Metabolite
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000060")!,
            term: "Metabolite",
            pronunciation: "meh-TAB-oh-lite",
            definition: "A substance produced when the body breaks down (metabolizes) something. Some toxins are harmless until the body converts them into dangerous metabolites. For example, ethylene glycol (antifreeze) itself is not the main problem—its metabolites cause kidney failure.",
            category: .mechanisms,
            relatedTerms: ["Hepatic", "Antidote"],
            searchKeywords: ["breakdown product", "metabolism"]
        ),

        // 67. Half-life
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000061")!,
            term: "Half-life",
            pronunciation: nil,
            definition: "The time it takes for half of a substance to be eliminated from the body. A toxin with a long half-life stays in the system longer, potentially causing prolonged symptoms. This affects how long monitoring and treatment may be needed.",
            category: .mechanisms,
            relatedTerms: ["Metabolite", "Chronic"],
            searchKeywords: ["elimination", "duration", "how long"]
        ),

        // 68. Electrolytes
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000062")!,
            term: "Electrolytes",
            pronunciation: "ee-LEK-troh-lites",
            definition: "Minerals in the blood (like sodium, potassium, and calcium) that regulate vital body functions including heart rhythm, muscle contractions, and fluid balance. Vomiting, diarrhea, and certain toxins can cause dangerous electrolyte imbalances requiring IV fluid correction.",
            category: .anatomy,
            relatedTerms: ["IV Fluids", "Dehydration", "Arrhythmia"],
            searchKeywords: ["sodium", "potassium", "calcium", "minerals"]
        ),

        // 69. Metabolic Acidosis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000063")!,
            term: "Metabolic Acidosis",
            pronunciation: "met-ah-BOL-ik as-ih-DOH-sis",
            definition: "A dangerous condition where the blood becomes too acidic, disrupting normal body functions. Causes include certain toxins (especially antifreeze/ethylene glycol), kidney failure, and severe dehydration. Signs include rapid breathing, lethargy, and collapse.",
            category: .conditions,
            relatedTerms: ["Nephrotoxicity", "Tachypnea", "Collapse"],
            searchKeywords: ["acidic blood", "acid-base"]
        ),

        // 70. Symptomatic Treatment
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000064")!,
            term: "Symptomatic Treatment",
            pronunciation: nil,
            definition: "Treatment focused on managing symptoms rather than addressing the underlying cause directly. When no specific antidote exists, veterinarians provide symptomatic treatment—such as anti-nausea medication for vomiting or oxygen for breathing difficulty—while the body eliminates the toxin.",
            category: .treatment,
            relatedTerms: ["Supportive Care", "Antidote"],
            searchKeywords: ["treating symptoms", "symptom management"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Batch 4 (Session 101)
        // ══════════════════════════════════════════════════════════════

        // 71. Hematuria
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000065")!,
            term: "Hematuria",
            pronunciation: "hee-mah-TOO-ree-ah",
            definition: "Blood in the urine. May appear pink, red, or brown. Can be caused by kidney damage, bladder injury, clotting problems (as with anticoagulant rodenticides), or urinary tract infections. Any blood in urine warrants veterinary evaluation.",
            category: .symptoms,
            relatedTerms: ["Coagulopathy", "Nephrotoxicity", "Renal"],
            searchKeywords: ["bloody urine", "blood in urine", "red urine", "pink urine"]
        ),

        // 72. Respiratory Depression
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000066")!,
            term: "Respiratory Depression",
            pronunciation: nil,
            definition: "Abnormally slow or shallow breathing that reduces oxygen intake. Can be caused by opioids, sedatives, and other CNS depressants. Severe respiratory depression is life-threatening. Signs include slow breathing rate, weak breaths, blue-tinged gums, and decreased responsiveness.",
            category: .symptoms,
            relatedTerms: ["CNS Depression", "Cyanosis", "Dyspnea", "Bradycardia"],
            searchKeywords: ["slow breathing", "shallow breathing", "breathing problems", "hypoventilation"]
        ),

        // 73. Cardiac Arrest
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000067")!,
            term: "Cardiac Arrest",
            pronunciation: nil,
            definition: "When the heart stops beating effectively, causing collapse and loss of consciousness. Without immediate CPR and emergency care, death occurs within minutes. Some severe toxicoses can lead to cardiac arrest. This is the most critical emergency possible.",
            category: .conditions,
            relatedTerms: ["Collapse", "Arrhythmia", "Cardiotoxicity"],
            searchKeywords: ["heart stopped", "heart attack", "no pulse", "CPR"]
        ),

        // 74. Pulmonary
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000068")!,
            term: "Pulmonary",
            pronunciation: "PULL-moh-nair-ee",
            definition: "Relating to the lungs. 'Pulmonary edema' means fluid in the lungs. 'Pulmonary toxicity' means a substance harms the lungs. The lungs are essential for oxygen exchange, so pulmonary problems quickly become serious.",
            category: .anatomy,
            relatedTerms: ["Dyspnea", "Tachypnea", "Inhalation", "Aspiration"],
            searchKeywords: ["lung", "lungs", "respiratory"]
        ),

        // 75. Systemic
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000069")!,
            term: "Systemic",
            pronunciation: "sis-TEM-ik",
            definition: "Affecting the whole body, not just one area. A 'systemic toxin' is absorbed into the bloodstream and can damage multiple organs. Contrast with 'local' effects that stay at the site of contact (like skin irritation). Systemic effects are generally more serious.",
            category: .general,
            relatedTerms: ["Ingestion", "Dermal Exposure", "Inhalation"],
            searchKeywords: ["whole body", "throughout body", "generalized"]
        ),

        // 76. Dose-Dependent
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000006A")!,
            term: "Dose-Dependent",
            pronunciation: nil,
            definition: "When the severity of effects increases with the amount of exposure. Most toxins are dose-dependent—a tiny amount may cause mild symptoms while a large amount causes severe illness. This is why the amount ingested matters when assessing poisoning risk.",
            category: .general,
            relatedTerms: ["Acute", "Toxicosis"],
            searchKeywords: ["amount matters", "how much", "quantity"]
        ),

        // 77. Idiosyncratic Reaction
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000006B")!,
            term: "Idiosyncratic Reaction",
            pronunciation: "id-ee-oh-sin-KRAT-ik",
            definition: "An unpredictable, unusual reaction to a substance that doesn't follow typical dose-response patterns. Some pets may have severe reactions to substances that are normally well-tolerated, or react to very small amounts. Grapes in dogs are a classic example—some dogs are severely affected while others show no ill effects.",
            category: .general,
            relatedTerms: ["Dose-Dependent", "Toxicosis"],
            searchKeywords: ["unpredictable", "unusual reaction", "sensitivity", "individual variation"]
        ),

        // 78. Latent Period
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000006C")!,
            term: "Latent Period",
            pronunciation: nil,
            definition: "The time between exposure to a toxin and the appearance of symptoms. Some toxins cause immediate effects; others have latent periods of hours or even days. For example, anticoagulant rodenticide symptoms may not appear for 2-5 days after ingestion, and lily toxicity in cats may take 24-72 hours to show kidney damage.",
            category: .general,
            relatedTerms: ["Acute", "Chronic", "Prognosis"],
            searchKeywords: ["delayed symptoms", "time to symptoms", "incubation"]
        ),

        // 79. Chelation Therapy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000006D")!,
            term: "Chelation Therapy",
            pronunciation: "kee-LAY-shun",
            definition: "A treatment using special medications that bind to heavy metals (like lead or zinc) in the body, allowing them to be excreted in urine. Used for heavy metal poisoning. The chelating agent essentially grabs onto metal atoms and escorts them out of the body.",
            category: .treatment,
            relatedTerms: ["Antidote", "Supportive Care"],
            searchKeywords: ["heavy metal treatment", "lead poisoning treatment", "zinc poisoning treatment"]
        ),

        // 80. Vitamin K Therapy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000006E")!,
            term: "Vitamin K Therapy",
            pronunciation: nil,
            definition: "Treatment with Vitamin K₁ (phytonadione) for anticoagulant rodenticide poisoning. These rodenticides work by blocking Vitamin K, which is needed for blood clotting. Treatment typically requires weeks of oral Vitamin K supplementation. Over-the-counter vitamins are NOT appropriate—prescription veterinary Vitamin K₁ is required.",
            category: .treatment,
            relatedTerms: ["Coagulopathy", "Antidote"],
            searchKeywords: ["rodenticide treatment", "rat poison treatment", "blood clotting treatment"]
        ),

        // 81. Lipid Emulsion Therapy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000006F")!,
            term: "Lipid Emulsion Therapy",
            pronunciation: nil,
            definition: "An IV treatment using fat solution to help remove certain fat-soluble toxins from the body. The fat particles absorb the toxin from tissues, reducing its effects. Used for some drug overdoses and toxicoses. Also called 'intralipid therapy' or 'ILE.'",
            category: .treatment,
            relatedTerms: ["IV Fluids", "Antidote", "Supportive Care"],
            searchKeywords: ["intralipid", "ILE", "fat emulsion"]
        ),

        // 82. Antiemetic
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000070")!,
            term: "Antiemetic",
            pronunciation: "an-tee-eh-MET-ik",
            definition: "A medication that prevents or controls vomiting and nausea. Often given as part of supportive care for poisoning after decontamination is complete. Common veterinary antiemetics include maropitant (Cerenia) and ondansetron.",
            category: .treatment,
            relatedTerms: ["Vomiting", "Supportive Care", "Symptomatic Treatment"],
            searchKeywords: ["anti-nausea", "stop vomiting", "nausea medication"]
        ),

        // 83. Gastroprotectant
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000071")!,
            term: "Gastroprotectant",
            pronunciation: "gas-troh-proh-TEK-tant",
            definition: "A medication that protects the stomach lining from irritation or ulcers. Often used when toxins have caused GI irritation or when other treatments (like activated charcoal) may be harsh on the stomach. Examples include famotidine, omeprazole, and sucralfate.",
            category: .treatment,
            relatedTerms: ["GI Tract", "Supportive Care", "Symptomatic Treatment"],
            searchKeywords: ["stomach protector", "antacid", "ulcer prevention"]
        ),

        // 84. Clinical Signs
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000072")!,
            term: "Clinical Signs",
            pronunciation: nil,
            definition: "Observable physical changes that indicate illness—what can be seen, measured, or detected during examination. In veterinary medicine, 'clinical signs' is preferred over 'symptoms' because animals can't describe how they feel. Examples include vomiting, tremors, pale gums, and elevated heart rate.",
            category: .general,
            relatedTerms: ["Prognosis", "Acute"],
            searchKeywords: ["symptoms", "signs of illness", "what to look for"]
        ),

        // 85. Asymptomatic
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000073")!,
            term: "Asymptomatic",
            pronunciation: "ay-simp-toh-MAT-ik",
            definition: "Showing no visible signs of illness despite exposure or underlying damage. A pet may be asymptomatic immediately after toxin exposure but develop signs later (during the latent period). Some toxins cause internal damage before any outward signs appear, which is why veterinary evaluation is important even if the pet 'seems fine.'",
            category: .general,
            relatedTerms: ["Clinical Signs", "Latent Period", "Prognosis"],
            searchKeywords: ["no symptoms", "seems fine", "looks normal", "not showing signs"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Batch 5 (Session 101) — Reaching 100 terms!
        // ══════════════════════════════════════════════════════════════

        // 86. Ptyalism
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000074")!,
            term: "Ptyalism",
            pronunciation: "TY-ah-lizm",
            definition: "Excessive drooling or salivation. Often used interchangeably with hypersalivation. Can be caused by nausea, oral irritation (as with calcium oxalate plants), toxin exposure, or difficulty swallowing. You may notice wet fur around the mouth, chin, or chest, or puddles of drool.",
            category: .symptoms,
            relatedTerms: ["Hypersalivation", "GI Tract", "Vomiting"],
            searchKeywords: ["drooling", "excessive saliva", "slobbering", "foaming"]
        ),

        // 87. Petechiae
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000075")!,
            term: "Petechiae",
            pronunciation: "peh-TEE-kee-eye",
            definition: "Tiny pinpoint red or purple spots on the skin, gums, or whites of the eyes caused by bleeding under the surface. A sign of clotting problems or platelet issues. Often seen with anticoagulant rodenticide poisoning. Look like small dots that don't fade when pressed.",
            category: .symptoms,
            relatedTerms: ["Coagulopathy", "Platelets", "Hematuria"],
            searchKeywords: ["red spots", "purple spots", "bruising", "bleeding spots"]
        ),

        // 88. Ecchymosis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000076")!,
            term: "Ecchymosis",
            pronunciation: "ek-ih-MOH-sis",
            definition: "Bruising—larger areas of bleeding under the skin that appear as purple, blue, or discolored patches. Like petechiae, indicates clotting problems. May appear on the belly, inner thighs, gums, or ear flaps. A serious sign requiring immediate veterinary care.",
            category: .symptoms,
            relatedTerms: ["Petechiae", "Coagulopathy", "Platelets"],
            searchKeywords: ["bruising", "bruises", "discoloration", "purple patches"]
        ),

        // 89. Nystagmus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000077")!,
            term: "Nystagmus",
            pronunciation: "nis-TAG-mus",
            definition: "Involuntary, rhythmic movement of the eyes—usually side-to-side, but can be up-and-down or rotational. Indicates neurological problems affecting balance or brain function. Often seen with vestibular toxicity or certain drug overdoses. The eyes appear to 'bounce' or 'flicker.'",
            category: .symptoms,
            relatedTerms: ["Ataxia", "CNS", "Neurotoxicity"],
            searchKeywords: ["eyes shaking", "eyes bouncing", "flickering eyes"]
        ),

        // 90. Paresis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000078")!,
            term: "Paresis",
            pronunciation: "pah-REE-sis",
            definition: "Partial paralysis or weakness—reduced ability to move a body part, but not complete loss of function. The pet may drag a limb, have a wobbly gait, or struggle to stand. Less severe than full paralysis but still indicates significant neurological involvement.",
            category: .symptoms,
            relatedTerms: ["Paralysis", "Ataxia", "Neurotoxicity"],
            searchKeywords: ["weakness", "partial paralysis", "weak legs", "limb weakness"]
        ),

        // 91. Paralysis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000079")!,
            term: "Paralysis",
            pronunciation: "pah-RAL-ih-sis",
            definition: "Complete loss of ability to move a body part. Can affect one limb, multiple limbs, or the entire body below a certain point. Some toxins (like tick paralysis or certain venoms) cause ascending paralysis that starts in the back legs and moves forward. Always an emergency.",
            category: .symptoms,
            relatedTerms: ["Paresis", "Neurotoxicity", "Respiratory Depression"],
            searchKeywords: ["can't move", "unable to move", "limp", "no movement"]
        ),

        // 92. Ileus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000007A")!,
            term: "Ileus",
            pronunciation: "IL-ee-us",
            definition: "When the intestines stop their normal movement (motility), causing contents to back up. Can result from toxin exposure, surgery, pain, or electrolyte imbalances. Signs include vomiting, bloating, lack of stool, and abdominal discomfort. Requires veterinary treatment to restart gut function.",
            category: .conditions,
            relatedTerms: ["GI Tract", "Vomiting", "Obstruction"],
            searchKeywords: ["gut stasis", "intestinal slowdown", "no bowel movement"]
        ),

        // 93. Obstruction
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000007B")!,
            term: "Obstruction",
            pronunciation: nil,
            definition: "A physical blockage preventing normal passage through a body structure—most commonly the GI tract. Foreign objects, expanding substances (like Gorilla Glue), or swollen tissue can cause obstruction. Signs include repeated vomiting, inability to keep food/water down, painful abdomen, and no stool. Often requires surgical intervention.",
            category: .conditions,
            relatedTerms: ["GI Tract", "Ileus", "Vomiting"],
            searchKeywords: ["foreign body", "intestinal blockage"]
        ),

        // 94. Perforation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000007C")!,
            term: "Perforation",
            pronunciation: "per-for-AY-shun",
            definition: "A hole or rupture in an organ wall, most often the stomach or intestines. Can be caused by sharp foreign objects, severe ulcers, or caustic substances. Contents leak into the abdomen causing severe infection (peritonitis). This is a surgical emergency with life-threatening consequences.",
            category: .conditions,
            relatedTerms: ["GI Tract", "Obstruction"],
            searchKeywords: ["GI perforation", "intestinal perforation", "stomach perforation", "perforated bowel"]
        ),

        // 95. Peritonitis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000007D")!,
            term: "Peritonitis",
            pronunciation: "per-ih-toh-NY-tis",
            definition: "Inflammation and infection of the abdominal cavity lining, usually from leakage of GI contents through a perforation. Causes severe abdominal pain, fever, shock, and rapid deterioration. Without emergency surgery and intensive care, peritonitis is often fatal.",
            category: .conditions,
            relatedTerms: ["Perforation", "Shock", "GI Tract"],
            searchKeywords: ["abdominal infection", "belly infection"]
        ),

        // 96. Monitoring
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000007E")!,
            term: "Monitoring",
            pronunciation: nil,
            definition: "Ongoing observation and testing to track a patient's condition over time. After toxin exposure, monitoring may include checking vital signs, blood work, kidney/liver values, and watching for delayed symptoms. Some toxins require monitoring for days to weeks even if the pet initially seems fine.",
            category: .treatment,
            relatedTerms: ["Supportive Care", "Prognosis", "Latent Period"],
            searchKeywords: ["observation", "follow-up", "rechecking"]
        ),

        // 97. Baseline
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000007F")!,
            term: "Baseline",
            pronunciation: nil,
            definition: "Initial measurements taken for comparison with later tests. After toxin exposure, baseline blood work establishes starting kidney/liver values so changes can be detected. For example, a normal baseline kidney value followed by elevated values later confirms developing kidney damage.",
            category: .treatment,
            relatedTerms: ["Monitoring", "Nephrotoxicity", "Hepatotoxicity"],
            searchKeywords: ["initial values", "starting point", "reference values"]
        ),

        // 98. Serum
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000080")!,
            term: "Serum",
            pronunciation: "SEER-um",
            definition: "The liquid portion of blood after cells and clotting factors are removed. Blood tests often measure substances in serum—such as 'serum creatinine' (kidney function) or 'serum liver enzymes.' When you see 'serum' before a test name, it refers to what's measured in this blood fluid.",
            category: .anatomy,
            relatedTerms: ["Baseline", "Monitoring"],
            searchKeywords: ["blood test", "blood work", "blood sample"]
        ),

        // 99. Contraindicated
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000081")!,
            term: "Contraindicated",
            pronunciation: "con-trah-IN-dih-kay-ted",
            definition: "When a treatment or action should NOT be done because it could cause harm. For example, inducing vomiting is contraindicated for caustic substances (could burn twice) or petroleum products (aspiration risk). Always follow veterinary guidance rather than attempting home treatment.",
            category: .general,
            relatedTerms: ["Emesis", "Aspiration", "Decontamination"],
            searchKeywords: ["should not", "do not", "never do", "harmful treatment"]
        ),

        // 100. Toxin vs Toxicant
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000082")!,
            term: "Toxin vs Toxicant",
            pronunciation: nil,
            definition: "Technically, a 'toxin' is a poison produced by a living organism (like snake venom or bacterial toxins), while a 'toxicant' is a man-made or non-biological poison (like antifreeze or medications). In everyday use, 'toxin' is often used for both. This app uses 'toxin' broadly for simplicity.",
            category: .general,
            relatedTerms: ["Toxicosis"],
            searchKeywords: ["definition", "terminology", "difference"]
        ),

        // MARK: - Batch 6 (Session 101)

        // 102. Hypoxia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000084")!,
            term: "Hypoxia",
            pronunciation: "hy-POK-see-ah",
            definition: "Insufficient oxygen reaching the body's tissues. Can result from breathing problems, heart issues, anemia, or toxins that interfere with oxygen transport (like carbon monoxide or methemoglobin-forming agents). Signs include blue gums (cyanosis), rapid breathing, weakness, and collapse. Hypoxia is life-threatening.",
            category: .conditions,
            relatedTerms: ["Cyanosis", "Methemoglobinemia", "Dyspnea", "Respiratory Depression"],
            searchKeywords: ["low oxygen", "oxygen deprivation", "suffocation"]
        ),

        // 103. Anaphylaxis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000085")!,
            term: "Anaphylaxis",
            pronunciation: "an-ah-fih-LAK-sis",
            definition: "A severe, potentially fatal allergic reaction that occurs rapidly after exposure. In pets, common triggers include insect stings, certain medications, and vaccines. Signs include facial swelling, hives, vomiting, diarrhea, difficulty breathing, collapse, and shock. Requires immediate emergency treatment with epinephrine.",
            category: .conditions,
            relatedTerms: ["Shock", "Edema", "Collapse", "Dyspnea"],
            searchKeywords: ["allergic reaction", "severe allergy", "anaphylactic shock", "bee sting reaction"]
        ),

        // 104. Rhabdomyolysis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000086")!,
            term: "Rhabdomyolysis",
            pronunciation: "rab-doh-my-OL-ih-sis",
            definition: "Breakdown of muscle tissue, releasing muscle cell contents into the bloodstream. The released proteins (especially myoglobin) can damage the kidneys. Causes include prolonged seizures, hyperthermia, certain toxins (hops in dogs), and severe exertion. Signs include muscle pain, weakness, dark brown urine, and kidney failure.",
            category: .conditions,
            relatedTerms: ["Acute Kidney Injury", "Hyperthermia", "Seizures"],
            searchKeywords: ["muscle breakdown", "muscle damage", "myoglobin", "dark urine"]
        ),

        // 105. Serotonin Syndrome
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000087")!,
            term: "Serotonin Syndrome",
            pronunciation: nil,
            definition: "A potentially life-threatening condition caused by excessive serotonin activity in the nervous system. Usually results from drug interactions or overdoses of serotonergic medications (SSRIs, SNRIs, tramadol, trazodone). Signs include agitation, tremors, hyperthermia, rapid heart rate, dilated pupils, and in severe cases, seizures and death.",
            category: .conditions,
            relatedTerms: ["Tremors", "Hyperthermia", "Mydriasis", "Tachycardia"],
            searchKeywords: ["SSRI toxicity", "antidepressant overdose", "serotonin toxicity"]
        ),

        // 106. Fasciculations
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000088")!,
            term: "Fasciculations",
            pronunciation: "fah-sik-yoo-LAY-shunz",
            definition: "Fine, rapid twitching of small muscle groups visible under the skin. Different from tremors (which involve larger muscle movements). Often seen with organophosphate/carbamate poisoning, some mushroom toxins, and other neurotoxins. May appear as rippling or quivering under the skin.",
            category: .symptoms,
            relatedTerms: ["Tremors", "Neurotoxicity", "Seizures"],
            searchKeywords: ["muscle twitching", "twitches", "muscle rippling", "quivering"]
        ),

        // 107. Epistaxis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000089")!,
            term: "Epistaxis",
            pronunciation: "ep-ih-STAK-sis",
            definition: "Nosebleed—bleeding from the nostrils. Can be caused by trauma, but in toxicology often indicates clotting problems (anticoagulant rodenticide poisoning), severe hypertension, or erosion of nasal blood vessels. May appear as dripping blood, sneezing blood, or bloody discharge.",
            category: .symptoms,
            relatedTerms: ["Coagulopathy", "Petechiae", "Hematuria"],
            searchKeywords: ["nosebleed", "bloody nose", "nasal bleeding", "blood from nose"]
        ),

        // 108. Syncope
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000008A")!,
            term: "Syncope",
            pronunciation: "SIN-koh-pee",
            definition: "Fainting—a brief loss of consciousness due to temporarily reduced blood flow to the brain. The pet suddenly collapses but typically recovers within seconds to minutes. Causes include heart problems, severe arrhythmias, and certain toxins. Different from seizures (no paddling or muscle activity during syncope).",
            category: .symptoms,
            relatedTerms: ["Collapse", "Arrhythmia", "Bradycardia", "Hypotension"],
            searchKeywords: ["fainting", "fainted", "passed out", "blacked out"]
        ),

        // 109. Hypocalcemia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000008B")!,
            term: "Hypocalcemia",
            pronunciation: "hy-poh-kal-SEE-mee-ah",
            definition: "Dangerously low calcium levels in the blood. Calcium is essential for muscle and nerve function. Signs include muscle tremors, twitching, stiff gait, seizures, and cardiac abnormalities. Can be caused by ethylene glycol (antifreeze), oxalate-containing plants, and certain other toxins that bind calcium.",
            category: .conditions,
            relatedTerms: ["Tremors", "Seizures", "Electrolytes", "Arrhythmia"],
            searchKeywords: ["low calcium", "calcium deficiency"]
        ),

        // 110. Hyperkalemia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000008C")!,
            term: "Hyperkalemia",
            pronunciation: "hy-per-kah-LEE-mee-ah",
            definition: "Dangerously high potassium levels in the blood. Potassium is critical for heart and muscle function. Elevated levels can cause life-threatening heart arrhythmias, muscle weakness, and cardiac arrest. Often results from kidney failure (kidneys can't excrete potassium) or massive tissue damage.",
            category: .conditions,
            relatedTerms: ["Electrolytes", "Arrhythmia", "Acute Kidney Injury", "Cardiac Arrest"],
            searchKeywords: ["high potassium", "potassium toxicity", "elevated potassium"]
        ),

        // 111. Encephalopathy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000008D")!,
            term: "Encephalopathy",
            pronunciation: "en-sef-ah-LOP-ah-thee",
            definition: "A general term for brain dysfunction or damage. Signs include altered mental status, confusion, behavioral changes, seizures, and coma. 'Hepatic encephalopathy' occurs when liver failure allows toxins to affect the brain. 'Lead encephalopathy' refers to brain damage from lead poisoning.",
            category: .conditions,
            relatedTerms: ["CNS", "Seizures", "Hepatotoxicity", "Neurotoxicity"],
            searchKeywords: ["brain damage", "brain dysfunction", "altered mental status", "confusion"]
        ),

        // 112. Uremia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000008E")!,
            term: "Uremia",
            pronunciation: "yoo-REE-mee-ah",
            definition: "A condition where waste products (normally filtered by the kidneys) build up in the blood due to kidney failure. Signs include nausea, vomiting, loss of appetite, bad breath (ammonia smell), mouth ulcers, lethargy, and neurological changes. Indicates severe kidney dysfunction requiring aggressive treatment.",
            category: .conditions,
            relatedTerms: ["Acute Kidney Injury", "Nephrotoxicity", "Renal", "Azotemia"],
            searchKeywords: ["kidney failure toxins", "waste buildup", "uremic"]
        ),

        // 113. Icterus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000008F")!,
            term: "Icterus",
            pronunciation: "IK-ter-us",
            definition: "The medical term for jaundice—yellowing of the skin, gums, and whites of the eyes caused by elevated bilirubin. You may see 'icteric' on vet records (meaning jaundiced). Same condition as jaundice, just the clinical terminology veterinarians use in documentation and communication.",
            category: .conditions,
            relatedTerms: ["Jaundice", "Hepatotoxicity", "Hepatic", "Hemolysis"],
            searchKeywords: ["icteric", "yellow", "jaundice medical term", "bilirubin"]
        ),

        // 114. Pale Gums
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000090")!,
            term: "Pale Gums",
            pronunciation: nil,
            definition: "Gums that appear white, very light pink, or gray instead of healthy pink. Indicates reduced blood flow or oxygen delivery—commonly from blood loss, anemia, shock, or severe illness. To check, press on the gum briefly; healthy gums should return to pink within 1-2 seconds (capillary refill time).",
            category: .symptoms,
            relatedTerms: ["Anemia", "Shock", "Mucous Membranes", "Coagulopathy"],
            searchKeywords: ["white gums", "gray gums", "pallor", "capillary refill", "CRT"]
        ),

        // 115. Aspiration Pneumonia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000091")!,
            term: "Aspiration Pneumonia",
            pronunciation: nil,
            definition: "Lung infection caused by inhaling foreign material (vomit, food, liquids, or other substances) into the airways. A serious complication that can occur during vomiting, force-feeding, or with petroleum product ingestion. Signs include coughing, difficulty breathing, fever, and lethargy. This is why inducing vomiting at home can be dangerous.",
            category: .conditions,
            relatedTerms: ["Aspiration", "Dyspnea", "Pulmonary", "Emesis", "Contraindicated"],
            searchKeywords: ["lung infection", "inhaled vomit", "breathing problems after vomiting"]
        ),

        // MARK: - Batch 7 (Session 101)

        // 116. Oxygen Therapy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000092")!,
            term: "Oxygen Therapy",
            pronunciation: nil,
            definition: "Providing supplemental oxygen to a patient who isn't getting enough on their own. May be delivered via face mask, nasal prongs, oxygen cage, or in severe cases, mechanical ventilation. Essential for treating hypoxia from respiratory problems, methemoglobinemia, carbon monoxide poisoning, or other conditions affecting oxygen delivery.",
            category: .treatment,
            relatedTerms: ["Hypoxia", "Cyanosis", "Dyspnea", "Supportive Care"],
            searchKeywords: ["supplemental oxygen", "oxygen cage", "oxygen mask", "O2"]
        ),

        // 117. Blood Transfusion
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000093")!,
            term: "Blood Transfusion",
            pronunciation: nil,
            definition: "Transfer of whole blood or packed red blood cells from a donor to a patient. Used when severe blood loss or destruction of red blood cells (hemolysis) causes life-threatening anemia. May be needed in severe anticoagulant rodenticide poisoning, Heinz body anemia, or other conditions causing significant blood loss or red cell destruction.",
            category: .treatment,
            relatedTerms: ["Anemia", "Coagulopathy", "Hemolysis", "Supportive Care"],
            searchKeywords: ["blood donation", "packed red blood cells", "pRBCs", "transfuse"]
        ),

        // 118. Plasma Transfusion
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000094")!,
            term: "Plasma Transfusion",
            pronunciation: nil,
            definition: "Transfer of plasma (the liquid portion of blood containing clotting factors and proteins) from a donor. Used to replace clotting factors in coagulopathy, particularly anticoagulant rodenticide poisoning when active bleeding is present. Fresh frozen plasma (FFP) is the most common form used.",
            category: .treatment,
            relatedTerms: ["Coagulopathy", "Vitamin K Therapy", "Serum", "Supportive Care"],
            searchKeywords: ["fresh frozen plasma", "FFP", "clotting factors", "plasma donation"]
        ),

        // 119. Sedation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000095")!,
            term: "Sedation",
            pronunciation: nil,
            definition: "Using medications to calm a patient, reduce anxiety, or control dangerous symptoms like severe agitation or tremors. Sedation ranges from mild calming to deep unconsciousness. In toxicology, often used to control tremors, prevent injury during seizures, and reduce metabolic demand (which lowers body temperature in hyperthermia).",
            category: .treatment,
            relatedTerms: ["Tremors", "Seizures", "Supportive Care"],
            searchKeywords: ["sedate", "tranquilize", "sedatives"]
        ),

        // 120. Muscle Relaxants
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000096")!,
            term: "Muscle Relaxants",
            pronunciation: nil,
            definition: "Medications that reduce muscle tension, spasms, or rigidity. In toxicology, commonly used to control severe tremors (methocarbamol is frequently used). Different from sedatives—muscle relaxants specifically target muscle activity while sedatives affect the brain. Often used alongside sedation for tremorgenic toxins.",
            category: .treatment,
            relatedTerms: ["Tremors", "Fasciculations", "Sedation", "Supportive Care"],
            searchKeywords: ["methocarbamol", "Robaxin", "muscle spasms", "tremor control"]
        ),

        // 121. Thermoregulation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000097")!,
            term: "Thermoregulation",
            pronunciation: "ther-moh-reg-yoo-LAY-shun",
            definition: "Managing body temperature—either cooling an overheated patient or warming a cold one. Critical in toxicology because many toxins cause hyperthermia (tremors, seizures generate heat) or hypothermia (CNS depression reduces heat production). Methods include cooling fans, cool IV fluids, ice packs, or warming blankets.",
            category: .treatment,
            relatedTerms: ["Hyperthermia", "Hypothermia", "Supportive Care"],
            searchKeywords: ["temperature control", "temperature management"]
        ),

        // 122. Fluid Therapy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000098")!,
            term: "Fluid Therapy",
            pronunciation: nil,
            definition: "Administration of fluids to treat dehydration, maintain blood pressure, support organ function, or help flush toxins from the body. Usually given intravenously (IV fluids), but can also be given subcutaneously (under the skin). One of the most common and important supportive care treatments in toxicology.",
            category: .treatment,
            relatedTerms: ["IV Fluids", "Dehydration", "Supportive Care", "Nephrotoxicity"],
            searchKeywords: ["hydration", "IV drip", "subcutaneous fluids", "rehydration"]
        ),

        // 123. Enzyme Inhibition
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000099")!,
            term: "Enzyme Inhibition",
            pronunciation: nil,
            definition: "When a substance blocks or reduces the activity of an enzyme (a protein that speeds up chemical reactions in the body). This is how many toxins cause harm—for example, organophosphates inhibit acetylcholinesterase (an enzyme that breaks down a nerve signal chemical), causing nerve signals to continue uncontrolled.",
            category: .mechanisms,
            relatedTerms: ["Neurotoxicity", "Metabolite"],
            searchKeywords: ["enzyme blocker", "inhibitor", "acetylcholinesterase", "AChE"]
        ),

        // 124. Receptor Agonist
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000009A")!,
            term: "Receptor Agonist",
            pronunciation: "AG-oh-nist",
            definition: "A substance that binds to a receptor and activates it, triggering a response. Many drugs and toxins work this way—they mimic the body's natural signaling molecules. For example, opioids are agonists at opioid receptors, causing pain relief but also respiratory depression when overstimulated.",
            category: .mechanisms,
            relatedTerms: ["Receptor Antagonist", "Neurotoxicity"],
            searchKeywords: ["activator", "stimulates receptor", "mimics"]
        ),

        // 125. Receptor Antagonist
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000009B")!,
            term: "Receptor Antagonist",
            pronunciation: "an-TAG-oh-nist",
            definition: "A substance that binds to a receptor and blocks it, preventing activation. Many antidotes work this way—they compete with the toxin for the receptor. For example, naloxone is an opioid antagonist that reverses opioid overdose by blocking opioid receptors. Also called a 'blocker.'",
            category: .mechanisms,
            relatedTerms: ["Receptor Agonist", "Antidote"],
            searchKeywords: ["blocker", "blocks receptor", "reversal agent", "competitive inhibitor"]
        ),

        // 126. Toxic Dose
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000009C")!,
            term: "Toxic Dose",
            pronunciation: nil,
            definition: "The amount of a substance needed to cause harmful effects. Varies based on the specific toxin, species, body size, and individual sensitivity. Veterinarians use published toxic dose ranges to assess risk, but because of individual variation, any exposure to a known toxin warrants professional evaluation.",
            category: .general,
            relatedTerms: ["Dose-Dependent", "Idiosyncratic Reaction", "Body Weight"],
            searchKeywords: ["how much is toxic", "dangerous amount", "poisonous dose"]
        ),

        // 127. Margin of Safety
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000009D")!,
            term: "Margin of Safety",
            pronunciation: nil,
            definition: "The difference between a therapeutic dose and a toxic dose. Substances with a 'narrow margin of safety' become dangerous at doses only slightly above the effective dose—these are more likely to cause accidental poisoning. Substances with a 'wide margin' are safer because toxicity requires much higher doses.",
            category: .general,
            relatedTerms: ["Toxic Dose", "Dose-Dependent"],
            searchKeywords: ["therapeutic index", "safety window", "narrow margin", "wide margin"]
        ),

        // 128. Species Sensitivity
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000009E")!,
            term: "Species Sensitivity",
            pronunciation: nil,
            definition: "Different animal species can have vastly different reactions to the same substance. Cats lack certain liver enzymes, making them extremely sensitive to drugs safe for dogs (like permethrin). Birds have highly efficient respiratory systems, making inhaled toxins more dangerous. This is why pet toxicity information must be species-specific.",
            category: .general,
            relatedTerms: ["Metabolite", "Hepatic"],
            searchKeywords: ["cats vs dogs", "species differences", "why cats are different", "bird sensitivity"]
        ),

        // 129. Decontamination Window
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-00000000009F")!,
            term: "Decontamination Window",
            pronunciation: nil,
            definition: "The limited time after ingestion when decontamination (inducing vomiting, giving activated charcoal) can be effective. Generally, emesis is most useful within 1-2 hours of ingestion before the toxin moves deeper into the GI tract or is absorbed. After this window, decontamination may be ineffective or even harmful.",
            category: .general,
            relatedTerms: ["Decontamination", "Emesis", "Activated Charcoal", "Time Since Exposure"],
            searchKeywords: ["how long after eating", "when to induce vomiting", "time limit", "too late"]
        ),

        // 130. Secondary Exposure
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A0")!,
            term: "Secondary Exposure",
            pronunciation: nil,
            definition: "Poisoning that occurs indirectly, not from the original source. Examples include: a pet grooming toxin-contaminated fur and ingesting it, a cat eating a rodent that consumed rodenticide, or a pet licking antifreeze off another pet's paws. Secondary exposure is often overlooked but can be just as dangerous as direct exposure.",
            category: .general,
            relatedTerms: ["Dermal Exposure", "Ingestion"],
            searchKeywords: ["relay toxicosis", "indirect poisoning", "eating poisoned rodent"]
        ),

        // MARK: - Batch 8 (Session 101)

        // 131. Hyperesthesia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A1")!,
            term: "Hyperesthesia",
            pronunciation: "hy-per-es-THEE-zee-ah",
            definition: "Abnormally heightened sensitivity to touch or stimuli. The pet may react dramatically to gentle touch, have rippling skin, or seem painful when handled. Classic sign of permethrin toxicity in cats—they may twitch, vocalize, or bite when touched. Also seen with some other neurotoxins.",
            category: .symptoms,
            relatedTerms: ["Neurotoxicity", "Tremors", "Fasciculations"],
            searchKeywords: ["sensitive to touch", "painful to touch", "skin rippling", "overreacting to touch"]
        ),

        // 132. Opisthotonus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A2")!,
            term: "Opisthotonus",
            pronunciation: "oh-pis-THOT-oh-nus",
            definition: "Severe muscle spasm causing the head and neck to arch backward and the back to become rigidly extended. A dramatic, alarming posture indicating severe neurological involvement. Seen with strychnine poisoning, metaldehyde (slug bait), severe tetanus, and some other neurotoxins. Always a critical emergency.",
            category: .symptoms,
            relatedTerms: ["Seizures", "Tremors", "Neurotoxicity"],
            searchKeywords: ["arched back", "head thrown back", "rigid posture", "body arching"]
        ),

        // 134. Photosensitivity
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A4")!,
            term: "Photosensitivity",
            pronunciation: "foh-toh-sen-sih-TIV-ih-tee",
            definition: "Abnormal sensitivity to sunlight causing skin damage in areas exposed to light (often non-pigmented or hairless areas). Certain plants (St. John's Wort, buckwheat) contain compounds that accumulate in skin and react with UV light, causing burns and tissue damage. More common in livestock but can affect pets.",
            category: .symptoms,
            relatedTerms: ["Dermal Exposure"],
            searchKeywords: ["sun sensitivity", "sunburn", "light sensitivity", "UV reaction"]
        ),

        // 135. Sudden Blindness
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A5")!,
            term: "Sudden Blindness",
            pronunciation: nil,
            definition: "Rapid loss of vision occurring within hours to days. Can result from severe hypertension (detached retinas), ivermectin toxicity in sensitive breeds, lead poisoning, or other toxins affecting the eyes or brain. Signs include bumping into objects, dilated unresponsive pupils, and hesitance to move. Requires immediate veterinary evaluation.",
            category: .symptoms,
            relatedTerms: ["Hypertension", "Mydriasis", "Neurotoxicity"],
            searchKeywords: ["can't see", "blind", "vision loss", "bumping into things"]
        ),

        // 136. DIC
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A6")!,
            term: "DIC",
            pronunciation: nil,
            definition: "Disseminated Intravascular Coagulation—a life-threatening condition where the clotting system becomes overactivated throughout the body, using up clotting factors and platelets. Paradoxically causes both widespread clotting AND uncontrolled bleeding. Can be triggered by severe infections, toxins, heatstroke, or snake envenomation. Extremely serious with high mortality.",
            category: .conditions,
            relatedTerms: ["Coagulopathy", "Platelets", "Shock", "Petechiae", "Hemostasis"],
            searchKeywords: ["disseminated intravascular coagulation", "clotting disorder", "bleeding and clotting"]
        ),

        // 137. Dialysis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A7")!,
            term: "Dialysis",
            pronunciation: "dy-AL-ih-sis",
            definition: "A procedure that filters waste products and toxins from the blood when the kidneys cannot. Hemodialysis uses a machine; peritoneal dialysis uses the abdominal lining. Available only at specialty veterinary hospitals. Can be life-saving for acute kidney failure from antifreeze or lily toxicity, or to remove certain toxins directly from blood.",
            category: .treatment,
            relatedTerms: ["Acute Kidney Injury", "Nephrotoxicity", "Uremia"],
            searchKeywords: ["hemodialysis", "kidney machine", "blood filtering", "renal replacement"]
        ),

        // 138. Intubation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A8")!,
            term: "Intubation",
            pronunciation: "in-too-BAY-shun",
            definition: "Placing a breathing tube into the trachea (windpipe) to secure the airway and allow mechanical ventilation. Necessary for patients with severe respiratory depression, during anesthesia, or to protect the airway during gastric lavage. The tube ensures oxygen can reach the lungs even if the pet cannot breathe effectively on their own.",
            category: .treatment,
            relatedTerms: ["Respiratory Depression", "Oxygen Therapy", "Gastric Lavage"],
            searchKeywords: ["breathing tube", "airway", "ventilator", "mechanical ventilation"]
        ),

        // 139. Pain Management
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000A9")!,
            term: "Pain Management",
            pronunciation: nil,
            definition: "Using medications and techniques to control pain. Important in toxicology because some poisonings cause significant discomfort (caustic burns, GI irritation, tissue damage). Uncontrolled pain increases stress, slows healing, and worsens outcomes. Veterinarians use various analgesics depending on the type and severity of pain.",
            category: .treatment,
            relatedTerms: ["Supportive Care", "Symptomatic Treatment"],
            searchKeywords: ["pain relief", "analgesic", "pain control", "pain medication"]
        ),

        // 140. Bioavailability
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000AA")!,
            term: "Bioavailability",
            pronunciation: "by-oh-ah-vay-lah-BIL-ih-tee",
            definition: "The proportion of a substance that actually reaches the bloodstream and can cause effects. Not everything ingested is fully absorbed—some passes through unchanged, some is broken down before absorption. A toxin with high bioavailability is more dangerous because more of it reaches the body. Affected by formulation, stomach contents, and other factors.",
            category: .mechanisms,
            relatedTerms: ["Ingestion", "Metabolite", "GI Tract"],
            searchKeywords: ["absorption", "how much absorbed", "reaches bloodstream"]
        ),

        // 141. Body Weight
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000AB")!,
            term: "Body Weight",
            pronunciation: nil,
            definition: "In toxicology, body weight is critical because toxic doses are typically calculated per kilogram (or pound) of body weight. A dose that causes mild symptoms in a 50-lb dog could be fatal to a 10-lb dog. This is why small pets (toy breeds, kittens, pocket pets) are at higher risk—the same amount of toxin is a relatively larger dose.",
            category: .general,
            relatedTerms: ["Toxic Dose", "Dose-Dependent", "Margin of Safety"],
            searchKeywords: ["small dogs", "toy breeds", "weight-based dosing"]
        ),

        // 142. Time Since Exposure
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000AC")!,
            term: "Time Since Exposure",
            pronunciation: nil,
            definition: "How long ago the pet was exposed to the toxin—crucial information for treatment decisions. Recent exposure (within 1-2 hours) may allow decontamination. Longer intervals mean the toxin is likely already absorbed, shifting focus to supportive care. Always note the time of exposure (or when the pet was last seen normal) when calling for help.",
            category: .general,
            relatedTerms: ["Decontamination Window", "Decontamination", "Emesis"],
            searchKeywords: ["when did it happen", "how long ago", "time of ingestion"]
        ),

        // 143. Oxidative Stress
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000AD")!,
            term: "Oxidative Stress",
            pronunciation: nil,
            definition: "Cellular damage caused by an imbalance between harmful reactive oxygen molecules (free radicals) and the body's ability to neutralize them. Many toxins cause harm through oxidative stress—damaging cell membranes, proteins, and DNA. Onions, garlic, zinc, and acetaminophen (in cats) all cause oxidative damage to red blood cells.",
            category: .mechanisms,
            relatedTerms: ["Oxidative Damage", "Heinz Body Anemia", "Hemolysis"],
            searchKeywords: ["free radicals", "cell damage", "reactive oxygen"]
        ),

        // 144. Protein Binding
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000AE")!,
            term: "Protein Binding",
            pronunciation: nil,
            definition: "When a substance attaches to proteins in the blood. Highly protein-bound toxins are harder to remove with dialysis or other treatments because only the 'free' (unbound) portion can be filtered. This affects how long a toxin stays in the body and how it distributes to tissues. NSAIDs and many other drugs are highly protein-bound.",
            category: .mechanisms,
            relatedTerms: ["Serum", "Dialysis", "Half-life"],
            searchKeywords: ["bound to protein", "albumin binding", "drug binding"]
        ),

        // 145. Mitochondrial Toxicity
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000AF")!,
            term: "Mitochondrial Toxicity",
            pronunciation: "my-toh-KON-dree-al",
            definition: "Damage to mitochondria—the 'power plants' inside cells that produce energy. When mitochondria are damaged, cells can't generate energy and may die. Certain toxins specifically target mitochondria, causing widespread organ damage. This mechanism is involved in some cases of liver failure, heart damage, and muscle breakdown from various toxins.",
            category: .mechanisms,
            relatedTerms: ["Hepatotoxicity", "Cardiotoxicity", "Rhabdomyolysis"],
            searchKeywords: ["cell energy", "cellular damage", "mitochondria damage"]
        ),

        // MARK: - Batch 9 (Session 101)

        // 146. Stranguria
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B0")!,
            term: "Stranguria",
            pronunciation: "stran-GOO-ree-ah",
            definition: "Painful, difficult urination with straining. The pet may posture repeatedly to urinate, produce only small amounts, vocalize, or lick the genital area. Can indicate urinary obstruction (emergency in male cats), bladder irritation from toxins, or urinary tract infection. If your pet is straining and not producing urine, seek emergency care immediately.",
            category: .symptoms,
            relatedTerms: ["Hematuria", "Renal", "Nephrotoxicity"],
            searchKeywords: ["straining to urinate", "painful urination", "can't pee", "difficulty urinating"]
        ),

        // 147. Tenesmus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B1")!,
            term: "Tenesmus",
            pronunciation: "teh-NEZ-mus",
            definition: "Straining to defecate, often with little or no result. The pet repeatedly assumes a posture to have a bowel movement but produces little or nothing, or only small amounts of mucus or blood. Can indicate GI irritation, obstruction, or colitis. Often confused with constipation or urinary straining.",
            category: .symptoms,
            relatedTerms: ["Diarrhea", "GI Tract", "Obstruction"],
            searchKeywords: ["straining to poop", "can't defecate", "straining bowel movement"]
        ),

        // 148. Anisocoria
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B2")!,
            term: "Anisocoria",
            pronunciation: "an-eye-soh-KOR-ee-ah",
            definition: "Unequal pupil sizes—one pupil larger or smaller than the other. Can indicate neurological problems, eye injury, or certain toxin effects. Some toxins cause both pupils to dilate (mydriasis) or constrict (miosis), but asymmetry suggests a focal problem and warrants immediate veterinary evaluation.",
            category: .symptoms,
            relatedTerms: ["Mydriasis", "Miosis", "CNS", "Neurotoxicity"],
            searchKeywords: ["unequal pupils", "different pupil sizes", "one pupil bigger"]
        ),

        // 149. Pruritus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B3")!,
            term: "Pruritus",
            pronunciation: "proo-RY-tus",
            definition: "Itching—the sensation that causes the desire to scratch, lick, or rub. While often associated with allergies or parasites, some toxin exposures (especially skin contact with irritants or allergic reactions) can cause intense pruritus. The pet may scratch, chew at skin, rub against objects, or have red irritated skin.",
            category: .symptoms,
            relatedTerms: ["Dermal Exposure", "Anaphylaxis"],
            searchKeywords: ["itching", "itchy", "scratching", "skin irritation"]
        ),

        // 150. Atropine
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B4")!,
            term: "Atropine",
            pronunciation: "AT-roh-peen",
            definition: "A medication used as an antidote for organophosphate and carbamate insecticide poisoning. It blocks the excessive nerve signaling caused by these toxins, reducing salivation, bronchial secretions, and slowing dangerous gut activity. Must be given by a veterinarian and often requires repeated dosing. Also used in some cardiac emergencies.",
            category: .treatment,
            relatedTerms: ["Antidote", "Receptor Antagonist", "Enzyme Inhibition"],
            searchKeywords: ["organophosphate antidote", "carbamate antidote", "anticholinergic"]
        ),

        // 151. 2-PAM (Pralidoxime)
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B5")!,
            term: "2-PAM (Pralidoxime)",
            pronunciation: "prah-LID-ox-eem",
            definition: "A medication used alongside atropine for organophosphate poisoning. While atropine manages symptoms, 2-PAM actually reactivates the inhibited enzyme (acetylcholinesterase) if given early enough. Most effective within the first 24-48 hours. Not effective for carbamate poisoning. Given by injection at veterinary hospitals.",
            category: .treatment,
            relatedTerms: ["Atropine", "Antidote", "Enzyme Inhibition"],
            searchKeywords: ["pralidoxime", "organophosphate treatment", "enzyme reactivator"]
        ),

        // 152. Fomepizole
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B6")!,
            term: "Fomepizole",
            pronunciation: "foh-MEP-ih-zohl",
            definition: "The preferred antidote for ethylene glycol (antifreeze) poisoning in dogs. It blocks the enzyme that converts ethylene glycol into its toxic metabolites. Most effective when given within 8-12 hours of ingestion, before kidney damage occurs. Very expensive but highly effective. Less effective in cats, who may need ethanol treatment instead.",
            category: .treatment,
            relatedTerms: ["Antidote", "Enzyme Inhibition", "Metabolite", "Acute Kidney Injury"],
            searchKeywords: ["antifreeze antidote", "ethylene glycol treatment", "Antizol"]
        ),

        // 153. N-Acetylcysteine (NAC)
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B7")!,
            term: "N-Acetylcysteine (NAC)",
            pronunciation: "en-ah-SEE-til-SIS-teen",
            definition: "The antidote for acetaminophen (Tylenol) toxicity. It replenishes glutathione, a natural antioxidant that protects cells from acetaminophen's toxic metabolite. Most effective when given early, ideally within 8 hours of ingestion. Also used for some other oxidative toxicities. Given IV at veterinary hospitals.",
            category: .treatment,
            relatedTerms: ["Antidote", "Hepatotoxicity", "Oxidative Damage", "Methemoglobinemia"],
            searchKeywords: ["acetaminophen antidote", "Tylenol antidote", "NAC", "Mucomyst"]
        ),

        // 154. Methylene Blue
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B8")!,
            term: "Methylene Blue",
            pronunciation: nil,
            definition: "A medication used to treat methemoglobinemia—it helps convert methemoglobin back to normal hemoglobin, restoring oxygen-carrying capacity. Given IV when methemoglobin levels are dangerously high. Causes blue-green discoloration of urine (normal effect). Used cautiously in cats, who are sensitive to oxidative damage.",
            category: .treatment,
            relatedTerms: ["Methemoglobinemia", "Antidote", "Cyanosis", "Hemoglobin"],
            searchKeywords: ["methemoglobinemia treatment", "blue dye treatment"]
        ),

        // 155. Pancreas
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000B9")!,
            term: "Pancreas",
            pronunciation: "PAN-kree-as",
            definition: "An organ that produces digestive enzymes and hormones (including insulin). When inflamed (pancreatitis), digestive enzymes can leak and damage surrounding tissue. High-fat foods and certain toxins can trigger pancreatitis. Located near the stomach and small intestine. Pancreatitis causes severe abdominal pain, vomiting, and can be life-threatening.",
            category: .anatomy,
            relatedTerms: ["Pancreatitis", "GI Tract"],
            searchKeywords: ["digestive organ", "insulin"]
        ),

        // 156. Esophagus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000BA")!,
            term: "Esophagus",
            pronunciation: "eh-SOF-ah-gus",
            definition: "The muscular tube connecting the mouth to the stomach. Caustic substances (strong acids or bases like drain cleaners) can burn the esophagus on the way down AND potentially again if vomiting is induced—which is why inducing vomiting is contraindicated for caustic ingestions. Esophageal damage can cause strictures (narrowing) requiring long-term management.",
            category: .anatomy,
            relatedTerms: ["GI Tract", "Regurgitation", "Contraindicated"],
            searchKeywords: ["food pipe", "swallowing tube"]
        ),

        // 157. Bone Marrow
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000BB")!,
            term: "Bone Marrow",
            pronunciation: nil,
            definition: "Soft tissue inside bones where blood cells are produced—red blood cells, white blood cells, and platelets all originate here. Some toxins suppress bone marrow function, leading to anemia, increased infection risk, and bleeding problems. Bone marrow suppression may not be apparent for days after exposure as existing blood cells are depleted.",
            category: .anatomy,
            relatedTerms: ["Anemia", "Platelets", "Hemoglobin"],
            searchKeywords: ["blood cell production", "blood factory"]
        ),

        // 158. Spleen
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000BC")!,
            term: "Spleen",
            pronunciation: nil,
            definition: "An organ that filters blood, removes old or damaged red blood cells, and stores blood cells. In Heinz body anemia and other hemolytic conditions, the spleen works overtime removing damaged red blood cells. The spleen may enlarge (splenomegaly) in response to increased workload. Located in the left side of the abdomen.",
            category: .anatomy,
            relatedTerms: ["Hemolysis", "Heinz Body Anemia", "Anemia"],
            searchKeywords: ["blood filter", "red blood cell removal"]
        ),

        // 159. Myocardium
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000BD")!,
            term: "Myocardium",
            pronunciation: "my-oh-KAR-dee-um",
            definition: "The muscular wall of the heart—the tissue that contracts to pump blood. 'Myocardial damage' means injury to the heart muscle itself. Some toxins (certain plants like oleander, foxglove, and some medications) directly damage the myocardium or disrupt its electrical activity, causing life-threatening cardiac problems.",
            category: .anatomy,
            relatedTerms: ["Cardiotoxicity", "Arrhythmia", "Cardiac Arrest"],
            searchKeywords: ["heart muscle", "heart wall", "cardiac muscle"]
        ),

        // 160. Nephron
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000BE")!,
            term: "Nephron",
            pronunciation: "NEF-ron",
            definition: "The microscopic functional unit of the kidney—each kidney contains hundreds of thousands of nephrons that filter blood, remove waste, and regulate fluid balance. When nephrons are damaged by toxins (ethylene glycol, lilies, NSAIDs), kidney function declines. Unlike some organs, damaged nephrons generally cannot regenerate.",
            category: .anatomy,
            relatedTerms: ["Renal", "Nephrotoxicity", "Acute Kidney Injury"],
            searchKeywords: ["kidney unit", "kidney cells", "filtration unit"]
        ),

        // MARK: - Batch 10 (Session 101)

        // 161. Hemoptysis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000BF")!,
            term: "Hemoptysis",
            pronunciation: "hee-MOP-tih-sis",
            definition: "Coughing up blood—blood originating from the lungs or airways. Different from hematemesis (vomiting blood from the stomach). May appear as bright red blood, pink frothy sputum, or blood-tinged mucus. Can indicate severe anticoagulant rodenticide poisoning, lung damage, or other serious respiratory problems.",
            category: .symptoms,
            relatedTerms: ["Coagulopathy", "Pulmonary", "Hematemesis"],
            searchKeywords: ["coughing blood", "bloody cough", "blood from lungs"]
        ),

        // 162. Borborygmi
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C0")!,
            term: "Borborygmi",
            pronunciation: "bor-boh-RIG-mee",
            definition: "Gurgling or rumbling sounds from the intestines caused by gas and fluid movement—'stomach growling.' Increased borborygmi can indicate GI upset, while absent gut sounds may indicate ileus (intestinal shutdown). Veterinarians listen with a stethoscope to assess GI function. Pronounced sounds are often audible without equipment.",
            category: .symptoms,
            relatedTerms: ["GI Tract", "Ileus", "Diarrhea"],
            searchKeywords: ["stomach growling", "gut sounds", "intestinal sounds", "rumbling stomach"]
        ),

        // 163. Ptosis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C1")!,
            term: "Ptosis",
            pronunciation: "TOH-sis",
            definition: "Drooping of the upper eyelid. Can indicate neurological problems, muscle weakness, or certain toxin effects. Bilateral (both eyes) ptosis may occur with botulism, tick paralysis, or some snake envenomations. May be subtle—the eye appears partially closed or sleepy-looking.",
            category: .symptoms,
            relatedTerms: ["Neurotoxicity", "Paralysis", "Paresis"],
            searchKeywords: ["droopy eyelid", "eyelid drooping", "sleepy eye", "can't open eye fully"]
        ),

        // 164. ARDS
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C2")!,
            term: "ARDS",
            pronunciation: nil,
            definition: "Acute Respiratory Distress Syndrome—severe lung inflammation causing fluid buildup and difficulty getting oxygen into the blood. A life-threatening complication that can follow aspiration, smoke inhalation, sepsis, or severe systemic illness. Requires intensive care with oxygen support, often mechanical ventilation. High mortality rate.",
            category: .conditions,
            relatedTerms: ["Pulmonary", "Dyspnea", "Hypoxia", "Aspiration Pneumonia"],
            searchKeywords: ["acute respiratory distress syndrome", "lung failure", "severe breathing problems"]
        ),

        // 165. Hepatic Encephalopathy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C3")!,
            term: "Hepatic Encephalopathy",
            pronunciation: "heh-PAT-ik en-sef-ah-LOP-ah-thee",
            definition: "Brain dysfunction caused by liver failure. When the liver can't filter toxins (especially ammonia) from blood, these substances affect brain function. Signs include disorientation, behavior changes, circling, head pressing, seizures, and coma. Seen with severe hepatotoxicity, portosystemic shunts, or end-stage liver disease.",
            category: .conditions,
            relatedTerms: ["Encephalopathy", "Hepatotoxicity", "Hepatic", "Seizures"],
            searchKeywords: ["liver brain syndrome", "ammonia toxicity", "liver failure confusion"]
        ),

        // 166. Cardiomyopathy
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C4")!,
            term: "Cardiomyopathy",
            pronunciation: "kar-dee-oh-my-OP-ah-thee",
            definition: "Disease of the heart muscle that impairs the heart's ability to pump blood effectively. Can be caused by some toxins (cobalt, certain drugs) or nutritional deficiencies. Types include dilated (enlarged, weak heart) and hypertrophic (thickened walls). Results in poor circulation, exercise intolerance, and potentially heart failure.",
            category: .conditions,
            relatedTerms: ["Cardiotoxicity", "Myocardium", "Arrhythmia"],
            searchKeywords: ["heart disease", "weak heart", "heart muscle disease", "DCM", "HCM"]
        ),

        // 167. Whole Bowel Irrigation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C5")!,
            term: "Whole Bowel Irrigation",
            pronunciation: nil,
            definition: "A decontamination technique using large volumes of a special electrolyte solution (polyethylene glycol) given by mouth or stomach tube to flush the entire GI tract. Used for sustained-release medications, iron, lead, or packets of drugs. Causes continuous watery diarrhea until the GI tract is cleared. Done only in veterinary hospitals.",
            category: .treatment,
            relatedTerms: ["Decontamination", "GI Tract", "Activated Charcoal"],
            searchKeywords: ["bowel flush", "GI flush", "PEG lavage", "GoLYTELY"]
        ),

        // 168. Cathartic
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C6")!,
            term: "Cathartic",
            pronunciation: "kah-THAR-tik",
            definition: "A substance that accelerates bowel movements to help eliminate toxins from the GI tract faster. Sometimes given with activated charcoal (sorbitol is common). Used cautiously because they can cause dehydration and electrolyte imbalances. Not recommended for home use—veterinarians decide when cathartics are appropriate.",
            category: .treatment,
            relatedTerms: ["Decontamination", "Activated Charcoal", "Diarrhea"],
            searchKeywords: ["laxative", "bowel stimulant", "sorbitol", "speeds elimination"]
        ),

        // 169. Anticonvulsant
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C7")!,
            term: "Anticonvulsant",
            pronunciation: "an-tee-kon-VUL-sant",
            definition: "Medication used to stop or prevent seizures. Common veterinary anticonvulsants include diazepam (Valium), phenobarbital, levetiracetam (Keppra), and propofol. Critical for managing seizures from toxins—uncontrolled seizures cause hyperthermia, brain damage, and can be fatal. Multiple drugs may be needed for severe cases.",
            category: .treatment,
            relatedTerms: ["Seizures", "Sedation", "Neurotoxicity"],
            searchKeywords: ["seizure medication", "anti-seizure", "stops seizures", "diazepam", "phenobarbital"]
        ),

        // 170. Deferoxamine
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C8")!,
            term: "Deferoxamine",
            pronunciation: "deh-fer-OX-ah-meen",
            definition: "A chelating agent used specifically for iron poisoning. It binds to excess iron in the blood, forming a complex that can be excreted by the kidneys. Given by IV infusion at veterinary hospitals. Causes the urine to turn a characteristic reddish-brown color ('vin rosé') as iron is eliminated.",
            category: .treatment,
            relatedTerms: ["Chelation Therapy", "Antidote"],
            searchKeywords: ["iron antidote", "iron poisoning treatment", "Desferal"]
        ),

        // 171. Pharmacokinetics
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000C9")!,
            term: "Pharmacokinetics",
            pronunciation: "far-mah-koh-kih-NET-iks",
            definition: "The study of how the body handles a substance over time—absorption (getting in), distribution (spreading through tissues), metabolism (breaking down), and elimination (getting out). Understanding pharmacokinetics helps predict how long a toxin will remain in the body and how it will affect different organs.",
            category: .general,
            relatedTerms: ["Bioavailability", "Half-life", "Metabolite"],
            searchKeywords: ["ADME", "drug movement", "how body processes drugs"]
        ),

        // 172. First-Pass Metabolism
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000CA")!,
            term: "First-Pass Metabolism",
            pronunciation: nil,
            definition: "When a substance absorbed from the GI tract passes through the liver before reaching general circulation, and the liver metabolizes some of it. This can reduce the amount reaching the body (reducing effect) or convert a harmless substance into a toxic metabolite (increasing danger). Substances injected or inhaled bypass first-pass metabolism.",
            category: .mechanisms,
            relatedTerms: ["Hepatic", "Metabolite", "Bioavailability"],
            searchKeywords: ["liver processing", "first pass effect", "presystemic metabolism"]
        ),

        // 173. Enterohepatic Recirculation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000CB")!,
            term: "Enterohepatic Recirculation",
            pronunciation: "EN-ter-oh-heh-PAT-ik",
            definition: "A cycle where substances excreted by the liver into bile are reabsorbed from the intestines back into the bloodstream. This prolongs the time a toxin stays in the body. Activated charcoal can interrupt this cycle by binding the substance in the gut before reabsorption. Important for some drugs and toxins.",
            category: .mechanisms,
            relatedTerms: ["Hepatic", "GI Tract", "Activated Charcoal", "Half-life"],
            searchKeywords: ["recirculation", "bile cycle", "reabsorption"]
        ),

        // 174. Volume of Distribution
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000CC")!,
            term: "Volume of Distribution",
            pronunciation: nil,
            definition: "A measure of how widely a substance spreads throughout the body. A high volume of distribution means the substance leaves the bloodstream and accumulates in tissues—making it harder to remove with dialysis. A low volume means it stays mostly in the blood—easier to filter out. Affects treatment decisions for serious poisonings.",
            category: .general,
            relatedTerms: ["Dialysis", "Protein Binding", "Pharmacokinetics"],
            searchKeywords: ["Vd", "tissue distribution", "drug distribution"]
        ),

        // 175. LD50
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000CD")!,
            term: "LD50",
            pronunciation: nil,
            definition: "Lethal Dose 50%—the dose that kills 50% of test animals in laboratory studies. Used in toxicology research to compare relative toxicity of substances. NOT useful for clinical decisions because it doesn't account for individual variation, species differences, or non-lethal harm. Pet Toxic does not use LD50 values because they can mislead pet owners about 'safe' amounts.",
            category: .general,
            relatedTerms: ["Toxic Dose", "Dose-Dependent"],
            searchKeywords: ["lethal dose", "median lethal dose", "toxicity testing"]
        ),

        // MARK: - Batch 11 (Session 101) — FINAL BATCH

        // 176. Strabismus
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000CE")!,
            term: "Strabismus",
            pronunciation: "strah-BIZ-mus",
            definition: "Abnormal positioning of the eyes—they don't look in the same direction. One or both eyes may deviate inward, outward, up, or down. Can indicate neurological problems, vestibular disease, or certain toxin effects. May appear suddenly with some poisonings. Different from nystagmus (rhythmic eye movement).",
            category: .symptoms,
            relatedTerms: ["Nystagmus", "Neurotoxicity", "CNS"],
            searchKeywords: ["crossed eyes", "eye deviation", "eyes pointing different directions", "lazy eye"]
        ),

        // 177. Thrombocytopenia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000CF")!,
            term: "Thrombocytopenia",
            pronunciation: "throm-boh-sy-toh-PEE-nee-ah",
            definition: "Abnormally low platelet count. Since platelets are essential for clotting, low levels cause bleeding problems—petechiae, bruising, prolonged bleeding from wounds, and internal hemorrhage. Can result from bone marrow suppression, immune destruction, or consumption (as in DIC). Different mechanism than anticoagulant rodenticide poisoning.",
            category: .conditions,
            relatedTerms: ["Platelets", "Coagulopathy", "Petechiae", "Bone Marrow"],
            searchKeywords: ["low platelets", "platelet deficiency", "bleeding disorder"]
        ),

        // 178. Myocarditis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D0")!,
            term: "Myocarditis",
            pronunciation: "my-oh-kar-DY-tis",
            definition: "Inflammation of the heart muscle (myocardium). Can be caused by infections, immune reactions, or certain toxins. Results in weakened heart contractions, arrhythmias, and potentially heart failure. Signs include weakness, exercise intolerance, rapid or irregular heartbeat, and breathing difficulty. Requires intensive supportive care.",
            category: .conditions,
            relatedTerms: ["Myocardium", "Cardiotoxicity", "Arrhythmia", "Cardiomyopathy"],
            searchKeywords: ["heart inflammation", "inflamed heart", "heart muscle inflammation"]
        ),

        // 179. Cornea
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D1")!,
            term: "Cornea",
            pronunciation: "KOR-nee-ah",
            definition: "The clear, dome-shaped outer layer at the front of the eye. Caustic substances (acids, bases, some plant saps) can burn the cornea, causing pain, cloudiness, ulceration, and potentially permanent vision damage. Eye exposure to irritants requires immediate flushing with water or saline and veterinary evaluation.",
            category: .anatomy,
            relatedTerms: ["Dermal Exposure", "Sudden Blindness"],
            searchKeywords: ["eye surface", "clear part of eye", "eye burn"]
        ),

        // 180. Retina
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D2")!,
            term: "Retina",
            pronunciation: "RET-ih-nah",
            definition: "The light-sensitive tissue lining the back of the eye that converts light into nerve signals for vision. Some toxins damage the retina directly, while others cause retinal detachment (usually from severe hypertension). Retinal damage can cause sudden blindness. The retina is examined with an ophthalmoscope.",
            category: .anatomy,
            relatedTerms: ["Sudden Blindness", "Hypertension"],
            searchKeywords: ["back of eye", "vision tissue", "retinal detachment"]
        ),

        // 181. Pharmacodynamics
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D3")!,
            term: "Pharmacodynamics",
            pronunciation: "far-mah-koh-dy-NAM-iks",
            definition: "The study of what a substance does TO the body—its effects on organs, receptors, and biological processes. While pharmacokinetics is 'what the body does to the drug,' pharmacodynamics is 'what the drug does to the body.' Understanding both helps predict toxicity patterns and treatment approaches.",
            category: .general,
            relatedTerms: ["Pharmacokinetics", "Receptor Agonist", "Receptor Antagonist"],
            searchKeywords: ["drug effects", "how drugs work", "mechanism of action"]
        ),

        // 182. Clearance
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D4")!,
            term: "Clearance",
            pronunciation: nil,
            definition: "The rate at which a substance is removed from the body, usually expressed as volume of blood cleared per unit time. Depends on liver metabolism, kidney excretion, and other elimination routes. Reduced clearance (from liver or kidney disease) means toxins stay in the body longer, potentially worsening effects.",
            category: .general,
            relatedTerms: ["Half-life", "Hepatic", "Renal", "Pharmacokinetics"],
            searchKeywords: ["elimination rate", "removal rate", "how fast eliminated"]
        ),

        // 183. Steady State
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D5")!,
            term: "Steady State",
            pronunciation: nil,
            definition: "When the amount of substance entering the body equals the amount being eliminated—blood levels remain constant. Important for medications given repeatedly: it takes about 4-5 half-lives to reach steady state. In toxicology, helps predict when blood levels will peak with chronic exposure or repeated dosing.",
            category: .general,
            relatedTerms: ["Half-life", "Chronic", "Clearance"],
            searchKeywords: ["equilibrium", "stable levels", "constant concentration"]
        ),

        // 184. Loading Dose
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D6")!,
            term: "Loading Dose",
            pronunciation: nil,
            definition: "A larger initial dose given to rapidly achieve effective blood levels, followed by smaller maintenance doses. Used when waiting for steady state would take too long. For example, Vitamin K therapy for rodenticide poisoning often starts with a loading dose to quickly restore clotting ability while maintenance doses continue protection.",
            category: .treatment,
            relatedTerms: ["Maintenance Dose", "Steady State", "Vitamin K Therapy"],
            searchKeywords: ["initial dose", "first dose", "bolus dose"]
        ),

        // 185. Maintenance Dose
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D7")!,
            term: "Maintenance Dose",
            pronunciation: nil,
            definition: "The regular, ongoing dose given to maintain effective blood levels after a loading dose or once steady state is reached. Designed to replace the amount eliminated between doses. Vitamin K therapy for rodenticide poisoning requires maintenance dosing for weeks because the toxin persists in the body.",
            category: .treatment,
            relatedTerms: ["Loading Dose", "Steady State", "Half-life"],
            searchKeywords: ["ongoing dose", "regular dose"]
        ),

        // 186. Trough Level
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D8")!,
            term: "Trough Level",
            pronunciation: nil,
            definition: "The lowest concentration of a substance in the blood, occurring just before the next dose is given. Monitoring trough levels ensures levels don't drop too low (losing effectiveness) or indicate accumulation. For some treatments, blood is drawn at the trough to assess whether dosing is appropriate.",
            category: .general,
            relatedTerms: ["Peak Level", "Monitoring", "Steady State"],
            searchKeywords: ["lowest level", "minimum concentration", "pre-dose level"]
        ),

        // 187. Peak Level
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000D9")!,
            term: "Peak Level",
            pronunciation: nil,
            definition: "The highest concentration of a substance in the blood, occurring shortly after a dose is absorbed. High peak levels can cause toxicity even if average levels are acceptable. Monitoring peak levels helps ensure they don't reach dangerous heights. The time to peak varies based on how the substance is given.",
            category: .general,
            relatedTerms: ["Trough Level", "Monitoring", "Bioavailability"],
            searchKeywords: ["highest level", "maximum concentration", "Cmax"]
        ),

        // 188. NOAEL
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000DA")!,
            term: "NOAEL",
            pronunciation: "NO-el",
            definition: "No Observed Adverse Effect Level—the highest dose in toxicity studies that causes no detectable harm. Used in research to establish safety margins for chemicals, medications, and food additives. Like LD50, this is a research term not useful for clinical decisions about individual pet exposures.",
            category: .general,
            relatedTerms: ["Toxic Dose", "LD50", "Margin of Safety"],
            searchKeywords: ["no effect level", "safe dose research", "safety testing"]
        ),

        // 189. Threshold Dose
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000DB")!,
            term: "Threshold Dose",
            pronunciation: nil,
            definition: "The minimum dose needed to produce a detectable effect. Below this threshold, no effect occurs; above it, effects appear and increase with dose. Most toxins have thresholds, but individual variation means there's no guaranteed 'safe' amount—one pet's threshold may be much lower than average.",
            category: .general,
            relatedTerms: ["Toxic Dose", "Dose-Dependent", "Idiosyncratic Reaction"],
            searchKeywords: ["minimum toxic dose", "lowest effective dose", "effect threshold"]
        ),

        // 190. Ocular Decontamination
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000DC")!,
            term: "Ocular Decontamination",
            pronunciation: nil,
            definition: "Flushing the eyes with large amounts of water or saline to remove toxic substances. Should be done immediately for any eye exposure to chemicals, irritants, or plant saps—before even calling the vet. Use room temperature water, hold eyelids open, and flush for 15-20 minutes. Then seek veterinary care.",
            category: .treatment,
            relatedTerms: ["Decontamination", "Cornea", "Dermal Exposure"],
            searchKeywords: ["eye flush", "eye wash", "eye irrigation", "eye rinsing"]
        ),

        // 191. Dermal Decontamination
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000DD")!,
            term: "Dermal Decontamination",
            pronunciation: nil,
            definition: "Removing toxic substances from the skin and fur, usually by bathing with mild dish soap (like Dawn) and lukewarm water. Important because pets groom themselves and can ingest toxins from their fur. Wear gloves to protect yourself. For oily substances, multiple washes may be needed. Dry the pet to prevent hypothermia.",
            category: .treatment,
            relatedTerms: ["Decontamination", "Dermal Exposure", "Secondary Exposure"],
            searchKeywords: ["washing off toxin", "skin decontamination", "fur wash"]
        ),

        // MARK: - Session 103: Body Systems + Regurgitation

        // 192. Regurgitation
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E2")!,
            term: "Regurgitation",
            pronunciation: "ree-GUR-jih-TAY-shun",
            definition: "The passive, effortless expulsion of undigested food or liquid from the esophagus or throat — NOT the stomach. Unlike vomiting, there is no retching, heaving, or abdominal effort. Food comes back up looking much like it did going down. Regurgitation suggests an esophageal problem rather than stomach irritation. Telling your vet whether your pet vomited or regurgitated helps with diagnosis.",
            category: .symptoms,
            relatedTerms: ["Vomiting", "Emesis", "Aspiration"],
            searchKeywords: ["regurgitate", "regurgitating", "bringing up food", "passive vomiting"]
        ),

        // 195. Hematochezia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E3")!,
            term: "Hematochezia",
            pronunciation: "hee-mat-oh-KEE-zee-ah",
            definition: "Fresh, bright red blood in the stool, indicating bleeding from the lower gastrointestinal tract (colon or rectum). Unlike melena (dark, tarry stool from upper GI bleeding), hematochezia appears red because the blood has not been digested. Can result from colitis, parasites, foreign bodies, or toxins that damage the intestinal lining.",
            category: .symptoms,
            relatedTerms: ["Melena", "Diarrhea", "GI Tract"],
            searchKeywords: ["bloody stool", "blood in stool", "red stool", "fresh blood stool", "bright red blood"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Session 104 Additions
        // ══════════════════════════════════════════════════════════════

        // 196. Azotemia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E4")!,
            term: "Azotemia",
            pronunciation: "az-oh-TEE-mee-ah",
            definition: "Elevated levels of nitrogen-containing waste products (BUN and creatinine) in the blood, indicating the kidneys are not filtering properly. Azotemia is an early sign of kidney dysfunction and may progress to uremia if untreated. Common in toxicities affecting the kidneys, such as lily ingestion in cats, grape/raisin toxicity, or ethylene glycol poisoning.",
            category: .conditions,
            relatedTerms: ["Uremia", "Acute Kidney Injury", "Nephrotoxicity"],
            searchKeywords: ["elevated BUN", "high creatinine", "kidney values", "renal values", "kidney blood test"]
        ),

        // 197. Oliguria
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E5")!,
            term: "Oliguria",
            pronunciation: "ol-ih-GYUR-ee-ah",
            definition: "Abnormally decreased urine production. A warning sign that the kidneys are struggling to function, often seen in acute kidney injury from toxins. Oliguria may progress to anuria (no urine production) if kidney damage worsens. Monitoring urine output is critical in hospitalized toxicosis patients.",
            category: .symptoms,
            relatedTerms: ["Anuria", "Acute Kidney Injury", "Polyuria"],
            searchKeywords: ["decreased urination", "less urine", "reduced urine output", "not peeing much", "low urine"]
        ),

        // 198. Anuria
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E6")!,
            term: "Anuria",
            pronunciation: "an-YUR-ee-ah",
            definition: "Complete absence of urine production — a medical emergency indicating severe kidney failure. The kidneys have essentially stopped working. In toxicosis cases, anuria suggests severe, potentially irreversible kidney damage and requires immediate intensive care, possibly including dialysis.",
            category: .symptoms,
            relatedTerms: ["Oliguria", "Acute Kidney Injury", "Uremia"],
            searchKeywords: ["no urination", "not urinating", "no urine", "stopped urinating", "can't pee"]
        ),

        // 199. Hemostasis
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E7")!,
            term: "Hemostasis",
            pronunciation: "hee-moh-STAY-sis",
            definition: "The body's process of stopping bleeding through blood clot formation. Involves platelets, clotting factors, and blood vessel constriction working together. Many toxins disrupt hemostasis — anticoagulant rodenticides deplete clotting factors, while some snake venoms cause both excessive clotting and bleeding.",
            category: .general,
            relatedTerms: ["Coagulopathy", "Platelets", "DIC"],
            searchKeywords: ["blood clotting", "clot formation", "stop bleeding", "clotting process"]
        ),

        // 200. Cachexia
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E8")!,
            term: "Cachexia",
            pronunciation: "kah-KEK-see-ah",
            definition: "Severe weight loss and muscle wasting that cannot be reversed by simply eating more. Often seen with chronic illness, organ failure, or prolonged toxin exposure. Unlike simple weight loss from not eating, cachexia involves metabolic changes that break down muscle tissue. A sign of serious underlying disease.",
            category: .conditions,
            relatedTerms: ["Anorexia", "Lethargy"],
            searchKeywords: ["severe weight loss", "muscle wasting", "emaciation", "wasting away", "skin and bones"]
        ),

        // 201. Ascites
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000E9")!,
            term: "Ascites",
            pronunciation: "ah-SY-teez",
            definition: "Abnormal accumulation of fluid in the abdominal cavity, causing a distended or swollen belly. Can result from liver failure, heart failure, or low blood protein. In toxicology, ascites may indicate severe liver damage (hepatotoxicity) or protein loss. The abdomen may feel fluid-filled when touched.",
            category: .conditions,
            relatedTerms: ["Edema", "Hepatotoxicity", "Effusion"],
            searchKeywords: ["abdominal fluid", "fluid in belly", "distended abdomen", "swollen belly", "pot belly"]
        ),

        // 202. Effusion
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-0000000000EA")!,
            term: "Effusion",
            pronunciation: "eh-FYOO-zhun",
            definition: "Abnormal accumulation of fluid in a body cavity. Pleural effusion (fluid around the lungs) causes breathing difficulty; pericardial effusion (fluid around the heart) can be life-threatening. May result from heart failure, infection, or toxins that increase vascular permeability or cause organ damage.",
            category: .conditions,
            relatedTerms: ["Ascites", "Edema", "Dyspnea"],
            searchKeywords: ["fluid accumulation", "pleural effusion", "pericardial effusion", "fluid around lungs", "fluid around heart"]
        ),
    ]

    // MARK: - Term Detection (Phase 2)

    /// Finds all glossary terms present in the given text (whole word matches only)
    /// - Parameter text: The text to scan for glossary terms
    /// - Returns: Array of GlossaryTerm objects found, sorted alphabetically by term name
    func findTerms(in text: String) -> [GlossaryTerm] {
        guard !text.isEmpty else { return [] }

        let lowercasedText = text.lowercased()

        return terms.filter { term in
            // Check main term name with word boundaries
            if containsWholeWord(lowercasedText, word: term.term.lowercased()) {
                return true
            }
            // Check search keywords with word boundaries
            if let keywords = term.searchKeywords {
                for keyword in keywords {
                    if containsWholeWord(lowercasedText, word: keyword.lowercased()) {
                        return true
                    }
                }
            }
            return false
        }
        .sorted { $0.term.localizedCaseInsensitiveCompare($1.term) == .orderedAscending }
    }

    /// Checks if text contains a word as a whole word (not as part of another word)
    /// - Parameters:
    ///   - text: The text to search in (should be lowercased)
    ///   - word: The word to search for (should be lowercased)
    /// - Returns: True if the word appears as a complete word in the text
    private func containsWholeWord(_ text: String, word: String) -> Bool {
        var searchStart = text.startIndex
        while let range = text.range(of: word, range: searchStart..<text.endIndex) {
            let isStartBoundary = range.lowerBound == text.startIndex ||
                !text[text.index(before: range.lowerBound)].isLetter
            let isEndBoundary = range.upperBound == text.endIndex ||
                !text[range.upperBound].isLetter

            if isStartBoundary && isEndBoundary {
                return true
            }

            searchStart = range.upperBound
        }
        return false
    }

    /// Finds glossary terms across multiple strings (useful for symptoms arrays)
    /// - Parameter texts: Array of strings to scan
    /// - Returns: Array of unique GlossaryTerm objects found, sorted alphabetically
    func findTerms(in texts: [String]) -> [GlossaryTerm] {
        let combinedText = texts.joined(separator: " ")
        return findTerms(in: combinedText)
    }
}
