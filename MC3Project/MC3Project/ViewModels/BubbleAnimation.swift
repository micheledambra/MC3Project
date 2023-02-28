//
//  BubbleAnimation.swift
//  MC3Project
//
//  Created by Mariavittoria La Barbera on 28/02/23.
//

import SwiftUI

struct BubbleAnimation: View {
    @State var scale : CGFloat = 1
    let rouge = Color(red: 255, green: 255, blue: 255) //custom color
    var body: some View {
        
        ZStack {
            ForEach (1...50, id:\.self) { _ in
                Circle ()
                    .foregroundColor(Color (red: .random(in: 0.4...1),
                                            green: 0.7,
                                            blue: .random(in: 0.11...1)))
                
                
                
                    .blendMode(.colorDodge) // The bottom circle is lightened by the top layer
                    .animation (Animation.spring (dampingFraction: 0.5)
                        .repeatForever()
                        .speed (.random(in: 0.05...0.4))
                        .delay(.random (in: 0...1)), value: scale
                    ) // move the circle to the target point and bounce back
                
                    .scaleEffect(self.scale * .random(in: 0.1...3))
                    .frame(width: .random(in: 1...100),
                           height: CGFloat.random (in:20...100),
                           alignment: .center)
                    .position(CGPoint(x: .random(in: 0...1112),
                                      y: .random (in:0...834)))
            }
            
            /* ZStack{
             Rectangle()
             .frame(width: 116.0, height: 57.0)
             .cornerRadius(/*@START_MENU_TOKEN@*/13.0/*@END_MENU_TOKEN@*/)
             .foregroundColor(.black)
             Button("Upload") {
             /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
             } .foregroundColor(.white)
             }*/
        }
        
        .onAppear {
            
            self.scale = 1.2 // default circle scale
        }
        
        .drawingGroup(opaque: false, colorMode: .linear) // makes the app faster, rendering the contents of the view into an off-screen image before putting it back onto the screen as a single rendered output
        .background(
            Rectangle()
                .foregroundColor(rouge))
        //.ignoresSafeArea()
    }
    
    struct BubbleAnimation_Previews: PreviewProvider {
        static var previews: some View {
            BubbleAnimation()
        }
    }
}
