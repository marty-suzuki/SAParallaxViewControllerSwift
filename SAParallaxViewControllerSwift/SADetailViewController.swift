//
//  SADetailViewController.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SADetailViewController: UIViewController {

    public var trantisionContainerView: SATransitionContainerView!
    public var headerView: UIView!
    public var imageView: UIImageView!
    public var closeButton: UIButton!
    
    private var headerColorView: UIView!
    private var headerImageView: UIImageView!!
    private var headerContainerView: UIView!
    private var blurImageView: UIImageView!
    
    private let headerViewHeight = CGFloat(44.0)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .whiteColor()
        
        let width = UIScreen.mainScreen().bounds.size.width
        self.imageView = UIImageView()
        self.imageView.image = self.trantisionContainerView.containerView.imageView.image!
        if let imageSize = self.imageView.image?.size {
            let height = width * imageSize.height / imageSize.width
            self.imageView.autoresizingMask = .None
            self.imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            self.view.addSubview(self.imageView)
        }
        
        self.headerContainerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: headerViewHeight))
        self.headerContainerView.alpha = 0.0
        self.headerContainerView.clipsToBounds = true
        self.view.addSubview(self.headerContainerView)
        
        self.blurImageView = UIImageView(frame: self.imageView.bounds)
        self.blurImageView.image = self.imageView.image?.blur(20.0)
        self.headerContainerView.addSubview(self.blurImageView)
        
        self.headerColorView = UIView(frame: self.headerContainerView.bounds)
        self.headerColorView.backgroundColor = .blackColor()
        self.headerColorView.alpha = 0.5
        self.headerContainerView.addSubview(self.headerColorView)
        
        self.headerView = UIView(frame: self.headerContainerView.bounds)
        self.headerContainerView.addSubview(self.headerView)
        
        self.closeButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: headerViewHeight, height: headerViewHeight))
        self.closeButton.setTitle("X", forState: .Normal)
        self.closeButton.titleLabel?.textColor = .whiteColor()
        self.closeButton.addTarget(self, action: "closeAction:", forControlEvents: .TouchUpInside)
        self.headerView.addSubview(self.closeButton)
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations: {
            
            self.headerContainerView.alpha = 1.0
            
            }, completion: { (finished) in
                
        })
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    public func closeAction(button: UIButton) {
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations: {
            
            self.headerContainerView.alpha = 0.0
            
        }, completion: { (finished) in
            
            self.dismissViewControllerAnimated(true, completion: nil)
                
        })
    }
}
