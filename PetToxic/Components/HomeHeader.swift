import SwiftUI

struct HomeHeader: View {
    @ObservedObject private var proSettings = ProSettings.shared
    @State private var showingSupporterThanks = false

    var body: some View {
        VStack(spacing: 4) {
            // Badge and Share button row
            HStack {
                // Supporter badge — top left
                if proSettings.isSupporter {
                    Image("supporter_badge")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .onTapGesture {
                            showingSupporterThanks = true
                        }
                }

                Spacer()

                ShareLink(
                    item: AppShare.url,
                    subject: Text(AppShare.subject),
                    message: Text(AppShare.message)
                ) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(10)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)

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
            Text("For When Curiosity Bites Back")
                .font(.poppinsSemiBold(size: 14))
                .foregroundColor(Color(red: 0.7, green: 0.8, blue: 0.8)) // Soft teal-tinted gray
                .italic()
        }
        .padding(.bottom, 16)
        .alert("Thank You!", isPresented: $showingSupporterThanks) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your support helps fund continued development and supports local animal shelters and rescues.")
        }
    }
}

#Preview {
    ZStack {
        AppBackground()
        HomeHeader()
    }
}
