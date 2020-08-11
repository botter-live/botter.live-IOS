//
//  MenuItem.swift
//  Botter
//
//  Created by Nora on 7/20/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_Menu : Mappable{
    var actions : [b_MenuItem]
    
    init(){
        actions = [b_MenuItem]()
    }

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        actions <- map["call_to_actions"]
    }
}

class b_MenuItem : Mappable {
    var payload : String
    var title : String
    var typeString : String
    var actions : [b_MenuItem]
    
    init(){
        payload = ""
        title = ""
        typeString = ""
        actions = [b_MenuItem]()
        
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        payload <- map["payload"]
        title <- map["title"]
        typeString <- map["type"]
        actions <- map["call_to_actions"]
    }
    
}
