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
    
    internal static var BotID : String = "nKmovPCdWNZdYnIejRnd"
    
    public static var AccentColor : UIColor = UIColor.init(codeString: "#642c7a"){
        didSet{
            Botter.reSet()
        }
    }
    public static var FontColor : UIColor = UIColor.white
    public static var BotterMessageFontColor : UIColor = UIColor.black
    public static var BotterMessageBGColor : UIColor = UIColor.init(codeString: "#eaf0f7")
    public static var ChatTitleColor : UIColor = UIColor.white
    
    public static var ChatTitleText : String = "Botter"
    public static var HeadlineMessage : String = "Hey there 👋"
    public static var WelcomeMessage : String = "We’re here to answer your questions about Company. Ask us anything!"
    
    public static var logo : UIImage = UIImage(named: "botterIcon", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var welcomeBrandLogo : UIImage = UIImage(named: "botterIcon", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var chatIcon : UIImage = UIImage(named: "ic-chat", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var agentAvatar : UIImage = UIImage(named: "agent", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    
    
    public static var hasFAQs : Bool = true
    public static var  alignLauncherLeft : Bool = false
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
            }
            BotterSettingsManager.BotID = id
        }
    }
    
    public static func setBotBase(url : String , clear : Bool = false){
        if url != BaseDataSource.Constants.BASE_URL && url != ""{
            if clear{
                ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                B_SocketManager.first = true
                B_SocketManager.shared = B_SocketManager()
            }
            BaseDataSource.Constants.BASE_URL = url
        }
    }
    
    public static func setBotUpload(url : String , clear : Bool = false){
        if url != BaseDataSource.Constants.UPLOAD_URL && url != ""{
            if clear{
                ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                B_SocketManager.first = true
                B_SocketManager.shared = B_SocketManager()
            }
            BaseDataSource.Constants.UPLOAD_URL = url
        }
    }
    
    public static func setBotSocket(url : String, clear : Bool = false){
        if url != BaseDataSource.Constants.SOCKET_URL && url != ""{
            if clear{
                ChatSessionManager.shared.setActiveSessionMessage(msg: nil)
                B_SocketManager.first = true
                B_SocketManager.shared = B_SocketManager()
            }
            BaseDataSource.Constants.SOCKET_URL = url
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
