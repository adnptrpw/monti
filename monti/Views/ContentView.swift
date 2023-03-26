//
//  ContentView.swift
//  monti
//
//  Created by Andini Putri Pramudya Wardani on 24/03/23.
//

import SwiftUI
import RealityKit
import PhotosUI
import UIKit

struct ContentView: View {
    @State var showImagePicker = false
    @State var selectedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if selectedImage == nil {
                    HStack {
                        Button {
                            // Placeholder: take a snapshot
                            ARVariables.arView.snapshot(saveToHDR: false) { (image) in
                                // Compress the image
                                let compressedImage = UIImage(
                                    data: (image?.pngData())!)
                                // Save in the photo album
                                UIImageWriteToSavedPhotosAlbum(
                                    compressedImage!, nil, nil, nil)
                            }
                        } label: {
                            Label("Take a picture", systemImage: "camera")
                                .font(.title3.weight(.bold))
                                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                                .background(Color("primary")).cornerRadius(1000)
                                .foregroundColor(Color.black)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.showImagePicker = true
                        }) {
                            Label("", systemImage: "photo.on.rectangle")
                                .font(.largeTitle.weight(.medium))
                                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                                .foregroundColor(Color.black)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                }
                
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0))
            
            // Add the blur background when the image is selected
            if selectedImage != nil {
                Rectangle()
                    .fill(Color.white.opacity(0.16))
                    .edgesIgnoringSafeArea(.all)
            }
            
            ZStack {
                VStack {
                    if let image = selectedImage {
                        Spacer()
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                if let image = selectedImage {
                                    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                                    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                                }
                            }) {
                                Label("", systemImage: "square.and.arrow.up")
                                    .font(.title3.weight(.bold))
                                    .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 12))
                                    .background(Color("primary")).cornerRadius(1000)
                                    .foregroundColor(Color.black)
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                if selectedImage != nil {
                    VStack {
                        HStack {
                            Button(action: {
                                self.selectedImage = nil
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .foregroundColor(Color.black)
                            }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    self.selectedImage = image
                }
            }
        }
        
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias SourceType = UIImagePickerController.SourceType
    
    let sourceType: SourceType
    let completionHandler: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Not needed in this example
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let completionHandler: (UIImage) -> Void
        
        init(completionHandler: @escaping (UIImage) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                completionHandler(image)
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


struct ARVariables{
    static var arView: ARView!
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        ARVariables.arView = ARView(frame: .zero)
        
        
        let anchor = try! Untitled.loadOpeningScene()
        
        // Add the box anchor to the scene
        //        arView.scene.anchors.append(anchor)
        ARVariables.arView.scene.anchors.append(anchor)
        
        return ARVariables.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

