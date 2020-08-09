//
//  BottomSquarTransition.swift
//  PayNas
//
//  Created by Nora on 4/17/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//


import UIKit

class BottomSquarTransition: NSObject {
    
    
    var squar = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            squar.center = startingPoint
        }
    }
    
    var squarColor = UIColor.white
    
    var duration = 0.5
    
    enum SquarTransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode:SquarTransitionMode = .present
    
}

extension BottomSquarTransition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
//                let viewSize = presentedView.frame.size
                
                squar = UIView()
                
                squar.frame = CGRect.init(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.height, height: 330)
             
                
                squar.layer.cornerRadius = 15
//                squar.center = startingPoint
                squar.backgroundColor = squarColor
                let y = UIScreen.main.bounds.height - 280
                squar.transform = CGAffineTransform.init(translationX: 20, y: y)
                containerView.addSubview(squar)
                
                
                
                presentedView.center = startingPoint
                presentedView.frame = UIScreen.main.bounds
                presentedView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height - 50 )
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.squar.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
//                let viewSize = returningView.frame.size
                
                
                squar.frame = CGRect.init(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.height, height: 330)
                
           
                
                squar.layer.cornerRadius = 15
//                squar.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.squar.transform = CGAffineTransform(scaleX: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
                    returningView.transform = CGAffineTransform(scaleX: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
//                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.squar, belowSubview: returningView)
                    }
                    
                    
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.squar.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                    
                })
                
            }
            
            
        }
        
    }
    
    
    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
