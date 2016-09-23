//
//  SATransitionManager.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

open class SATransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    open var animationDuration = 0.25

    //MARK: - UIViewControllerAnimatedTransitioning
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        else { return }
    
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        switch (toViewController, fromViewController) {
        case (let _ as SAParallaxViewController, let fromVC as SADetailViewController):
            guard let transitionContainer = fromVC.trantisionContainerView else { break }
            containerView.addSubview(transitionContainer)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                
                transitionContainer.closeAnimation()
                
            }, completion: { (finished) in
                
                UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                    
                    transitionContainer.containerView?.blurContainerView.alpha = 1.0
                    
                    }, completion: { (finished) in
                        
                        let cancelled = transitionContext.transitionWasCancelled
                        if cancelled {
                            transitionContainer.removeFromSuperview()
                        } else {
                            containerView.addSubview(toViewController.view)
                        }
                        transitionContext.completeTransition(!cancelled)
                        
                })
            })
            return
            
        case (let toVC as SADetailViewController, let _ as SAParallaxViewController):
            guard let transitionContainer = toVC.trantisionContainerView else { break }
            containerView.addSubview(transitionContainer)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                
                transitionContainer.containerView?.blurContainerView.alpha = 0.0
                
            }, completion: { (finished) in
                
                UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                    
                    transitionContainer.openAnimation()
                    
                    }, completion: { (finished) in
                        
                        let cancelled = transitionContext.transitionWasCancelled
                        if cancelled {
                            transitionContainer.removeFromSuperview()
                        } else {
                            containerView.addSubview(toViewController.view)
                        }
                        transitionContext.completeTransition(!cancelled)
                        
                })
            })
            return
            
        default:
            break
        }
        
        transitionContext.completeTransition(true)
    }
}
