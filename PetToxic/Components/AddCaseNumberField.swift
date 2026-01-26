import SwiftUI

struct AddCaseNumberField: View {
    @Binding var text: String
    let placeholder: String
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()

            Button(action: {
                guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                onAdd()
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(text.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .accentColor)
            }
            .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }
}

#Preview {
    VStack {
        AddCaseNumberField(
            text: .constant(""),
            placeholder: "Enter case number",
            onAdd: {}
        )
        AddCaseNumberField(
            text: .constant("ABC-123"),
            placeholder: "Enter case number",
            onAdd: {}
        )
    }
    .padding()
}
