//
//  UITextFeild.swift
//  mytoyota
//
//  Created by Nora on 5/15/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
//    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "semibold") != nil {
                fontName += "-Semibold";
            }else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }
    
    public var align : NSTextAlignment {
        get {
            return self.textAlignment ;
        }
        set {
            textAlignment = align
        }
    }
    
    
}
