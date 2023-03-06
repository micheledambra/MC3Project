//
//  Utilities.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import Foundation
import UIKit

struct Position {
    let x: Int
    let y: Int

    init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }

}

struct ColorIntesities {

    var red: Double
    var green: Double
    var blue: Double

    var scaledRed: Double {
        red/255
    }

    var scaledGreen: Double {
        green/255
    }

    var scaledBlue: Double {
        blue/255
    }

    init(red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension ColorIntesities {
    func convertToHSB() -> ColorHSB {

        let color = UIColor(red: self.scaledRed,
                              green: self.scaledGreen,
                              blue: self.scaledBlue,
                              alpha: 1.0)

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        let hsbColor = ColorHSB(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness))

        //print("Hue: \(hue), Saturation: \(saturation), Brightness: \(brightness)")

        return hsbColor

    }
}


struct ColorHSB {
    var hue  = 0.0
    var saturation = 0.0
    var brightness = 0.0

    init(hue: Double = 0.0, saturation: Double = 0.0, brightness: Double = 0.0) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
    }
}

enum RGB {
    case red, green, blue
}

enum ColorScheme {
    case rgb, hsb
}
