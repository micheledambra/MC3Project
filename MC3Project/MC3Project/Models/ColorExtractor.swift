//
//  ColorExtractor.swift
//  MC3Project
//
//  Created by Simon Bestler on 22.02.23.
//

import Foundation
import UIKit

struct ColorExtractor {

    private let scaleFactor: Double
    private let cgImage: CGImage
    private let imageData: CFData
    private let imageBytePointer: UnsafePointer<UInt8>
    private let bytesPerPixel: Int

    init(image: UIImage, scaleFactor : Double) {
        self.scaleFactor = scaleFactor
        let resizedImage = image.resizeByScalingFactor(scaleFactor)
        if let image = resizedImage?.cgImage {
            print("Resized Image width: \(resizedImage!.size.width), height: \(resizedImage!.size.height)")
            cgImage = image
        } else {
            // TODO: Better error handling needed (Maybe show alert, image not working?
            fatalError("Creating cgImage from Image failed!")
        }
        if let dataProvider = cgImage.dataProvider,
           let extractedData = dataProvider.data,
           let pointer = CFDataGetBytePtr(extractedData) {
            imageData = extractedData
            imageBytePointer = pointer
        } else {
            fatalError("Extracting Data from Image failed!")
        }
        bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
    }

    func getRGB(at pos: Position) -> ColorIntesities {
        let offset = (pos.y * cgImage.bytesPerRow) + (pos.x * bytesPerPixel)
        let red = Double(imageBytePointer[offset])
        let green = Double(imageBytePointer[offset + 1])
        let blue = Double(imageBytePointer[offset + 2])

        let colors = ColorIntesities(red: red, green: green, blue: blue)
        return colors
    }

    func getHSB(at positon: Position) -> ColorHSB {
        let colorIntensities = getRGB(at: positon)
        return colorIntensities.convertToHSB()
    }
}
