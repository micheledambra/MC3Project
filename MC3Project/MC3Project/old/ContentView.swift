//
//  ContentView.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 13/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewState = CGPoint.zero
    
    @ObservedObject var colorExtraction = ColorExtraction()
    
    
    var tap: some Gesture {
            TapGesture(count: 1)
                .onEnded {
                    colorExtraction.currentColor[0] = 0.0
                    colorExtraction.currentColor[1] = 0.0
                    colorExtraction.currentColor[2] = 0.0
                }
        }
    
    var body: some View {
        //GeometryReader { geometry in
        VStack{
            VStack{
                Rectangle()
                    .foregroundColor(Color(red: colorExtraction.currentColor[0]/255.0, green: colorExtraction.currentColor[1]/255.0, blue: Double(colorExtraction.currentColor[2]/255.0)))
                    .frame(width: 100, height: 100)
                
            }
            VStack {
                Image("test300")
                //.resizable()
                    .frame(width: 300, height:300)
                //.ignoresSafeArea()
                //.scaledToFill()
                //.ignoresSafeArea(.all)
                //.edgesIgnoringSafeArea(.all)
                    .gesture(
                        
                        DragGesture(minimumDistance: 0).onChanged { value in
                            //print("Tapped at \(value.location)")
                            colorExtraction.getRGB(x: Int(value.location.x), y: Int(value.location.y))
                            //print("Color at \()")
                            //colorExtraction.fixValue()
                            viewState = value.location
                        }
                            .onEnded({ _ in
                                colorExtraction.currentColor[0] = 0.0
                                colorExtraction.currentColor[1] = 0.0
                                colorExtraction.currentColor[2] = 0.0
                            })
                    )
                
                //Text("Position \(viewState)")
            } .ignoresSafeArea(edges: .all)
            
                .accessibilityAddTraits(.allowsDirectInteraction)
            
            //}
        }
        
    }
    
}


 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
    }
 }
 
