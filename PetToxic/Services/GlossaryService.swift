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
    ]
}
