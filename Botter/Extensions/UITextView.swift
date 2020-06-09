//
//  UITextView.swift
//  LM
//
//  Created by George Naiem on 3/26/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//

import UIKit

extension UITextView: UITextViewDelegate {
    
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            }else if fontNameToTest.range(of: "semibold") != nil {
                fontName += "-Semibold";
            }
            else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }

    
    
    // Placeholder text
    @IBInspectable var placeholder: String? {
        
        get {
            // Get the placeholder text from the label
            var placeholderText: String?
            
            if let placeHolderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeHolderLabel.text
            }
            return placeholderText
        }
        
        set {
            // Store the placeholder text in the label
            let placeHolderLabel = self.viewWithTag(100) as! UILabel?
            if placeHolderLabel == nil {
                // Add placeholder label to text view
                self.addPlaceholderLabel(newValue!)
            }
            else {
                placeHolderLabel?.text = newValue
                placeHolderLabel?.sizeToFit()
            }
        }
    }
    
    
    
    
    // Hide the placeholder label if there is no text
    // in the text viewotherwise, show the label
    public func textViewDidChange(_ textView: UITextView) {
        
        let placeHolderLabel = self.viewWithTag(100)
        
        if !self.hasText {
            // Get the placeholder label
            placeHolderLabel?.isHidden = false
        }
        else {
            placeHolderLabel?.isHidden = true
        }
    }
    
    // Add a placeholder label to the text view
    func addPlaceholderLabel(_ placeholderText: String) {
        
        // Create the label and set its properties
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin.x = 0
        placeholderLabel.frame.origin.y = 8.0
        placeholderLabel.frame.size.width = 200
        //placeholderLabel.frame.size.height = 50
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.white
        placeholderLabel.alpha = 0.5
        placeholderLabel.tag = 100
        placeholderLabel.textAlignment = .natural
        // Hide the label if there is text in the text view
        placeholderLabel.isHidden = self.text.length > 0
        placeholderLabel.sizeToFit()
      //  self.addSubview(placeholderLabel)
        //self.delegate = self;
    }
    
    
   
    
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }

   
    
//    @IBInspectable var placeholder: String {
//        get {
//            return placeholder
//        }
//        set {
//            placeholder = placeholder
//        }
//    }
    
}
