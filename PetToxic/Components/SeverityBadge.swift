import SwiftUI

enum SeverityBadgeSize {
    case small
    case medium
    case large

    var font: Font {
        switch self {
        case .small: return .caption2
        case .medium: return .caption
        case .large: return .subheadline
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .small: return 6
        case .medium: return 8
        case .large: return 12
        }
    }

    var verticalPadding: CGFloat {
        switch self {
        case .small: return 2
        case .medium: return 4
        case .large: return 6
        }
    }
}

struct SeverityBadge: View {
    let severity: Severity
    var size: SeverityBadgeSize = .medium

    var body: some View {
        Text(severity.displayName)
            .font(size.font)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .background(severity.color)
            .clipShape(Capsule())
            .accessibilityLabel("Severity: \(severity.displayName)")
    }
}

#Preview {
    VStack(spacing: 16) {
        HStack(spacing: 8) {
            ForEach(Severity.allCases, id: \.self) { severity in
                SeverityBadge(severity: severity, size: .small)
            }
        }

        HStack(spacing: 8) {
            ForEach(Severity.allCases, id: \.self) { severity in
                SeverityBadge(severity: severity, size: .medium)
            }
        }

        HStack(spacing: 8) {
            ForEach(Severity.allCases, id: \.self) { severity in
                SeverityBadge(severity: severity, size: .large)
            }
        }
    }
    .padding()
}
