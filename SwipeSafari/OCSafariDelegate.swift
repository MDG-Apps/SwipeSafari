//
//  OCSafariDelegate.swift
//  SwipeSafari
//
//  Created by Yannik Ehlert on 27.10.15.
//  Copyright © 2015 Stefan Gugarel. All rights reserved.
//

import UIKit
import SafariServices

class OCSafariDelegate: NSObject, SFSafariViewControllerDelegate, OCSafariViewControllerDelegate, UINavigationControllerDelegate {
    var animator: OCModalPushPopAnimator?
    var delegate : UIViewController! = nil
    
    // MARK: - SFSafariViewControllerDelegate
    
    @objc func safariViewControllerDidFinish(controller: SFSafariViewController) {
        delegate.navigationController?.popToRootViewControllerAnimated(true)
    }
    func handleSwipeInSafari(recognizer: UIScreenEdgePanGestureRecognizer) {
        
        let realPercentComplete = (recognizer.locationInView(delegate.view).x) / delegate.view.bounds.size.width
        
        let percentComplete = realPercentComplete / 2.5
        
        switch recognizer.state {
            
        case .Began:
            animator = OCModalPushPopAnimator()
            delegate.navigationController?.popViewControllerAnimated(true)
            
        case .Changed:
            animator?.updateInteractiveTransition(percentComplete)
            
        case .Ended:
            
            if realPercentComplete < 0.5 {
                // If swipe is below half of screen cancel gesture
                animator?.cancelInteractiveTransition()
            } else {
                // If swipe is above half of screen finish gesture
                animator?.finishInteractiveTransition()
            }
            animator = nil
            
            
        case .Cancelled:
            animator?.cancelInteractiveTransition()
            animator = nil
            
        default: ()
        }
    }
    
    
    // MARK: - UINavigation delegate
    
    @objc func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return animator
    }
    
    @objc func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return animator
    }
}
