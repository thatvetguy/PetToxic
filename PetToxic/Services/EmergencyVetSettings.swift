import SwiftUI

@MainActor
final class EmergencyVetSettings: ObservableObject {
    static let shared = EmergencyVetSettings()

    @Published var emergencyVetName: String {
        didSet { UserDefaults.standard.set(emergencyVetName, forKey: "emergencyVetName") }
    }

    @Published var emergencyVetPhone: String {
        didSet { UserDefaults.standard.set(emergencyVetPhone, forKey: "emergencyVetPhone") }
    }

    @Published var emergencyVetAddress: String {
        didSet { UserDefaults.standard.set(emergencyVetAddress, forKey: "emergencyVetAddress") }
    }

    var hasAnyInfo: Bool {
        !emergencyVetName.isEmpty || !emergencyVetPhone.isEmpty || !emergencyVetAddress.isEmpty
    }

    private init() {
        self.emergencyVetName = UserDefaults.standard.string(forKey: "emergencyVetName") ?? ""
        self.emergencyVetPhone = UserDefaults.standard.string(forKey: "emergencyVetPhone") ?? ""
        self.emergencyVetAddress = UserDefaults.standard.string(forKey: "emergencyVetAddress") ?? ""
    }
}
