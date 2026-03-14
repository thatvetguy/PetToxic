import SwiftUI

struct CategoryGridItem: View {
    let category: Category
    let itemCount: Int
    var isLocked: Bool = false

    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: category.icon)
                    .font(.largeTitle)
                    .frame(width: 44, height: 44)
                    .foregroundStyle(isLocked ? Color("AccentColor").opacity(0.5) : Color("AccentColor"))

                if isLocked {
                    HStack(spacing: 2) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 7, weight: .bold))
                        Text("PRO")
                            .font(.system(size: 8, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(Capsule().fill(Color.yellow.opacity(0.85)))
                    .offset(x: 8, y: -4)
                }
            }

            VStack(spacing: 4) {
                Text(category.displayName)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                if isLocked {
                    Text("PRO")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.yellow)
                } else {
                    Text("\(itemCount) items")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .opacity(isLocked ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(isLocked
            ? "\(category.displayName), Pro feature, locked"
            : "\(category.displayName), \(itemCount) items")
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
        CategoryGridItem(category: .foods, itemCount: 25)
        CategoryGridItem(category: .diseasesAndConditions, itemCount: 8, isLocked: true)
    }
    .padding()
}
