//
//  StartConversationViewController.swift
//  Botter
//
//  Created by Nora on 6/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class StartConversationViewController: UIViewController {

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
        CommonActions.openChat(parent: self, data: BotData())
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
    
    static func openChat(parent : UIViewController , data: BotData){
        let chatScreen = ChatWireframe.init(botData: data)
//        if #available(iOS 13.0, *) {
//            chatScreen.viewController.modalPresentationStyle = .automatic
//        } else {
//            // Fallback on earlier versions
//        }
        parent.presentWireframe(chatScreen, animated: true , completion: nil)
    //    WebLinksViewController.openInParent(link: "https://aldawaa.bluecrunch.org/", parent: parent)
    }
}
