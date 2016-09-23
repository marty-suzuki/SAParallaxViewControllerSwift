//
//  SAParallaxViewCell.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

open class SAParallaxViewCell: UICollectionViewCell {
    
    open var containerView = SAParallaxContainerView()
    
    fileprivate var previousImageOffset = CGPoint.zero
    
    public convenience init() {
        self.init(frame: .zero)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    open override func prepareForReuse() {
        containerView.removeFromSuperview()
        initialize()
    }
    
    //MARK: - SAParallaxViewCell Private Methods
    fileprivate func initialize() {
        containerView.frame = bounds
        addSubview(containerView)
    }
    
    //MARK: - SAParallaxViewCell Public Methods
    open func setImage(_ image: UIImage) {
        containerView.setImage(image)
    }
    
    open func setImageOffset(_ offset: CGPoint) {
        if isSelected {
            return
        }
        containerView.setImageOffset(offset)
    }
    
    open func screenShot() -> UIImageView {
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        containerView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView(frame: containerView.bounds)
        imageView.image = image
        
        return imageView
    }
}
