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

    func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func showMessage(_ message: String) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حسناً".localize(), style: UIAlertAction.Style.cancel, handler: nil));
        present(alert, animated: true, completion: nil)
    }
    
    func showMessage(_ message: String,completion : @escaping (()->())) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "حسناً".localize(), style: UIAlertAction.Style.cancel, handler: {(action) in
            completion()
        }));
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLogOutAlert() -> Void {
          let alert=UIAlertController(title: nil, message: "Your session is expired due to logging in from another device", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "Logout".localize(), style: UIAlertAction.Style.cancel, handler: {(action) in
//            UserDataSource.setUser(user: nil)
//            MyUtils.openLoginScreen()
          }));
          
          present(alert, animated: true, completion: nil)
      }
    
    func showErrorMessageWithRetry(_ message: String ,retryTitle : String ,completion : @escaping (()->())) -> Void {
        let alert=UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: retryTitle, style: UIAlertAction.Style.default, handler: {(action) in
            completion()
        }));
        alert.addAction(UIAlertAction(title: "Cancel".localize(), style: UIAlertAction.Style.cancel, handler: {(action) in
        }));
        
        present(alert, animated: true, completion: nil)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromStoryBoard(appStoryBoard : AppStoryboard)-> Self{
        return appStoryBoard.viewController(viewControllerClass: self)
    }

    
    
    
    
    func showPleaseWaitAlert() {
        let pleaseWaitAlert = UIAlertController(title: nil, message:"Please wait.\n\n\n".localize(), preferredStyle: .alert)
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        spinner.center = CGPoint(x: 130.5, y: 65.5)
        spinner.color = UIColor.black
        spinner.startAnimating()
        pleaseWaitAlert.view!.addSubview(spinner)
        self.present(pleaseWaitAlert, animated: false, completion: nil)
    }
    
    func makePhoneCall(phoneNumber : String){
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func showInternetAlert( funcToLoad : @escaping (()->()) ){
        
        let alert = UIAlertController(title: "Please check your internet connection then try again.".localize(), message: "" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel".localize() , style: UIAlertAction.Style.cancel , handler: {(UIAlertAction) in
            
        }))
        alert.addAction(UIAlertAction(title: "Try again".localize() , style: UIAlertAction.Style.default , handler: {(UIAlertAction) in
            
            
            funcToLoad()

            
        }
            
        ))
        self.present(alert, animated: true, completion: nil)
        
    }

    func areYouSureMsg(Msg : String , funcToLoad : @escaping ((Bool)->()) ){
        
        let alert = UIAlertController(title: Msg , message: "" , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "لا".localize() , style: UIAlertAction.Style.cancel , handler: {(UIAlertAction) in
            funcToLoad(false)
        }))
        alert.addAction(UIAlertAction(title: "نعم".localize() , style: UIAlertAction.Style.default , handler: {(UIAlertAction) in
             funcToLoad(true)
            
        }
            
        ))
        self.present(alert, animated: true, completion: nil)
        
    }

    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }

    func isEmailAddress(_ emailAddress: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: emailAddress)
    }
    
    func isMobileNumber(_ mobileNumber: String) -> Bool {
        if mobileNumber.length < 6 {
            return false
        }
        let charcterSet  = CharacterSet(charactersIn: "+0123456789").inverted
        let inputString = mobileNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  mobileNumber == filtered
    }
    
    func textHasOnlyNumbers(_ text: String) -> Bool {
        
        let charcterSet  = CharacterSet(charactersIn: "0123456789").inverted
        let inputString = text.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  text == filtered
    }
   
    
    
    

    @IBAction func backPop(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backDismiss(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func openLogin(_ sender : Any){
//       MyUtils.openLogin()
    }
    
    func appIsArabic()->Bool{
        let language = Bundle.main.preferredLocalizations[0] as NSString
        if language.contains("ar"){
            return true
        }
        else{
            return false
        }
    }
    
    
    func add(childViewContoller : UIViewController , inView containerView : UIView){
        addChild(childViewContoller)
        
        childViewContoller.view.frame = CGRect.init(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        containerView.addSubview(childViewContoller.view)
        childViewContoller.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewContoller.didMove(toParent: self)
    }
    
    func remove(childViewContoller : UIViewController){
        childViewContoller.willMove(toParent: nil)
        childViewContoller.view.removeFromSuperview()
        childViewContoller.removeFromParent()
    }

}
