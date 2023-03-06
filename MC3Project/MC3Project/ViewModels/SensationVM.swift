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
    var image: UIImage
    @Published var scaleFactor : Double {
        didSet {
            self.colorExtractor = ColorExtractor(image: self.image, scaleFactor: scaleFactor)
        }
    }

    private var colorExtractor: ColorExtractor
    private var soundCreator: SoundCreator
    private var haptics: CustomHaptics

    init(image: UIImage) {
        self.scaleFactor = 1.0
        self.image = image
        self.soundCreator = SoundCreator(oscillatorSettings: [
            OscillatorSettings(frequency: 261.63, amplitude: 0.0),
            OscillatorSettings(frequency: 329.63, amplitude: 0.0),
            OscillatorSettings(frequency: 392, amplitude: 0.0)
        ]
        )
        self.colorExtractor = ColorExtractor(image: self.image, scaleFactor: 1.0)
        self.haptics = CustomHaptics()
    }

    func processDragAction(position : Position, scaledImgSize : CGSize) {
        dragPosition = position
        if(position.x < Int(scaledImgSize.width) && position.x > 0 &&
           position.y < Int(scaledImgSize.height) && position.y > 0){
            haptics.stop()
            colorIntensities = colorExtractor.getRGB(at: dragPosition)
        }else {
            haptics.play()
            colorIntensities = ColorIntesities()
            updateSoundSettings(colorIntensities: colorIntensities)
        }
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
            haptics.stop()
        }
    }

}
