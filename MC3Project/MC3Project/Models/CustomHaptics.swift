//
//  CustomHaptics.swift
//  MC3Project
//
//  Created by Simon Bestler on 02.03.23.
//

import Foundation
import CoreHaptics


class CustomHaptics {

    private let softContinousPattern = [
        CHHapticEventParameter(
          parameterID: .hapticIntensity,
          value: 0.36),
        CHHapticEventParameter(
          parameterID: .hapticSharpness,
          value: 0.08),
        CHHapticEventParameter(
          parameterID: .attackTime,
          value: 0.39),
        CHHapticEventParameter(
          parameterID: .decayTime,
          value: 0.16),
        CHHapticEventParameter(
          parameterID: .releaseTime,
          value: 0.33),
        CHHapticEventParameter(
          parameterID: .sustained,
          value: 1)
      ]
    var engine : CHHapticEngine?
    var engineIsStopped = false
    var player : CHHapticPatternPlayer?
    var isPlaying = false

    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }

        // The engine stopped; print out why
        engine?.stoppedHandler = { reason in
            print("The engine stopped: \(reason)")
            self.engineIsStopped = true
        }

        // If something goes wrong, attempt to restart the engine immediately
        engine?.resetHandler = { [weak self] in
            print("The engine reset")

            do {
                try self?.engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }
    }

    func play() {
        if (!isPlaying){
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: softContinousPattern, relativeTime: 0, duration: 30)
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                if engineIsStopped {
                    try engine?.start()
                    engineIsStopped = false
                }
                player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
                isPlaying = true
            } catch {
                print(error)
            }
        }
    }

    func stop(){
        if (isPlaying){
            do {
                try player?.stop(atTime: 0)
                isPlaying = false
            } catch {
                print("error")
            }
        }
    }

}

