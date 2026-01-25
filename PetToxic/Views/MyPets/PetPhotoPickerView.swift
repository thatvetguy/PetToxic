import SwiftUI
import PhotosUI
import AVFoundation

struct PetPhotoPickerView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selectedImage: UIImage?
    let onImageSelected: (UIImage) -> Void

    @State private var photosPickerItem: PhotosPickerItem?
    @State private var showCamera = false
    @State private var showPermissionAlert = false

    var body: some View {
        NavigationStack {
            List {
                // Photo Library Option
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Label("Choose from Library", systemImage: "photo.on.rectangle")
                }
                .onChange(of: photosPickerItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            await MainActor.run {
                                onImageSelected(image)
                                dismiss()
                            }
                        }
                    }
                }

                // Camera Option
                Button {
                    checkCameraPermission()
                } label: {
                    Label("Take Photo", systemImage: "camera")
                }

                // Remove Photo Option (if there's an existing photo)
                if selectedImage != nil {
                    Button(role: .destructive) {
                        onImageSelected(UIImage()) // Empty image signals removal
                        dismiss()
                    } label: {
                        Label("Remove Photo", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Pet Photo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .fullScreenCover(isPresented: $showCamera) {
                CameraView { image in
                    if let image = image {
                        onImageSelected(image)
                    }
                    dismiss()
                }
                .ignoresSafeArea()
            }
            .alert("Camera Access Required", isPresented: $showPermissionAlert) {
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please allow camera access in Settings to take a photo.")
            }
        }
    }

    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            showCamera = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        showCamera = true
                    }
                }
            }
        case .denied, .restricted:
            showPermissionAlert = true
        @unknown default:
            break
        }
    }
}

// MARK: - Camera View (UIKit wrapper)

struct CameraView: UIViewControllerRepresentable {
    let onImageCaptured: (UIImage?) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = true // Allows cropping
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onImageCaptured: onImageCaptured)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let onImageCaptured: (UIImage?) -> Void

        init(onImageCaptured: @escaping (UIImage?) -> Void) {
            self.onImageCaptured = onImageCaptured
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // Prefer edited (cropped) image
            let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
            onImageCaptured(image)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            onImageCaptured(nil)
        }
    }
}
