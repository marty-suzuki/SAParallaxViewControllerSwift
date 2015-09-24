//
//  NSLayoutConstraint+Easy.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    public class func applyAutoLayout(superview: UIView, target: UIView, top: Float?, left: Float?, right: Float?, bottom: Float?, height: Float?, width: Float?) {
        
        target.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(target)
        
        var verticalFormat = "V:"
        if let top = top {
            verticalFormat += "|-(\(top))-"
        }
        verticalFormat += "[target"
        if let height = height {
            verticalFormat += "(\(height))"
        }
        verticalFormat += "]"
        if let bottom = bottom {
            verticalFormat += "-(\(bottom))-|"
        }
        let verticalConstrains = NSLayoutConstraint.constraintsWithVisualFormat(verticalFormat, options: [], metrics: nil, views: [ "target" : target ])
        superview.addConstraints(verticalConstrains)
        
        var horizonFormat = "H:"
        if let left = left {
            horizonFormat += "|-(\(left))-"
        }
        horizonFormat += "[target"
        if let width = width {
            horizonFormat += "(\(width))"
        }
        horizonFormat += "]"
        if let right = right {
            horizonFormat += "-(\(right))-|"
        }
        let horizonConstrains = NSLayoutConstraint.constraintsWithVisualFormat(horizonFormat, options: [], metrics: nil, views: [ "target" : target ])
        superview.addConstraints(horizonConstrains)
    }
}
