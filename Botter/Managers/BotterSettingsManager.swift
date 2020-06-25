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
    
    public static var AccentColor : UIColor = UIColor.init(codeString: "#642c7a")
    public static var FontColor : UIColor = UIColor.white
    public static var BotterMessageFontColor : UIColor = UIColor.black
    public static var BotterMessageBGColor : UIColor = UIColor.init(codeString: "#eaf0f7")
    public static var ChatTitleColor : UIColor = UIColor.white
    
    public static var ChatTitleText : String = "Botter"
    public static var HeadlineMessage : String = "Hey there 👋"
    public static var WelcomeMessage : String = "We’re here to answer your questions about Company. Ask us anything!"
    
    public static var logo : UIImage = UIImage(named: "botterIcon", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    public static var chatIcon : UIImage = UIImage(named: "ic-chat", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
    

    public static var  alignLauncherLeft : Bool = false
    public static var bottomMargin : CGFloat = 40
    
    public struct Font {
        public static var regularFontName : String = ""
        public static var mediumFontName : String = ""

        static func getRegularFontForLabel(lbl : UILabel)->UIFont{
            if let regularFont = UIFont.init(name: regularFontName , size: lbl.font.pointSize){
                return regularFont
            }
            return UIFont.systemFont(ofSize: lbl.font.pointSize)
        }
        
        static func getMediumFontForLabel(lbl : UILabel)->UIFont{
            
            if let mediumFont = UIFont.init(name: mediumFontName , size: lbl.font.pointSize){
               return mediumFont
            }
             return UIFont.boldSystemFont(ofSize: lbl.font.pointSize)
        }
        
    }
}
