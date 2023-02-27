//
//  SensationView.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import SwiftUI

struct SensationView: View {

    @Environment(\.dismiss) var dismiss


    @ObservedObject var sensationVM :SensationVM

    init(){
        sensationVM = SensationVM(image: UIImage(named: "test300.png")!)
    }

    init(imageData : Data?){
        let img = UIImage(data: imageData!)
        self.sensationVM = SensationVM(image: img!)
    }

    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .foregroundColor(Color(
                        red: sensationVM.colorIntensities.scaledRed,
                        green: sensationVM.colorIntensities.scaledGreen,
                        blue: sensationVM.colorIntensities.scaledBlue))
                    .frame(width: 100, height: 100)
            }
            VStack {
                Image(uiImage: sensationVM.image)
                    .frame(width: 300, height: 300)
            }
            .gesture(dragGesture)
            .accessibilityAddTraits(.allowsDirectInteraction)
            VStack{
                Button("Dismiss"){
                    dismiss()
                }
            }
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
/*
 struct SensationView_Previews: PreviewProvider {
 static var previews: some View {
 SensationView()
 }
 }
 */
