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
            handleDraggingState(isDragging)
        }
    }

    @Published var colorIntensities = ColorIntesities()
    var dragPosition = Position()
    var imageAreaSize : CGSize

    var image: UIImage

    private var colorExtractor: ColorExtractor
    private var soundCreator: SoundCreator
    

    init(image: UIImage, imageAreaSize : CGSize) {
        self.imageAreaSize = imageAreaSize
        self.image = image.scalePreservingAspectRatio(targetSize: imageAreaSize)
        self.colorExtractor = ColorExtractor(image: image)
        self.soundCreator = SoundCreator(oscillatorSettings: [
            OscillatorSettings(frequency: 261.63, amplitude: 0.0),
            OscillatorSettings(frequency: 329.63, amplitude: 0.0),
            OscillatorSettings(frequency: 392, amplitude: 0.0)
        ]
        )
    }

    func processDragAction(x: Int, y: Int) {
        dragPosition = Position(x: x, y: y)
        colorIntensities = colorExtractor.getRGB(at: dragPosition)
        updateSoundSettings(colorIntensities: colorIntensities)
    }

    private func updateSoundSettings(colorIntensities: ColorIntesities) {
        soundCreator.settings[0].amplitude = colorIntensities.scaledRed
        soundCreator.settings[1].amplitude = colorIntensities.scaledGreen
        soundCreator.settings[2].amplitude = colorIntensities.scaledBlue
    }

    private func handleDraggingState(_ : Bool) {
        if isDragging {
            soundCreator.startSound()
        }else {
            colorIntensities = ColorIntesities()
            soundCreator.stopSound()
        }
    }

}
