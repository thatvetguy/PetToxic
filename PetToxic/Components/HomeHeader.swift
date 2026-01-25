import SwiftUI

struct HomeHeader: View {
    var body: some View {
        VStack(spacing: 4) {
            // Logo + App Name row
            HStack(spacing: 12) {
                // Logo image (from asset catalog)
                Image("LaunchLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)

                // App name
                Text("Pet Toxic")
                    .font(.poppinsBold(size: 32))
                    .foregroundColor(.white)
            }

            // Tagline
            Text("Because curiosity shouldn't hurt")
                .font(.poppinsSemiBold(size: 14))
                .foregroundColor(Color(red: 0.7, green: 0.8, blue: 0.8)) // Soft teal-tinted gray
                .italic()
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
}

#Preview {
    ZStack {
        AppBackground()
        HomeHeader()
    }
}
