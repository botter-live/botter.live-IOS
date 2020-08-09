//
//  BotData.swift
//  Botter
//
//  Created by Nora on 7/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class BotData : Mappable{
    var startForm : Form
    var endForm : Form
    var menu : Menu
    
    
    init() {
        startForm = Form()
        endForm = Form()
        menu = Menu()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        startForm <- map["startForm"]
        endForm <- map["endForm"]
        menu <- map["menu"]
    }
    
    static func getBotterData(dict : [String : Any])->BotData{
        return Mapper<BotData>().map(JSON: dict)!
    }
}
