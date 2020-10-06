//
//  Prombet.swift
//  Botter
//
//  Created by Nora on 9/6/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class Prombet : Mappable{
    var errorMessage : String
    var typeString : String
    var regex : String
    var answered = false
    var answerText = ""
    var type : b_MessageType = .text
    var tempAnswer = ""
    
    init(){
        errorMessage = ""
        typeString = ""
        regex = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        errorMessage <- map["errorMessage"]
        typeString <- map["type"]
        regex <- map["regex"]
    }
}
