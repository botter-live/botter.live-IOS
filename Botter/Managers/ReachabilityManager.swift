//
//  ReachabilityManager.swift
//  Botter
//
//  Created by Nora on 6/23/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class ReachabilityManager: NSObject {
    static  let shared = ReachabilityManager()
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()
    
    var reachabilityChangedEvent:(()->())!
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
       let reachability = notification.object as! Reachability
        reachabilityStatus = reachability.currentReachabilityStatus
       switch reachability.currentReachabilityStatus {
       case .notReachable:
       debugPrint("Network became unreachable")
       case .reachableViaWiFi:
       debugPrint("Network reachable through WiFi")
       case .reachableViaWWAN:
       debugPrint("Network reachable through Cellular Data")
     }
        if reachabilityChangedEvent != nil{
            reachabilityChangedEvent()
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
       NotificationCenter.default.addObserver(self,
                 selector: #selector(self.reachabilityChanged),
                 name: Notification.Name.ReachabilityChanged,
                   object: reachability)
        
        reachability.startNotifier()
//      do{
//        try
//      } catch {
//        debugPrint("Could not start reachability notifier")
//      }
    }
    
    func stopMonitoring(){
       reachability.stopNotifier()
       NotificationCenter.default.removeObserver(self,
                                                 name: Notification.Name.ReachabilityChanged,
                   object: reachability)
//        reachabilityChangedEvent = nil
    }
}
