//
//  UIWindow.swift
//  MyLexus
//
//  Created by Nora on 7/26/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import  UIKit

public extension UIWindow {
    
    var b_visibleViewController: UIViewController? {
        return UIWindow.b_getVisibleViewControllerFrom(self.rootViewController)
    }
    
    static func b_getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.b_getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.b_getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.b_getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}
