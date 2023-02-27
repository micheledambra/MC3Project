//
//  SensationView.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import SwiftUI

struct SensationView: View {

    private let img : UIImage
    private let imgSize : CGSize
    @State private var scaledImgSize: CGSize

    @ObservedObject var sensationVM : SensationVM

    init(){
        self.img = UIImage(named: "IMG_1179.heic")!
        self.sensationVM = SensationVM(image: img)
        self.imgSize = img.size
        self.scaledImgSize = CGSize()
    }

    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .foregroundColor(Color(
                        red: sensationVM.colorIntensities.scaledRed,
                        green: sensationVM.colorIntensities.scaledGreen,
                        blue: sensationVM.colorIntensities.scaledBlue))
                    .frame(width: 50, height: 50)
            }
            
            VStack {
                GeometryReader { geo in
                    resizableImageView(geo: geo)
                }

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
                let x = Int(value.location.x)
                let y = Int(value.location.y)
                if (x < Int(scaledImgSize.width) && y < Int(scaledImgSize.height)){
                    sensationVM.processDragAction(x: x,y: y)
                }
            }
            .onEnded { _ in
                sensationVM.isDragging = false
            }
    }

    private func resizableImageView(geo : GeometryProxy) -> some View {
        return Image(uiImage: sensationVM.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear{
                sensationVM.scaleFactor = calcScaleFactor(areaSize: geo.size,
                                                          imgSize: imgSize)
                scaledImgSize.height = sensationVM.scaleFactor * imgSize.height
                scaledImgSize.width = sensationVM.scaleFactor * imgSize.width
            }
        }

    private func calcScaleFactor(areaSize: CGSize, imgSize: CGSize) -> Double {
        let widhtScale = areaSize.width / imgSize.width
        let heightScale = areaSize.height / imgSize.height
        return min(widhtScale, heightScale)
    }

}
/*
 struct SensationView_Previews: PreviewProvider {
 static var previews: some View {
 SensationView()
 }
 }
 */
