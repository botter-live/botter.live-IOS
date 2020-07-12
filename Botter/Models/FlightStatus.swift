//
//  FlightStatus.swift
//  Botter
//
//  Created by Nora on 7/8/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class FlightStatus : Mappable{
    var arrivalAirportCode : String
    var arrivalAirportName : String
    var arrivalGate : String
    var depratureAirportCode : String
    var depratureAirportName : String
    var depratureGate : String
    var arrives : String
    var departs : String
    var flight : String
    var status : String
    var confirmationNumber : String
    
    init() {
        arrivalAirportCode = ""
        depratureAirportCode = ""
        arrivalAirportName = ""
        depratureAirportName = ""
        arrivalGate = ""
        depratureGate = ""
        arrives = ""
        departs = ""
        flight = ""
        status = ""
        confirmationNumber = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        arrivalAirportCode <- map["arrivalAcronym"]
        depratureAirportCode <- map["departureAcronym"]
        arrivalAirportName <- map["arrivalName"]
        depratureAirportName <- map["departureName"]
        arrivalGate <- map["arrivalGate"]
        depratureGate <- map["departureGate"]
        arrives <- map["arrives"]
        departs <- map["departs"]
        flight <- map["flight"]
        status <- map["status"]
        confirmationNumber <- map["confirmation_number"]
    }
}
