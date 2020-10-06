//
//  NotificationManager.swift
//  Botter
//
//  Created by Nora on 9/28/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class NotificationManager{
    
    static var shared = NotificationManager()
    
    func sendToken(){
        let dataSource = BotterDataSource()
        dataSource.sendToken { (status, response) in
            
        }
    }
    
    func clear(){
        UserDefaults.standard.setValue(0 , forKey: "notificationCount")
        UserDefaults.standard.setValue(nil, forKey: "notificationIDs")
        Botter.reSet()
    }
    
    func addNotification(id : String){
        if !checkIfAlreadySaved(id: id){
            let count = getNotificationCount() + 1
            UserDefaults.standard.setValue(count , forKey: "notificationCount")
            Botter.reSet()
        }
    }
    
    func getNotificationCount()->Int{
        if let count = UserDefaults.standard.value(forKey: "notificationCount") as? Int{
            return count
        }
        
        return 0
    }
    
    func checkIfAlreadySaved(id : String)->Bool{
        if var saved = UserDefaults.standard.value(forKey: "notificationIDs") as? [String] {
            if saved.contains(id){
                return true
            }else{
                saved.append(id)
                UserDefaults.standard.setValue(saved, forKey: "notificationIDs")
                return false
            }
        }
        UserDefaults.standard.setValue([id], forKey: "notificationIDs")
        return false
    }
}
