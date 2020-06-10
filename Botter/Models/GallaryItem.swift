//
//  GallaryItem.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class GallaryItem : Codable , Mappable{
    
    private var actions : [Action]
    var title : String
    var imageUrl : String
    var action : Action
    var hasAction : Bool
    
    init(){
        actions = [Action]()
        title = ""
        imageUrl = ""
        action = Action()
        hasAction = false
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        actions <- map["actions"]
        title <- map["header"]
        imageUrl <- map["url"]
        hasAction = actions.count != 0
        if hasAction {
            action = actions[0]
        }
    }
}
