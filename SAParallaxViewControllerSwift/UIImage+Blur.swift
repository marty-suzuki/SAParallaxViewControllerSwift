//
//  UIImage+Blur.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/01.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import Accelerate

extension UIImage {
    func blur(size: Float) -> UIImage! {
        let boxSize = size - (size % 2) + 1
        let image = self.CGImage
        let inProvider = CGImageGetDataProvider(image)
        
        let height = CGImageGetHeight(image)
        let width = CGImageGetWidth(image)
        let rowBytes = CGImageGetBytesPerRow(image)
        
        let inBitmapData = CGDataProviderCopyData(inProvider)
        let inData = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)
        
        let outData = malloc(CGImageGetBytesPerRow(image) * CGImageGetHeight(image))
        var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)
        
        let error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(image))
        let imageRef = CGBitmapContextCreateImage(context)
        let bluredImage = UIImage(CGImage: imageRef)
        
        free(outData)
        
        return bluredImage
    }
}