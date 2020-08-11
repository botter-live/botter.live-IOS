//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
//import SlideMenuControllerSwift

extension UIViewController   {

    func b_showMessage(_ message: String) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حسناً".b_localize(), style: UIAlertAction.Style.cancel, handler: nil));
        present(alert, animated: true, completion: nil)
    }
    
    func b_showMessage(_ message: String,completion : @escaping (()->())) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حسناً".b_localize(), style: UIAlertAction.Style.cancel, handler: {(action) in
            completion()
        }));
        
        present(alert, animated: true, completion: nil)
    }
 
    
    class var b_storyboardID : String {
        return "\(self)"
    }
    
    static func b_instantiateFromStoryBoard(appStoryBoard : AppStoryboard)-> Self{
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    func b_makePhoneCall(phoneNumber : String){
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func b_areYouSureMsg(Msg : String , funcToLoad : @escaping ((Bool)->()) ){
        
        let alert = UIAlertController(title: Msg , message: "" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "No".b_localize() , style: UIAlertAction.Style.cancel , handler: {(UIAlertAction) in
            funcToLoad(false)
        }))
        alert.addAction(UIAlertAction(title: "Yes".b_localize() , style: UIAlertAction.Style.default , handler: {(UIAlertAction) in
             funcToLoad(true)
            
        }
            
        ))
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func b_backDismiss(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
   

}
