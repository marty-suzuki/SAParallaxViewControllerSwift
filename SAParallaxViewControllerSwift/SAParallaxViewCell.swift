//
//  SAParallaxViewCell.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SAParallaxViewCell: UICollectionViewCell {
    
    public var containerView = SAParallaxContainerView()
    
    private var previousImageOffset = CGPoint.zero
    
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
    
    public override func prepareForReuse() {
        containerView.removeFromSuperview()
        initialize()
    }
    
    //MARK: - SAParallaxViewCell Private Methods
    private func initialize() {
        containerView.frame = bounds
        addSubview(containerView)
    }
    
    //MARK: - SAParallaxViewCell Public Methods
    public func setImage(_ image: UIImage) {
        containerView.setImage(image)
    }
    
    public func setImageOffset(_ offset: CGPoint) {
        if isSelected {
            return
        }
        containerView.setImageOffset(offset)
    }
    
    public func screenShot() -> UIImageView {
        
        let scale = UIScreen.main().scale
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        containerView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView(frame: containerView.bounds)
        imageView.image = image
        
        return imageView
    }
}
