//
//  BubbleAnimation2.swift
//  MC3Project
//
//  Created by Dolores Pastore on 02/03/23.
//

import SwiftUI

struct BubbleAnimation2: View {
        let colors = [Color.red, Color.orange, Color.yellow, Color.pink, Color.blue, Color.purple, Color.green, Color.indigo, Color.black]
        let minSize: CGFloat = 50
        let maxSize: CGFloat = 90
        let maxOffset: CGFloat = 700
        
        @State var circles: [(color: Color, size: CGFloat, offset: CGSize)] = []
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    ForEach(circles.indices, id: \.self) { index in
                        Circle()
                            .fill(circles[index].color)
                            .frame(width: circles[index].size, height: circles[index].size)
                            .offset(circles[index].offset)
                            .animation(Animation.easeInOut(duration: 8).repeatForever())
                    }
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                        withAnimation {
                            let newCircles = (0..<Int.random(in: 1...3)).map { _ in
                                let color = colors.randomElement()!
                                let size = CGFloat.random(in: minSize...maxSize)
                                let x = CGFloat.random(in: -maxOffset...maxOffset)
                                let y = CGFloat.random(in: -maxOffset...maxOffset)
                                let offset = CGSize(width: x, height: y)
                                return (color, size, offset)
                            }
                            circles.append(contentsOf: newCircles)
                            if circles.count > 100 {
                                circles.removeFirst(circles.count - 30)
                            }
                        }
                    }
                }
            }
            //.background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }

struct BubbleAnimation2_Previews: PreviewProvider {
    static var previews: some View {
        BubbleAnimation2()
    }
}
