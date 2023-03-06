//
//  ColorCircle.swift
//  MC3Project
//
//  Created by Simon Bestler on 06.03.23.
//

import Foundation
import SwiftUI


struct ColorCircle : Identifiable {
    let id = UUID()
    let color : Color
    let scaleIn : CGFloat
    let scaleOut : CGFloat
    var scale : CGFloat
    var isSelected : Bool
    var frequency : Double = 0.0

    private var soundCreator : SoundCreator

    init(color: Color, scaleIn: CGFloat = 1.0, scaleOut: CGFloat = 1.2) {
        self.color = color
        self.scaleIn = scaleIn
        self.scaleOut = scaleOut
        self.scale  = scaleIn
        self.isSelected = false
        self.frequency = ColorCircle.calcFrequency(color: color)
        self.soundCreator = SoundCreator(oscillatorSettings: [OscillatorSettings(frequency: frequency, amplitude: 1.0)])
    }

    mutating func startAnimation(){
        isSelected = true
        withAnimation {
            scale = scaleOut
        }
        soundCreator.settings[0].amplitude = 1.0
        soundCreator.startSound()
    }

    mutating func stopAnimation(){
        isSelected = false
        withAnimation {
            scale = scaleIn
        }
        soundCreator.stopSound()
    }

    static func calcFrequency(color : Color) -> Double{
        let colorHSB = color.getColorHSB()
        let degree = colorHSB.hue * 360
        let frequency = 650 - 250 / 270 * degree
        return frequency
    }
}
