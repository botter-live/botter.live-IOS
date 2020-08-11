//
//  GallaryItem.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_GallaryItem : Codable , Mappable{
    
    var actions : [b_Action]
    var title : String
    var imageUrl : String
    var desc : String
    var type : String
    var mediaType : b_MediaType
    var thumbnail : String
    
    init(){
        actions = [b_Action]()
        title = ""
        imageUrl = ""
        desc = ""
        type = ""
        mediaType = .image
        thumbnail = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        actions <- map["actions"]
        title <- map["header"]
        imageUrl <- map["url"]
        desc <- map["desc"]
        type <- map["media_type"]
        mediaType = b_MediaType.init(rawValue: type) ?? .image
        thumbnail <- map["video_thumbnail"]
    }
    
    enum b_MediaType : String , Codable{
        case image = "image"
        case gif = "gif"
        case video = "video"
    }
}
