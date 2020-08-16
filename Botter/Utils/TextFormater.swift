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
    
    func formatText (text : String) -> NSAttributedString  {
//        let attributedString = NSMutableAttributedString(string: text as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
//         var newText = replaceSpecialChars(text: attributedString,char: "*")
//         newText = replaceSpecialChars(text: attributedString,char: "_")
//         newText = replaceSpecialChars(text: attributedString,char: "~")
        let renderer = MarkupRenderer(baseFont: BotterSettingsManager.Font.getRegularFontForParsing())
        let newText = renderer.render(text: text)
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
            print(text.string.unicodeScalars.count)
            let ftempIndex  = text.string.firstIndex(of: "_")
            text.replaceCharacters(in: NSRange(location: ftempIndex?.distance(in: text.string) ?? startIndex , length: 1), with: " ")
            let tempIndex  = text.string.firstIndex(of: "_")
            print(tempIndex?.distance(in: text.string) ?? 0)
            text.replaceCharacters(in: NSRange(location: tempIndex?.distance(in: text.string) ?? endIndex, length: 1), with: " ")
            
        }else if char == "~" {
            let strikethrough = text.string[range]
            let somePartStringRange = (text.string as NSString).range(of: String(strikethrough))
            text.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: somePartStringRange)
            text.replaceCharacters(in: NSRange(location: startIndex, length: 1), with: " ")
            text.replaceCharacters(in: NSRange(location: endIndex, length: 1), with: " ")
        }
    }
}
extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(from: string.startIndex, to: self) }
}
