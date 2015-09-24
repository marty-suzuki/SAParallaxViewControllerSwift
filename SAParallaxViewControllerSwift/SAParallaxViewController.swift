//
//  SAParallaxViewController.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public let kParallaxViewCellReuseIdentifier = "Cell"

public class SAParallaxViewController: UIViewController {
    
    public var collectionView = UICollectionView(frame: .zero, collectionViewLayout: SAParallaxViewLayout())
    
    private let transitionManager = SATransitionManager()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .whiteColor()
        
        NSLayoutConstraint.applyAutoLayout(view, target: collectionView, top: 0.0, left: 0.0, right: 0.0, bottom: 0.0, height: nil, width: nil)
        
        collectionView.registerClass(SAParallaxViewCell.self, forCellWithReuseIdentifier: kParallaxViewCellReuseIdentifier)
        collectionView.backgroundColor = .clearColor()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let cells = collectionView.visibleCells()
        for cell in cells {
            cell.selected = false
        }
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

//MARK: - UICollectionViewDataSource
extension SAParallaxViewController: UICollectionViewDataSource {
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kParallaxViewCellReuseIdentifier, forIndexPath: indexPath) 
        cell.backgroundColor = .clearColor()
        cell.selected = false
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SAParallaxViewController: UICollectionViewDelegate {
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if let cells = collectionView.visibleCells() as? [SAParallaxViewCell] {
            for cell in cells {
                let point = cell.superview!.convertPoint(cell.frame.origin, toView:view)
                
                let yScrollStart = scrollView.frame.size.height - cell.frame.size.height
                if yScrollStart >= point.y {
                    
                    let imageRemainDistance = (cell.containerView.imageView.frame.size.width - cell.frame.size.height) / 2.0
                    let maxScrollDistance = scrollView.frame.size.height
                    var yOffset = (1.0 - ((point.y + cell.frame.size.height) / maxScrollDistance)) * imageRemainDistance
                    
                    if yOffset > imageRemainDistance {
                        yOffset = imageRemainDistance
                    }
                    if let parallaxStartPosition = cell.containerView.parallaxStartPosition() {
                        cell.setImageOffset(CGPoint(x: 0.0, y: -(parallaxStartPosition) - yOffset))
                    }
                }
            }
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.selected = true
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SAParallaxViewController: UIViewControllerTransitioningDelegate {

    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
}
