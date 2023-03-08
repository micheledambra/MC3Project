//
//  SensationView.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import SwiftUI
import SwiftUIShakeGesture

struct SensationView: View {

    @Environment(\.dismiss) var dismiss

    private let img : UIImage
    private let imgSize : CGSize
    @State private var scaledImgSize = CGSize()

    @ObservedObject var sensationVM : SensationVM
    
    @State var circlePosition:CGPoint = CGPoint(x: 0, y: 0)
    @State private var isAlert = false

    init(){
        self.img = UIImage(named: "testcolors.png")!
        self.imgSize = img.size
        self.sensationVM = SensationVM(image: img)
    }

    init(imageData : Data?){
        if let imageData = imageData,
           let originalImage = UIImage(data: imageData),
           let img = originalImage.convertToJPEG(){
            self.img = img
            self.imgSize = self.img.size
            self.sensationVM = SensationVM(image: img)
        }else {
            self = .init()
        }

    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                sensationVM.isDragging = true
                let x = Int(value.location.x)
                let y = Int(value.location.y)
                let position = Position(x: x, y: y)
                circlePosition.x = CGFloat(x)
                circlePosition.y = CGFloat(y)
                sensationVM.processDragAction(position: position, scaledImgSize: scaledImgSize)
            }
            .onEnded { _ in
                sensationVM.isDragging = false
            }
    }

    var body: some View {
        NavigationStack {
            ZStack() {
                /*VStack {
                 Circle()
                 .foregroundColor(Color(
                 red: sensationVM.colorIntensities.scaledRed,
                 green: sensationVM.colorIntensities.scaledGreen,
                 blue: sensationVM.colorIntensities.scaledBlue))
                 .frame(width: 50, height: 50)
                 .position(x: circlePosition.x, y: circlePosition.y)
                 }*/

                //VStack{
                GeometryReader { geo in
                    resizableImageView(geo: geo)
                    //.position(x: geo.size.width/2, y:geo.size.height/2)
                }


                

                //}
                .gesture(dragGesture)
                .accessibilityAddTraits(.allowsDirectInteraction)

                if sensationVM.isDragging == true {
                    Circle()
                        .strokeBorder(.black)
                        .background(Circle().fill(Color(
                            red: sensationVM.colorIntensities.scaledRed,
                            green: sensationVM.colorIntensities.scaledGreen,
                            blue: sensationVM.colorIntensities.scaledBlue)))
                    //.foregroundColor(Color(
                    // red: sensationVM.colorIntensities.scaledRed,
                    // green: sensationVM.colorIntensities.scaledGreen,
                    //blue: sensationVM.colorIntensities.scaledBlue))

                        .frame(width: 35, height: 35)
                        .position(x: circlePosition.x, y: (circlePosition.y-40))
                }
                //Text("Shake to Exit")
            }
            .onShake{
                isAlert = true
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "x.circle")
                        .onTapGesture {
                            isAlert = true
                    }
                        .accessibilityLabel("Button close view")
                }
            }
            .alert(isPresented:$isAlert) {
                Alert(
                    title: Text("Are you sure you want to leave this view?"),
                    message: Text("You will then return to the selection and can choose a new image"),
                    primaryButton: .default(Text("Yes")) {
                        dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }

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

 struct SensationView_Previews: PreviewProvider {
     static var previews: some View {
        SensationView()
     }
 }

