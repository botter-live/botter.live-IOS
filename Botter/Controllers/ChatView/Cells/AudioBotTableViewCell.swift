//
//  AudioBotTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/10/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
//import KDEAudioPlayer

class AudioBotTableViewCell: BotChatTableViewCell {

    @IBOutlet weak var imageBtn : UIButton!
    @IBOutlet weak var actionBtn : UIButton!
    @IBOutlet weak var seekBar : UISlider!
    @IBOutlet weak var progress : UIActivityIndicatorView!
    
//    var player = Player()
    var player = AudioPlayer()
    var playPausePressed : ((Int)->())!
    var isCurrent = false
    var durationTxt = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setData(msg: BasicMessage, showIcon: Bool = false ,isCurrent: Bool , index : Int){
        super.setData(msg: msg, showIcon: showIcon)
        imageBtn.tag = index
        //set image
        self.isCurrent = isCurrent
        player.delegate = self
        seekBar.value = 0
//        let item = AudioItem(mediumQualitySoundURL: URL.init(string: msg.mediaUrl))
        //        player.currentItem = item
//        player.play(item: item!)
        self.setDuration()
        self.msg.foundDuration = {
            self.setDuration()
        }
        setImage(state: player.state)
    }
    
    @IBAction func buttonTapped(){
        imageBtn.isHidden = false
        progress.isHidden = true
        switch player.state {
        case .buffering , .waitingForConnection:
            progress.isHidden = false
            imageBtn.isHidden = true
            break
        case .failed:
            let item = AudioItem(mediumQualitySoundURL: URL.init(string: msg.mediaUrl))!
            player.play(item: item)
            break
        case .paused:
            player.resume()
            break
        case .playing:
            player.stop()
            break
        case .stopped:
            let item = AudioItem(mediumQualitySoundURL: URL.init(string: msg.mediaUrl))!
            player.play(item: item)
            break
        }
 
        if playPausePressed != nil {
            playPausePressed(imageBtn.tag)
        }
    }

    
    override func prepareForReuse() {
//        player = AudioPlayer()
        player.delegate = nil
        durationTxt = ""
        
    }
    
    func setDuration(){
        durationTxt = msg.audioDuration.asString(style: .positional)
        textLbl.text = durationTxt
        seekBar.maximumValue = Float(msg.audioDuration)
        seekBar.value = 0
    }
    
    @IBAction func seekBarValueChanded(_ sender : UISlider){
        if isCurrent {
            player.seek(to: TimeInterval(sender.value))
        }else if player.currentItem != nil {
            player.seek(to: TimeInterval(sender.value))
        }else{
            let item = AudioItem(mediumQualitySoundURL: URL.init(string: msg.mediaUrl))!
            player.play(item: item)
            if playPausePressed != nil {
                playPausePressed(imageBtn.tag)
            }
            
            player.seek(to: TimeInterval(sender.value))
        }
    }

}
extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = style
    formatter.zeroFormattingBehavior = .pad
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
    
}
extension AudioBotTableViewCell : AudioPlayerDelegate{
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
      setImage(state: state)
    }
    
    func setImage(state : AudioPlayerState){
        imageBtn.isHidden = false
        progress.isHidden = true
//        MyFrameworkBundle.bundle
        let pause = UIImage(named:  "pauseIcon" , in: MyFrameworkBundle.bundle , compatibleWith: nil)
        let play = UIImage(named:   "playIcon", in: MyFrameworkBundle.bundle, compatibleWith: nil)
        switch state {
        case .buffering , .waitingForConnection:
            imageBtn.isHidden = true
            progress.isHidden = false
            imageBtn.setImage(play, for: .normal)
            break
        case .failed:
            imageBtn.setImage(play, for: .normal)
            break
        case .paused:
            imageBtn.setImage(play, for: .normal)
            break
        case .playing:
            imageBtn.setImage(pause, for: .normal)
            break
        case .stopped:
            setDuration()
            imageBtn.setImage(play, for: .normal)
            break
        }
    }
    
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        seekBar.value = Float(player.currentItemProgression!)
        textLbl.text = player.currentItemProgression!.asString(style: .positional) +  "  /  " + player.currentItemDuration!.asString(style: .positional)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateEmptyMetadataOn item: AudioItem, withData data: Metadata) {
        print(data)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didLoad range: TimeRange, for item: AudioItem) {
        
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, willStartPlaying item: AudioItem) {
        if !isCurrent {
            audioPlayer.stop()
        }
    }
}
