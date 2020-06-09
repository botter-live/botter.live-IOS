//
//  UIButton.swift
//  mytoyota
//
//  Created by Nora on 6/11/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    public var substituteFontName : String {
        get {
            return self.titleLabel!.font.fontName;
        }
        set {
            let fontNameToTest = self.titleLabel!.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            }else if fontNameToTest.range(of: "regular") != nil {
                fontName += "-Regular";
            }else if fontNameToTest.range(of: "italic") != nil {
                fontName += "-Italic";
            }
            else if fontNameToTest.range(of: "semibold") != nil {
                fontName += "-Semibold";
            }
            else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }else{
            
            
            }
            self.titleLabel!.font = UIFont(name: fontName, size: self.titleLabel!.font.pointSize)
        }
    }
    
    
}

