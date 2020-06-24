//
//  Botter.swift
//  BotterSDK
//
//  Created by Nora on 6/7/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit
//public class Botter {
//
////     private static var floatingButtonController: FloatingBtnController?
//
//
//
//}
public func show(APIKey : String){
    let floatingButtonController = FloatingBtnController()
}

public var chatTitle = ""

public func openChatScreen(APIKey : String){
    let windows = UIApplication.shared.windows
    if let index = windows.lastIndex(where: { (window) -> Bool in
        window is FloatingButtonWindow
    }){
       openChat(parent: UIApplication.shared.windows[index].visibleViewController!)
    }
}

public func hideLauncherButton(){
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        (floatingWindow as? FloatingButtonWindow)?.button?.isHidden = true
    }
}

public func showLauncherButton(){
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        (floatingWindow as? FloatingButtonWindow)?.button?.isHidden = false
    }
}

internal func openChat(parent : UIViewController){
    let chatScreen = StartConversationViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
    if #available(iOS 13.0, *) {
        chatScreen.modalPresentationStyle = .automatic
    } else {
        // Fallback on earlier versions
    }
    parent.present(chatScreen, animated: true , completion: nil)
//    WebLinksViewController.openInParent(link: "https://aldawaa.bluecrunch.org/", parent: parent)
}

public func setLauncherBottomMargin(marginValue value : Float){
    BotterSettingsManager.bottomMargin = CGFloat(value)
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        (floatingWindow as? FloatingButtonWindow)?.resetButtonPlace()
    }
}

//UIWindow.Level.alert + 1
