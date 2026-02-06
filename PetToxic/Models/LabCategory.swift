//
//  LabCategory.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import SwiftUI

enum LabCategory: String, Codable, CaseIterable, Identifiable {
    // CBC subsections
    case redBloodCells
    case whiteBloodCells
    case platelets
    case cageSideTests

    // Chemistry subsections
    case kidneyValues
    case liverValues
    case proteins
    case electrolytes
    case metabolism
    case muscle

    // Coagulation subsection
    case clottingTimes

    // Pancreas subsection
    case pancreaticEnzymes

    // Urinalysis subsections
    case physical
    case chemicalDipstick
    case sediment

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .redBloodCells: return "Red Blood Cells"
        case .whiteBloodCells: return "White Blood Cells"
        case .platelets: return "Platelets"
        case .cageSideTests: return "Cage-Side Tests"
        case .kidneyValues: return "Kidney Values"
        case .liverValues: return "Liver Values"
        case .proteins: return "Proteins"
        case .electrolytes: return "Electrolytes"
        case .metabolism: return "Metabolism"
        case .muscle: return "Muscle"
        case .clottingTimes: return "Clotting Times"
        case .pancreaticEnzymes: return "Pancreatic Enzymes"
        case .physical: return "Urine Appearance"
        case .chemicalDipstick: return "Urine Dipstick"
        case .sediment: return "Urine Sediment"
        }
    }

    /// The parent panel this subsection belongs to
    var panelType: LabPanelType {
        switch self {
        case .redBloodCells, .whiteBloodCells, .platelets, .cageSideTests:
            return .cbc
        case .kidneyValues, .liverValues, .proteins, .electrolytes, .metabolism, .muscle:
            return .chemistry
        case .clottingTimes:
            return .coagulation
        case .pancreaticEnzymes:
            return .pancreas
        case .physical, .chemicalDipstick, .sediment:
            return .urinalysis
        }
    }

    /// SF Symbol icon for this category (iOS 16.0+ compatible)
    var icon: String {
        switch self {
        case .redBloodCells: return "drop.fill"
        case .whiteBloodCells: return "shield.fill"
        case .platelets: return "bandage.fill"
        case .cageSideTests: return "eyedropper.halffull"
        case .kidneyValues: return "cross.vial.fill"
        case .liverValues: return "cross.vial.fill"
        case .proteins: return "circle.grid.3x3.fill"
        case .electrolytes: return "plus.forwardslash.minus"
        case .metabolism: return "bolt.fill"
        case .muscle: return "figure.walk"
        case .clottingTimes: return "clock.fill"
        case .pancreaticEnzymes: return "staroflife.fill"
        case .physical: return "eye.fill"
        case .chemicalDipstick: return "drop.triangle.fill"
        case .sediment: return "magnifyingglass"
        }
    }

    /// Sort order within its parent panel (controls display order in By Category view)
    var sortOrder: Int {
        switch self {
        case .redBloodCells: return 0
        case .whiteBloodCells: return 1
        case .platelets: return 2
        case .cageSideTests: return 3
        case .kidneyValues: return 0
        case .liverValues: return 1
        case .proteins: return 2
        case .electrolytes: return 3
        case .metabolism: return 4
        case .muscle: return 5
        case .clottingTimes: return 0
        case .pancreaticEnzymes: return 0
        case .physical: return 0
        case .chemicalDipstick: return 1
        case .sediment: return 2
        }
    }

    /// All categories belonging to a given panel, in display order
    static func categories(for panel: LabPanelType) -> [LabCategory] {
        LabCategory.allCases
            .filter { $0.panelType == panel }
            .sorted { $0.sortOrder < $1.sortOrder }
    }
}
