//
//  MenuItem.swift
//  Botter
//
//  Created by Nora on 7/20/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class Menu : Mappable{
    var actions : [MenuItem]
    
    init(){
        actions = [MenuItem]()
    }

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        actions <- map["call_to_actions"]
    }
}

class MenuItem : Mappable {
    var payload : String
    var title : String
    var typeString : String
    var actions : [MenuItem]
    
    init(){
        payload = ""
        title = ""
        typeString = ""
        actions = [MenuItem]()
        
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
