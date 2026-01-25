import SwiftUI

struct AppBackground: View {
    var body: some View {
        ZStack {
            // Gradient base
            LinearGradient(
                colors: [
                    Color(red: 0.102, green: 0.227, blue: 0.227), // #1A3A3A
                    Color(red: 0.051, green: 0.122, blue: 0.122)  // #0D1F1F
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // Paw print texture overlay
            PawPrintPattern()
                .opacity(0.05)
        }
        .ignoresSafeArea()
    }
}

struct PawPrintPattern: View {
    let columns = 8
    let rows = 16

    var body: some View {
        GeometryReader { geometry in
            let pawSize: CGFloat = 30
            let spacingX = geometry.size.width / CGFloat(columns)
            let spacingY = geometry.size.height / CGFloat(rows)

            ForEach(0..<rows, id: \.self) { row in
                ForEach(0..<columns, id: \.self) { col in
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: pawSize))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(pawRotation(row: row, col: col)))
                        .position(
                            x: spacingX * CGFloat(col) + spacingX / 2 + pawOffset(row: row, col: col).x,
                            y: spacingY * CGFloat(row) + spacingY / 2 + pawOffset(row: row, col: col).y
                        )
                }
            }
        }
    }

    // Pseudo-random rotation based on position (deterministic, not actually random)
    func pawRotation(row: Int, col: Int) -> Double {
        let seed = Double((row * 7 + col * 13) % 31)
        return (seed / 31.0) * 30.0 - 15.0 // Range: -15° to +15°
    }

    // Slight offset for organic feel
    func pawOffset(row: Int, col: Int) -> CGPoint {
        let seedX = Double((row * 11 + col * 17) % 23)
        let seedY = Double((row * 13 + col * 19) % 29)
        return CGPoint(
            x: (seedX / 23.0) * 10.0 - 5.0, // Range: -5 to +5
            y: (seedY / 29.0) * 10.0 - 5.0  // Range: -5 to +5
        )
    }
}

#Preview {
    AppBackground()
}
