import SwiftUI

struct SettingsView: View {
    @ObservedObject private var appearance = AppearanceSettings.shared
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
                                .foregroundStyle(.primary)
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
                } header: {
                    Text("My Pets")
                } footer: {
                    Text("Manage your pet profiles for quick access during emergencies.")
                }

                // MARK: - Appearance
                Section {
                    ForEach(AppearanceMode.allCases, id: \.self) { mode in
                        Button {
                            appearance.mode = mode
                        } label: {
                            HStack {
                                Image(systemName: mode.icon)
                                    .foregroundStyle(iconColor(for: mode))
                                    .frame(width: 24)

                                Text(mode.rawValue)
                                    .foregroundStyle(.primary)

                                Spacer()

                                if appearance.mode == mode {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(Color("AccentColor"))
                                }
                            }
                        }
                    }
                } header: {
                    Text("Appearance")
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
                                    .foregroundStyle(.primary)
                            }
                        }
                        .tint(Color("AccentColor"))

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
                    } header: {
                        Text("Developer Options")
                    } footer: {
                        Text("Toggle PRO mode for testing.")
                    }
                }

                // MARK: - Version
                Section {
                    HStack {
                        Spacer()
                        Text("Version \(appVersion) (build \(buildNumber))")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .onTapGesture {
                                handleVersionTap()
                            }
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Settings")
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
            .padding(.bottom, 20)
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

    private func iconColor(for mode: AppearanceMode) -> Color {
        switch mode {
        case .system: return .secondary
        case .light: return .orange
        case .dark: return .indigo
        }
    }
}

#Preview {
    SettingsView()
}
