//
//  VolumeRGBTestView.swift
//  MC3Project
//
//  Created by Simon Bestler on 19.02.23.
//

import SwiftUI

struct VolumeRGBTestView: View {
    @ObservedObject var testSoundVM = TestSoundVM()

    var body: some View {
        VStack {
            Button("Play") {
                testSoundVM.isPlaying = true
            }
            Button("Stop") {
                testSoundVM.isPlaying = false
            }
            VStack {
                Rectangle()
                    .foregroundColor(Color(
                        red: testSoundVM.colorIntensities.scaledRed,
                        green: testSoundVM.colorIntensities.scaledGreen,
                        blue: testSoundVM.colorIntensities.scaledBlue))
                    .cornerRadius(10)
                    .padding()
            }
            VStack {
                Text("Red")
                Slider(value: $testSoundVM.colorIntensities.red, in: 0...255)
                Text(String(testSoundVM.colorIntensities.red))
                Divider()
            }
            VStack {
                Text("Green")
                Slider(value: $testSoundVM.colorIntensities.green, in: 0...255)
                Text(String(testSoundVM.colorIntensities.green))
                Divider()
            }
            VStack {
                Text("Blue")
                Slider(value: $testSoundVM.colorIntensities.blue, in: 0...255)
                Text(String(testSoundVM.colorIntensities.blue))
                Divider()
            }
            Spacer()
        }

    }

}

struct VolumeRGBTest_Previews: PreviewProvider {
    static var previews: some View {
        VolumeRGBTestView()
    }
}
