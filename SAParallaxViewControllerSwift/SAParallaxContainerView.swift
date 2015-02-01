//
//  SAParallaxContainerView.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/01.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class SAParallaxContainerView: UIView {
    var imageView: UIImageView!
    var accessoryView: UIView!
    private var yStartPoint: CGFloat!
    private var accessoryViewHeight = CGFloat(60.0)
    private var blurContainerView: UIView!
    private var blurImageView: UIImageView!
    private var blurColorView: UIView!
    private var blurSize = Float(20.0)
    
    override init() {
        super.init()
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    //MARK: - SAParallaxContainerView Private Methods
    private func initialize() {
        self.imageView = UIImageView()
        self.imageView.contentMode = .ScaleAspectFit
        
        self.blurImageView = UIImageView()
        
        self.blurContainerView = UIView()
        self.blurContainerView.backgroundColor = .clearColor()
        self.blurContainerView.clipsToBounds = true
        
        self.accessoryView = UIView()
        self.accessoryView.backgroundColor = .clearColor()
        
        self.blurColorView = UIView()
        self.blurColorView.backgroundColor = .blackColor()
        self.blurColorView.alpha = 0.3
        
        self.backgroundColor = .clearColor()
        self.clipsToBounds = true
    }
    
    //MARK: - SAParallaxContainerView Public Methods
    func setImage(image: UIImage) {
        self.imageView.image = image
        if let imageSize = self.imageView.image?.size {
            let width = self.bounds.size.width
            let height = width * imageSize.height / imageSize.width
            
            var yPoint = CGFloat(0.0)
            if let yStartPoint = self.yStartPoint {
                yPoint = yStartPoint
            } else {
                self.yStartPoint = yPoint
            }
            self.imageView.autoresizingMask = .None
            self.imageView.frame = CGRect(x: 0, y: -yPoint, width: width, height: height)
            self.addSubview(self.imageView)
        }
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = width / 320.0 * self.accessoryViewHeight
        self.blurContainerView.frame = CGRect(x: 0, y: self.frame.size.height - height, width: width, height: height)
        self.addSubview(self.blurContainerView)
        
        let blurImage = self.imageView.image?.blur(self.blurSize)
        if let imageSize = blurImage?.size {
            let height = width * imageSize.height / imageSize.width
            self.blurImageView.image = blurImage
            self.blurImageView.frame = CGRect(x: 0, y: -(self.frame.size.height - self.blurContainerView.frame.height), width: width, height: height)
            self.blurContainerView.addSubview(self.blurImageView)
        }
        
        self.blurColorView.frame = self.blurContainerView.bounds
        self.blurContainerView.addSubview(self.blurColorView)
        
        self.accessoryView.frame = self.blurContainerView.bounds
        self.blurContainerView.addSubview(self.accessoryView)
    }
    
    func setImageOffset(offset: CGPoint) {
        self.imageView.frame = CGRectOffset(self.imageView.bounds, offset.x, offset.y)
        self.blurImageView.frame = CGRectOffset(self.blurImageView.bounds, offset.x, -(self.frame.size.height - self.blurContainerView.frame.height) + offset.y)
    }
    
    func setParallaxStartPosition(#y: Float) {
        self.yStartPoint = CGFloat(y)
    }
    
    func parallaxStartPosition() -> CGFloat {
        return self.yStartPoint
    }
    
    func setAccessoryViewHeight(height: Float) {
        self.accessoryViewHeight = CGFloat(height)
    }
    
    func setBlurSize(size :Float) {
        self.blurSize = size
    }
}