//
//  VolumeRGBTestView.swift
//  MC3Project
//
//  Created by Simon Bestler on 19.02.23.
//

import SwiftUI

struct VolumeRGBTestView: View {
    @ObservedObject var soundCreator = SoundCreator()
    
    
    var body: some View {
        VStack {
            Button("Play") {
                soundCreator.startAudio()
            }
            Button("Stop") {
                soundCreator.stopAudio()
            }
            VStack {
                Rectangle()
                    .foregroundColor(Color(red: soundCreator.red/255, green: soundCreator.green/255, blue: soundCreator.blue/255))
                    .cornerRadius(10)
                    .padding()
            }
            VStack{
                Text("Red")
                Slider(value: $soundCreator.red, in: 0...255)
                Text(String(soundCreator.red))
                Divider()
            }
            VStack{
                Text("Green")
                Slider(value: $soundCreator.green, in: 0...255)
                Text(String(soundCreator.green))
                Divider()
            }
            VStack{
                Text("Blue")
                Slider(value: $soundCreator.blue, in: 0...255)
                Text(String(soundCreator.blue))
                Divider()
            }
            Spacer()
        }
    }}

struct VolumeRGBTest_Previews: PreviewProvider {
    static var previews: some View {
        VolumeRGBTestView()
    }
}
