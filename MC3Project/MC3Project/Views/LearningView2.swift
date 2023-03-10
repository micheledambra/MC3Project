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
        ColorCircle(color: .red),
        ColorCircle(color: .orange),
    ]

    @State private var colorsRow2 = [
        ColorCircle(color: .yellow),
        ColorCircle(color: .green),
        ColorCircle(color: .blue),
    ]

    @State private var colorsRow3 = [
        ColorCircle(color: .indigo),
        ColorCircle(color: .purple),
        ColorCircle(color: .white)
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
        } else if (colorCircle.color == .black) {
            return .white
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
            .accessibilityLabel("\(colorCircle.color.description)")
            .accessibilityAddTraits(.allowsDirectInteraction)
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
