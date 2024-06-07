//
//  CircularProfileImage.swift
//  SymbolsDetection
//
//  Created by Dmitriy Soloshenko on 24.05.2024.
//

import SwiftUI

struct CircularProfileImage: View {
    let imageState: TransferableImage.ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}
