//
//  Location.swift
//  Botter
//
//  Created by Nora on 6/17/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_Location : Mappable , Codable{
    var title : String
    var imageUrl : String
    var lat : Double
    var long : Double
    var btnUrl : String
    var desc : String
    var btnTitle : String
    
    
    init(){
        title = ""
        imageUrl = ""
        lat = 0
        long = 0
        btnUrl = ""
        desc = ""
        btnTitle = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        imageUrl <- map["imageUrl"]
        lat <- map["coords.lat"]
        long <- map["coords.long"]
        btnUrl <- map["buttonUrl"]
        desc <- map["description"]
        btnTitle <- map["buttonTitle"]
    }
}
