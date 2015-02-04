//
//  SADetailViewController.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class SADetailViewController: UIViewController {

    var trantisionContainerView: SATransitionContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .whiteColor()
        
        let imageView = UIImageView()
        imageView.image = trantisionContainerView.containerView.imageView.image!
        if let imageSize = imageView.image?.size {
            let width = UIScreen.mainScreen().bounds.size.width
            let height = width * imageSize.height / imageSize.width
            imageView.autoresizingMask = .None
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            self.view.addSubview(imageView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
