//
//  FlightStatus.swift
//  Botter
//
//  Created by Nora on 7/8/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

class b_FlightStatus : Mappable {
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
    var introMessage : String
    private var statusColorStr : String
    var statusColor : UIColor
    
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
        introMessage = ""
        statusColorStr = ""
        statusColor = UIColor.init(codeString: "#aaaaaa")
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
        introMessage <- map["intro_message"]
        statusColorStr <- map["status_color"]
        
        setColor()
        
    }
    
    
    func setColor(){
        let testCase = NSPredicate(format:"SELF MATCHES %@", "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$")
        let isValid = testCase.evaluate(with: statusColorStr)
        if isValid {
            let color = UIColor.init(codeString: statusColorStr)
            statusColor = color
        }
    }
}
