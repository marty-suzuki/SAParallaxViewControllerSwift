//
//  SATransitionManager.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class SATransitionManager: NSObject {
    var animationDuration = 0.25
}

//MARK: - UIViewControllerAnimatedTransitioning
extension SATransitionManager: UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        let toView = toViewController!.view
        let fromView = fromViewController!.view
        
        let containerView = transitionContext.containerView()
        let duration = transitionDuration(transitionContext)
        
        if let parallax = toViewController as? ViewController {
            if let detail = fromViewController as? SADetailViewController {
                let transitionContainer = detail.trantisionContainerView
                containerView.addSubview(transitionContainer)
                
                UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {
                    transitionContainer.closeAnimation()
                    }, completion: { (finished) in
                        let cancelled = transitionContext.transitionWasCancelled()
                        if cancelled {
                            transitionContainer.removeFromSuperview()
                        } else {
                            containerView.addSubview(toView)
                        }
                        transitionContext.completeTransition(!cancelled)
                })
            }
        } else if let parallax = fromViewController as? ViewController {
            if let detail = toViewController as? SADetailViewController {
                let transitionContainer = detail.trantisionContainerView
                containerView.addSubview(transitionContainer)
                
                UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {
                    transitionContainer.openAnimation()
                    }, completion: { (finished) in
                        let cancelled = transitionContext.transitionWasCancelled()
                        if cancelled {
                            transitionContainer.removeFromSuperview()
                        } else {
                            containerView.addSubview(toView)
                        }
                        transitionContext.completeTransition(!cancelled)
                })
            }
        }
    }
}
