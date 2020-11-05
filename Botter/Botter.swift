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
    }else{
        if let window = UIApplication.shared.keyWindow{
            openChat(parent: window.b_visibleViewController!)
        }
    }
}

public func hideLauncherButton(){
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        (floatingWindow as? FloatingButtonWindow)?.fView?.isHidden = true
    }
}

public func showLauncherButton(){
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        (floatingWindow as? FloatingButtonWindow)?.fView?.isHidden = false
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
    if floatingControllerIsVisible(){
        let windows = UIApplication.shared.windows
        if let floatingWindow = windows.last(where:  { (window) -> Bool in
            window is FloatingButtonWindow
        }){
            (floatingWindow as? FloatingButtonWindow)?.resetButtonPlace()
        }
    }
}

public func setFCMToken(token : String){
    BotterSettingsManager.FCMToken = token
}

public func isBotterMessage(userInfo : [AnyHashable:Any])->Bool{
    if let type = userInfo["gcm.notification.notification_sender"] as? String{
        return type == "botter"
    }
    return false
}


public func handleMessage(userInfo : [AnyHashable:Any] ,completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
    if isBotterMessage(userInfo: userInfo){
        if (UIApplication.shared.applicationState == .active && chatScreenIsActive()) {
            completionHandler([])
        }else if !ChatSessionManager.shared.hasActiveSession() {
            completionHandler([])
        }else{
            if let id = userInfo["gcm.message_id"] as? String{
                NotificationManager.shared.addNotification(id:id)
            }
            completionHandler([.sound , .badge , .alert])
        }
    }else{
        completionHandler([.sound , .badge , .alert])
    }
}

private func handleMessageClick(userInfo : [AnyHashable:Any]){
    if isBotterMessage(userInfo: userInfo){
        if let id = userInfo["gcm.message_id"] as? String{
            switch UIApplication.shared.applicationState{
            case .active :
                if !chatScreenIsActive(){
                    //open chat
                }
                break
            case .background :
                //open
                NotificationManager.shared.addNotification(id:id)
                break
            case .inactive :
                //open
                NotificationManager.shared.addNotification(id:id)
                break
            @unknown default:
                break
            }
        }
    }
}

func chatScreenIsActive()->Bool{
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        if let visible = floatingWindow.b_visibleViewController{
            return visible is b_ChatViewController
        }
        
        return false
    }
    
    return false
}

func floatingControllerIsVisible()->Bool{
    let windows = UIApplication.shared.windows
    if let floatingWindow = windows.last(where:  { (window) -> Bool in
        window is FloatingButtonWindow
    }){
        if let visible = floatingWindow.b_visibleViewController{
            return visible is b_FloatingBtnController
        }
        
        return false
    }
    
    return false
}
