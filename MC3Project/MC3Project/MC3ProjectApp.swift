//
//  MC3ProjectApp.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 13/02/23.
//

import SwiftUI
import AudioKit
import AVFoundation

@main
struct MC3ProjectApp: App {

    init() {
        #if os(iOS)
            do {
                Settings.bufferLength = .short
                try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
                try AVAudioSession.sharedInstance().setCategory(.playback,
                                                                options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP, .allowAirPlay, .allowBluetooth])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch let err {
                print(err)
            }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
