//
//  BotData.swift
//  Botter
//
//  Created by Nora on 7/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_BotData : Mappable{
    var startForm : b_Form
    var endForm : b_Form
    var menu : b_Menu
    
    
    init() {
        startForm = b_Form()
        endForm = b_Form()
        menu = b_Menu()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        startForm <- map["startForm"]
        endForm <- map["endForm"]
        menu <- map["menu"]
    }
    
    static func getBotterData(dict : [String : Any])->b_BotData{
        return Mapper<b_BotData>().map(JSON: dict)!
    }
}
