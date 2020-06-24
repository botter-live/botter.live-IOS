//
//  UIManager.swift
//  Botter
//
//  Created by Nora on 6/23/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

class botBubbelView : UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = BotterSettingsManager.BotterMessageBGColor
    }
}
class AccentView : UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = BotterSettingsManager.AccentColor
    }
}

class UserMesgLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        let tFont = BotterSettingsManager.Font.getRegularFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}

class BotterMesgLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
        let tFont = BotterSettingsManager.Font.getRegularFontForLabel(lbl: self)
         tFont.withSize(font.pointSize)
        font = tFont
        
    }
}

class ChatHeader : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.ChatTitleColor
        let tFont = BotterSettingsManager.Font.getMediumFontForLabel(lbl: self)
         tFont.withSize(font.pointSize)
        font = tFont
        text = BotterSettingsManager.ChatTitleText
    }
}

class boldChatText : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
        let tFont = BotterSettingsManager.Font.getMediumFontForLabel(lbl: self)
         tFont.withSize(font.pointSize)
        font = tFont
    }
}

class MediumChatText : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
        let tFont = BotterSettingsManager.Font.getMediumFontForLabel(lbl: self)
         tFont.withSize(font.pointSize)
        font = tFont
    }
}


class ChatHeadLine : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        let tFont = BotterSettingsManager.Font.getMediumFontForLabel(lbl: self)
         tFont.withSize(26)
        font = tFont
        text = BotterSettingsManager.HeadlineMessage
    }
}

class ChatWelcomeLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        let tFont = BotterSettingsManager.Font.getRegularFontForLabel(lbl: self)
         tFont.withSize(font.pointSize)
        font = tFont
        text = BotterSettingsManager.WelcomeMessage
    }
}

class AccentBtn : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(BotterSettingsManager.FontColor, for: .normal)
//        let tFont = BotterSettingsManager.font.regular
//         tFont.withSize(font.pointSize)
//        font = tFont
        tintColor = BotterSettingsManager.AccentColor
    }
}


class FontLikeBtn : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(BotterSettingsManager.FontColor, for: .normal)
//        let tFont = BotterSettingsManager.font.regular
//        tFont.pointSize = font.pointSize
//        font = tFont
        backgroundColor = BotterSettingsManager.AccentColor
        tintColor = BotterSettingsManager.FontColor
        titleLabel?.textColor = BotterSettingsManager.FontColor
    }
}

class HeaderBtn : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = BotterSettingsManager.ChatTitleColor
    }
    
    
}

class HeaderLogo : UIImageView{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = BotterSettingsManager.AccentColor
        if BotterSettingsManager.logo != nil {
            image = BotterSettingsManager.logo
        }
    }
}

class AccentTextLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.AccentColor
    }
}
