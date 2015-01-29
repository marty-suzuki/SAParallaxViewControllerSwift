//
//  SAParallaxViewCell.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class SAParallaxViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    //var priceImage: UIImageView!
    
    override init() {
        super.init()
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        
        //priceImage = UIImageView()
        
        backgroundColor = .clearColor()
        clipsToBounds = true
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
        if let imageSize = imageView.image?.size {
            let width = UIScreen.mainScreen().bounds.size.width
            let height = width * imageSize.height / imageSize.width
            
            let yPosition = CGFloat(frame.size.height / 2.0)
            imageView.autoresizingMask = .None
            imageView.frame = CGRect(x: 0, y: -yPosition, width: width, height: height)
            addSubview(imageView)
        }
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = width / 320.0 * 60.0
        //priceImage.image = UIImage(named: "price")
        //priceImage.frame = CGRect(x: 0, y: frame.size.height - height, width: width, height: height)
        //addSubview(priceImage)
    }
    
    func setImageOffset(offset: CGPoint) {
        imageView.frame = CGRectOffset(imageView.bounds, offset.x, offset.y)
    }
}
