import SwiftUI

struct SettingsView: View {
    @ObservedObject private var appearance = AppearanceSettings.shared

    var body: some View {
        NavigationStack {
            List {
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
