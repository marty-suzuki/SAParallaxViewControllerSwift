//
//  SADetailViewController.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import SABlurImageView

open class SADetailViewController: UIViewController {
    fileprivate struct Const {
        static let headerViewHeight: CGFloat = 44
    }
    
    open var trantisionContainerView: SATransitionContainerView?
    open var imageView = SABlurImageView()
    
    open var headerView: UIView?
    open var closeButton: UIButton?
    fileprivate var headerColorView: UIView?
    fileprivate var headerImageView: UIImageView?
    fileprivate var headerContainerView: UIView?
    fileprivate var blurImageView: UIImageView?

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let width = UIScreen.main.bounds.size.width
        imageView.image = trantisionContainerView?.containerView?.imageView.image
        if let imageSize = imageView.image?.size {
            let height = width * imageSize.height / imageSize.width
            imageView.autoresizingMask = UIViewAutoresizing()
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            view.addSubview(imageView)
        }
        

        let headerContainerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: Const.headerViewHeight))
        headerContainerView.alpha = 0.0
        headerContainerView.clipsToBounds = true
        view.addSubview(headerContainerView)
        self.headerContainerView = headerContainerView
        
        let blurImageView = SABlurImageView(frame: imageView.bounds)
        blurImageView.addBlurEffect(20.0)
        headerContainerView.addSubview(blurImageView)
        self.blurImageView = blurImageView
        
        let headerColorView = UIView(frame: headerContainerView.bounds)
        headerColorView.backgroundColor = .black
        headerColorView.alpha = 0.5
        headerContainerView.addSubview(headerColorView)
        self.headerColorView = headerColorView
        
        let headerView = UIView(frame: headerContainerView.bounds)
        headerContainerView.addSubview(headerView)
        self.headerView = headerView
        
        let closeButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: Const.headerViewHeight, height: Const.headerViewHeight))
        closeButton.setTitle("×", for: UIControlState())
        closeButton.titleLabel?.font = .systemFont(ofSize: Const.headerViewHeight)
        closeButton.titleLabel?.textColor = .white
        closeButton.addTarget(self, action: #selector(SADetailViewController.closeAction(_:)), for: .touchUpInside)
        headerView.addSubview(closeButton)
        self.closeButton = closeButton
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.headerContainerView?.alpha = 1.0
        }, completion: nil)
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override var prefersStatusBarHidden : Bool {
        return true
    }
    
    open func closeAction(_ button: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.headerContainerView?.alpha = 0.0
        }, completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
}
