//
//  History.swift
//  Botter
//
//  Created by Nora on 8/4/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class History :  Mappable {
    
    var list : [BasicMessage]
    private var nList : [HistoryItem]
    
    
    init(){
        list = [BasicMessage]()
        nList = [HistoryItem]()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        list <- map["history"]
//        list = nList.map({ (item) -> BasicMessage in
//            item.message
//        })
    }
    
    static func getHistory(dict : [String:Any])-> History{
        return Mapper<History>().map(JSON: dict)!
    }
}
class HistoryItem :  Mappable{
    
    var message : BasicMessage
    
    init(){
        message = BasicMessage()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        message <- map["message"]
    }
}
