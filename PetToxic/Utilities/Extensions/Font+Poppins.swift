import SwiftUI
import UIKit

extension Font {
    /// Bold font for titles - uses Poppins if available, falls back to SF Rounded
    static func poppinsBold(size: CGFloat) -> Font {
        // Try Poppins first, fall back to SF Rounded
        if UIFont(name: "Poppins-Bold", size: size) != nil {
            return .custom("Poppins-Bold", size: size)
        }
        return .system(size: size, weight: .bold, design: .rounded)
    }

    /// SemiBold font for subtitles - uses Poppins if available, falls back to SF Rounded
    static func poppinsSemiBold(size: CGFloat) -> Font {
        // Try Poppins first, fall back to SF Rounded
        if UIFont(name: "Poppins-SemiBold", size: size) != nil {
            return .custom("Poppins-SemiBold", size: size)
        }
        return .system(size: size, weight: .semibold, design: .rounded)
    }
}
