//
//  AudioHandler.swift
//  Botter
//
//  Created by Nora on 6/10/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import AVFoundation

extension  ChatViewController{
    
}

extension AVPlayer  {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

class Player : NSObject {
    
    static var shared = Player()
    var player: AVPlayer?
    var audio: BasicMessage?
    var playerItem : AVPlayerItem?
    var durationDetected : ((Double)->())!
    
    override init() {
        audio = nil
    }
    
    func currentlyPlaying() -> BasicMessage? {
        return audio
    }
    
    func setAudio(this audio: BasicMessage ){
        do {
            guard let url = URL.init(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3") else { return }
            //try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.removeObserver(player!, forKeyPath: "status")
            player?.addObserver(self , forKeyPath: "status", options: .new, context: nil)
            self.audio = audio
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func play() {
        stop()
        player?.play()
    }
    
    func stop() {
        player?.pause()
//        player = nil
        
        self.audio = nil
    }
    
    func pause(){
        player?.pause()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if player?.status == .readyToPlay {
                print(player?.currentItem?.duration)
                print(CMTimeGetSeconds((player?.currentItem?.duration)!))
                if durationDetected != nil{
//                    print("duration :\(player!.currentItem.duration.seconds)")
                    durationDetected(CMTimeGetSeconds((player?.currentItem?.duration)!))
                }
                
                //          let videoLength = CMTimeGetSeconds((player?.currentItem?.duration)!)
                //          videoProgressSlider.maximumValue = Float(videoLength)
            }
        }
    }
}
public extension CharacterSet {

    static let urlQueryParameterAllowed = CharacterSet.urlQueryAllowed.subtracting(CharacterSet(charactersIn: "&?"))

    static let urlQueryDenied           = CharacterSet.urlQueryAllowed.inverted()
    static let urlQueryKeyValueDenied   = CharacterSet.urlQueryParameterAllowed.inverted()
    static let urlPathDenied            = CharacterSet.urlPathAllowed.inverted()
    static let urlFragmentDenied        = CharacterSet.urlFragmentAllowed.inverted()
    static let urlHostDenied            = CharacterSet.urlHostAllowed.inverted()

    static let urlDenied                = CharacterSet.urlQueryDenied
        .union(.urlQueryKeyValueDenied)
        .union(.urlPathDenied)
        .union(.urlFragmentDenied)
        .union(.urlHostDenied)


    func inverted() -> CharacterSet {
        var copy = self
        copy.invert()
        return copy
    }
}



public extension String {
    func urlEncoded(denying deniedCharacters: CharacterSet = .urlDenied) -> String? {
        return addingPercentEncoding(withAllowedCharacters: deniedCharacters.inverted())
    }
}
