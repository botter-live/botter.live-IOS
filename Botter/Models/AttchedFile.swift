//
//  AttchedFile.swift
//  Botter
//
//  Created by Nora on 7/28/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_AttachedFile : Mappable{
    var type : String
    var url : String
    var code : Int
    var error : String
    var name : String
    
    init(){
        type = ""
        url = ""
        error = ""
        code = -1
        name = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        url <- map["url"]
        error <- map["error"]
        code <- map["code"]
        name <- map["name"]
    }
    
    static func getData(dict : [String : Any])->b_AttachedFile{
        return Mapper<b_AttachedFile>().map(JSON: dict)!
    }
}
