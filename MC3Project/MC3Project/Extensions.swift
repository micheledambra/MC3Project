//
//  Extensions.swift
//  MC3Project
//
//  Created by Simon Bestler on 27.02.23.
//

import Foundation
import UIKit


extension UIImage {

    func resizeByScalingFactor(_ scaleFactor : Double) -> UIImage? {
        let cgImage = self.cgImage!

        let destWidth = Int(self.size.width * scaleFactor)
        let destHeight = Int(self.size.height * scaleFactor)
        let destSize = CGSize(width: destWidth, height: destHeight)
        let bitsPerComponent = 8
        let bytesPerPixel = cgImage.bitsPerPixel / bitsPerComponent
        let destBytesPerRow = destWidth * bytesPerPixel

        let context = CGContext(data: nil,
                                width: destWidth,
                                height: destHeight,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: destBytesPerRow,
                                space: cgImage.colorSpace!,
                                bitmapInfo: cgImage.bitmapInfo.rawValue)!
        context.interpolationQuality = .high

        context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: destSize))
        return context.makeImage().flatMap { UIImage(cgImage: $0, scale: 1.0, orientation: self.imageOrientation) }
    }
}

