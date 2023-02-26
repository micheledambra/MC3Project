//
//  SensationView.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import SwiftUI

struct SensationView: View {

    
    @ObservedObject var sensationVM = SensationVM(image: UIImage(named: "testcolors.png")!,
                                                  imageAreaSize: UIScreen.main.bounds.size)

    var body: some View {
        VStack {
            /*
            VStack {
                Rectangle()
                    .foregroundColor(Color(
                        red: sensationVM.colorIntensities.scaledRed,
                        green: sensationVM.colorIntensities.scaledGreen,
                        blue: sensationVM.colorIntensities.scaledBlue))
                    .frame(width: 100, height: 100)
            }
             */
            VStack {
                Image(uiImage: sensationVM.image)
                    .frame(width: 300, height: 300)
            }
            .gesture(dragGesture)
            .accessibilityAddTraits(.allowsDirectInteraction)
        }
    }

    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                sensationVM.isDragging = true
                sensationVM.processDragAction(x: Int(value.location.x),
                                              y: Int(value.location.y))
            }
            .onEnded { _ in
                sensationVM.isDragging = false
            }
    }

}

struct SensationView_Previews: PreviewProvider {
    static var previews: some View {
        SensationView()
    }
}
