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
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
   
//    func substring(_ from: Int) -> String {
//        return self.substring(from: self.index(self.startIndex, offsetBy: from))
//    }
    
    func isNumeric() -> Bool
    {
        let number = Int(self)
        return number != nil
    }

   func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
    func updateToEngNum()->String{
        var text = ""
        text = self.replacingOccurrences(of: "٠", with: "0")
        text = text.replacingOccurrences(of: "١", with: "1")
        text = text.replacingOccurrences(of: "٢", with: "2")
        text = text.replacingOccurrences(of: "٣", with: "3")
        text = text.replacingOccurrences(of: "٤", with: "4")
        text = text.replacingOccurrences(of: "٥", with: "5")
        text = text.replacingOccurrences(of: "٦", with: "6")
        text = text.replacingOccurrences(of: "٧", with: "7")
        text = text.replacingOccurrences(of: "٨", with: "8")
        text = text.replacingOccurrences(of: "٩", with: "9")
        return text
    }
    
    func components(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
    
    func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0
        
        for character in self {
            collectedCharacters.append(character)
            count += 1
            if (count == length) {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }
        
        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }
        
        return result
    }

    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, count)]))
        }
        return result
    }
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }
    
    func doStringContainsNumber( ) -> Bool{
        
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: self)
        
        return containsNumber
    }
    
     func isValidPhoneNumber () -> Bool{
        if  self.count == 11 && isNumeric(){
            let prefix = String(self.prefix(3))
            if prefix == "010" || prefix == "011" || prefix == "012" ||  prefix == "015"  || prefix == "٠١٠" || prefix == "٠١١" || prefix == "٠١٢" || prefix == "٠١٥"
            {
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }

    
    func trim ()->String{
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func toDate () -> Date{
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
    
    static func getURL(baseURL: String, params: Dictionary<String, String?>) -> String {
        var url = baseURL + "?"
        for  item in params  {
            if item.value != nil {
                url = url + item.key + "=" + item.value!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&"
            }
        }
        url = url.substring(to: url.index(before: url.endIndex))
        
        return url
    }


    func isDate() -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
   
        if dateFormatterGet.date(from: self) != nil {
            return true
        } else {
            return false
        }
    }
    
    
    func localize() -> String{
        return NSLocalizedString(self, comment: self)
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
