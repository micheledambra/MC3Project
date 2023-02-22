//
//  ContentView.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 13/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewState = CGPoint.zero
    
    
    var body: some View {
        VStack {
            
            Image("test600")
                .resizable()
                .frame(width: 350, height:350)
                //.ignoresSafeArea()
                //.scaledToFill()
                //.ignoresSafeArea(.all)
                //.edgesIgnoringSafeArea(.all)
                
                .onTapGesture { location in
                    print("Tapped at \(location)")
                }
                .gesture(
                    
                    DragGesture().onChanged { value in
                        print("Tapped at \(value.location)")
                        viewState = value.location
                    }
                    )
                
            //Text("Position \(viewState)")
        } .ignoresSafeArea(edges: .all)
        
        .accessibilityAddTraits(.allowsDirectInteraction)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
