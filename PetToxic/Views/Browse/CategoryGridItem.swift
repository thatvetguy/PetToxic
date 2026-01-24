import SwiftUI

struct CategoryGridItem: View {
    let category: Category
    let itemCount: Int

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: category.icon)
                .font(.system(size: 32))
                .frame(width: 44, height: 44)
                .foregroundStyle(Color("AccentColor"))

            VStack(spacing: 4) {
                Text(category.displayName)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                Text("\(itemCount) items")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(category.displayName), \(itemCount) items")
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
        CategoryGridItem(category: .foods, itemCount: 25)
        CategoryGridItem(category: .plants, itemCount: 42)
    }
    .padding()
}
