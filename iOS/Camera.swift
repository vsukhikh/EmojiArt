//
//  Camera.swift
//  EmojiArt
//
//  Created by Владимир Сухих on 17.11.2021.
//

import SwiftUI

struct Camera: UIViewControllerRepresentable {
    
    var handledPickedImage: (UIImage?) -> Void
    
    static var isAvailable: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(handledPickedImage: handledPickedImage)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to do here
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var handledPickedImage: (UIImage?) -> Void
        
        init(handledPickedImage: @escaping (UIImage?) -> Void) {
            self.handledPickedImage = handledPickedImage
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            handledPickedImage(nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            handledPickedImage((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }
}
