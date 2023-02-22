//
//  PosixToRGB.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 22/02/23.
//

import Foundation
import UIKit

class ColorExtraction: ObservableObject {
    
    @Published var currentColor = [0.0, 0.0, 0.0]
    
    let image = UIImage(named: "test300.png")!
    let cgImage : CGImage
    //let bytesPerPixel : Int
    //let bytes : UnsafePointer<UInt8>!
    
    
    init(){
        
        //assert(cgImage.colorSpace!.model == .rgb)
        cgImage = image.cgImage!
        let data = cgImage.dataProvider!.data
    }
    
    func fixValue(){
        getRGB(x: 10, y: 10)
    }
    

    
    

    
    func getRGB(x:Int, y:Int){
        let data = cgImage.dataProvider!.data
        let bytes = CFDataGetBytePtr(data)!
        let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
        let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
        let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
        currentColor[0] = Double(components.0)
        currentColor[1] = Double(components.1)
        currentColor[2] = Double(components.2)
        print("[x:\(x), y:\(y)] \(components)")
        return
    }
    
}

