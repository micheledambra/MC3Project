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
    var colorScheme : ColorScheme

    private var colorExtractor: ColorExtractor
    private var soundCreator: SoundCreator
    private var haptics: CustomHaptics

    init(image: UIImage) {
        self.colorScheme = .hsb
        self.scaleFactor = 1.0
        self.image = image
        if colorScheme == .rgb {
            self.soundCreator = SoundCreator(oscillatorSettings: [
                OscillatorSettings(frequency: 261.63, amplitude: 0.0),
                OscillatorSettings(frequency: 329.63, amplitude: 0.0),
                OscillatorSettings(frequency: 392, amplitude: 0.0)
            ])
        } else {
            self.soundCreator = SoundCreator(oscillatorSettings: [
                OscillatorSettings(frequency: 500.0, amplitude: 1.0)
            ])
        }
        self.colorExtractor = ColorExtractor(image: self.image, scaleFactor: 1.0)
        self.haptics = CustomHaptics()
    }

    func processDragAction(position : Position, scaledImgSize : CGSize) {
        dragPosition = position
        if(position.x < Int(scaledImgSize.width) && position.x > 0 &&
           position.y < Int(scaledImgSize.height) && position.y > 0){
            haptics.stop()
            colorIntensities = colorExtractor.getRGB(at: dragPosition)
            updateSoundSettings(colorIntensities: colorIntensities)
        }else {
            haptics.play()
            colorIntensities = ColorIntesities()
            soundCreator.stopSound()
        }
    }

    private func updateSoundSettings(colorIntensities: ColorIntesities) {
        if colorScheme == .rgb {
            soundCreator.settings[0].amplitude = colorIntensities.scaledRed
            soundCreator.settings[1].amplitude = colorIntensities.scaledGreen
            soundCreator.settings[2].amplitude = colorIntensities.scaledBlue
        }
        else {
            let colorHSB = colorIntensities.convertToHSB()
            let degree = colorHSB.hue * 360
            let frequency = 650 - 250 / 270 * degree
            print(frequency)
            soundCreator.settings[0].frequency = frequency
        }
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
