//
//  FaqsData.swift
//  Botter
//
//  Created by SherifShokry on 7/20/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//


import Foundation

class b_FaqData : Mappable{
    var id : Int
    var body : b_FaqsItem
    var createdAt : String
    
    init() {
        id = -1
        body = b_FaqsItem()
        createdAt = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        body <- map["body"]
        createdAt <- map["created_at"]
    }
    
    static func getFAQS(dict : [[String : Any]])->[b_FaqData]{
        return Mapper<b_FaqData>().mapArray(JSONArray: dict)
    
    }
}


class b_FaqsItem : Mappable{
    var answer : String
    var question : String
    
    
    init() {
        answer = ""
        question = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        answer <- map["answer"]
        question <- map["question"]
    }

}
