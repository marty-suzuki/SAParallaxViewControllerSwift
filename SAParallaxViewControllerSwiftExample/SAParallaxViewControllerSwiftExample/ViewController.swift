//
//  ViewController.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/02.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import SAParallaxViewControllerSwift

class ViewController: SAParallaxViewController {
    let titleList: [String] = ["Girl with Room", "Beautiful sky", "Music Festival", "Fashion show", "Beautiful beach", "Pizza and beer"]
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rawCell = super.collectionView(collectionView, cellForItemAt: indexPath)
        guard let cell = rawCell as? SAParallaxViewCell else { return rawCell }
            
        for case let view as UILabel in cell.containerView.accessoryView.subviews {
            view.removeFromSuperview()
        }
        
        let index = (indexPath as NSIndexPath).row % 6
        let imageName = String(format: "image%d", index + 1)
        if let image = UIImage(named: imageName) {
            cell.setImage(image)
        }
        let label = UILabel(frame: cell.containerView.accessoryView.bounds)
        label.textAlignment = .center
        label.text = titleList[index]
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        cell.containerView.accessoryView.addSubview(label)
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        
        guard let cells = collectionView.visibleCells as? [SAParallaxViewCell] else { return }
        let containerView = SATransitionContainerView(frame: view.bounds)
        containerView.setViews(cells, view: view)
        
        let viewController = DetailViewController()
        viewController.transitioningDelegate = self
        viewController.trantisionContainerView = containerView
        
        present(viewController, animated: true, completion: nil)
    }
}
