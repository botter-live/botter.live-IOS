//
//  TextFormater.swift
//  Botter
//
//  Created by Nora on 8/13/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

class TextFormater{
    
    static var shared = TextFormater()
    
    func formatText (text : String) -> NSMutableAttributedString  {
        let attributedString = NSMutableAttributedString(string: text as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
         var newText = replaceSpecialChars(text: attributedString,char: "*")
         newText = replaceSpecialChars(text: attributedString,char: "_")
         newText = replaceSpecialChars(text: attributedString,char: "~")
         return newText
    }
    
    func replaceSpecialChars(text: NSMutableAttributedString, char : Character) ->NSMutableAttributedString {
         var count = 0
         var startIndex = 0
         var endIndex = 0
        for i in 0..<text.string.count {
            if (text.string[text.string.index(text.string.startIndex, offsetBy: i)] == char) {
                   count = count + 1
               if (count % 2 == 0) {
                    endIndex = i
                formateAttributedString(startIndex: startIndex, endIndex: endIndex, text: text, char: char)
               } else {
                    startIndex = i
               }
           }
         }
         return text
       }
    

    func formateAttributedString(startIndex : Int , endIndex : Int, text:NSMutableAttributedString, char : Character)  {
        let start = text.string.index(text.string.startIndex, offsetBy: startIndex)
        let end = text.string.index(text.string.startIndex, offsetBy: startIndex + (endIndex - startIndex))
        let range = start..<end
        if char == "*" {
            let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)]
            let boldText = text.string[range]
            text.addAttributes(boldFontAttribute, range:text.mutableString.range(of: String(boldText)))
            text.replaceCharacters(in: NSRange(location: startIndex, length: 1), with: " ")
            text.replaceCharacters(in: NSRange(location: endIndex, length: 1), with: " ")
        }else if char == "_" {
            let italicFontAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15.0)]
            let boldText = text.string[range]
            text.addAttributes(italicFontAttribute, range: text.mutableString.range(of: String(boldText)))
            text.replaceCharacters(in: NSRange(location: startIndex, length: 1), with: " ")
            text.replaceCharacters(in: NSRange(location: endIndex, length: 1), with: " ")
        }else if char == "~" {
            let strikethrough = text.string[range]
            let somePartStringRange = (text.string as NSString).range(of: String(strikethrough))
            text.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: somePartStringRange)
            text.replaceCharacters(in: NSRange(location: startIndex, length: 1), with: " ")
            text.replaceCharacters(in: NSRange(location: endIndex, length: 1), with: " ")
        }
    }
}
