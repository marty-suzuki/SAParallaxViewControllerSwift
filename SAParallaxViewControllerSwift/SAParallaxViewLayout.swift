//
//  SAParallaxViewLayout.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SAParallaxViewLayout: UICollectionViewFlowLayout {
    
    private let kDefaultHeight: CGFloat = 220.0
    
    public override init() {
        super.init()
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        minimumInteritemSpacing = 0.0
        minimumLineSpacing = 0.0
        sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let width = UIScreen.mainScreen().bounds.size.width
        let height = width / 320.0 * kDefaultHeight
        itemSize = CGSize(width: width, height: height)
    }
    
    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElementsInRect(rect)
    }
    
    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItemAtIndexPath(indexPath)
    }
}
