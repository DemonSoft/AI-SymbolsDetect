//
//  TransferableImage.swift
//  SymbolsDetection
//
//  Created by Dmitriy Soloshenko on 24.05.2024.
//

import SwiftUI
import PhotosUI
import CoreTransferable

struct TransferableImage: Transferable {
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
    }

    
    let image: Image
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
        #if canImport(AppKit)
            guard let nsImage = NSImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(nsImage: nsImage)
            return ProfileImage(image: image)
        #elseif canImport(UIKit)
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return TransferableImage(image: image)
        #else
            throw TransferError.importFailed
        #endif
        }
    }
}
