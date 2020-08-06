//
//  AttchedFile.swift
//  Botter
//
//  Created by Nora on 7/28/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class AttachedFile : Mappable{
    var type : String
    var url : String
    var code : Int
    var error : String
    
    init(){
        type = ""
        url = ""
        error = ""
        code = -1
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        url <- map["url"]
        error <- map["error"]
        code <- map["code"]
    }
    
    static func getData(dict : [String : Any])->AttachedFile{
        return Mapper<AttachedFile>().map(JSON: dict)!
    }
}
