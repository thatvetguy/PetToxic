//
//  GlossaryTerm.swift
//  PetToxic
//
//  Created by Claude Code on 2/2/26.
//

import Foundation

// MARK: - GlossaryCategory

enum GlossaryCategory: String, CaseIterable, Codable {
    case symptoms = "Symptoms & Signs"
    case conditions = "Conditions"
    case mechanisms = "Toxic Mechanisms"
    case anatomy = "Anatomy & Physiology"
    case treatment = "Treatment Terms"
    case general = "General"

    var icon: String {
        switch self {
        case .symptoms: return "exclamationmark.triangle"
        case .conditions: return "heart.text.square"
        case .mechanisms: return "bolt.trianglebadge.exclamationmark"
        case .anatomy: return "figure.stand"
        case .treatment: return "cross.case"
        case .general: return "book"
        }
    }
}

// MARK: - GlossaryTerm

struct GlossaryTerm: Identifiable, Codable {
    let id: UUID
    let term: String
    let pronunciation: String?
    let definition: String
    let category: GlossaryCategory
    let relatedTerms: [String]?
    let searchKeywords: [String]?

    init(
        id: UUID = UUID(),
        term: String,
        pronunciation: String? = nil,
        definition: String,
        category: GlossaryCategory,
        relatedTerms: [String]? = nil,
        searchKeywords: [String]? = nil
    ) {
        self.id = id
        self.term = term
        self.pronunciation = pronunciation
        self.definition = definition
        self.category = category
        self.relatedTerms = relatedTerms
        self.searchKeywords = searchKeywords
    }
}
