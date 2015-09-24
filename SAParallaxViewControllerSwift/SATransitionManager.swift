//
//  SATransitionManager.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SATransitionManager: NSObject {
    public var animationDuration = 0.25
}

//MARK: - UIViewControllerAnimatedTransitioning
extension SATransitionManager: UIViewControllerAnimatedTransitioning {

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        guard let containerView = transitionContext.containerView() else {
            return
        }
        
        let duration = transitionDuration(transitionContext)
        if let _ = toViewController as? SAParallaxViewController {
            if let detail = fromViewController as? SADetailViewController {
                if let transitionContainer = detail.trantisionContainerView {
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
                }
            }
        } else if let _ = fromViewController as? SAParallaxViewController {
            if let detail = toViewController as? SADetailViewController {
                if let transitionContainer = detail.trantisionContainerView {
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
                }
            }
        }
    }
}
