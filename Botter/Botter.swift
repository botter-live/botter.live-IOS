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
    let floatingButtonController = b_FloatingBtnController()
    BotterSettingsManager.BotID = APIKey
}

//public var chatTitle = ""

public func openChatScreen(APIKey : String){
    let windows = UIApplication.shared.windows
    if let index = windows.lastIndex(where: { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        BotterSettingsManager.BotID = APIKey
       openChat(parent: UIApplication.shared.windows[index].b_visibleViewController!)
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
//    let isFirst = B_SocketManager.first && !ChatSessionManager.shared.hasActiveSession()
    if B_SocketManager.first {
        let startForm = StartFormWireframe.init()
        parent.present(startForm.viewController, animated: true , completion: nil)
        //    WebLinksViewController.openInParent(link: "https://aldawaa.bluecrunch.org/", parent: parent)
    }else{
        CommonActions.openChat(parent: parent, data: b_ChatViewController.botData)
    }
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

public func reSet(){
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        (floatingWindow as? FloatingButtonWindow)?.resetButtonPlace()
    }
}

//UIWindow.Level.alert + 1
