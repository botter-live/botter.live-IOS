//
//  Validations.swift
//  MyLexus
//
//  Created by Nora on 6/19/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation

class Validations {
    
    static func isValidPhoneNumber (text : String) -> Bool{
//        if  text.count >= 6 && text.isNumeric(){
//            return true
//        }else{
//            return false
//        }
        let regex = "^(010|011|012|015)[0-9]{8}$"
        let testCase = NSPredicate(format:"SELF MATCHES %@", regex)
        let isValid = testCase.evaluate(with: text)
        
        return isValid
    }
    
    static func doStringContainsNumber(text : String) -> Bool{
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: text)
        
        return containsNumber
    }
    
    static func isValidEmail(text : String) -> Bool {
        let regEx = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: text)
    }
    
    static func textHasOnlyNumbers(_ text: String) -> Bool {
        
        let charcterSet  = CharacterSet(charactersIn: "0123456789").inverted
        let inputString = text.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  text == filtered
    }
    
    static func isValidPassword(text: String)->Bool{
        return text.count >= 3
    }
    
    static func isValidName(string : String)->Bool{
        let regxAr = "[ء-ي ]{2,}"
        let testAr = NSPredicate(format:"SELF MATCHES %@", regxAr)
        
        let regex = "[A-Z][a-zA-Z ]{2,}"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
//[^#&<>\"~;$^%{}?]
        let result1 = test.evaluate(with: string)
        let result2 = testAr.evaluate(with: string)
        
        return (( result1 || result2 ) && string.count > 1)
        
    }
    
    static func isValidUserName(string : String)->Bool{
       
        let regex = "[a-zA-Z][a-zA-Z0-9_-]{1,30}"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)

        return (test.evaluate(with: string))
        
    }
    
    
    static func isChar(text : String)->Bool{
        let regx = "(?![ثحخذشظضغكهؤءزئ])[ء-ي]+"
        let test = NSPredicate(format:"SELF MATCHES %@", regx)
        return test.evaluate(with: text)
    }
    
    static func isNumber(text : String)->Bool{
        let regx = "[0-9٠-٩]+"
        let test = NSPredicate(format:"SELF MATCHES %@", regx)
        return test.evaluate(with: text)
    }
    
    static func validateLicenseCharNumber(text : String)->Bool{
        let regx = "(?![ثحخذشظضغكهؤءزئ])[ء-ي]{1,4}[0-9٠-٩]{1,4}"
        let test = NSPredicate(format:"SELF MATCHES %@", regx)
        return test.evaluate(with: text)
    }
    
    static func validateLicenseNumber(text : String)->Bool{
        let regx = "[0-9٠-٩]{1,7}"
        let test = NSPredicate(format:"SELF MATCHES %@", regx)
        return test.evaluate(with: text)
    }
    
    static func validateDLicenseNumber(text : String)->Bool{
        let regx = "[0-9٠-٩]{14}"
        let test = NSPredicate(format:"SELF MATCHES %@", regx)
        return test.evaluate(with: text)
    }
}
