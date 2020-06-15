//
//  Action.swift
//  Botter
//
//  Created by Nora on 6/4/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
//import  ObjectMapper

class Action : Codable , Mappable{
    var type : String
    var title : String
    var block : Int
    var value : String
    var action : ActionType
    var msgIndex = -1
    
    init(){
        type = ""
        title = ""
        block = -1
        value = ""
        action = .none
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        title <- map["title"]
        block <- map["block_id"]
        value <- map["value"]
        action = ActionType.init(rawValue: type.lowercased()) ?? .none
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}

enum ActionType : String , Codable{
    case postBack = "postback"
    case call = "call"
    case openUrl = "openurl"
    case none = ""
}
