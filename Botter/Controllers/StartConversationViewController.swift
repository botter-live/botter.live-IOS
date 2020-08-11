//
//  StartConversationViewController.swift
//  Botter
//
//  Created by Nora on 6/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class b_StartConversationViewController: b_LocalizableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newConversationClicked(){
        CommonActions.openChat(parent: self, data: b_BotData())
    }

    @IBAction func botterWebsiteClicked (){
        CommonActions.botterSiteClicked()
    }
 
}

class CommonActions{
    static func botterSiteClicked(){
        if let url = URL(string: "https://botter.ai/") {
            //            UIApplication.shared.open(url)
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    static func openChat(parent : UIViewController , data: b_BotData){
        let chatScreen = b_ChatWireframe.init(botData: data)
//        if #available(iOS 13.0, *) {
//            chatScreen.viewController.modalPresentationStyle = .automatic
//        } else {
//            // Fallback on earlier versions
//        }
        parent.presentWireframe(chatScreen, animated: true , completion: nil)
    //    WebLinksViewController.openInParent(link: "https://aldawaa.bluecrunch.org/", parent: parent)
    }
    
    static func loadText(for key : String)->String{
         
        
//        guard let path = MyFrameworkBundle.bundle.url(forResource: "Localizable", withExtension: "strings", subdirectory: "Localization", localization: "en")else{
//            return key
//        }
//
////        guard let path = MyFrameworkBundle.bundle.url(forResource: "Localizable", withExtension: "strings" , subdirectory : "Localization/en.lproj")else{
////            return key
////        }
//
//        guard let dict = NSDictionary(contentsOf: path) else {
//                return key
//            }
//        guard let translation = dict.value(forKey: key) as? String else {
//                return key
//            }
//
        if BotterSettingsManager.language == .arabic{
            
            if let translation = LocalStrings.shared.stringDict[key]{
                return translation
            }
        }
        return key
    }
}

