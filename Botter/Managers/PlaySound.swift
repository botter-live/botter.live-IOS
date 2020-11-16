//
//  PlaySound.swift
//  Botter
//
//  Created by Nora on 9/30/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import AVFoundation

class PlaySound : NSObject{
    private static var player: AVAudioPlayer?
    private static var shared = PlaySound()
    private static var waitingList = [String]()
    private static var isLoading = false
    
    static func incomingMsg(){
        guard let url = MyFrameworkBundle.bundle.url(forResource: "incoming" , withExtension: "mp3") else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            // your code here
            if chatScreenIsActive() &&  !isPlaying(){
                playSound(url: url)
            }
        }
    }
    
    static func typing(){
        guard let url = MyFrameworkBundle.bundle.url(forResource: "typing", withExtension: "mp3") else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            // your code here
            
            if chatScreenIsActive() &&  !isPlaying(){
                playSound(url: url)
            }
        }
    }
    
    static func stop(){
        if isPlaying(){
            player?.stop()
            player = nil
        }else{
//            player = nil
        }
    }
    
    private static func isPlaying()->Bool{
      return player != nil && (player?.isPlaying ?? false)
    }
    
    static func playerIsBusy()->Bool{
        return isPlaying() || isLoading
    }
    
    private static func playSound(url : URL) {

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default , options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
           
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }
            player.delegate = PlaySound.shared
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func textToSpeech(text : String){
        isLoading = true
        let dataSource = TextToSpeechDataSource()
        dataSource.getVoiceFile(text: text) { (status, response) in
            isLoading = false
            switch status {
            case .sucess:
                let fileStr = response as? String ?? ""
                if chatScreenIsActive(){
                    playAudio(audioStr: fileStr)
                }
                break
            case .networkError , .error:
                break
            }
        }
    }
    
    private static func playAudio(audioStr : String){
        do {
                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default , options: [.mixWithOthers])
                try AVAudioSession.sharedInstance().setActive(true)
                let audioData: Data! = Data(base64Encoded: audioStr, options: .ignoreUnknownCharacters)
                //print(track)
                if audioData != nil {
                    player = try AVAudioPlayer(data: audioData)
                    guard let player = player else { return }
                    player.delegate = PlaySound.shared
                    player.play()
                    print("is playing:", player.isPlaying)
                    print(player.duration)
                }
                else {
                    print("Data Not Exist")
                }
            }
            catch {
                print("didnt work 2")
                NSLog("Unresolved error \(error.localizedDescription)")
                // SHOW ALERT OR SOMETHING
            }
    }
    
}
extension PlaySound : AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        PlaySound.stop()
        B_SocketManager.shared.checkWaitingList()
    }
    
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer){
        print("audioPlayerBeginInterruption")
    }
    
    func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int){
        print("audioPlayerEndInterruption")
    }
}
