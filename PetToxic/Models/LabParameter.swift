//
//  LabParameter.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import Foundation

struct LabParameter: Identifiable, Codable {
    let id: UUID
    let name: String                        // "Alanine Aminotransferase"
    let abbreviation: String                // "ALT"
    let alternateAbbreviations: [String]?   // ["SGPT"]
    let category: LabCategory               // .liverValues
    let panelType: LabPanelType             // .chemistry (denormalized for convenience)
    let whatItMeasures: String              // 2-3 sentences
    let highMeaning: String                 // "What HIGH May Mean" — 2-4 sentences
    let lowMeaning: String?                 // "What LOW May Mean" — 2-4 sentences, nil if N/A
    let speciesNotes: String?               // Dog vs. cat differences, 1 sentence
    let relatedGlossaryTerms: [String]?     // Links to existing Glossary terms (Phase 2)
    let searchKeywords: [String]?           // Additional search terms

    init(
        id: UUID = UUID(),
        name: String,
        abbreviation: String,
        alternateAbbreviations: [String]? = nil,
        category: LabCategory,
        panelType: LabPanelType,
        whatItMeasures: String,
        highMeaning: String,
        lowMeaning: String? = nil,
        speciesNotes: String? = nil,
        relatedGlossaryTerms: [String]? = nil,
        searchKeywords: [String]? = nil
    ) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.alternateAbbreviations = alternateAbbreviations
        self.category = category
        self.panelType = panelType
        self.whatItMeasures = whatItMeasures
        self.highMeaning = highMeaning
        self.lowMeaning = lowMeaning
        self.speciesNotes = speciesNotes
        self.relatedGlossaryTerms = relatedGlossaryTerms
        self.searchKeywords = searchKeywords
    }
}
