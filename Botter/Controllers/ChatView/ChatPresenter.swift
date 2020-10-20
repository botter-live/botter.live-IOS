//
//  ChatPresenter.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright (c) 2020 BlueCrunch. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class b_ChatPresenter {
    
    // MARK: - Private properties -
    
    private unowned var view: ChatViewInterface
    private var interactor: ChatInteractorInterface
    private var wireframe: ChatWireframeInterface
    
    var messgesList : [b_BasicMessage]!
    
    // MARK: - Lifecycle -
    
    init(view: ChatViewInterface, interactor: ChatInteractorInterface, wireframe: ChatWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.messgesList = [b_BasicMessage]()
    }
    

    func close(){
        interactor = b_ChatInteractor()
        wireframe = b_ChatWireframe(botData: b_BotData())
        B_SocketManager.shared.messageRecieved = nil
    }
}

// MARK: - Extensions -

extension b_ChatPresenter: ChatPresenterInterface {
    
    
    func openSocket() {
        self.interactor.openSocket()
        B_SocketManager.shared.connectionUpdated = {
            //            DispatchQueue.main.async {
            self.view.connectionUpdated(isConnected: B_SocketManager.shared.isConnected)
            //            }
            
        }
    }
    
    func messageReceived(message: b_BasicMessage , isHistory : Bool = false) {
        
        messgesList = messgesList.filter { (msg) -> Bool in
            msg.msgType != .typing
        }
        if message.msgType == .flightStatus{
            if message.flighStatus.introMessage != ""{
                let nMessage = b_BasicMessage()
                //                nMessage = message
                nMessage.msgType = .text
                nMessage.text = message.flighStatus.introMessage
                nMessage.msgIndex = messgesList.count
                messgesList.append(nMessage)
            }
        }
        message.msgIndex = messgesList.count
        if messgesList.count > 0 && messgesList[messgesList.count - 1].msgType == .userInput && !messgesList[messgesList.count - 1].prompt.answered {
            setUserInputAnswer(newMsg: message)
        }else{
            messgesList.append(message)
        }
        
        if message.msgType == .audio{
            b_AudioHandler.shared.addAudioMessage(msg: message)
        }
        
        self.view.reload()
        
        
        if isHistory{
            
        }else if message.msgType == .typing{
            PlaySound.typing()
        }else if message.msgType == .hero{
            PlaySound.textToSpeech(text: message.text)
        }else if message.sender.senderType != .user{
            PlaySound.incomingMsg()
        }
    }
    
    func setUserInputAnswer(newMsg : b_BasicMessage){
        let msg = messgesList[messgesList.count - 1]
        if msg.prompt.typeString.lowercased() == "file"{
            msg.prompt.type = newMsg.msgType
            if newMsg.msgType == .attachment{
                messgesList[messgesList.count - 1].prompt.answerText = newMsg.text
            }else{
                messgesList[messgesList.count - 1].prompt.answerText = newMsg.mediaUrl
            }
        }else{
            messgesList[messgesList.count - 1].prompt.answerText = newMsg.text
        }
        messgesList[messgesList.count - 1].prompt.answered = msg.msgSent
    }
    
    func historyLoaded(list: [b_BasicMessage]) {
        for msg in list{
            NotificationManager.shared.clear()
            messageReceived(message: msg , isHistory: true)
        }
    }
    
    func sendMessage(text: String) {
        self.interactor.sendMessage(text: text, completion: { Message in
            
            self.messageReceived(message: Message)
        })
    }
    
    func sendAttachment(file: b_AttachedFile) {
        self.interactor.sendAttachment(file: file) { (msg) in
            self.messageReceived(message: msg)
        }
    }
    
    func clearTextBox() {
        self.view.clearTextBox()
    }
    
    func showError(errorMsg: String) {
        self.view.showError(errorMsg: errorMsg)
    }
    
    func openVideo(url: String) {
        self.wireframe.openVideo(url: url)
    }
    
    func actionClicked(action: b_Action) {
        interactor.actionClicked(action: action)
    }
    
    func triviaActionClicked(action: b_Action) {
        interactor.triviaMessage(action: action) { (msg) in
            self.messageReceived(message: msg)
            //            if let last = self.messgesList.last{
            //                if last.msgType != .dateTime{
            //                    self.messgesList[action.msgIndex].actions.removeAll()
            //                }
            //            }
            self.messgesList[action.msgIndex].actions.removeAll()
            self.view.reload()
        }
        
    }
    
    func resend(msg: b_BasicMessage) {
        interactor.resend(msg: msg) { (isSent) in
            self.messgesList[msg.msgIndex].msgSent = isSent
            self.view.reload()
        }
        
    }
    
    func openUrl(url: String) {
        wireframe.openUrl(url: url)
    }
    
    func call(number: String) {
        wireframe.call(number: number)
    }
    
    func openEndForm(form: b_Form , isHistory : Bool) {
        wireframe.openEndForm(form: form, isHistory: isHistory)
    }
    
    func sendMenuAction(action : b_MenuItem){
        self.interactor.sendMenuAction(action: action) { (msg) in
            self.messageReceived(message: msg)
            self.view.reload()
        }
    }
    
    func sendUserLocation(latitude: Double, langtuide: Double) {
        self.interactor.sendUserLocation(latitude: latitude, langtuide: langtuide) { (Message) in
            self.messageReceived(message: Message)
        }
    }
    
    func endSession() {
        self.interactor.endSession()
    }
}
