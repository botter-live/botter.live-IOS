//
//  PaddedUILabel.swift
//  MyLexus
//
//  Created by Nora on 7/11/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit
    
@IBDesignable class PaddedUILabel: UILabel {
        
        @IBInspectable var topInset: CGFloat = 5.0
        @IBInspectable var bottomInset: CGFloat = 5.0
        @IBInspectable var leftInset: CGFloat = 8.0
        @IBInspectable var rightInset: CGFloat = 8.0
        
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: rect.inset(by: insets))
        }
        
        
    override open var intrinsicContentSize : CGSize {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += topInset + bottomInset
            intrinsicSuperViewContentSize.width += leftInset + rightInset
            return intrinsicSuperViewContentSize
        }
        
    }


