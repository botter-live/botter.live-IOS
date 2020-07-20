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

final class ChatPresenter {

    // MARK: - Private properties -

    private unowned let view: ChatViewInterface
    private let interactor: ChatInteractorInterface
    private let wireframe: ChatWireframeInterface

    var messgesList : [BasicMessage]!
    
    // MARK: - Lifecycle -

    init(view: ChatViewInterface, interactor: ChatInteractorInterface, wireframe: ChatWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.messgesList = [BasicMessage]()
    }
}

// MARK: - Extensions -

extension ChatPresenter: ChatPresenterInterface {
    func openSocket() {
        self.interactor.openSocket()
        SocketManager.shared.connectionUpdated = { 
            self.view.connectionUpdated(isConnected: SocketManager.shared.isConnected)
        }
    }
    
    func messageReceived(message: BasicMessage) {
        messgesList = messgesList.filter { (msg) -> Bool in
            msg.msgType != .typing
        }
        message.msgIndex = messgesList.count
        messgesList.append(message)
        if message.msgType == .audio{
            AudioHandler.shared.addAudioMessage(msg: message)
        }
        self.view.reload()
    }
    
    func sendMessage(text: String) {
        self.interactor.sendMessage(text: text, completion: { Message in
            
            self.messageReceived(message: Message)
        })
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
    
    func actionClicked(action: Action) {
        interactor.actionClicked(action: action)
    }
    
    func triviaActionClicked(action: Action) {
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
    
    func resend(msg: BasicMessage) {
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
    
    func openEndForm(form: Form) {
        wireframe.openEndForm(form: form)
    }
    
}
