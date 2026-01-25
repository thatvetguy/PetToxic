import SwiftUI

struct SettingsView: View {
    @ObservedObject private var appearance = AppearanceSettings.shared

    var body: some View {
        NavigationStack {
            List {
                // MARK: - My Pets (Test Section - Remove in Phase 4)
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
                } header: {
                    Text("My Pets")
                } footer: {
                    Text("Manage your pet profiles for quick access during emergencies.")
                }

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
            }
            .navigationTitle("Settings")
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
