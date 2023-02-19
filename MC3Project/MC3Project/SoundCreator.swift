//
//  SoundCreator.swift
//  MC3Project
//
//  Created by Simon Bestler on 19.02.23.
//

import Foundation
import AudioKit
import SoundpipeAudioKit

class SoundCreator : ObservableObject, HasAudioEngine {
    
    let frequencies = [261.63, 329.63, 392]
    let engine : AudioEngine
    var oscillators : [Oscillator]
    var mixer : Mixer
    @Published var red = 0.0 {
        didSet {
            oscillators[0].amplitude = Float(red / 255)
        }
    }
    @Published var green = 0.0 {
        didSet {
            oscillators[1].amplitude = Float(green / 255)
        }
    }
    @Published var blue = 0.0 {
        didSet {
            oscillators[2].amplitude = Float(blue / 255)
        }
    }



    
    init() {
        engine = AudioEngine()
        mixer = Mixer()
        oscillators = [Oscillator]()
        for frequency in frequencies {
            let oscillator = createOscillator(frequency: frequency)
            oscillators.append(oscillator)
            mixer.addInput(oscillator)
        }
        engine.output = mixer
        try! engine.start()
    }
    
    
    func startAudio() {
        oscillators.forEach{
            $0.start()
        }
    }
    
    func stopAudio(){
        oscillators.forEach {
            $0.stop()
        }
    }
    
    
    private func createOscillator(frequency: Double) -> Oscillator {
        let oscillator = Oscillator()
        oscillator.frequency = Float(frequency)
        oscillator.amplitude = 0.0
        return oscillator
    }
    
}
