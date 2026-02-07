import SwiftUI
import Foundation

enum AppShare {
    // TODO: Update with real App Store URL after launch
    static let url = URL(string: "https://apps.apple.com/app/pet-toxic/id0000000000")!
    static let message = "Check out Pet Toxic — a quick reference for pet poison safety! 🐾"
    static let subject = "Pet Toxic App"
}

enum AppColors {
    static let teal = Color(red: 0.29, green: 0.61, blue: 0.61)
    static let primary = Color("AccentColor")
    static let background = Color(hex: "F8F9FA")
    static let surface = Color.white
    static let textPrimary = Color(hex: "333333")
    static let textSecondary = Color(hex: "666666")

    enum Severity {
        static let low = Color(hex: "90EE90")
        static let moderate = Color(hex: "FFD700")
        static let high = Color(hex: "FFA500")
        static let severe = Color(hex: "FF4444")
    }

    enum Disclaimer {
        static let background = Color(hex: "FFF3CD")
        static let border = Color(hex: "FFECB5")
    }
}

enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

enum AppLayout {
    static let tabBarBottomPadding: CGFloat = 80
}

enum AppCornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
}
