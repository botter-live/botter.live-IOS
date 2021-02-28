//
//  Date.swift
//  LM
//
//  Created by George Naiem on 4/3/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//

import UIKit

extension Date {
    
    func b_timeAgoDisplay() -> String {

        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) sec ago"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) days ago"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff) weeks ago"
    }

    func b_toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    func b_toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    func b_getWeatherDateString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        
        return dateFormatter.string(from: self)
    }
    
    func b_getWeekDay()->String{
        let dateFormater = DateFormatter()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: Date())
        let weekDay = myComponents.weekday
        dateFormater.locale = NSLocale.init(localeIdentifier: "en_US") as Locale
        let index = (weekDay!  - 1) % 7
//        print(dateFormater.shortWeekdaySymbols[index])
        return (dateFormater.shortWeekdaySymbols[index]).capitalized
//            dateFormater.weekdaySymbols[Calendar.current.component(.weekday, from: self)]
    }
    
}
