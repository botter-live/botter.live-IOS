//
//  MyUtils.swift
//  Loreal Medical
//
//  Created by Nora on 3/18/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main = "B_Chat"
    case Forms = "B_Forms"
    
    
   
    var b_instance : UIStoryboard {

        return UIStoryboard(name: self.rawValue, bundle: MyFrameworkBundle.bundle)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type)->T{
        let b_storyboardID = (viewControllerClass as UIViewController.Type).b_storyboardID
        let mInstance = self.b_instance
        let vc = mInstance.instantiateViewController(withIdentifier: b_storyboardID ) as! T
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

