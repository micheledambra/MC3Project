//
//  SoundCreator.swift
//  MC3Project
//
//  Created by Simon Bestler on 23.02.23.
//

import Foundation
import AudioKit
import SoundpipeAudioKit

struct SoundCreator: HasAudioEngine {

    var settings: [OscillatorSettings] {
        didSet {
            updateOscillators(settings: settings)
        }
    }

    let engine: AudioEngine
    private var oscillators: [Oscillator]
    private let mixer: Mixer

    init(oscillatorSettings: [OscillatorSettings]) {
        self.engine = AudioEngine()
        self.mixer = Mixer()
        self.settings = oscillatorSettings
        self.oscillators = [Oscillator]()

        for setting in settings {
            let oscillator = createOscillator(frequency: setting.frequency, amplitude: setting.amplitude)
            oscillators.append(oscillator)
            mixer.addInput(oscillator)
        }
        engine.output = mixer

        // TODO: Add proper error handling
        try! engine.start()

    }

    func startSound() {
        oscillators.forEach {
            $0.start()
        }
    }

    func stopSound() {
        oscillators.forEach {
            $0.stop()
        }
    }

    private func createOscillator(frequency: Double, amplitude: Double) -> Oscillator {
        let oscillator = Oscillator()
        oscillator.frequency = Float(frequency)
        oscillator.amplitude = AUValue(amplitude)
        return oscillator
    }

    private func updateOscillators(settings: [OscillatorSettings]) {
        guard settings.count == oscillators.count else {
            print("Error:Count of oscillators and settings does not match!")
            return
        }
        for (index, setting) in settings.enumerated() {
            oscillators[index].frequency = Float(setting.frequency)
            oscillators[index].amplitude = Float(setting.amplitude)
        }
    }

}

struct OscillatorSettings {
    var frequency: Double
    var amplitude: Double

    init(frequency: Double, amplitude: Double) {
        self.frequency = frequency
        self.amplitude = amplitude
    }

    init() {
        self.frequency = 0.0
        self.amplitude = 0.0
    }
}
