//
//  BasicMessage.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
//import ObjectMapper
import LazyImage

class b_BasicMessage :  Mappable {
    
    var msgIndex = -1
    var type : String
    var text : String
    var isBotMsg : Bool
    var slug : String
    var msgType : b_MessageType
    var mediaUrl : String
    var actions : [b_Action]
    var galleryItems : [b_GallaryItem]
    var image : String
    var url : String
    var weather : b_Weather
    var player = AudioPlayer()
    var audioDuration : TimeInterval!
    var audioIndex = -1
    var foundDuration : (()->())!
    var hasTime : Bool
    var pickDateTimeTitle : String
    var location : b_Location
    var msgSent = true
    var blockValue = ""
    var flightInfo : b_FlightTicket
    var flighStatus : b_FlightStatus
    var invoice : b_Invoice
    var notifyText : String
    var sender : b_Sender
    let lazyImage = LazyImage()
    
    init(){
        type = ""
        text = ""
        isBotMsg = true
        slug = ""
        msgType = .text
        mediaUrl = ""
        actions = [b_Action]()
        galleryItems = [b_GallaryItem]()
        image = ""
        url = ""
        audioDuration = 0
        weather = b_Weather()
        hasTime = false
        pickDateTimeTitle = ""
        location = b_Location()
        flightInfo = b_FlightTicket()
        flighStatus = b_FlightStatus()
        invoice = b_Invoice()
        notifyText = ""
        sender = b_Sender()
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        text <- map["payload"]
        isBotMsg <- map["isBotMsg"]
        slug <- map["slug"]
//        slug = slug.replacingOccurrences(of: "-", with: "").lowercased()
        msgType = b_MessageType.init(rawValue: slug) ?? .text
        mediaUrl <- map["mediaUrl"]
        actions <- map["actions"]
        galleryItems <- map["data"]
        image <- map["image"]
        url <- map["url"]
        weather <- map["data"]
        hasTime <- map["hasTime"]
        pickDateTimeTitle <- map["text"]
        location <- map["location"]
        flightInfo <- map["data"]
        flighStatus <- map["data"]
        invoice <- map["data"]
        notifyText <- map["notify_text"]
        sender <- map["sender"]
        
        if msgType == .audio{
            handleAudio()
        }
        if msgType == .dateTime{
            let action = b_Action()
            action.title = hasTime ? "Pick Time" : "Pick Date"
            action.action = .date
            actions.append(action)
        }
        
        if msgType == .image || msgType == .userImage{
            
            lazyImage.prefetchImage(url: mediaUrl)
        }
        
        if msgType == .userMsg {
            text <- map["text"]
        }
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    static func getMessage(dict : [String:Any])-> b_BasicMessage{
        return Mapper<b_BasicMessage>().map(JSON: dict)!
    }
    
    
    func handleAudio(){
        let item = AudioItem(mediumQualitySoundURL: URL.init(string: mediaUrl))
        player.delegate = self
        player.play(item: item!)
        player.volume = 0
//        setImage(state: player.state)
    }
}

enum b_MessageType : String , Codable{
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
    case typing = "typing"
    case gif = "gif"
    case map = "map"
    case dateTime = "card-date-time-input"
    case receipt = "receipt"
    case none = ""
    case notify = "escalate"
    case attachment = "attachment"
    case userMsg = "message"
    case userImage = "image_attachment"
}

extension b_BasicMessage : AudioPlayerDelegate{
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem) {
        self.audioDuration = duration
        player.stop()
        if foundDuration != nil {
            self.foundDuration()
            self.foundDuration = nil
        }
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, willStartPlaying item: AudioItem) {
        player.stop()
    }
}

class b_Sender : Mappable{
    
    var senderID : String
    var avatar : String
    var senderType : b_SenderType
    var avatarType : b_AvatarType
    private var senderTypeStr : String
    private var avatarTypeStr : String
    
    init()
    {
        senderID = ""
        senderTypeStr = ""
        avatarTypeStr = ""
        avatar = ""
        senderType = .bot
        avatarType = .empty
    }
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        senderID <- map["sender_id"]
        avatar <- map["avatar"]
        avatarTypeStr <- map["avatar_type"]
        senderTypeStr <- map["sender_type"]
        
        senderType = b_SenderType.init(rawValue: senderTypeStr) ?? .bot
        avatarType = b_AvatarType.init(rawValue: avatarTypeStr) ?? .empty
    }
    
    
    
}
enum b_SenderType : String{
    case user = "USER"
    case agent = "AGENT"
    case bot = "BOT"
}

enum b_AvatarType : String{
    case url = "url"
    case base64 = "base64"
    case empty = ""
}
