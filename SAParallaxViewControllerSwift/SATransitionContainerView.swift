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
        for cell in cells {
            let point = cell.superview!.convertPoint(cell.frame.origin, toView:view)
            viewInitialPositions.append(point)
            
            if cell.selected {
                let containerView = SAParallaxContainerView(frame: cell.containerView.bounds)
                containerView.frame.origin = point
                containerView.clipsToBounds = true
                containerView.backgroundColor = .whiteColor()
                containerViewInitialFrame = containerView.frame
                
                if let image = cell.containerView.imageView.image {
                    containerView.setImage(image)
                }
                if let _ = containerView.imageView.image {
                    containerView.imageView.frame = cell.containerView.imageView.frame
                    imageViewInitialFrame = containerView.imageView.frame
                }
                
                if let _ = containerView.blurImageView.image {
                    containerView.blurImageView.frame = cell.containerView.blurImageView.frame
                    blurImageViewInitialFrame = containerView.blurImageView.frame;
                }
                
                views.append(containerView)
                addSubview(containerView)
                self.containerView = containerView
            } else {
                let imageView = cell.screenShot()
                imageView.frame.origin = point
                views.append(imageView)
                addSubview(imageView)
            }
        }
    }
    
    public func openAnimation() {
        if let yPositionContainer = containerView?.frame.origin.y, containerViewHeight = containerView?.frame.size.height {
            let height = frame.size.height
            
            let distanceToTop = yPositionContainer
            let distanceToBottom = height - (yPositionContainer + containerViewHeight)
            
            for view in views {
                if view != containerView {
                    var frame = view.frame
                    
                    if frame.origin.y < yPositionContainer {
                        frame.origin.y -= distanceToTop
                        view.frame = frame
                    } else {
                        frame.origin.y += distanceToBottom
                        view.frame = frame
                    }
                } else {
                    if let containerView = containerView {
                        containerView.frame = bounds
                        containerView.imageView.frame = containerView.imageView.bounds
                        var rect = containerView.blurContainerView.frame
                        rect.origin.y = height - rect.size.height
                        containerView.blurContainerView.frame = rect
                    }
                }
            }
        }
    }
    
    public func closeAnimation() {
        for (index, view) in views.enumerate() {
            if view != containerView {
                let point = self.viewInitialPositions[index]
                view.frame.origin = point
            } else {
                containerView?.frame = containerViewInitialFrame
                containerView?.imageView.frame = imageViewInitialFrame
                containerView?.blurImageView.frame = blurImageViewInitialFrame
                if let containerView = containerView {
                    var rect = containerView.blurContainerView.frame
                    rect.origin.y = containerView.frame.size.height - rect.size.height
                    containerView.blurContainerView.frame = rect
                }
            }
        }
    }
}
