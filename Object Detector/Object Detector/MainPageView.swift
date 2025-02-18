//
//  MainPageView.swift
//  Object Detector
//
//  Created by Vurukuti Dheeraj on 2/17/25.
//

import SwiftUI
import Vision
import CoreML
import AVFoundation
import FirebaseAuth

struct MainPageView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var imageDescription: String = "Select an image to get started!"
    @State private var isImagePickerPresented: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isProcessing: Bool = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Title
                Text("Object Detector")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                // Image display
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 300)
                        .cornerRadius(15)
                        .overlay(
                            Text("No Image Selected")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }

                // Text description
                Spacer()
                if isProcessing {
                    ProgressView("Processing Image...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(imageDescription)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()

                // Button controls
                HStack(spacing: 20) {
                    Button(action: {
                        sourceType = .photoLibrary
                        isImagePickerPresented = true
                    }) {
                        Label("Photos", systemImage: "photo.on.rectangle")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }

                    Button(action: {
                        sourceType = .camera
                        isImagePickerPresented = true
                    }) {
                        Label("Camera", systemImage: "camera")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(sourceType: sourceType, selectedImage: $selectedImage, imageDescription: $imageDescription)
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Binding var imageDescription: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.imageDescription = "Processing..."
                identifyImage(image: image)
            }
            picker.dismiss(animated: true)
        }

        func identifyImage(image: UIImage) {
            guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
                parent.imageDescription = "Failed to load ML model."
                return
            }

            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let firstResult = results.first else {
                    self?.parent.imageDescription = "Failed to process the image."
                    return
                }

                DispatchQueue.main.async {
                    self?.parent.imageDescription = "Confidence: \(Int(firstResult.confidence * 100))%\nIdentifier: \(firstResult.identifier)"
                    // text to speach
//                     let utTerance = AVSpeechUtterance(string: (self?.parent.imageDescription)!)
//                    utTerance.voice = AVSpeechSynthesisVoice(language: "en-gb")
//                    let synthesizer = AVSpeechSynthesizer()
//                    synthesizer.speak(utTerance)
                }
            }

            guard let ciImage = CIImage(image: image) else {
                parent.imageDescription = "Invalid image format."
                return
            }

            let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                do {
                    try handler.perform([request])
                } catch {
                    DispatchQueue.main.async {
                        self?.parent.imageDescription = "Error: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
}

#Preview {
    MainPageView()
}
