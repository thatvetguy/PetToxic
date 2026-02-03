import SwiftUI

struct SymptomsListView: View {
    let symptoms: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(symptoms.filter { !$0.isEmpty }, id: \.self) { symptom in
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 6))
                        .foregroundStyle(.secondary)
                        .padding(.top, 6)

                    Text(symptom)
                        .font(.body)
                }
            }
        }
    }
}

#Preview {
    SymptomsListView(symptoms: [
        "Vomiting",
        "Diarrhea",
        "Increased thirst and urination",
        "Restlessness or hyperactivity"
    ])
    .padding()
}
