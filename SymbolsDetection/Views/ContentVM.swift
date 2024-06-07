//
//  ContentVM.swift
//  SymbolsDetection
//
//  Created by Dmitriy Soloshenko on 24.05.2024.
//

import Combine
import SwiftUI
import UIKit

class ContentVM : ObservableObject {
    
    // MARK: - Types
    
    // MARK: - Publishers
    @Published private (set) var result = ""

    // MARK: - Public properties
    
    // MARK: - Private properties

    /// A predictor instance that uses Vision and Core ML to generate prediction strings from a photo.
    private let imagePredictor = ImagePredictor()

    /// The largest number of predictions the main view controller displays the user.
    private let predictionsToShow    = 2

    // MARK: - Init
    init() {
    }
    
    deinit {
    }
    
    // MARK: - Public methods
    func picked(_ image: UIImage?) {
        guard let picture = image else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(picture)
        }
    }

    // MARK: - Private methods
    
    // MARK: Image prediction methods
    private func classifyImage(_ image: UIImage) {
        self.imagePredictor.makePredictions(for: image, completionHandler: predictHandler)
    }

    private func predictHandler(_ prediction: ImagePredictor.Prediction) {
        let words = prediction.names.joined(separator: "\n")
        self.result = prediction.names.count >= 0 ? words : ""
    }

}
