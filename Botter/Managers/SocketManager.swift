//
//  SocketManager.swift
//  Botter
//
//  Created by Nora on 6/2/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
//import Starscream

class SocketManager : WebSocketDelegate  {
    
    static var shared : SocketManager! = SocketManager()
    var messageRecieved:((BasicMessage)->())!
    var connectionUpdated:(()->())!
    private var socket: WebSocket!
    var timer : Timer!
    var pingCheck = true
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
        ReachabilityManager.shared.startMonitoring()
        ReachabilityManager.shared.reachabilityChangedEvent = {
            if !self.isConnected && ReachabilityManager.shared.isNetworkAvailable{
                self.connect()
            }
            print(ReachabilityManager.shared.isNetworkAvailable)
            self.isConnected = ReachabilityManager.shared.isNetworkAvailable
        }
    }
    
    //    let server = WebSocketServer()
    private let guid : String = UUID().uuidString
    
    private var first = true
    
    func connect(){
        //        if socket != nil{
        //            socket.disconnect()
        //        }
        var request = URLRequest(url: URL(string: "wss://botter-gateway-web.botter.live/")!)
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
            sendOpeningMessage()
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
        socket.disconnect()
        ReachabilityManager.shared.stopMonitoring()
    }
    
    func dissConnect() {
        socket.disconnect()
    }
    
    func sendOpeningMessage(){
        let msg = ["bot_id": "nKmovPCdWNZdYnIejRnd" ,
                   "channel": "socket" ,
                   "type": first ? "hello"  : "welcome_back",
                   "user": guid ,
                   "user_profile": ""]
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected{
                self.first = false
                self.socket.write(string: msgString)
            }
        }
    }
    
    func sendMessage(text : String , completion:@escaping((Bool)->())){
        let msg = ["bot_id": "nKmovPCdWNZdYnIejRnd" ,
                   "channel": "socket" ,
                   "type": "message" ,
                   "text" : text ,
                   "user": guid ,
                   "user_profile": ""]
        
        let msgString = json(from: msg) ?? ""
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            if self.isConnected {
                self.socket.write(string: msgString) {
                    DispatchQueue.main.async {
                        // your code here
                        completion(self.isConnected && ReachabilityManager.shared.isNetworkAvailable)
                    }
                }
            }
        }
        
    }
    
    func sendPostBack(value : String , completion:@escaping((Bool)->())){
        //        if isConnected {
        let msg : [String : Any] = [
            "type": "message" ,
            "text" : value,
            "user": guid ,
            "bot_id": "nKmovPCdWNZdYnIejRnd" ,
        ]
        
        let msgString = json(from: msg) ?? ""
        //            socket.write(string: msgString)
        self.socket.write(ping: "PING".data(using: .utf8)!) {
            self.socket.write(string: msgString) {
                DispatchQueue.main.async {
                    // your code here
                    completion(self.isConnected && ReachabilityManager.shared.isNetworkAvailable)
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
        let msgObj = BasicMessage.getMessage(dict: messageJson)
        
        if self.messageRecieved != nil{
            messageRecieved(msgObj)
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