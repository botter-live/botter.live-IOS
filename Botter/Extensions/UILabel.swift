//
//  UILabel.swift
//  mytoyota
//
//  Created by Nora on 5/15/17.
//  Copyright © 2017 Nora. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    public var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
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
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
  
}
