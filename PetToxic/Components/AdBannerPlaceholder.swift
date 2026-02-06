import SwiftUI

struct AdBannerPlaceholder: View {
    var body: some View {
        VStack(spacing: 0) {
            BannerAdView()
                .frame(height: 50)
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    ZStack {
        Color.black
        VStack {
            Spacer()
            AdBannerPlaceholder()
        }
    }
}
