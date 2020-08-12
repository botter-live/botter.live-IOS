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
        if tag == 101{
            text = text?.b_localize()
        }
        textColor = BotterSettingsManager.FontColor
        
    }
    
    let padding = UIEdgeInsets(top: 0, left: 4 , bottom: 0, right: 8)

    public override func drawText(in rect: CGRect) {
        let insets = padding
        super.drawText(in: rect.inset(by: insets))
    }

    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }

    public override func sizeToFit() {
        super.sizeThatFits(intrinsicContentSize)
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
        textAlignment = .left
        textColor = BotterSettingsManager.ChatTitleColor
        text = BotterSettingsManager.language == .arabic ? CommonActions.loadText(for: BotterSettingsManager.ChatTitleText) : BotterSettingsManager.ChatTitleText
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
        text = BotterSettingsManager.language == .arabic ? CommonActions.loadText(for: BotterSettingsManager.HeadlineMessage) : BotterSettingsManager.HeadlineMessage
    }
}

class b_ChatWelcomeLbl : b_BasicRegularLbl{
    override func awakeFromNib() {
        super.awakeFromNib()
        textColor = BotterSettingsManager.FontColor
        text = BotterSettingsManager.language == .arabic ? CommonActions.loadText(for: BotterSettingsManager.WelcomeMessage) : BotterSettingsManager.WelcomeMessage
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

class chatView : UIView{
    override class func awakeFromNib() {
        self.appearance().semanticContentAttribute = .forceLeftToRight
        
    }
}

class AccentImage : UIImageView{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = BotterSettingsManager.AccentColor
       
    }
}

class b_AttachmentImage : UIImageView{
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = BotterSettingsManager.FontColor
        
    }
}


extension UITextField {
    open override func awakeFromNib() {
        if self.textAlignment == .natural{
            self.textAlignment = BotterSettingsManager.language == .arabic ? .right : .left
        }
    }
}

extension UITextView {
    open override func awakeFromNib() {
        if self.textAlignment == .natural{
            self.textAlignment = BotterSettingsManager.language == .arabic ? .right : .left
        }
    }
}

extension UILabel {
    open override func awakeFromNib() {
        if self.textAlignment == .natural{
            self.textAlignment = BotterSettingsManager.language == .arabic ? .right : .left
        }
    }
}
