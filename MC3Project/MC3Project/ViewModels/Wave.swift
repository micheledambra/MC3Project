//
//  Wave.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 07/03/23.
//

import SwiftUI

let LINE_LENGTH: Double = 500.0
let N = 720
let LINES = 1
let WAVES: Double = 16.0
let WAVE_HEIGHT: Double = 50
let SPACING: Double = 60.0
let CURL_AMOUNT: Double = 19.0

struct Wave: Shape {
    var factor: Double
    
    var animatableData: Double {
        get { factor }
        set { self.factor = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            (0 ..< LINES).forEach { l in
                (0 ..< N).forEach { n in
                    (n == 0)
                        ? path.move(to: point(l, step: n))
                        : path.addLine(to: point(l, step: n))
                }
                    
            }
        }
    }
    
    func point(_ line: Int, step: Int) -> CGPoint {
        let fraction: Double = Double(step) / Double(N - 1)
        let phase: Double = map(Double(step), 0, Double(N - 1), 0, 2 * Double.pi * WAVES) - 2 * Double.pi * factor
        let x: Double = lerp(-LINE_LENGTH / 2, LINE_LENGTH / 2, fraction)
        let y: Double = SPACING * (Double(line) - 0.5 * Double(LINES - 1))
        
        let amount: Double = ease(map(cos(2 * Double.pi * factor + atan2(x, y) - 0.01 * dist(x, y, 0, 0)), 1, -1, 0, 1))
        let angle: Double = phase + Double.pi * Double(line)
        
        let h: Double = x - CURL_AMOUNT * cos(angle) * amount
        let v: Double = y + Double(0.5 * WAVE_HEIGHT * sin(angle) * amount) - Double(0.5 * WAVE_HEIGHT * amount)
        
        return CGPoint(x: h, y: v)
    }
    
    func map(
        _ value: Double,
        _ start1: Double, _ stop1: Double,
        _ start2: Double, _ stop2: Double
    ) -> Double {
        start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
    }
    
    func lerp(_ a: Double, _ b: Double, _ t: Double) -> Double {
        a + (b - a) * t
    }
    
    func dist(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))
    }
    
    func ease(_ p: Double) -> Double {
        3 * p * p - 2 * p * p * p
    }
}

struct AnimatedWave: View {
    @State var factor: Double = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            Wave(factor: self.factor)
                .stroke(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, . blue, .indigo]), startPoint: .trailing, endPoint: .leading), lineWidth: 3)
                .transformEffect(self.scale(to: proxy.size))
                .transformEffect(self.translate(to: proxy.size))
        }
        .onAppear {
            withAnimation(self.animation) {
                self.factor = 1
            }
        }
    }
    
    var animation: Animation {
        Animation.linear(duration: 3).repeatForever(autoreverses: false)
    }
    
    func scale(to size: CGSize) -> CGAffineTransform {
        CGAffineTransform(
            scaleX: self.scaleFactor(size: size),
            y: self.scaleFactor(size: size))
    }
    
    func scaleFactor(size: CGSize) -> CGFloat {
        min(size.width, size.height) / CGFloat(LINE_LENGTH)
    }
    
    func translate(to size: CGSize) -> CGAffineTransform {
        CGAffineTransform(
            translationX: size.width / 2,
            y: size.height / 4)
    }
}

struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedWave()
    }
}
