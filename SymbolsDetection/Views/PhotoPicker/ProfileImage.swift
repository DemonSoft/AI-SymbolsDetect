//
//  ProfileImage.swift
//  SymbolsDetection
//
//  Created by Dmitriy Soloshenko on 24.05.2024.
//

import SwiftUI

struct ProfileImage: View {
    let imageState: TransferableImage.ImageState
    
    var body: some View {
        switch self.imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}
