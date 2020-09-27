//
//  SocketManager.swift
//  Botter
//
//  Created by Nora on 6/2/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit
//import Starscream

class B_SocketManager : WebSocketDelegate  {
    
    static var shared : B_SocketManager! = B_SocketManager()
    var messageRecieved:((b_BasicMessage)->())!
    var historyLoaded:(([b_BasicMessage])->())!
    var connectionUpdated:(()->())!
    private var socket: WebSocket!
    var timer : Timer!
    var pingCheck = true
    var channel = "mobile-ios"
    var attributes : [[String:Any]]!
    var sendOpening = true
    var isConnected = false {
        didSet{
            if !isConnected{
                timer.invalidate()
            }
            if connectionUpdated != nil {
                connectionUpdated()
            }
        }
    }
    
    init(){
        guid = getUserId()
        b_ReachabilityManager.shared.startMonitoring()
        b_ReachabilityManager.shared.reachabilityChangedEvent = {
            if !self.isConnected && b_ReachabilityManager.shared.isNetworkAvailable{
                self.connect()
            }
            print(b_ReachabilityManager.shared.isNetworkAvailable)
            self.isConnected = b_ReachabilityManager.shared.isNetworkAvailable
        }
    }
    
    //    let server = WebSocketServer()
    private var guid : String = ""
    
    static var first = true
    
    func getUserId()->String{
        //        if let id = UserDefaults.standard.value(forKey: "guid") as? String{
        //            return id
        //        }else{
        //            let id = UUID().uuidString
        //            UserDefaults.standard.set(id, forKey: "guid")
        //            return id
        //        }
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    func connect(){
        //        if socket != nil{
        //            socket.disconnect()
        //        }
        
        var request = URLRequest(url: URL(string: BaseDataSource.Constants.SOCKET_URL)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: {timer in
            if self.pingCheck{
                self.socket.write(ping: "PING".data(using: .utf8)!)
                self.pingCheck = false
            }else{
                self.isConnected = false
                self.socket.disconnect()
                self.socket.connect()
            }
        })
        
    }
    
    func connectionUpdates(canSend: Bool) {
        isConnected = canSend
    }
    
    
    
    internal
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            pingCheck = true
            print("websocket is connected: \(headers)")
            if sendOpening {
                sendOpeningMessage()
                sendOpening = false
            }
            
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            handleMessage(msg: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            pingCheck = true
            if !isConnected{
                connect()
            }
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            self.connect()
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    
    
    deinit {
        if socket != nil{
            socket.disconnect()
        }
        b_ReachabilityManager.shared.stopMonitoring()
    }
    
    func dissConnect() {
        socket.disconnect()
    }
    
    func sendAttrebutes(attributes : [[String:Any]]){
        let msg = ["bot_id": BotterSettingsManager.BotID ,
                   "channel": channel ,
                   "type": "set_attributes",
                   "user": guid ,
                   "attributes": attributes] as [String : Any]
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected{
                self.socket.write(string: msgString)
                //                self.sendOpeningMessage()
            }
        }
    }
    
    func sendOpeningMessage(){
        let isFirst = B_SocketManager.first && !ChatSessionManager.shared.hasActiveSession()
        let msg = ["bot_id": BotterSettingsManager.BotID ,
                   "channel": channel ,
                   "type": isFirst  ? "hello"  : "welcome_back",
                   "user": guid ,
                   "user_profile": ""]
        let msgString = json(from: msg) ?? ""
//        ChatSessionManager.shared.setActiveSession(active: true)
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected{
                self.socket.write(string: msgString)
                B_SocketManager.self.first = false
                if self.attributes != nil{
                    self.sendAttrebutes(attributes: self.attributes)
                }
            }
        }
    }
    
    func endSession(){
        let msg = ["bot_id": BotterSettingsManager.BotID ,
                   "channel": channel ,
                   "type":  "end_conversation",
                   "user": guid ,
                   "user_profile": ""]
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected{
                self.socket.write(string: msgString)
            }
        }
        
        B_SocketManager.first = true
        B_SocketManager.shared = B_SocketManager()
    }
    
    func sendMessage(text : String , completion:@escaping((Bool)->())){
        let msg = ["bot_id": BotterSettingsManager.BotID ,
                   "channel": channel ,
                   "type": "message" ,
                   "text" : text ,
                   "user": guid ,
                   "slug" : "message" ,
                   "user_profile": ""]
        
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected {
                self.socket.write(string: msgString) {
                    DispatchQueue.main.async {
                        // your code here
                        completion(self.isConnected && b_ReachabilityManager.shared.isNetworkAvailable)
                    }
                }
            }
        }
        
    }
    
    func sendUserLocation(latitude : Double , langtude : Double,  completion:@escaping((Bool)->())){
        let msg = [
            "bot_id": BotterSettingsManager.BotID ,
            "channel": channel ,
            "type": "message" ,
            "latitude" : latitude,
            "langtude": langtude,
            "user": guid ,
            "slug" : "user_location" ,
            "user_profile": ""] as [String : Any]
        
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected {
                self.socket.write(string: msgString) {
                    DispatchQueue.main.async {
                        // your code here
                        completion(self.isConnected && b_ReachabilityManager.shared.isNetworkAvailable)
                    }
                }
            }
        }
        
    }
    
    func sendAttachment(file : b_AttachedFile , completion:@escaping((Bool)->())){
        
        let dataStr =  ["attachment_type" : file.type ,
                        "type": "attachment" ,
                        "url" : file.url ,
        ]
        var msg = ["bot_id": BotterSettingsManager.BotID ,
                   "channel": channel ,
                   "user": guid ,
                   "type":"message" ,
                   "text" : json(from: dataStr) ?? "" ,
                   "slug" : file.type == "image" ? "image_attachment" : "attachment" ,
                   "user_profile": ""] as [String : Any]
        
        if file.type != "image"{
            msg["file_name"] = file.name
        }
        
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected {
                self.socket.write(string: msgString) {
                    DispatchQueue.main.async {
                        // your code here
                        completion(self.isConnected && b_ReachabilityManager.shared.isNetworkAvailable)
                    }
                }
            }
        }
        
    }
    
    
    func sendPostBack(value : String , title : String , slug : String = "" , completion:@escaping((Bool)->())){
        //        if isConnected {
        let msg : [String : Any] = [
            "type": "message" ,
            "channel": channel ,
            "slug" : slug ,
            "text" : value,
            "user": guid ,
            "postback": ["title" : title , "payload" : value ],
            "bot_id": BotterSettingsManager.BotID ,
        ]
        
        let msgString = json(from: msg) ?? ""
        //            socket.write(string: msgString)
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            self.socket.write(string: msgString) {
                DispatchQueue.main.async {
                    // your code here
                    completion(self.isConnected && b_ReachabilityManager.shared.isNetworkAvailable)
                }
            }
        }
        //        }else{
        //            connect()
        //            sendPostBack(value: value)
        //        }
    }
    
    func handleMessage(msg : String){
        let messageJson = convertToJSON(text: msg) ?? [:]
        let msgObj = b_BasicMessage.getMessage(dict: messageJson)
        if msgObj.msgType == .none{
            let history = b_History.getHistory(dict: messageJson)
            if self.historyLoaded != nil{
                historyLoaded(history.list)
            }
        }else{
            if self.messageRecieved != nil{
                messageRecieved(msgObj)
            }
        }
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func convertToJSON(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
