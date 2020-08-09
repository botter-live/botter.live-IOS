//
//  FlightTicket.swift
//  Botter
//
//  Created by Nora on 7/7/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class FlightTicket : Mappable{
    var confirmationNumber : String
    var currency : String
    var passengers : [String]
    var total : String
    var tickets : [TicketInfo]
    
    
    init() {
        confirmationNumber = ""
        currency = ""
        passengers = [String]()
        total = ""
        tickets = [TicketInfo]()
        
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        confirmationNumber <- map["confirmation_number"]
        currency <- map["currency"]
        passengers <- map["passengers"]
        total <- map["total"]
        tickets <- map["flight_info"]
        
    }
}
class TicketInfo : Mappable{
    var stops : String
    var arrivalAirPort : Airport
    var depratureAirPort : Airport
    var date : String
    
    init(){
        stops = ""
        arrivalAirPort = Airport()
        depratureAirPort = Airport()
        date = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        stops <- map["stops_number"]
        arrivalAirPort <- map["arrival_airport"]
        depratureAirPort <- map["departure_airport"]
        date <- map["flight_schedule.departure_time"]
    }
}

class Airport : Mappable{
    var code : String
    var city : String
    
    init(){
        code = ""
        city = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["airport_code"]
        city <- map["city"]
        
    }
}
