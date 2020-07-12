//
//  BasicMessage.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
//import ObjectMapper

class BasicMessage :  Mappable {
    
    var msgIndex = -1
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
    var weather : Weather
    var player = AudioPlayer()
    var audioDuration : TimeInterval!
    var audioIndex = -1
    var foundDuration : (()->())!
    var hasTime : Bool
    var pickDateTimeTitle : String
    var location : Location
    var msgSent = true
    var blockValue = ""
    var flightInfo : FlightTicket
    var flighStatus : FlightStatus
    var invoice : Invoice
    
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
        audioDuration = 0
        weather = Weather()
        hasTime = false
        pickDateTimeTitle = ""
        location = Location()
        flightInfo = FlightTicket()
        flighStatus = FlightStatus()
        invoice = Invoice()
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        text <- map["payload"]
        isBotMsg <- map["isBotMsg"]
        slug <- map["slug"]
//        slug = slug.replacingOccurrences(of: "-", with: "").lowercased()
        msgType = MessageType.init(rawValue: slug) ?? .text
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
        
        if msgType == .audio{
            handleAudio()
        }
        if msgType == .dateTime{
            let action = Action()
            action.title = hasTime ? "Pick Time" : "Pick Date"
            action.action = .date
            actions.append(action)
        }
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    static func getMessage(dict : [String:Any])-> BasicMessage{
        return Mapper<BasicMessage>().map(JSON: dict)!
    }
    
    
    func handleAudio(){
        let item = AudioItem(mediumQualitySoundURL: URL.init(string: mediaUrl))
        player.delegate = self
        player.play(item: item!)
        player.volume = 0
//        setImage(state: player.state)
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
    case typing = "typing"
    case gif = "gif"
    case map = "map"
    case dateTime = "card-date-time-input"
    case receipt = "receipt"
}

extension BasicMessage : AudioPlayerDelegate{
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
