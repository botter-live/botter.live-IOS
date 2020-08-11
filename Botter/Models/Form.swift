//
//  Form.swift
//  Botter
//
//  Created by Nora on 7/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_Form : Mappable{
    var inputs  : [b_FormInput]
    var label : String
    var locale : String
    var name : String
    
    init(){
        inputs = [b_FormInput]()
        label = ""
        locale = ""
        name = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        inputs <- map["inputs"]
        label <- map["label"]
        locale <- map["locale"]
        name <- map["name"]
    }
    
}

class b_FormInput : Mappable{
    var errorMessage : String
    var key : String
    var label : String
    var regex : String
    var required : Bool
    var multiple : Bool
    var type : b_FormInputType = .unknown
    var options : [String]
    private var typeString : String{
        didSet{
            type = b_FormInputType.init(rawValue: typeString) ?? .unknown
        }
    }
    
    
    init(){
        errorMessage = ""
        key = ""
        label = ""
        regex = ""
        required = false
        multiple = false
        typeString = ""
        options = [String]()
        
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        errorMessage <- map["errorMessage"]
        key <- map["key"]
        label <- map["label"]
        regex <- map["regex_ios"]
        required <- map["required"]
        typeString <- map["type"]
        options <- map["options"]
        multiple <- map["multiple"]
    }
    
    
}
enum b_FormInputType : String{
    case unknown = ""
    case textfield = "textfield"
    case select = "select"
    case textarea = "textarea"
    case radio = "radio"
    case time = "time"
    case date = "date"

}
