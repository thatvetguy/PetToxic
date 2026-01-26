import SwiftUI

struct SettingsView: View {
    @ObservedObject private var proSettings = ProSettings.shared

    @State private var versionTapCount = 0
    @State private var showUnlockToast = false

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
                    // MARK: - My Pets
                    Section {
                        NavigationLink {
                            PetListView()
                        } label: {
                            HStack {
                                Image(systemName: "pawprint.fill")
                                    .foregroundStyle(Color("AccentColor"))
                                    .frame(width: 24)
                                Text("My Pets")
                                    .foregroundStyle(.white)
                                Spacer()
                                if !proSettings.isPro {
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
                        .disabled(!proSettings.isPro)
                        .listRowBackground(Color.white.opacity(0.08))
                    } header: {
                        Text("My Pets")
                            .foregroundStyle(.white.opacity(0.7))
                    } footer: {
                        Text("Manage your pet profiles for quick access during emergencies.")
                            .foregroundStyle(.white.opacity(0.5))
                    }

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
                            Text("Toggle PRO mode for testing.")
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }

                    // MARK: - Version
                    Section {
                        HStack {
                            Spacer()
                            Text("Version \(appVersion) (build \(buildNumber))")
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.5))
                                .onTapGesture {
                                    handleVersionTap()
                                }
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
            .overlay(alignment: .bottom) {
                if showUnlockToast {
                    toastView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }

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
            .padding(.bottom, 100) // Extra space for tab bar
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
}

#Preview {
    SettingsView()
}
