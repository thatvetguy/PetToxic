//
//  LabPanelType.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import Foundation

enum LabPanelType: String, Codable, CaseIterable, Identifiable {
    case cbc
    case chemistry
    case coagulation
    case pancreas
    case urinalysis

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .cbc: return "CBC"
        case .chemistry: return "Chemistry"
        case .coagulation: return "Coagulation"
        case .pancreas: return "Pancreas"
        case .urinalysis: return "Urinalysis"
        }
    }

    /// Sort order for displaying panels in the By Category view
    var sortOrder: Int {
        switch self {
        case .cbc: return 0
        case .chemistry: return 1
        case .coagulation: return 2
        case .pancreas: return 3
        case .urinalysis: return 4
        }
    }
}
