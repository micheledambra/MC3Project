//
//  LearningView2.swift
//  MC3Project
//
//  Created by Dolores Pastore on 02/03/23.
//

import SwiftUI

struct LearningView2: View {
    @State private var circle1Scale: CGFloat = 1
    @State private var circle2Scale: CGFloat = 1.2
    @State private var circle3Scale: CGFloat = 0.9
    @State private var circle4Scale: CGFloat = 1
    @State private var circle5Scale: CGFloat = 0.9
    @State private var circle6Scale: CGFloat = 1
    @State private var circle7Scale: CGFloat = 0.9
    @State private var circle8Scale: CGFloat = 1
    @State private var circle9Scale: CGFloat = 1
    
    
    var body: some View {
        VStack {
            HStack {
                Circle().fill(.black)
                    .scaleEffect(circle1Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Circle().strokeBorder(.black)
                    .background(Circle()
                        .fill(.white))
                    .scaleEffect(circle3Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Circle().strokeBorder(.red)
                    .background(Circle()
                        .fill(.red))
                    .scaleEffect(circle3Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
            }
            
            .padding()
            //Spacer()
            
            HStack {
                Circle().strokeBorder(.orange).background(Circle().fill(.orange))
                    .scaleEffect(circle4Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Circle().strokeBorder(.yellow).background(Circle().fill(.yellow))
                    .scaleEffect(circle5Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Circle().strokeBorder(.green)
                    .background(Circle().fill(.green))
                    .scaleEffect(circle6Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
            }
            .padding()
            //Spacer()
            
            HStack {
                Circle().strokeBorder(.blue)
                    .background(Circle()
                        .fill(.blue))
                    .scaleEffect(circle7Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Circle().strokeBorder(.indigo)
                    .background(Circle()
                        .fill(.indigo))
                    .scaleEffect(circle8Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Circle().strokeBorder(.purple)
                    .background(Circle().fill(.purple))
                    .scaleEffect(circle9Scale)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
            }
            .onAppear {
                withAnimation {
                    circle1Scale = 1.2
                    circle2Scale = 1.1
                    circle3Scale = 1.2
                    circle4Scale = 1.1
                    circle5Scale = 1.2
                    circle6Scale = 1.1
                    circle7Scale = 1.2
                    circle8Scale = 1.1
                    circle9Scale = 1.2
                }
            }
            .padding()
        }
    }
}
struct LearningView2_Previews: PreviewProvider {
    static var previews: some View {
        LearningView2()
    }
}
