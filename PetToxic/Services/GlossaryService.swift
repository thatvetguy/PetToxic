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
            searchKeywords: ["shaking", "shivering", "twitching", "muscle tremors"]
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
            relatedTerms: ["Nephrotoxicity", "Jaundice"],
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
            relatedTerms: nil,
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
            searchKeywords: ["gastrointestinal", "stomach", "intestines", "digestive", "gut"]
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
            searchKeywords: ["removing poison", "treatment", "first aid"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000014")!,
            term: "Emesis",
            pronunciation: "EM-eh-sis",
            definition: "The medical term for vomiting, often referring to intentionally induced vomiting to remove a swallowed toxin. Emesis must only be induced by a veterinarian — it is contraindicated (dangerous) for caustic substances, petroleum products, or when the pet is already showing neurological symptoms.",
            category: .treatment,
            relatedTerms: ["Decontamination"],
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
            searchKeywords: ["blue gums", "gray gums", "purple gums", "oxygen", "blue tongue"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000017")!,
            term: "Dyspnea",
            pronunciation: "DISP-nee-ah",
            definition: "Difficult or labored breathing. Affected pets may breathe with their mouth open, extend their neck, use abdominal muscles to breathe, or make wheezing/gasping sounds. Dyspnea indicates the pet is not getting enough oxygen and requires immediate veterinary attention.",
            category: .symptoms,
            relatedTerms: ["Cyanosis", "Tachypnea"],
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
            searchKeywords: ["tired", "sleepy", "weak", "no energy", "sluggish", "not moving"]
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
            relatedTerms: ["Emesis", "Hematemesis"],
            searchKeywords: ["throwing up", "vomit", "puking", "sick"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000025")!,
            term: "Diarrhea",
            pronunciation: "dy-ah-REE-ah",
            definition: "Loose, watery, or frequent bowel movements. Common with GI toxins and irritants. Can lead to dehydration, especially in small pets. Bloody diarrhea (bright red or dark/tarry) is more serious and indicates GI bleeding that requires prompt veterinary attention.",
            category: .symptoms,
            relatedTerms: nil,
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
            relatedTerms: ["Nephrotoxicity"],
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
            searchKeywords: ["low temperature", "cold", "freezing"]
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
            searchKeywords: ["antidote", "counteract poison", "cure", "treatment"]
        ),

        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000039")!,
            term: "IV Fluids",
            pronunciation: nil,
            definition: "Fluids given directly into a vein (intravenous) to maintain hydration, support blood pressure, and help flush toxins from the body through the kidneys. A cornerstone of supportive care for most poisonings. The type and rate of fluids are tailored to each patient's needs.",
            category: .treatment,
            relatedTerms: ["Supportive Care"],
            searchKeywords: ["intravenous fluids", "fluid therapy", "hydration", "drip"]
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
            searchKeywords: ["sedation", "drowsy", "unresponsive", "sleepy", "depressed"]
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
            relatedTerms: ["GI Tract", "Hematemesis", "Coagulopathy"],
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
            searchKeywords: ["low blood pressure", "shock", "weak pulse"]
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
            searchKeywords: ["outcome", "recovery", "survival", "chances"]
        ),

        // 52. Ingestion
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000052")!,
            term: "Ingestion",
            pronunciation: nil,
            definition: "Taking a substance into the body by swallowing (eating or drinking). This is the most common route of poisoning in pets. The substance then enters the digestive system where it may be absorbed into the bloodstream.",
            category: .general,
            relatedTerms: ["GI Tract", "Decontamination", "Emesis"],
            searchKeywords: ["eating", "swallowing", "ate", "eaten", "swallowed", "oral"]
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
            searchKeywords: ["blood", "oxygen", "red blood cells"]
        ),

        // 57. Platelets
        GlossaryTerm(
            id: UUID(uuidString: "A0000001-0001-0001-0001-000000000057")!,
            term: "Platelets",
            pronunciation: "PLAYT-lets",
            definition: "Tiny blood cells that help form clots to stop bleeding. Some toxins (like certain rodenticides) interfere with platelet function or clotting factors, causing uncontrolled bleeding. Low platelet counts can lead to bruising, bloody urine or stool, and prolonged bleeding from minor injuries.",
            category: .anatomy,
            relatedTerms: ["Coagulopathy", "Hematemesis", "Melena"],
            searchKeywords: ["blood clotting", "thrombocytes", "bleeding"]
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
            relatedTerms: ["Polydipsia", "Nephrotoxicity", "Acute Kidney Injury"],
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
            relatedTerms: ["Dyspnea", "Hypotension"],
            searchKeywords: ["swelling", "fluid retention", "puffy", "swollen"]
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
            searchKeywords: ["fluid loss", "dried out", "not drinking"]
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
            searchKeywords: ["amount", "quantity", "how much"]
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
            searchKeywords: ["delay", "delayed symptoms", "time to symptoms", "incubation"]
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
    ]
}
