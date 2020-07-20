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
    
    
    init() {
        startForm = Form()
        endForm = Form()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        startForm <- map["startForm"]
        endForm <- map["endForm"]
    }
    
    static func getBotterData(dict : [String : Any])->BotData{
        return Mapper<BotData>().map(JSON: dict)!
    }
}
