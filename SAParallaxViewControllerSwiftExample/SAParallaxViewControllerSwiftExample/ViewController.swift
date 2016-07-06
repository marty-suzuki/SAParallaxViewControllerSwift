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
}

//MARK: - UICollectionViewDataSource
extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        if let cell = cell as? SAParallaxViewCell {
            
            for view in cell.containerView.accessoryView.subviews {
                if let view = view as? UILabel {
                    view.removeFromSuperview()
                }
            }
            
            let index = (indexPath as NSIndexPath).row % 6
            let imageName = String(format: "image%d", index + 1)
            if let image = UIImage(named: imageName) {
                cell.setImage(image)
            }
            let title = ["Girl with Room", "Beautiful sky", "Music Festival", "Fashion show", "Beautiful beach", "Pizza and beer"]
            let label = UILabel(frame: cell.containerView.accessoryView.bounds)
            label.textAlignment = .center
            label.text = title[index]
            label.textColor = .white()
            label.font = .systemFont(ofSize: 30)
            cell.containerView.accessoryView.addSubview(label)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        
        if let cells = collectionView.visibleCells() as? [SAParallaxViewCell] {
            let containerView = SATransitionContainerView(frame: view.bounds)
            containerView.setViews(cells: cells, view: view)
            
            let viewController = DetailViewController()
            viewController.transitioningDelegate = self
            viewController.trantisionContainerView = containerView
            
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
