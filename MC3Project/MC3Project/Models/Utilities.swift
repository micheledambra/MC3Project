//
//  Utilities.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import Foundation

struct Position {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init() {
        self.x = 0
        self.y = 0
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

    init() {
        self.red = 0.0
        self.green = 0.0
        self.blue = 0.0
    }

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

enum RGB {
    case red, green, blue
}
