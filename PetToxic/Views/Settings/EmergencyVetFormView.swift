import SwiftUI

struct EmergencyVetFormView: View {
    @ObservedObject private var settings = EmergencyVetSettings.shared
    @State private var showClearAlert = false

    var body: some View {
        Form {
            Section("Clinic Information") {
                TextField("Clinic Name", text: $settings.emergencyVetName)

                TextField("Phone Number", text: $settings.emergencyVetPhone)
                    .keyboardType(.phonePad)
                    .onChange(of: settings.emergencyVetPhone) {
                        let formatted = PhoneFormatter.format(settings.emergencyVetPhone)
                        if formatted != settings.emergencyVetPhone {
                            settings.emergencyVetPhone = formatted
                        }
                    }

                TextField("Address", text: $settings.emergencyVetAddress)
            }

            if settings.hasAnyInfo {
                Section {
                    Button(role: .destructive) {
                        showClearAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Clear All")
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle("My Emergency Vet")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil
                    )
                }
            }
        }
        .alert("Clear All Fields?", isPresented: $showClearAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                settings.emergencyVetName = ""
                settings.emergencyVetPhone = ""
                settings.emergencyVetAddress = ""
            }
        } message: {
            Text("This will remove your emergency vet information.")
        }
    }
}

#Preview {
    NavigationStack {
        EmergencyVetFormView()
    }
}
