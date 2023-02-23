//
//  SensationVM.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import Foundation
import UIKit

class SensationVM: ObservableObject {

    @Published var isDragging = false {
        didSet {
            if isDragging == false {
                colorIntensities = ColorIntesities()
            }
        }
    }

    @Published var colorIntensities = ColorIntesities()
    var position = Position()
    let scalingFactor = 1.0

    let image: UIImage

    var colorExtractor: ColorExtractor

    init(image: UIImage) {
        self.image = image
        self.colorExtractor = ColorExtractor(image: image)
    }

    func processDragAction(x: Int, y: Int) {
        position = Position(x: x, y: y)
        colorIntensities = colorExtractor.getRGB(at: position)
    }

}
