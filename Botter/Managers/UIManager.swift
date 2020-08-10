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
class b_AccentView : UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = BotterSettingsManager.AccentColor
    }
}

class b_BasicRegularLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        let tFont = BotterSettingsManager.Font.getRegularFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}

class b_BasicMediumLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        let tFont = BotterSettingsManager.Font.getMediumFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}

class b_BasicBoldLbl : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        let tFont = BotterSettingsManager.Font.getBoldFontForLabel(lbl: self)
        tFont.withSize(font.pointSize)
        font = tFont
    }
}


class b_UserMesgLbl : b_BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        
    }
}

class b_BotterMesgLbl : b_BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
    }
}

class b_ChatHeader : b_BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.ChatTitleColor
        text = BotterSettingsManager.ChatTitleText
    }
}

class b_boldChatText : b_BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
    }
}

class b_AccentTextLbl : b_BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.AccentColor
    }
}

class b_MediumChatText : b_BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.BotterMessageFontColor
    }
}


class b_ChatHeadLine : b_BasicMediumLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        text = BotterSettingsManager.HeadlineMessage
    }
}

class b_ChatWelcomeLbl : b_BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        text = BotterSettingsManager.WelcomeMessage
    }
}

class b_AccentBtn : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(BotterSettingsManager.AccentColor, for: .normal)
//        let tFont = BotterSettingsManager.font.regular
//         tFont.withSize(font.pointSize)
//        font = tFont
        b_borderColor = BotterSettingsManager.AccentColor
        tintColor = BotterSettingsManager.AccentColor
    }
    
}


class b_FontLikeBtn : UIButton{
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

class b_HeaderBtn : UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = BotterSettingsManager.ChatTitleColor
    }
    
    
}

class b_HeaderLogo : UIImageView{
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


