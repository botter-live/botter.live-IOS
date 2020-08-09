//
//  BotChatTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class BotChatTableViewCell: UserChatTableViewCell {
    
    @IBOutlet weak var botIcon : UIView!
    @IBOutlet weak var avatarImg : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var iFrame = self.avatarImg.frame
        iFrame.size = CGSize.init(width: 32, height: 32)
        self.avatarImg.frame = iFrame
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(msg : BasicMessage , showIcon : Bool = false){
        super.setData(msg : msg , showIcon: showIcon)
        self.msg = msg
        botIcon.isHidden = !showIcon
        
        if avatarImg != nil{
            if showIcon && msg.sender.senderType == .agent{
                switch msg.sender.avatarType {
                case .base64:
                    getBase64Imag()
                    break
                case .url:
                    setAvatarByUrl()
                case.empty:
                    setAvatar()
                    break
                }
            }else{
                self.avatarImg.image = BotterSettingsManager.logo
                self.avatarImg.contentMode = .center
//                setAvatar()
            }
        }
    }
    
    func setAvatar(){
        self.avatarImg.image = BotterSettingsManager.agentAvatar
        self.avatarImg.contentMode = .scaleAspectFit
    }
    
    func setAvatarByUrl(){
        setAvatar()
        DispatchQueue.main.async {
            self.msg.lazyImage.show(imageView: self.avatarImg, url: self.msg.sender.avatar) { (error) in
                if error == nil {
                    self.avatarImg.contentMode = .scaleAspectFill
                }
            }
        }
    }
    
    func getBase64Imag(){
        if let dataDecoded:NSData = NSData(base64Encoded: self.msg.sender.avatar, options: NSData.Base64DecodingOptions(rawValue: 0)){
            if let decodedimage:UIImage = UIImage(data: dataDecoded as Data){
                print(decodedimage)
                DispatchQueue.main.async {
                    self.avatarImg.image = decodedimage
                    self.avatarImg.contentMode = .scaleAspectFill
                }
            }else{
                setAvatar()
            }
        }else{
            setAvatar()
        }
    }
    
}
