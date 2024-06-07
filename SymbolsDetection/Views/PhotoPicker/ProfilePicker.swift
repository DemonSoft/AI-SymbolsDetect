//
//  ProfilePicker.swift
//  SymbolsDetection
//
//  Created by Dmitriy Soloshenko on 25.05.2024.
//

import Combine
import SwiftUI
import PhotosUI
import CoreTransferable

/// Image picker details see here:
///  https://developer.apple.com/documentation/photokit/bringing_photos_picker_to_your_swiftui_app

class ProfilePicker : ObservableObject {
    
    // MARK: - Types
    
    // MARK: - Publishers
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            self.update(imageSelection)
        }
    }
    // MARK: - Public properties
    
    // MARK: - Private properties
    @Published private(set) var imageState: TransferableImage.ImageState = .empty
    @Published private(set) var picture: UIImage?
    
    // MARK: - Public methods

    // MARK: - Private methods
    private func update(_ imageSelection: PhotosPickerItem?) {
        if let imageSelection {
            let progress = self.loadTransferable(imageSelection)
            self.imageState = .loading(progress)
        } else {
            self.imageState = .empty
        }
    }
    
    private func loadTransferable(_ imageSelection: PhotosPickerItem) -> Progress {
        self.transferPicture(imageSelection)
        return imageSelection.loadTransferable(type: TransferableImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.image)
                case .success(nil) :
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    private func transferPicture(_ imageSelection: PhotosPickerItem) {
        imageSelection.loadTransferable(type: Data.self) { result in
            
            switch result {
            case .success(let data):
                if let data = data  {
                    let uiImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.picture = uiImage
                    }
                }
                default: return
            }
        }
    }
}

