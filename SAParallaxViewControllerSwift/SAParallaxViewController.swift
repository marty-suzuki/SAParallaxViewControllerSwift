//
//  SAParallaxViewController.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/01/30.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import MisterFusion



public class SAParallaxViewController: UIViewController {
    
    public static let ParallaxViewCellReuseIdentifier = "ParallaxViewCellReuseIdentifier"
    
    public var collectionView = UICollectionView(frame: .zero, collectionViewLayout: SAParallaxViewLayout())
    
    private let transitionManager = SATransitionManager()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white()
        
        view.addLayoutSubview(collectionView, andConstraints:
            collectionView.Top,
            collectionView.Left,
            collectionView.Right,
            collectionView.Bottom
        )
        
        collectionView.register(SAParallaxViewCell.self, forCellWithReuseIdentifier: self.dynamicType.ParallaxViewCellReuseIdentifier)
        collectionView.backgroundColor = .clear()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.visibleCells().forEach { $0.isSelected = false }
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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.dynamicType.ParallaxViewCellReuseIdentifier, for: indexPath)
        cell.backgroundColor = .clear()
        cell.isSelected = false
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SAParallaxViewController: UICollectionViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cells = collectionView.visibleCells() as? [SAParallaxViewCell] else { return }
        cells.forEach {
            guard let point = $0.superview?.convert($0.frame.origin, to:view) else { return }
            let yScrollStart = scrollView.frame.size.height - $0.frame.size.height
            if yScrollStart >= point.y {
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
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        collectionView.cellForItem(at: indexPath)?.isSelected = true
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension SAParallaxViewController: UIViewControllerTransitioningDelegate {

    public func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
    
    public func animationController(forDismissedController dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
}
