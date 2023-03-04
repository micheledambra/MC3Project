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
        let cgImage = self.cgImage!.rotating(to: CGImagePropertyOrientation(self.imageOrientation))!

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

    /// Converts the underlying image to JPG, so that different image processing is always the same without having to take into account if the image originally was in a dfferent format (especially PNG)
    func convertToJPEG() -> UIImage? {
        let jpegData = self.jpegData(compressionQuality: 1.0)
        if let jpegData = jpegData, let newImage = UIImage(data: jpegData) {
            return newImage
        } else {
            return nil
        }
    }
}

extension CGImage {
    func rotating(to orientation: CGImagePropertyOrientation) -> CGImage? {
        var orientedImage: CGImage?
        
        let originalWidth = self.width
        let originalHeight = self.height
        let bitsPerComponent = self.bitsPerComponent
        let bitmapInfo = self.bitmapInfo
        
        guard let colorSpace = self.colorSpace else {
            return nil
        }
        
        var degreesToRotate: Double
        var swapWidthHeight: Bool
        var mirrored: Bool
        
        switch orientation {
        case .up:
            degreesToRotate = 0.0
            swapWidthHeight = false
            mirrored = false
            break
        case .upMirrored:
            degreesToRotate = 0.0
            swapWidthHeight = false
            mirrored = true
            break
        case .right:
            degreesToRotate = -90.0
            swapWidthHeight = true
            mirrored = false
            break
        case .rightMirrored:
            degreesToRotate = -90.0
            swapWidthHeight = true
            mirrored = true
            break
        case .down:
            degreesToRotate = 180.0
            swapWidthHeight = false
            mirrored = false
            break
        case .downMirrored:
            degreesToRotate = 180.0
            swapWidthHeight = false
            mirrored = true
            break
        case .left:
            degreesToRotate = 90.0
            swapWidthHeight = true
            mirrored = false
            break
        case .leftMirrored:
            degreesToRotate = 90.0
            swapWidthHeight = true
            mirrored = true
            break
        }
        
        let radians = degreesToRotate * Double.pi / 180.0
        
        var width: Int
        var height: Int
        
        if swapWidthHeight {
            width = originalHeight
            height = originalWidth
        } else {
            width = originalWidth
            height = originalHeight
        }
        
        let bytesPerRow = (width * bitsPerPixel) / 8
        
        let contextRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        contextRef?.translateBy(x: CGFloat(width) / 2.0, y: CGFloat(height) / 2.0)
        
        if mirrored {
            contextRef?.scaleBy(x: -1.0, y: 1.0)
        }
        
        contextRef?.rotate(by: CGFloat(radians))
        
        if swapWidthHeight {
            contextRef?.translateBy(x: -CGFloat(height) / 2.0, y: -CGFloat(width) / 2.0)
        } else {
            contextRef?.translateBy(x: -CGFloat(width) / 2.0, y: -CGFloat(height) / 2.0)
        }
        
        contextRef?.draw(self, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(originalWidth), height: CGFloat(originalHeight)))
        
        orientedImage = contextRef?.makeImage()
        
        return orientedImage
    }
}

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError("Image orientation not known")
        }
    }
}

