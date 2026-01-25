import SwiftUI

struct PetAvatarView: View {
    let photoFilename: String?
    let size: CGFloat

    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                // Default placeholder
                ZStack {
                    Color.gray.opacity(0.3)
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: size * 0.4))
                        .foregroundColor(.gray.opacity(0.6))
                }
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 2)
        )
        .onAppear {
            loadImage()
        }
        .onChange(of: photoFilename) { _, _ in
            loadImage()
        }
    }

    private func loadImage() {
        guard let filename = photoFilename else {
            image = nil
            return
        }
        image = PetPhotoService.shared.loadPhoto(filename: filename)
    }
}

#Preview {
    VStack(spacing: 20) {
        PetAvatarView(photoFilename: nil, size: 100)
        PetAvatarView(photoFilename: nil, size: 60)
        PetAvatarView(photoFilename: nil, size: 40)
    }
    .padding()
    .background(Color.black)
}
