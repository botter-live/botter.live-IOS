//
//  GallaryItem.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class GallaryItem : Codable , Mappable{
    
    var actions : [Action]
    var title : String
    var imageUrl : String
    var desc : String
    var type : String
    var mediaType : MediaType
    var thumbnail : String
    
    init(){
        actions = [Action]()
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
        mediaType = MediaType.init(rawValue: type) ?? .image
        thumbnail <- map["video_thumbnail"]
    }
    
    enum MediaType : String , Codable{
        case image = "image"
        case gif = "gif"
        case video = "video"
    }
}
