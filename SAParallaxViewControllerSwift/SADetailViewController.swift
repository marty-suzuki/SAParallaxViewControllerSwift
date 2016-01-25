//
//  SADetailViewController.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import SABlurImageView

public class SADetailViewController: UIViewController {

    static private let HeaderViewHeight: CGFloat = 44
    
    public var trantisionContainerView: SATransitionContainerView?
    public var imageView = SABlurImageView()
    
    public var headerView: UIView?
    public var closeButton: UIButton?
    private var headerColorView: UIView?
    private var headerImageView: UIImageView?
    private var headerContainerView: UIView?
    private var blurImageView: UIImageView?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .whiteColor()
        
        let width = UIScreen.mainScreen().bounds.size.width
        imageView.image = trantisionContainerView?.containerView?.imageView.image
        if let imageSize = imageView.image?.size {
            let height = width * imageSize.height / imageSize.width
            imageView.autoresizingMask = .None
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            view.addSubview(imageView)
        }
        
        let headerContainerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: self.dynamicType.HeaderViewHeight))
        headerContainerView.alpha = 0.0
        headerContainerView.clipsToBounds = true
        view.addSubview(headerContainerView)
        self.headerContainerView = headerContainerView
        
        let blurImageView = SABlurImageView(frame: imageView.bounds)
        blurImageView.addBlurEffect(20.0)
        headerContainerView.addSubview(blurImageView)
        self.blurImageView = blurImageView
        
        let headerColorView = UIView(frame: headerContainerView.bounds)
        headerColorView.backgroundColor = .blackColor()
        headerColorView.alpha = 0.5
        headerContainerView.addSubview(headerColorView)
        self.headerColorView = headerColorView
        
        let headerView = UIView(frame: headerContainerView.bounds)
        headerContainerView.addSubview(headerView)
        self.headerView = headerView
        
        let closeButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.dynamicType.HeaderViewHeight, height: self.dynamicType.HeaderViewHeight))
        closeButton.setTitle("X", forState: .Normal)
        closeButton.titleLabel?.textColor = .whiteColor()
        closeButton.addTarget(self, action: "closeAction:", forControlEvents: .TouchUpInside)
        headerView.addSubview(closeButton)
        self.closeButton = closeButton
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations: {
            self.headerContainerView?.alpha = 1.0
        }, completion: nil)
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
            self.headerContainerView?.alpha = 0.0
        }, completion: { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}
