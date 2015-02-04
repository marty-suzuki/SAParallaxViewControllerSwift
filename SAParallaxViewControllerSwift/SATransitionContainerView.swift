//
//  SATransitionContainerView.swift
//  SAParallaxViewControllerSwiftExample
//
//  Created by 鈴木大貴 on 2015/02/05.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class SATransitionContainerView: UIView {

    var views = [UIView]()
    var viewInitialPositions = [CGPoint]()
    var imageViewInitialFrame: CGRect!
    var blurImageViewInitialFrame: CGRect!
    var containerViewInitialFrame: CGRect!
    var containerView: SAParallaxContainerView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init() {
        super.init()
    }
    
    func setViews(#cells: [SAParallaxViewCell], view: UIView) {
        for cell in cells {
            let point = cell.superview!.convertPoint(cell.frame.origin, toView:view)
            self.viewInitialPositions.append(point)
            
            if cell.selected {
                self.containerView = SAParallaxContainerView(frame: cell.containerView.bounds)
                self.containerView.frame.origin = point
                self.containerView.clipsToBounds = true
                self.containerView.backgroundColor = .whiteColor()
                self.containerViewInitialFrame = self.containerView.frame
                
                self.containerView.setImage(cell.containerView.imageView.image!)
                if let image = self.containerView.imageView.image {
                    self.containerView.imageView.frame = cell.containerView.imageView.frame
                    self.imageViewInitialFrame = self.containerView.imageView.frame
                }
                
                if let bluredImage = self.containerView.blurImageView.image {
                    self.containerView.blurImageView.frame = cell.containerView.blurImageView.frame
                    self.blurImageViewInitialFrame = self.containerView.blurImageView.frame;
                }
                
                self.views.append(self.containerView)
                self.addSubview(self.containerView)
            } else {
                let imageView = cell.screenShot()
                imageView.frame.origin = point
                self.views.append(imageView)
                self.addSubview(imageView)
            }
        }
    }
    
    func openAnimation() {
        let yPositionContainer = self.containerView.frame.origin.y
        let containerViewHeight = self.containerView.frame.size.height
        let height = self.frame.size.height
        
        let distanceToTop = yPositionContainer
        let distanceToBottom = height - (yPositionContainer + containerViewHeight)
        
        for view in self.views {
            if view != self.containerView {
                var frame = view.frame
                
                if frame.origin.y < yPositionContainer {
                    frame.origin.y -= distanceToTop
                    view.frame = frame
                } else {
                    frame.origin.y += distanceToBottom
                    view.frame = frame
                }
            } else {
                self.containerView.frame = self.bounds
                self.containerView.imageView.frame = self.containerView.imageView.bounds
                var rect = self.containerView.blurContainerView.frame
                rect.origin.y = height - rect.size.height
                self.containerView.blurContainerView.frame = rect
            }
        }
    }
    
    func closeAnimation() {
        for (index, view) in enumerate(self.views) {
            if view != self.containerView {
                let point = self.viewInitialPositions[index]
                view.frame.origin = point
            } else {
                self.containerView.frame = self.containerViewInitialFrame
                self.containerView.imageView.frame = self.imageViewInitialFrame
                self.containerView.blurImageView.frame = self.blurImageViewInitialFrame
                var rect = self.containerView.blurContainerView.frame
                rect.origin.y = self.containerView.frame.size.height - rect.size.height
                self.containerView.blurContainerView.frame = rect
            }
        }
    }
}
