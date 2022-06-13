//
//  PhotoLibrary.swift
//  EmojiArt
//
//  Created by Владимир Сухих on 17.11.2021.
//

import SwiftUI
import PhotosUI

struct PhotoLibrary: UIViewControllerRepresentable {
    var handledPickedImage: (UIImage?) -> Void
    
    static var isAvailable: Bool {
        return true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(handledPickedImage: handledPickedImage)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var handledPickedImage: (UIImage?) -> Void

        init(handledPickedImage: @escaping (UIImage?) -> Void) {
            self.handledPickedImage = handledPickedImage
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let found = results.map { $0.itemProvider }.loadObjects(ofType: UIImage.self) { [weak self] image in
                self?.handledPickedImage(image)
            }
            if !found {
                handledPickedImage(nil)
            }
        }
    }
}

