//
//  Toast.swift
//  ETY
//
//  Created by Nora on 10/14/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showToast(message : String , font : UIFont) {
        var tabBarHeight : CGFloat = 0
        if self.tabBarController != nil{
            tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        }
        let toastView = UILabel(frame: CGRect(x: 0 , y: self.view.frame.size.height - 100 - tabBarHeight, width: self.view.frame.width, height: 120))
        toastView.tag = 20
        if let old = self.view.viewWithTag(20) {
            old.removeFromSuperview()
        }
        let toastLabel = UILabel(frame: CGRect(x: 20 , y: 8, width: toastView.frame.width - 40 , height: 100 - 8))
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .left;
        toastLabel.font = font
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 3
        toastView.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.minimumScaleFactor = 0.5
        self.view.addSubview(toastView)
        toastView.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
extension UIView {
    func showToast(message : String , font : UIFont){
        
        UIApplication.shared.windows[0].visibleViewController?.showToast(message: message, font: font)
    }
}
