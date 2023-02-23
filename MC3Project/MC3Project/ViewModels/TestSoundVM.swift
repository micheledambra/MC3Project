//
//  TestSoundVM.swift
//  MC3Project
//
//  Created by Simon Bestler on 23.02.23.
//

import Foundation

class TestSoundVM: ObservableObject {
    @Published var colorIntensities: ColorIntesities {
        didSet {
            updateSoundSettings(colorIntensities: colorIntensities)
        }
    }
    @Published var isPlaying = false {
        didSet {
            if isPlaying == true {
                soundCreator.startSound()
            } else {
                soundCreator.stopSound()
            }
        }
    }
    var soundCreator: SoundCreator

    init() {
        self.colorIntensities = ColorIntesities()
        self.soundCreator = SoundCreator(oscillatorSettings: [
            OscillatorSettings(frequency: 261.63, amplitude: 0.0),
            OscillatorSettings(frequency: 329.63, amplitude: 0.0),
            OscillatorSettings(frequency: 392, amplitude: 0.0)
        ]
        )
    }

    private func updateSoundSettings(colorIntensities: ColorIntesities) {
        soundCreator.settings[0].amplitude = colorIntensities.scaledRed
        soundCreator.settings[1].amplitude = colorIntensities.scaledGreen
        soundCreator.settings[2].amplitude = colorIntensities.scaledBlue
    }
}
