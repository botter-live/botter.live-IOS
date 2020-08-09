//
//  UIFont.swift
//  Fresh
//
//  Created by Karim abdelhameed mohamed on 1/29/18.
//  Copyright © 2018 bluecrunch. All rights reserved.
//

import Foundation
import UIKit

struct AppFontName {
    static let regular = "Cairo-Regular"
    static let bold = "Cairo-Bold"
    static let italic = "Cairo-Regular"
    static let semiBold = "Cairo-SemiBold"
    static let light = "Cairo-Light"
    static let heavy = "Cairo-Black"
    static let medium = "Cairo-SemiBold"
    
//    static let Nobel_Book = "Nobel-Book"
//    static let Nobel_Light = "Nobel-Light"
//    static let Nobel_Regular = "Nobel-Regular"
//    static let Nobel_Bold = "Nobel-Bold"

}

extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size - 4)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }
    
    @objc class func myHeavySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.heavy, size: size)!
    }
    
    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light, size: size)!
    }
    
    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semiBold, size: size)!
    }
    
    

    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            let mFontAttribute = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
            if let fontAttribute = fontDescriptor.fontAttributes[mFontAttribute] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AppFontName.regular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.bold
                case "CTFontObliqueUsage":
                    fontName = AppFontName.italic
                case "CTFontSemiboldUsage":
                    fontName = AppFontName.semiBold
                case "CTFontUltraLightUsage":
                    fontName = AppFontName.light
                case "CTFontHeavyUsage" :
                    fontName = AppFontName.heavy
                default:
                    fontName = AppFontName.regular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }
    
    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
            
            let lightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:)))
            let myLightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:)))
            method_exchangeImplementations(lightSystemFontMethod!, myLightSystemFontMethod!)
            
            let semiBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:)))
            let mySemiBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:)))
            method_exchangeImplementations(semiBoldSystemFontMethod!, mySemiBoldSystemFontMethod!)
            
            let heavySystemFontMethod = class_getClassMethod(self, #selector(myHeavySystemFont(ofSize:)))
            let myHeavySystemFontMethod = class_getClassMethod(self, #selector(myHeavySystemFont(ofSize:)))
            method_exchangeImplementations(heavySystemFontMethod!, myHeavySystemFontMethod!)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}
