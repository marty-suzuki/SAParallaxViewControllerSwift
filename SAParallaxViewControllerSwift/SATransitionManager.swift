//
//  SATransitionManager.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SATransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    public var animationDuration = 0.25
    
    //MARK: - UIViewControllerAnimatedTransitioning
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        else { return }
    
        let containerView = transitionContext.containerView()
        let duration = transitionDuration(transitionContext)
        
        switch (toViewController, fromViewController) {
        case (let _ as SAParallaxViewController, let fromVC as SADetailViewController):
            guard let transitionContainer = fromVC.trantisionContainerView else { break }
            containerView.addSubview(transitionContainer)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {
                
                transitionContainer.closeAnimation()
                
            }, completion: { (finished) in
                
                UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {
                    
                    transitionContainer.containerView?.blurContainerView.alpha = 1.0
                    
                    }, completion: { (finished) in
                        
                        let cancelled = transitionContext.transitionWasCancelled()
                        if cancelled {
                            transitionContainer.removeFromSuperview()
                        } else {
                            containerView.addSubview(toViewController.view)
                        }
                        transitionContext.completeTransition(!cancelled)
                        
                })
            })
            return
            
        case (let toVC as SADetailViewController, let fromVC as SAParallaxViewController):
            guard let transitionContainer = toVC.trantisionContainerView else { break }
            containerView.addSubview(transitionContainer)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {
                
                transitionContainer.containerView?.blurContainerView.alpha = 0.0
                
            }, completion: { (finished) in
                
                UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {
                    
                    transitionContainer.openAnimation()
                    
                    }, completion: { (finished) in
                        
                        let cancelled = transitionContext.transitionWasCancelled()
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
