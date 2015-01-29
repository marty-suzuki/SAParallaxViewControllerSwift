//
//  SAParallaxViewController.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SAParallaxViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UICollectionViewDataSource
extension SAParallaxViewController: UICollectionViewDataSource {
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 30
//    }
//    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
//        cell.backgroundColor = .redColor()
//        cell.selected = false
//        if let image = UIImage(named: String(format: "s0%d", indexPath.row%8+1)) {
//            (cell as ParallaxCollectionViewCell).setImage(image)
//        }
//        return cell
//    }
}

//MARK: - UICollectionViewDelegate
extension SAParallaxViewController: UICollectionViewDelegate {
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        if let cells = collectionView?.visibleCells() as? [ParallaxCollectionViewCell] {
//            for cell in cells {
//                let point = cell.superview!.convertPoint(cell.frame.origin, toView:view)
//                
//                let yScrollStart = scrollView.frame.size.height - cell.frame.size.height
//                if yScrollStart >= point.y {
//                    
//                    let imageRemainDistance = (cell.containerView.imageView.frame.size.width - cell.frame.size.height) / 2.0
//                    let maxScrollDistance = scrollView.frame.size.height
//                    var yOffset = (1.0 - ((point.y + cell.frame.size.height) / maxScrollDistance)) * imageRemainDistance
//                    
//                    if yOffset > imageRemainDistance {
//                        yOffset = imageRemainDistance
//                    }
//                    cell.setImageOffset(CGPoint(x: 0.0, y: -(cell.frame.size.height / 2.0)-yOffset))
//                }
//            }
//        }
//    }
//    
//    
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as ParallaxCollectionViewCell
//        cell.selected = true
//        
//        if let cells = collectionView.visibleCells() as? [ParallaxCollectionViewCell] {
//            let containerView = TransitionContainerView(frame: view.bounds)
//            containerView.setViews(cells: cells, view: view)
//            
//            let viewController = DetailViewController()
//            viewController.transitioningDelegate = self
//            viewController.trantisionContainerView = containerView
//            
//            presentViewController(viewController, animated: true, completion: nil)
//        }
//    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SAParallaxViewController: UIViewControllerTransitioningDelegate {
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return TransitionController()
//    }
//    
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return TransitionController()
//    }
}
