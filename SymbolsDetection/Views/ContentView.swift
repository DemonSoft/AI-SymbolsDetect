//
//  ContentView.swift
//  SymbolsDetection
//
//  Created by Dmitriy Soloshenko on 24.05.2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject private var model = ContentVM()
    @StateObject private var piker = ProfilePicker()
    
    var body: some View {
        VStack(spacing: 32) {
            
            ZStack {
                CircularProfileImage(imageState: self.piker.imageState)
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: self.$piker.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        }
                        .buttonStyle(.borderless)
                        .onChange(of: self.piker.picture) { _, newValue in
                            self.model.picked(newValue)
                        }
                    }
            }

            Text(self.model.result)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}




