import SwiftUI
import UIKit

class PetPhotoService {
    static let shared = PetPhotoService()

    private let fileManager = FileManager.default
    private let photosDirectory: URL

    private init() {
        // Create pet_photos directory in documents
        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        photosDirectory = documents.appendingPathComponent("pet_photos", isDirectory: true)

        // Create directory if it doesn't exist
        if !fileManager.fileExists(atPath: photosDirectory.path) {
            try? fileManager.createDirectory(at: photosDirectory, withIntermediateDirectories: true)
        }
    }

    /// Save an image for a pet, compressing to max 500KB
    /// - Parameters:
    ///   - image: The UIImage to save
    ///   - petId: The pet's UUID
    /// - Returns: The filename if successful
    func savePhoto(_ image: UIImage, for petId: UUID) -> String? {
        let filename = "\(petId.uuidString).jpg"
        let fileURL = photosDirectory.appendingPathComponent(filename)

        // Resize if needed (max 800x800 for efficiency)
        let resizedImage = resizeImage(image, maxDimension: 800)

        // Compress to JPEG, targeting under 500KB
        guard let data = compressImage(resizedImage, maxSizeKB: 500) else {
            print("Failed to compress image")
            return nil
        }

        do {
            try data.write(to: fileURL)
            return filename
        } catch {
            print("Failed to save photo: \(error)")
            return nil
        }
    }

    /// Load a pet's photo
    /// - Parameter filename: The photo filename
    /// - Returns: UIImage if found
    func loadPhoto(filename: String) -> UIImage? {
        let fileURL = photosDirectory.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }

    /// Delete a pet's photo
    /// - Parameter filename: The photo filename
    func deletePhoto(filename: String) {
        let fileURL = photosDirectory.appendingPathComponent(filename)
        try? fileManager.removeItem(at: fileURL)
    }

    // MARK: - Private Helpers

    private func resizeImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        let size = image.size

        guard size.width > maxDimension || size.height > maxDimension else {
            return image
        }

        let ratio = min(maxDimension / size.width, maxDimension / size.height)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }

    private func compressImage(_ image: UIImage, maxSizeKB: Int) -> Data? {
        var compression: CGFloat = 0.9
        let maxBytes = maxSizeKB * 1024

        guard var data = image.jpegData(compressionQuality: compression) else {
            return nil
        }

        // Reduce quality until under size limit
        while data.count > maxBytes && compression > 0.1 {
            compression -= 0.1
            guard let newData = image.jpegData(compressionQuality: compression) else {
                return data
            }
            data = newData
        }

        return data
    }
}
