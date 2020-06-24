//
//  AudioHandler.swift
//  Botter
//
//  Created by Nora on 6/10/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class MyAudio : AudioItem{
    var message = BasicMessage()
}

class AudioHandler{
    
    static var shared = AudioHandler()
    
    var player = AudioPlayer()
    var playPausePressed : ((Int)->())!
    var audios = [MyAudio]()
    var current : AudioBotTableViewCell!
    
    init(){
        player.delegate = self
        //        player.shouldResumePlaying = true
    }
    
    func addAudioMessage(msg:BasicMessage){
        if let item = MyAudio(mediumQualitySoundURL: URL.init(string: msg.mediaUrl)){
            msg.audioIndex = audios.count
            item.message = msg
            audios.append(item)
            player.add(item: item)
            print("audio count : \(player.items?.count)")
        }
    }
    
    func seekTo(_ value : Float , cell : AudioBotTableViewCell ){
        if current != nil && cell.msg.msgIndex == current.msg.msgIndex {
            player.seek(to: TimeInterval(value))
        }else{
            playPausePressed(cell: cell)
        }
    }
    
    func playPausePressed(cell : AudioBotTableViewCell){
        print("audio count : \(player.items?.count)")
        if player.items?.count ?? 0 == 0{
            player.add(items: audios)
        }
        if current != nil && cell.msg.msgIndex == current.msg.msgIndex{
            if player.state == .playing{
                player.pause()
//                current = nil
            }else{
                player.resume()
            }
        }else if current != nil{
            player.pause()
            current.setDuration()
            AudioHandler.setImage(state: player.state , cell: current)
            current = cell
            if let item = audios.last(where: {$0.message.msgIndex == cell.msg.msgIndex}){
                player.play(item: item)
                AudioHandler.setImage(state: player.state , cell: current)
            }
        }else{
            current = cell
            if let item = audios.last(where: {$0.message.msgIndex == cell.msg.msgIndex}){
                player.play(item: item)
                AudioHandler.setImage(state: player.state , cell: current)
            }
        }
    }
}
extension AudioHandler : AudioPlayerDelegate{
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
        if current != nil{
            AudioHandler.setImage(state: state, cell: current)
        }
        
        switch state {
        case .playing:
            print("Playing")
            break
        default:
            break
        }
    }
    
    static func setImage(state : AudioPlayerState , cell : AudioBotTableViewCell){
        cell.imageBtn.isHidden = false
        cell.progress.isHidden = true
        //        MyFrameworkBundle.bundle
        let pause = UIImage(named:  "pauseIcon" , in: MyFrameworkBundle.bundle , compatibleWith: nil)
        let play = UIImage(named:   "playIcon", in: MyFrameworkBundle.bundle, compatibleWith: nil)
        if AudioHandler.shared.current != nil && cell.msg.msgIndex == AudioHandler.shared.current.msg.msgIndex{
            switch state {
            case .buffering , .waitingForConnection:
                cell.imageBtn.isHidden = true
                cell.progress.isHidden = false
                cell.imageBtn.setImage(play, for: .normal)
                break
            case .failed:
                cell.imageBtn.setImage(play, for: .normal)
                break
            case .paused:
                cell.imageBtn.setImage(play, for: .normal)
                break
            case .playing:
                cell.imageBtn.setImage(pause, for: .normal)
                break
            case .stopped:
                cell.setDuration()
                cell.imageBtn.setImage(play, for: .normal)
                break
            }
        }else{
            cell.imageBtn.setImage(play, for: .normal)
        }
    }
    
   
    
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        if current != nil{
            if Float(player.currentItemProgression!) > current.seekBar.value{
                current.seekBar.value = Float(player.currentItemProgression!)
                current.textLbl.text = player.currentItemProgression!.asString(style: .positional) +  "  /  " + player.currentItemDuration!.asString(style: .positional)
            }
        }
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateEmptyMetadataOn item: AudioItem, withData data: Metadata) {
        print(data)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didLoad range: TimeRange, for item: AudioItem) {
        
    }
    
    
    func audioPlayer(_ audioPlayer: AudioPlayer, willStartPlaying item: AudioItem) {
         
        if current != nil {
            if self.current.seekBar.value > 0 {
                audioPlayer.seek(to: TimeInterval(self.current.seekBar.value))
            }else{
               
            }
        }else{
            player.stop()
        }
    }
}
