//
//  Analytics.swift
//  ETY
//
//  Created by Nora on 11/27/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import Foundation
//import FirebaseAnalytics

class MyAnalytics {
    
    static var shared = MyAnalytics()
    
    var home = "home"
    var challenges = "yolker_challenges"
    var achievedChallenges = "achieved_challenges"
    var makeAppointment = "book_appointment"
    var editProfile = "edit_profile"
    var packages = "packages"
    var periodTracker = "period_tracker"
    var login = "login"
    var allergiesFoodDislikes = "allergies_food_dislikes"
    var register = "register"
    var stepsTracker = "steps_tracker"
    var progress = "insights"
    var exchangeList = "exchange_list"
    var groceryList = "grocery_list"
    var userMeals = "user_meals"
    
    
    func addEvent(key : String , params : [String : Any]? = [:]){
//        Analytics.logEvent(key , parameters: params)
    }
     
}



