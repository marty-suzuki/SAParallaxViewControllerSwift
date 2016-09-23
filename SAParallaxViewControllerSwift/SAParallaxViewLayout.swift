//
//  SAParallaxViewLayout.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

open class SAParallaxViewLayout: UICollectionViewFlowLayout {
    
    fileprivate static let defaultHeight: CGFloat = 220
    
    public override init() {
        super.init()
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        minimumInteritemSpacing = 0.0
        minimumLineSpacing = 0.0
        sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let width = UIScreen.main.bounds.size.width
        let height = width / 320.0 * SAParallaxViewLayout.defaultHeight
        itemSize = CGSize(width: width, height: height)
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
}
