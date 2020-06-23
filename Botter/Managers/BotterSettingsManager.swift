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
    
    public static var logo : UIImage = #imageLiteral(resourceName: "botterIcon")
    
    
    public struct font {
        static var regular : UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static var medium : UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        static var bold : UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        
    }
}
