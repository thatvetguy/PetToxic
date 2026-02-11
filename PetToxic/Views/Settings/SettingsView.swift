import SwiftUI

struct SettingsView: View {
    @ObservedObject private var proSettings = ProSettings.shared
    @ObservedObject private var storeKit = StoreKitService.shared

    #if DEBUG
    @State private var versionTapCount = 0
    @State private var showUnlockToast = false
    #endif
    @State private var showProUpsell = false
    @State private var showUpgradeSheet = false
    @State private var showRestoreAlert = false
    @State private var isRestoring = false
    @State private var proUpsellMessage = ""

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()

                List {
                    // MARK: - Pro Features
                    Section {
                        // Upgrade row (visible for free users)
                        if !proSettings.isPro {
                            Button {
                                showUpgradeSheet = true
                            } label: {
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow)
                                        .frame(width: 24)
                                    Text("Upgrade to Pro")
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.gray.opacity(0.5))
                                }
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        }

                        // Upgrade to Pet Hero (visible for Pro users who aren't Pet Heroes)
                        if proSettings.isPro && !proSettings.isSupporter {
                            Button {
                                showUpgradeSheet = true
                            } label: {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.pink)
                                        .frame(width: 24)
                                    Text("Upgrade to Pet Hero")
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.gray.opacity(0.5))
                                }
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        }

                        // My Pets
                        if proSettings.isPro {
                            NavigationLink {
                                PetListView()
                            } label: {
                                proFeatureLabel(icon: "pawprint.fill", iconColor: Color("AccentColor"), text: "My Pets")
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        } else {
                            Button {
                                proUpsellMessage = "Add your pets for quick access to their info during emergencies. Upgrade to Pro to unlock My Pets."
                                showProUpsell = true
                            } label: {
                                proFeatureLabel(icon: "pawprint.fill", iconColor: Color("AccentColor"), text: "My Pets", showBadge: true)
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        }

                        // Medical Glossary
                        if proSettings.isPro {
                            NavigationLink {
                                GlossaryView()
                            } label: {
                                proFeatureLabel(icon: "character.book.closed.fill", iconColor: .teal, text: "Medical Glossary")
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        } else {
                            Button {
                                proUpsellMessage = "Look up veterinary and toxicology terms. Upgrade to Pro to access the Medical Glossary."
                                showProUpsell = true
                            } label: {
                                proFeatureLabel(icon: "character.book.closed.fill", iconColor: .teal, text: "Medical Glossary", showBadge: true)
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        }

                        // Lab Work Guide
                        if proSettings.isPro {
                            NavigationLink {
                                LabWorkGuideView()
                            } label: {
                                proFeatureLabel(icon: "cross.vial.fill", iconColor: .teal, text: "Lab Work Guide")
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        } else {
                            Button {
                                proUpsellMessage = "Understand your pet's blood work results. Upgrade to Pro to access the Lab Work Guide."
                                showProUpsell = true
                            } label: {
                                proFeatureLabel(icon: "cross.vial.fill", iconColor: .teal, text: "Lab Work Guide", showBadge: true)
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        }
                    } header: {
                        Text("Pro Features")
                            .foregroundStyle(.white.opacity(0.7))
                    } footer: {
                        Text("Manage pet profiles, look up medical terms, and understand lab results.")
                            .foregroundStyle(.white.opacity(0.5))
                    }

                    // MARK: - Purchases
                    Section {
                        Button {
                            isRestoring = true
                            Task {
                                await storeKit.restorePurchases()
                                isRestoring = false
                                showRestoreAlert = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundStyle(.teal)
                                    .frame(width: 24)
                                Text("Restore Purchases")
                                    .foregroundStyle(.white)
                                Spacer()
                                if isRestoring {
                                    ProgressView()
                                        .tint(.white)
                                }
                            }
                        }
                        .disabled(isRestoring)
                        .listRowBackground(Color.white.opacity(0.08))
                    }

                    #if DEBUG
                    // MARK: - Developer Options (hidden until unlocked)
                    if proSettings.developerOptionsUnlocked {
                        Section {
                            Toggle(isOn: Binding(
                                get: { proSettings.debugProEnabled },
                                set: { proSettings.debugProEnabled = $0 }
                            )) {
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow)
                                        .frame(width: 24)
                                    Text("PRO Mode")
                                        .foregroundStyle(.white)
                                }
                            }
                            .tint(Color("AccentColor"))
                            .listRowBackground(Color.white.opacity(0.08))

                            Toggle(isOn: Binding(
                                get: { proSettings.debugSupporterEnabled },
                                set: { proSettings.debugSupporterEnabled = $0 }
                            )) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.pink)
                                        .frame(width: 24)
                                    Text("Pet Hero Mode")
                                        .foregroundStyle(.white)
                                }
                            }
                            .tint(Color("AccentColor"))
                            .listRowBackground(Color.white.opacity(0.08))

                            Button(role: .destructive) {
                                proSettings.developerOptionsUnlocked = false
                                versionTapCount = 0
                            } label: {
                                HStack {
                                    Image(systemName: "eye.slash.fill")
                                        .foregroundStyle(.red)
                                        .frame(width: 24)
                                    Text("Hide Developer Options")
                                        .foregroundStyle(.red)
                                }
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                        } header: {
                            Text("Developer Options")
                                .foregroundStyle(.white.opacity(0.7))
                        } footer: {
                            Text("Toggle PRO and Pet Hero modes for testing.")
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    #endif

                    // MARK: - About
                    Section {
                        DisclosureGroup("About Pet Toxic") {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Pet Toxic was developed by a veterinarian").bold() + Text(" to help pet owners quickly identify potential hazards in their pet's environment.")

                                Text("All toxicity information in this app is free for every user — no paywalls, no locked articles. Paid upgrades unlock bonus features like My Pets, the Medical Glossary, and the Lab Work Guide.")

                                Text("A portion of the proceeds helps fund improvements for this app, supports the development of additional pet safety resources and benefits animal shelters and rescues in Southern California.")

                                Group {
                                    Text("We hope you find Pet Toxic useful — please share it with your fellow pet lovers! If you have suggestions for additions or corrections, we'd love to hear from you at ") +
                                    Text("support@pettoxic.com").bold()
                                }

                                if let mailURL = URL(string: "mailto:support@pettoxic.com") {
                                    Link("Email support@pettoxic.com", destination: mailURL)
                                        .font(.footnote)
                                        .foregroundStyle(Color("AccentColor"))
                                }

                                Text("Pet Toxic is an independent app and is not affiliated with, endorsed by, or partnered with the ASPCA Animal Poison Control Center or Pet Poison Helpline.")
                                    .font(.footnote)
                                    .opacity(0.7)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                            .padding(.vertical, 8)
                        }
                        .foregroundStyle(.white)
                        .listRowBackground(Color.white.opacity(0.08))
                    }

                    // MARK: - Share This App
                    Section {
                        ShareLink(
                            item: AppShare.url,
                            subject: Text(AppShare.subject),
                            message: Text(AppShare.message)
                        ) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundStyle(.teal)
                                    .frame(width: 24)
                                Text("Share This App")
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.gray.opacity(0.5))
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.08))
                    }

                    // MARK: - Disclaimer
                    Section {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("This information is for educational purposes only and does not constitute veterinary medical advice. If your pet has been exposed to a potentially toxic substance, contact a licensed veterinarian or animal poison control center immediately.")

                            Text("This database covers common toxic substances but is not a comprehensive listing of all possible hazards. The absence of a substance from this app should not be interpreted as an indication of safety. When in doubt, contact a veterinarian or animal poison control center.")

                            Text("Images in this app are AI-generated for illustrative purposes only and may not accurately represent the actual appearance of substances, plants, or animals described.")
                        }
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.vertical, 4)
                        .listRowBackground(Color.white.opacity(0.08))
                    } header: {
                        Text("Disclaimer")
                            .foregroundStyle(.white.opacity(0.7))
                    }

                    // MARK: - Version
                    Section {
                        HStack {
                            Spacer()
                            Text("Version \(appVersion) (build \(buildNumber))")
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.5))
                                #if DEBUG
                                .onTapGesture {
                                    handleVersionTap()
                                }
                                #endif
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    }

                    // Extra space for tab bar
                    Section {
                        Color.clear.frame(height: 60)
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            #if DEBUG
            .overlay(alignment: .bottom) {
                if showUnlockToast {
                    toastView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            #endif
            .alert("Pro Feature", isPresented: $showProUpsell) {
                Button("Maybe Later", role: .cancel) { }
                Button("Upgrade to Pro") { showUpgradeSheet = true }
            } message: {
                Text(proUpsellMessage)
            }
            .alert("Restore Purchases", isPresented: $showRestoreAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(storeKit.restoreMessage ?? "Done.")
            }
            .sheet(isPresented: $showUpgradeSheet) {
                UpgradeView()
            }
        }
    }

    // MARK: - Helpers

    private func proFeatureLabel(icon: String, iconColor: Color, text: String, showBadge: Bool = false) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .frame(width: 24)
            Text(text)
                .foregroundStyle(.white)
            Spacer()
            if showBadge {
                Text("PRO")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("AccentColor").opacity(0.8))
                    .clipShape(Capsule())
            }
        }
    }

    #if DEBUG
    private var toastView: some View {
        Text("Developer Options Unlocked")
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color("AccentColor"))
            .clipShape(Capsule())
            .shadow(radius: 4)
            .padding(.bottom, AppLayout.tabBarBottomPadding)
    }

    private func handleVersionTap() {
        guard !proSettings.developerOptionsUnlocked else { return }

        versionTapCount += 1

        if versionTapCount >= 5 {
            withAnimation(.spring(response: 0.3)) {
                proSettings.developerOptionsUnlocked = true
                showUnlockToast = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showUnlockToast = false
                }
            }
        }
    }
    #endif
}

#Preview {
    SettingsView()
}
