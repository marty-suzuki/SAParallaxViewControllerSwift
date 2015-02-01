//
//  SAParallaxViewLayout.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class SAParallaxViewLayout: UICollectionViewFlowLayout {
    private let kDefaultHeight: CGFloat = 220.0
    
    override init() {
        super.init()
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        minimumInteritemSpacing = 0.0
        minimumLineSpacing = 0.0
        sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let width = UIScreen.mainScreen().bounds.size.width
        let height = width / 320.0 * self.kDefaultHeight
        itemSize = CGSize(width: width, height: height)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        return super.layoutAttributesForElementsInRect(rect)
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return super.layoutAttributesForItemAtIndexPath(indexPath)
    }
}
