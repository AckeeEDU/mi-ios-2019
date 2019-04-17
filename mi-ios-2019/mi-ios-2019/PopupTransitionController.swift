//
//  PopupTransitionController.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 17/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class PopupTransitionController: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    var animationType: AnimationType = .present
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //The view controller's view that is presenting the popup view
        let containerView = transitionContext.containerView
        
        switch animationType {
        case .present:
            //The modal view itself
            guard let popupView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view else { return }
            
            containerView.addSubview(popupView)
            popupView.frame = CGRect(x: 40, y: containerView.frame.height, width: containerView.frame.width-80, height: containerView.frame.height-80)
            popupView.layoutIfNeeded()
            
            popupView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(40)
            }
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                containerView.layoutIfNeeded()
            }) { _ in
                transitionContext.completeTransition(true)
            }
        case .dismiss:
            //The modal view itself
            guard let popupView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view else { return }
            
            popupView.snp.remakeConstraints { make in
                make.leading.trailing.height.equalToSuperview().inset(40)
                make.top.equalTo(containerView.snp.bottom)
            }
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                containerView.layoutIfNeeded()
                
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
        
    }
    
    
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationType = .present
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animationType = .dismiss
        return self
    }
}
