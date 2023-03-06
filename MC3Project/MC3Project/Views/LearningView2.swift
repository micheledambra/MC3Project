//
//  LearningView2.swift
//  MC3Project
//
//  Created by Dolores Pastore on 02/03/23.
//

import SwiftUI

struct LearningView2: View {

    @State private var colorsRow1 = [
        ColorCircle(color: .black),
        ColorCircle(color: .white),
        ColorCircle(color: .red),
    ]

    @State private var colorsRow2 = [
        ColorCircle(color: .orange),
        ColorCircle(color: .yellow),
        ColorCircle(color: .green),
    ]

    @State private var colorsRow3 = [
        ColorCircle(color: .blue),
        ColorCircle(color: .indigo),
        ColorCircle(color: .purple)

    ]



    var body: some View {
        VStack {
            ColorRowView(colorCircles: $colorsRow1)
            ColorRowView(colorCircles: $colorsRow2)
            ColorRowView(colorCircles: $colorsRow3)
        }
    }
}


struct ColorRowView : View {

    @Binding var colorCircles : [ColorCircle]

    var body: some View {
        HStack {
            ForEach($colorCircles) { $colorCircle in
                ColorCircleView(colorCircle: $colorCircle)
            }
        }
        .padding()
    }
}


struct ColorCircleView: View {

    @Binding var colorCircle : ColorCircle

    var strokeColor : Color {
        if colorCircle.color == .white {
            return .black
        } else {
            return colorCircle.color
        }
    }

    var body: some View {
        Circle()
            .strokeBorder(strokeColor)
            .background(Circle().fill(colorCircle.color))
            .scaleEffect(colorCircle.scale)
            .animation(Animation.easeInOut(duration: 1)
                .repeat(while: colorCircle.isSelected,autoreverses: true), value: colorCircle.scale)
            .gesture(pressGesture)
    }

    var pressGesture : some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                colorCircle.startAnimation()
            }
            .onEnded { _ in
                colorCircle.stopAnimation()
            }
    }
}

struct LearningView2_Previews: PreviewProvider {
    static var previews: some View {
        LearningView2()
    }
}
