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
    case Main = "Chat"
    case Forms = "Forms"
    
    
   
    var instance : UIStoryboard {
        
//        let storyboardBundle = Bundle(for: ChatViewController.self)
//        let storyboardBundle = Bundle(identifier: "Botter")!

        return UIStoryboard(name: self.rawValue, bundle: MyFrameworkBundle.bundle)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type)->T{
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        let mInstance = self.instance
        let vc = mInstance.instantiateViewController(withIdentifier: storyBoardID ) as! T
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

class MyUtils {
   
    static func openHomeScreen(){
//        let vc = HomeTabBarController.instantiateFromStoryBoard(appStoryBoard: .Home)
//        vc.viewControllers![0] = MoreRouter.createModule()
//        vc.viewControllers![1] = MyLicensesRouter.createModule()
//        vc.viewControllers![2] = HomeRouter.createModule()
////        vc.viewControllers![3] = LocationsRouter.createModule()
//        vc.selectedIndex = index ?? 0
//        let nvc = UINavigationController(rootViewController: vc)
//        nvc.navigationBar.isHidden = true
//        UIApplication.shared.windows[0].rootViewController = nvc
//        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
  
  
  
    
    static func getNavigationController()->UINavigationController?{
        let root = (UIApplication.shared.windows[0].rootViewController)
        if root is UINavigationController{
            return root as? UINavigationController
        }else{
            return nil
        }
    }
    
    static func getNotificationStatus()->Bool{
        if let status = UserDefaults.standard.value(forKey: Constants.NOTIFICATIONS) as? Bool{
            return status
        }
        return true
    }
    static func getLanguage() -> String
    {
        if let language = UserDefaults.standard.value(forKey: "current_language") as? String{
            return language
        }
        return "en"
    }
    
    static func formatNumber(_ n: Int) -> String {
        
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num {
            
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
            
        }
        
    }

}
