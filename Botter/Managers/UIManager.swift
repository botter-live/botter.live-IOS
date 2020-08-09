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

class BasicRegularLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        let tFont = BotterSettingsManager.Font.getRegularFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}

class BasicMediumLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        let tFont = BotterSettingsManager.Font.getMediumFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}

class BasicBoldLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        let tFont = BotterSettingsManager.Font.getBoldFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}


class UserMesgLbl : BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        
    }
}

class BotterMesgLbl : BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
    }
}

class ChatHeader : BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.ChatTitleColor
        text = BotterSettingsManager.ChatTitleText
    }
}

class boldChatText : BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
    }
}

class AccentTextLbl : BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.AccentColor
    }
}

class MediumChatText : BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
    }
}


class ChatHeadLine : BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        text = BotterSettingsManager.HeadlineMessage
    }
}

class ChatWelcomeLbl : BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        text = BotterSettingsManager.WelcomeMessage
    }
}

class AccentBtn : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(BotterSettingsManager.AccentColor, for: .normal)
//        let tFont = BotterSettingsManager.font.regular
//         tFont.withSize(font.pointSize)
//        font = tFont
        borderColor = BotterSettingsManager.AccentColor
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

class AccentImage : UIImageView{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = BotterSettingsManager.AccentColor
       
    }
}


