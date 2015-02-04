//
//  SAParallaxViewController.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

let kParallaxViewCellReuseIdentifier = "Cell"

class SAParallaxViewController: UIViewController {
    
    var collectionView :UICollectionView!
    
    private let transitionManager = SATransitionManager()
    
    override init() {
        super.init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .whiteColor()
        
        self.collectionView = UICollectionView(frame: .zeroRect, collectionViewLayout: SAParallaxViewLayout())
        
        NSLayoutConstraint.applyAutoLayout(self.view, target: self.collectionView, top: 0.0, left: 0.0, right: 0.0, bottom: 0.0, height: nil, width: nil)
        
        self.collectionView.registerClass(SAParallaxViewCell.self, forCellWithReuseIdentifier: kParallaxViewCellReuseIdentifier)
        self.collectionView.backgroundColor = .clearColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let cells = self.collectionView?.visibleCells() as? [UICollectionViewCell] {
            for cell in cells {
                cell.selected = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UICollectionViewDataSource
extension SAParallaxViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kParallaxViewCellReuseIdentifier, forIndexPath: indexPath) as SAParallaxViewCell
        cell.backgroundColor = .clearColor()
        cell.selected = false
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SAParallaxViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let cells = self.collectionView.visibleCells() as? [SAParallaxViewCell] {
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
                    cell.setImageOffset(CGPoint(x: 0.0, y: -(cell.containerView.parallaxStartPosition())-yOffset))
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as SAParallaxViewCell
        cell.selected = true
        
        if let cells = collectionView.visibleCells() as? [SAParallaxViewCell] {
            let containerView = SATransitionContainerView(frame: view.bounds)
            containerView.setViews(cells: cells, view: view)
            
            let viewController = SADetailViewController()
            viewController.transitioningDelegate = self
            viewController.trantisionContainerView = containerView
            
            presentViewController(viewController, animated: true, completion: nil)
        }
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SAParallaxViewController: UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionManager
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionManager
    }
}
