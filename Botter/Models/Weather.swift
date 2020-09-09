//
//  Weather.swift
//  Botter
//
//  Created by Nora on 6/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_Weather : Mappable , Codable{
    var area : String
    var imageUrl : String
    var temp : String
    var heighTemp : String
    var lowTemp : String
    
    init(){
        area = ""
        imageUrl = ""
        temp = ""
        heighTemp = ""
        lowTemp = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        area <- map["area"]
        imageUrl <- map["imageUrl"]
        temp <- map["temp"]
        heighTemp <- map["highTemp"]
        lowTemp <- map["lowTemp"]
    }
}
