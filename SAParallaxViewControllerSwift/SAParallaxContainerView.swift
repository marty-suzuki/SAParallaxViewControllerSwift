//
//  SAParallaxContainerView.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/01.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import SABlurImageView

public class SAParallaxContainerView: UIView {
    
    public var imageView = UIImageView()
    public var accessoryView = UIView()
    
    public var blurContainerView = UIView()
    public var blurImageView = SABlurImageView()
    
    private var yStartPoint: CGFloat?
    private var accessoryViewHeight: CGFloat = 60
    
    private var blurColorView = UIView()
    private var blurSize: CGFloat = 20
    
    public convenience init() {
        self.init(frame: .zero)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    //MARK: - SAParallaxContainerView Private Methods
    private func initialize() {
        imageView.contentMode = .ScaleAspectFit
        
        blurContainerView.backgroundColor = .clearColor()
        blurContainerView.clipsToBounds = true
        
        accessoryView.backgroundColor = .clearColor()
        
        blurColorView.backgroundColor = .whiteColor()
        blurColorView.alpha = 0.3
        
        backgroundColor = .clearColor()
        clipsToBounds = true
    }
    
    //MARK: - SAParallaxContainerView Public Methods
    public func setImage(image: UIImage) {
        self.imageView.image = image
        if let imageSize = imageView.image?.size {
            let width = bounds.size.width
            let height = width * imageSize.height / imageSize.width
            
            let yPoint = yStartPoint ?? 0
            if yPoint == 0 {
                yStartPoint = 0
            }
            imageView.autoresizingMask = .None
            imageView.frame = CGRect(x: 0, y: -yPoint, width: width, height: height)
            addSubview(imageView)
        }
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = width / 320.0 * accessoryViewHeight
        blurContainerView.frame = CGRect(x: 0, y: frame.size.height - height, width: width, height: height)
        addSubview(blurContainerView)
        
        let blurImage = imageView.image
        if let imageSize = blurImage?.size {
            let height = width * imageSize.height / imageSize.width
            blurImageView.image = blurImage
            blurImageView.addBlurEffect(blurSize)
            blurImageView.frame = CGRect(x: 0, y: -(frame.size.height - blurContainerView.frame.height), width: width, height: height)
            blurContainerView.addSubview(blurImageView)
        }
        
        blurColorView.frame = blurContainerView.bounds
        blurContainerView.addSubview(blurColorView)
        
        accessoryView.frame = blurContainerView.bounds
        blurContainerView.addSubview(accessoryView)
    }
    
    public func setImageOffset(offset: CGPoint) {
        imageView.frame = CGRectOffset(imageView.bounds, offset.x, offset.y)
        blurImageView.frame = CGRectOffset(blurImageView.bounds, offset.x, -(frame.size.height - blurContainerView.frame.height) + offset.y)
    }
    
    public func setParallaxStartPosition(y y: CGFloat) {
        yStartPoint = CGFloat(y)
    }
    
    public func parallaxStartPosition() -> CGFloat? {
        return yStartPoint
    }
    
    public func setAccessoryViewHeight(height: CGFloat) {
        accessoryViewHeight = CGFloat(height)
    }
    
    public func setBlurSize(size: CGFloat) {
        blurSize = size
    }
    
    public func setBlurColorAlpha(alpha: CGFloat) {
        blurColorView.alpha = alpha
    }
    
    public func setBlurColor(color: UIColor) {
        blurColorView.backgroundColor = color
    }
}