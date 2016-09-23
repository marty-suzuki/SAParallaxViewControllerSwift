//
//  SATransitionContainerView.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

open class SATransitionContainerView: UIView {

    open var views: [UIView] = []
    open var viewInitialPositions: [CGPoint] = []
    open var imageViewInitialFrame: CGRect = .zero
    open var blurImageViewInitialFrame: CGRect = .zero
    open var containerViewInitialFrame: CGRect = .zero
    open var containerView: SAParallaxContainerView?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    open func setViews(_ cells: [SAParallaxViewCell], view: UIView) {
        cells.forEach {
            guard let point = $0.superview?.convert($0.frame.origin, to:view) else { return }
            viewInitialPositions.append(point)
            
            if $0.isSelected {
                let containerView = SAParallaxContainerView(frame: $0.containerView.bounds)
                containerView.frame.origin = point
                containerView.clipsToBounds = true
                containerView.backgroundColor = .white
                containerViewInitialFrame = containerView.frame
                
                if let image = $0.containerView.imageView.image {
                    containerView.setImage(image)
                }
                if let _ = containerView.imageView.image {
                    containerView.imageView.frame = $0.containerView.imageView.frame
                    imageViewInitialFrame = containerView.imageView.frame
                }
                
                if let _ = containerView.blurImageView.image {
                    containerView.blurImageView.frame = $0.containerView.blurImageView.frame
                    blurImageViewInitialFrame = containerView.blurImageView.frame;
                }
                
                views.append(containerView)
                addSubview(containerView)
                self.containerView = containerView
                return
            }
            
            let imageView = $0.screenShot()
            imageView.frame.origin = point
            views.append(imageView)
            addSubview(imageView)
        }
    }
    
    open func openAnimation() {
        guard
            let yPositionContainer = containerView?.frame.origin.y,
            let containerViewHeight = containerView?.frame.size.height
        else { return }
        let height = frame.size.height
        
        let distanceToTop = yPositionContainer
        let distanceToBottom = height - (yPositionContainer + containerViewHeight)
        
        views.forEach {
            if $0 != containerView {
                var frame = $0.frame
                if frame.origin.y < yPositionContainer {
                    frame.origin.y -= distanceToTop
                } else {
                    frame.origin.y += distanceToBottom
                }
                $0.frame = frame
                return
            }
            guard let containerView = containerView else { return }
            containerView.frame = bounds
            containerView.imageView.frame = containerView.imageView.bounds
            var rect = containerView.blurContainerView.frame
            rect.origin.y = height - rect.size.height
            containerView.blurContainerView.frame = rect
        }
    }
    
    open func closeAnimation() {
        views.enumerated().forEach {
            if $0.element != containerView {
                let point = self.viewInitialPositions[$0.offset]
                $0.element.frame.origin = point
                return
            }
            containerView?.frame = containerViewInitialFrame
            containerView?.imageView.frame = imageViewInitialFrame
            containerView?.blurImageView.frame = blurImageViewInitialFrame
            guard let containerView = containerView else { return }
            var rect = containerView.blurContainerView.frame
            rect.origin.y = containerView.frame.size.height - rect.size.height
            containerView.blurContainerView.frame = rect
        }
    }
}
