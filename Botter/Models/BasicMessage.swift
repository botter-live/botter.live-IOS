//
//  BasicMessage.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
//import ObjectMapper

class BasicMessage : Codable , Mappable {
    
    var type : String
    var text : String
    var isBotMsg : Bool
    var slug : String
    var msgType : MessageType
    var mediaUrl : String
    var actions : [Action]
    var galleryItems : [GallaryItem]
    var image : String
    var url : String
    
    init(){
        type = ""
        text = ""
        isBotMsg = true
        slug = ""
        msgType = .text
        mediaUrl = ""
        actions = [Action]()
        galleryItems = [GallaryItem]()
        image = ""
        url = ""
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        text <- map["payload"]
        isBotMsg <- map["isBotMsg"]
        slug <- map["slug"]
        msgType = MessageType.init(rawValue: slug.lowercased()) ?? .text
        mediaUrl <- map["mediaUrl"]
        actions <- map["actions"]
        galleryItems <- map["data"]
        image <- map["image"]
        url <- map["url"]
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    static func getMessage(dict : [String:Any])-> BasicMessage{
        return Mapper<BasicMessage>().map(JSON: dict)!
    }
}


enum MessageType : String , Codable{
    case text = "text"
    case flightStatus = "flight-status"
    case flightPassngers = "flight-passngers"
    case triviaQuestion = "trivia-question"
    case weather = "weather"
    case image = "image"
    case audio = "audio"
    case gallery = "gallery"
    case video = "video"
    case hero = "hero"
}
