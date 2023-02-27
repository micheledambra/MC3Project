//
//  SensationView.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import SwiftUI

struct SensationView: View {

    let img : UIImage
    let imgSize : CGSize

    @ObservedObject var sensationVM : SensationVM

    init(){
        self.img = UIImage(named: "IMG_1179.heic")!
        self.sensationVM = SensationVM(image: img)
        self.imgSize = img.size
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

    private func resizableImageView(geo : GeometryProxy) -> some View {
        return Image(uiImage: sensationVM.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear{
                sensationVM.scaleFactor = calcScaleFactor(areaSize: geo.size,
                                                          imgSize: imgSize)
            }
        }

    private func calcScaleFactor(areaSize: CGSize, imgSize: CGSize) -> Double {
        let widhtScale = areaSize.width / imgSize.width
        let heightScale = areaSize.height / imgSize.height
        return min(widhtScale, heightScale)
    }

}

struct SensationView_Previews: PreviewProvider {
    static var previews: some View {
        SensationView()
    }
}
