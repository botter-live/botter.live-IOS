//
//  ChatSessionManager.swift
//  Botter
//
//  Created by Nora on 8/31/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class ChatSessionManager {
    
    static var shared = ChatSessionManager()
    
    private var key = "active"
//    private let msgKey = "msgKey"
    private var defaults = UserDefaults.standard
    
//    func setActiveSession(active : Bool){
//        defaults.set(active, forKey: key)
//
//    }
//
    func hasActiveSession()->Bool{
        if let _ : miniMessage = b_CachingModel.getCachedData(CACHE_KEY: b_CachingModel.CachingKeys.LAST_MESSAGE_CACHE_KEY){
            return true
        }
        return false
    }
    
    func setActiveSessionMessage(msg : b_BasicMessage?){
        //           defaults.set(msg, forKey: msgKey)
        if let tMesg = msg {
            if tMesg.msgType != .typing && tMesg.msgType != .notify{
                let savedMsg = miniMessage.init(msg: tMesg)
                b_CachingModel.setCached(item: savedMsg , key: b_CachingModel.CachingKeys.LAST_MESSAGE_CACHE_KEY)
            }
        }else{
            defaults.set(nil, forKey: b_CachingModel.CachingKeys.LAST_MESSAGE_CACHE_KEY)
        }
    }
    func getActiveSessionMsg()->String{
        if let msg : miniMessage = b_CachingModel.getCachedData(CACHE_KEY: b_CachingModel.CachingKeys.LAST_MESSAGE_CACHE_KEY){
            return getLastMsgText(msg: msg)
        }
        return ""
    }
    
    
   private func getLastMsgText(msg : miniMessage)->String{
        if msg.type != .typing && msg.type != .notify{
            switch msg.type {
            case .audio  , .gif , .image  , .video  , .attachment , .userImage :
                let savedMsg =  getMsgSenderString(msg: msg) + "Attachment".b_localize()
                //                ChatSessionManager.shared.setActiveSessionMessage(msg: savedMsg)
                return savedMsg
            default:
                let savedMsg =  getMsgSenderString(msg: msg) + msg.text
                //                ChatSessionManager.shared.setActiveSessionMessage(msg: savedMsg)
                return savedMsg
            }
        }
        return ""
    }
    
   private func getMsgSenderString(msg : miniMessage)->String{
        switch msg.sender.senderType {
        case .agent:
            return "Agent".b_localize() + ": "
        case .bot :
            return "Bot".b_localize() + ": "
        case .user :
            return "You".b_localize() + ": "
        }
    }
    
}
