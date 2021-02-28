//
//  PlaySound.swift
//  Botter
//
//  Created by Nora on 9/30/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import AVFoundation

internal class PlaySound{
    private static var player: AVAudioPlayer?
    
    
    static func incomingMsg(){
        guard let url = MyFrameworkBundle.bundle.url(forResource: "incoming" , withExtension: "mp3") else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            // your code here
            playSound(url: url)
        }
    }
    
    static func typing(){
        guard let url = MyFrameworkBundle.bundle.url(forResource: "typing", withExtension: "mp3") else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            // your code here
            playSound(url: url)
        }
        
    }
    
    static func stop(){
//        if player != nil && player?.isPlaying ?? false{
//            player?.stop()
//        }
    }
    
    private static func playSound(url : URL) {

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
