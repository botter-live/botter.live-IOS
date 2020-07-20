//
//  ChatInterfaces.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright (c) 2020 BlueCrunch. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol ChatWireframeInterface: WireframeInterface {
    func openVideo(url : String)
    func openUrl(url : String)
    func call(number: String)
    func openEndForm(form : Form)
}

protocol ChatViewInterface: ViewInterface {
    func reload()
    func clearTextBox()
    func showError(errorMsg : String)
    func connectionUpdated(isConnected : Bool)
    
}

protocol ChatPresenterInterface: PresenterInterface {
    var messgesList : [BasicMessage]! { get set }
    func openSocket()
    func messageReceived(message : BasicMessage)
    func sendMessage(text : String)
    func clearTextBox()
    func showError(errorMsg : String)
    func openVideo(url : String)
    func actionClicked(action : Action)
    func openUrl(url : String)
    func call(number: String)
    func triviaActionClicked(action: Action)
    func resend(msg : BasicMessage)
    func openEndForm(form : Form)
}

protocol ChatInteractorInterface: InteractorInterface {
    func openSocket()
    func sendMessage(text : String , completion:@escaping((BasicMessage)->()))
    func actionClicked(action : Action)
    func triviaMessage(action : Action , completion:@escaping((BasicMessage)->()))
    func resend(msg: BasicMessage , completion:@escaping((Bool)->()))
    
}
