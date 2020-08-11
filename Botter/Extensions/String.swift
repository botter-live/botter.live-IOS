//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func b_className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    
    func b_components(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
 
    func b_trim ()->String{
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func b_toDate () -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }

        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
       
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZZZZZ"
               if let date = dateFormatter.date(from: self)
               {
                   return date
               }
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM"
        if let date = dateFormatter.date(from: self){
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = dateFormatter.date(from: self){
            return date
        }
        dateFormatter.dateFormat = "hh:mm a"
        if let date = dateFormatter.date(from: self){
            return date
        }
        dateFormatter.dateFormat = "hh:mm"
        if let date = dateFormatter.date(from: self){
            return date
        }
        dateFormatter.dateFormat = "yyyy"
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        return Date()
        
    }
 
    func b_localize() -> String{
//        return NSLocalizedString(self, bundle: MyFrameworkBundle.bundle, comment: self)
        return CommonActions.loadText(for: self)
        
//        return NSLoca
    }

    func b_height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
