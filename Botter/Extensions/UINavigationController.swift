//
//  UINavigationController.swift
//  Shezlong
//
//  Created by Nora on 9/14/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

   

    open override var childForStatusBarStyle: UIViewController?{
        return self.topViewController
    }

}
