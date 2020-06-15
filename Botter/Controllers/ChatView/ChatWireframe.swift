//
//  ChatWireframe.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright (c) 2020 BlueCrunch. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import AVKit

final class ChatWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = ChatViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
        super.init(viewController: moduleViewController)

        let interactor = ChatInteractor()
        let presenter = ChatPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
        interactor.presenter = presenter
    }

}

// MARK: - Extensions -

extension ChatWireframe: ChatWireframeInterface {
    
    func openVideo(url: String) {
        if url.isYoutubeLink(){
            openUrl(url: url)
        }else{
            let nURL = url.replacingOccurrences(of: "http:", with: "https:")
            if let vedioURL =  URL.init(string: nURL) {
                let player = AVPlayer(url:vedioURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                
                let windows = UIApplication.shared.windows
                if let floatingWindow = windows.last(where:  { (window) -> Bool in
                    window is FloatingButtonWindow
                }){
                    if let currentVC = (floatingWindow as? FloatingButtonWindow)?.visibleViewController{
                        currentVC.present(playerViewController, animated: true) {
                            player.play()
                        }
                    }
                }
                
                
            }
        }
    }
    
    func openUrl(url: String) {
//        WebLinksViewController.openInParent(link: url, parent: self.viewController)
        if let url = URL(string: url) {
//            UIApplication.shared.open(url)
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func call(number: String) {
        self.viewController.makePhoneCall(phoneNumber: number)
    }
}

