//
//  SAParallaxViewController.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import MisterFusion

open class SAParallaxViewController: UIViewController {
    
    open static let parallaxViewCellReuseIdentifier = "ParallaxViewCellReuseIdentifier"
    
    open var collectionView = UICollectionView(frame: .zero, collectionViewLayout: SAParallaxViewLayout())
    
    fileprivate let transitionManager = SATransitionManager()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addLayoutSubview(collectionView, andConstraints:
            collectionView.top,
            collectionView.left,
            collectionView.right,
            collectionView.bottom
        )
        
        collectionView.register(SAParallaxViewCell.self, forCellWithReuseIdentifier: SAParallaxViewController.parallaxViewCellReuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.visibleCells.forEach { $0.isSelected = false }
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override var prefersStatusBarHidden : Bool {
        return true
    }
}

//MARK: - UICollectionViewDataSource
extension SAParallaxViewController: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SAParallaxViewController.parallaxViewCellReuseIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.isSelected = false
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SAParallaxViewController: UICollectionViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cells = collectionView.visibleCells as? [SAParallaxViewCell] else { return }
        cells.forEach {
            guard let point = $0.superview?.convert($0.frame.origin, to:view) else { return }
            let yScrollStart = scrollView.frame.size.height - $0.frame.size.height
            guard yScrollStart >= point.y else { return }
            let imageRemainDistance = ($0.containerView.imageView.frame.size.width - $0.frame.size.height) / 2.0
            let maxScrollDistance = scrollView.frame.size.height
            var yOffset = (1.0 - ((point.y + $0.frame.size.height) / maxScrollDistance)) * imageRemainDistance
            
            if yOffset > imageRemainDistance {
                yOffset = imageRemainDistance
            }
            if let parallaxStartPosition = $0.containerView.parallaxStartPosition() {
                $0.setImageOffset(CGPoint(x: 0.0, y: -(parallaxStartPosition) - yOffset))
            }
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        collectionView.cellForItem(at: indexPath)?.isSelected = true
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SAParallaxViewController: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
}
