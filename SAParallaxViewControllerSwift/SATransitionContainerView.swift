//
//  SATransitionContainerView.swift
//  SAParallaxViewControllerSwift
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SATransitionContainerView: UIView {

    public var views = [UIView]()
    public var viewInitialPositions = [CGPoint]()
    public var imageViewInitialFrame: CGRect = .zero
    public var blurImageViewInitialFrame: CGRect = .zero
    public var containerViewInitialFrame: CGRect = .zero
    public var containerView: SAParallaxContainerView?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setViews(cells cells: [SAParallaxViewCell], view: UIView) {
        cells.forEach {
            guard let point = $0.superview?.convertPoint($0.frame.origin, toView:view) else { return }
            viewInitialPositions.append(point)
            
            if $0.selected {
                let containerView = SAParallaxContainerView(frame: $0.containerView.bounds)
                containerView.frame.origin = point
                containerView.clipsToBounds = true
                containerView.backgroundColor = .whiteColor()
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
    
    public func openAnimation() {
        if let yPositionContainer = containerView?.frame.origin.y, containerViewHeight = containerView?.frame.size.height {
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
                } else {
                    guard let containerView = containerView else { return }
                    containerView.frame = bounds
                    containerView.imageView.frame = containerView.imageView.bounds
                    var rect = containerView.blurContainerView.frame
                    rect.origin.y = height - rect.size.height
                    containerView.blurContainerView.frame = rect
                }
            }
        }
    }
    
    public func closeAnimation() {
        views.enumerate().forEach {
            if $0.element != containerView {
                let point = self.viewInitialPositions[$0.index]
                $0.element.frame.origin = point
            } else {
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
}
