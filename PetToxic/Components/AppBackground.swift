import SwiftUI

struct AppBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.102, green: 0.227, blue: 0.227), // #1A3A3A
                Color(red: 0.051, green: 0.122, blue: 0.122)  // #0D1F1F
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    AppBackground()
}
