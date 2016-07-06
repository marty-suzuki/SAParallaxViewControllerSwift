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

    public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: UITransitionContextToViewControllerKey),
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey)
        else { return }
        let containerView = transitionContext.containerView()
        let duration = transitionDuration(transitionContext)
        
        
        switch (toViewController, fromViewController) {
        case (let parallaxVC as SAParallaxViewController, let detailVC as SADetailViewController):
            guard  let transitionContainer = detailVC.trantisionContainerView else { return }
            containerView.addSubview(transitionContainer)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                
                transitionContainer.closeAnimation()
                
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                        
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
            
        case (let detailVC as SADetailViewController, let parallaxVC as SAParallaxViewController):
            guard  let transitionContainer = detailVC.trantisionContainerView else { return }
            
            containerView.addSubview(transitionContainer)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                
                transitionContainer.containerView?.blurContainerView.alpha = 0.0
                
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
                        
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
            
        default:
            return
        }
        
        
//        if let _ = toViewController as? SAParallaxViewController {
//            if let detail = fromViewController as? SADetailViewController {
//                if let transitionContainer = detail.trantisionContainerView {
//                    containerView.addSubview(transitionContainer)
//                    
//                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
//                        
//                        transitionContainer.closeAnimation()
//                        
//                    }, completion: { (finished) in
//                        
//                        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
//                            
//                            transitionContainer.containerView?.blurContainerView.alpha = 1.0
//                            
//                        }, completion: { (finished) in
//                            
//                            let cancelled = transitionContext.transitionWasCancelled()
//                            if cancelled {
//                                transitionContainer.removeFromSuperview()
//                            } else {
//                                containerView.addSubview(toViewController.view)
//                            }
//                            transitionContext.completeTransition(!cancelled)
//                            
//                        })
//                    })
//                }
//            }
//        } else if let _ = fromViewController as? SAParallaxViewController {
//            if let detail = toViewController as? SADetailViewController {
//                if let transitionContainer = detail.trantisionContainerView {
//                    containerView.addSubview(transitionContainer)
//                    
//                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
//                        
//                        transitionContainer.containerView?.blurContainerView.alpha = 0.0
//                        
//                    }, completion: { (finished) in
//                        
//                        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
//                            
//                            transitionContainer.openAnimation()
//                            
//                        }, completion: { (finished) in
//                            
//                            let cancelled = transitionContext.transitionWasCancelled()
//                            if cancelled {
//                                transitionContainer.removeFromSuperview()
//                            } else {
//                                containerView.addSubview(toViewController.view)
//                            }
//                            transitionContext.completeTransition(!cancelled)
//                            
//                        })
//                    })
//                }
//            }
//        }
    }
}
