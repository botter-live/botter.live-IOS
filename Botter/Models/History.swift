//
//  History.swift
//  Botter
//
//  Created by Nora on 8/4/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_History :  Mappable {
    
    var list : [b_BasicMessage]
    private var nList : [b_HistoryItem]
    
    
    init(){
        list = [b_BasicMessage]()
        nList = [b_HistoryItem]()
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
    
    static func getHistory(dict : [String:Any])-> b_History{
        return Mapper<b_History>().map(JSON: dict)!
    }
}
class b_HistoryItem :  Mappable{
    
    var message : b_BasicMessage
    
    init(){
        message = b_BasicMessage()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        message <- map["message"]
    }
}
