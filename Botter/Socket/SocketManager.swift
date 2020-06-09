//
//  SocketManager.swift
//  Botter
//
//  Created by Nora on 6/2/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
//import Starscream

class SocketManager : WebSocketDelegate {
   
    static var shared = SocketManager()
    var messageRecieved:((BasicMessage)->())!
    
    private var socket: WebSocket!
    var isConnected = false
//    let server = WebSocketServer()
    private let guid : String = UUID().uuidString
    
    private var first = true
    
    func connect(){
        var request = URLRequest(url: URL(string: "wss://botter-gateway-web.botter.live/")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    internal
    func didReceive(event: WebSocketEvent, client: WebSocket) {
           switch event {
           case .connected(let headers):
               isConnected = true
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
               break
           case .viabilityChanged(_):
               break
           case .reconnectSuggested(_):
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
        first = false
        socket.write(string: msgString)
    }
    
    func sendMessage(text : String){
        let msg = ["bot_id": "nKmovPCdWNZdYnIejRnd" ,
                   "channel": "socket" ,
                   "type": "message" ,
                   "text" : text ,
                   "user": guid ,
                   "user_profile": ""]
        
        let msgString = json(from: msg) ?? ""
        socket.write(string: msgString)
    }
    
    func sendPostBack(value : String){
        let msg : [String : Any] = [
                   "type": "message" ,
                   "text" : value,
                   "user": guid ,
                   "bot_id": "nKmovPCdWNZdYnIejRnd" ,
                   ]
        
        let msgString = json(from: msg) ?? ""
        socket.write(string: msgString)
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
