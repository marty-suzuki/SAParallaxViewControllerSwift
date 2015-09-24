//
//  UIImage+Blur.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/01.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import Accelerate

extension UIImage {
    
    public func blur(size: Float) -> UIImage! {
        
        let boxSize = size - (size % 2) + 1
        let image = self.CGImage
        let inProvider = CGImageGetDataProvider(image)
        
        let height = vImagePixelCount(CGImageGetHeight(image))
        let width = vImagePixelCount(CGImageGetWidth(image))
        let rowBytes = CGImageGetBytesPerRow(image)
        
        let inBitmapData = CGDataProviderCopyData(inProvider)
        let inData = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)
        
        let outData = malloc(CGImageGetBytesPerRow(image) * CGImageGetHeight(image))
        var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)
        
        let _ = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGBitmapContextCreate(outBuffer.data, Int(outBuffer.width), Int(outBuffer.height), 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(image).rawValue)
        let imageRef = CGBitmapContextCreateImage(context)!
        let bluredImage = UIImage(CGImage: imageRef)
        
        free(outData)
        
        return bluredImage
    }
}