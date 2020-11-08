//
//  BotterSettingsManager.swift
//  Botter
//
//  Created by Nora on 6/23/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

public class BotterSettingsManager  {
    
    internal static var BotID : String = "nKmovPCdWNZdYnIejRnd"{
        didSet{
            NotificationManager.shared.sendToken()
        }
    }
    internal static var FCMToken : String = ""{
        didSet{
            //sendToken
            NotificationManager.shared.sendToken()
        }
    }
    
    public static var AccentColor : UIColor = UIColor.init(codeString: "#642c7a")
    
    public static var LauncherColor : UIColor = AccentColor{
        didSet{
            Botter.reSet()
        }
    }
    
    public static var UserMessageBGColor : UIColor = AccentColor
    public static var HeaderColor : UIColor = AccentColor
    public static var FontColor : UIColor = UIColor.white
    public static var BotterMessageFontColor : UIColor = UIColor.black
    public static var BotterMessageBGColor : UIColor = UIColor.init(codeString: "#eaf0f7")
    public static var ChatTitleColor : UIColor = UIColor.white
    
    public static var ChatTitleText : String = "BOTTER"
    public static var HeadlineMessage : String = "Hey there 👋"
    public static var WelcomeMessage : String = "We’re here to answer your questions about Company. Ask us anything!"
    
    public static var logo : UIImage = UIImage(named: "botterIcon", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var welcomeBrandLogo : UIImage = UIImage(named: "botterIcon", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var chatHeaderLogo : UIImage = UIImage(named: "botterIcon", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var chatIcon : UIImage = UIImage(named: "ic-chat", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var agentAvatar : UIImage = UIImage(named: "agent", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    
    
    public static var hasFAQs : Bool = true
    public static var  alignLauncherLeft : Bool = false{
        didSet{
            Botter.reSet()
        }
    }
    public static var showOnClosePopup : Bool = true
    
    public static var bottomMargin : CGFloat = 40{
        didSet{
            Botter.reSet()
        }
    }
    
    public static var language : b_Language = .english {
        didSet{
//            UserDefaults.standard.set(["ar", "en"], forKey: "AppleLanguages")
//            Bundle.b_setLanguage(language.rawValue)
        }
    }
    
    public struct Font {
        public static var regularFontName : String = ""
        public static var mediumFontName : String = ""
        public static var boldFontName : String = ""

        static func getRegularFontForLabel(lbl : UILabel)->UIFont{
            if let regularFont = UIFont.init(name: regularFontName , size: lbl.font.pointSize){
                return regularFont
            }
            return UIFont.systemFont(ofSize: lbl.font.pointSize)
        }
        
        static func getRegularFontForParsing()->UIFont{
            if let regularFont = UIFont.init(name: regularFontName , size: 16){
                return regularFont
            }
            return UIFont.systemFont(ofSize: 16)
        }
        
        static func getRegularFontForFeild(feild : UITextField)->UIFont{
            if let regularFont = UIFont.init(name: regularFontName , size: feild.font?.pointSize ?? 13){
                return regularFont
            }
            return UIFont.systemFont(ofSize: feild.font?.pointSize ?? 13)
        }
        
        static func getRegularFontForTextArea(feild : UITextView)->UIFont{
            if let regularFont = UIFont.init(name: regularFontName , size: feild.font?.pointSize ?? 13){
                return regularFont
            }
            return UIFont.systemFont(ofSize: feild.font?.pointSize ?? 13)
        }
        
        static func getMediumFontForLabel(lbl : UILabel)->UIFont{
            
            if let mediumFont = UIFont.init(name: mediumFontName , size: lbl.font.pointSize){
               return mediumFont
            }
             return UIFont.boldSystemFont(ofSize: lbl.font.pointSize)
        }
        
        static func getBoldFontForLabel(lbl : UILabel)->UIFont{
            
            if let boldFont = UIFont.init(name: boldFontName , size: lbl.font.pointSize){
               return boldFont
            }else{
                if let mediumFont = UIFont.init(name: mediumFontName , size: lbl.font.pointSize){
                   return mediumFont
                }
            }
             return UIFont.boldSystemFont(ofSize: lbl.font.pointSize)
        }
        
    }
    
    public static func setBotID(id : String , clear : Bool = false){
        if id != BotterSettingsManager.BotID{
            if clear{
                ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                B_SocketManager.first = true
                B_SocketManager.shared = B_SocketManager()
                NotificationManager.shared.clear()
            }
            BotterSettingsManager.BotID = id
        }
    }
    
    public static func setBotBase(url : String , clear : Bool = false){
        if url != BaseDataSource.Constants.BASE_URL && url != ""{
            if url.lowercased().hasPrefix("http"){
                if clear{
                    ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                    B_SocketManager.first = true
                    B_SocketManager.shared = B_SocketManager()
                    NotificationManager.shared.clear()
                }
                if !(url.hasSuffix("/")){
                    BaseDataSource.Constants.BASE_URL = url + "/"
                }else{
                    BaseDataSource.Constants.BASE_URL = url
                }
            }else{
                print("Error: Invalid URL")
            }
        }
    }
    
    public static func setBotUpload(url : String , clear : Bool = false){
        if url != BaseDataSource.Constants.UPLOAD_URL && url != ""{
            if url.lowercased().hasPrefix("http"){
                if clear{
                    ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                    B_SocketManager.first = true
                    B_SocketManager.shared = B_SocketManager()
                    NotificationManager.shared.clear()
                }
                BaseDataSource.Constants.UPLOAD_URL = url
            }else{
                print("Error: Invalid URL")
            }
        }
    }
    
    public static func setBotSocket(url : String, clear : Bool = false){
        if url != BaseDataSource.Constants.SOCKET_URL && url != ""{
            if url.lowercased().hasPrefix("ws"){
                if clear{
                    ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                    B_SocketManager.first = true
                    B_SocketManager.shared = B_SocketManager()
                    NotificationManager.shared.clear()
                }
                if !(url.hasSuffix("/")){
                    BaseDataSource.Constants.SOCKET_URL = url + "/"
                }else{
                    BaseDataSource.Constants.SOCKET_URL = url
                }
            }
            else{
                print("Error: Invalid URL")
            }
        }
    }
    
    
    public static func getBotBase()->String{
        return BaseDataSource.Constants.BASE_URL
    }
    
    public static func getBotUpload()->String{
        return BaseDataSource.Constants.UPLOAD_URL
    }
    
    public static func getBotSocket()->String{
        return BaseDataSource.Constants.SOCKET_URL
    }
}

public enum b_Language : String{
    case arabic = "ar"
    case english = "en"
    case french = "fr"

}
