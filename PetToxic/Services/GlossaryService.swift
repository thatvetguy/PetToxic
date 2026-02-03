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
    ]
}
