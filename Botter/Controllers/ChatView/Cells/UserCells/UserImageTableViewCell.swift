//
//  UserImageTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/29/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class UserImageTableViewCell: UserChatTableViewCell {
    
    @IBOutlet weak var msgImage : UIImageView?
    @IBOutlet weak var actionBtn : UIButton?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     func setData(msg: b_BasicMessage) {
        super.setData(msg: msg)
        self.msgImage?.image = nil
        if msg.slug == "user_location"{
             self.msg.lazyImage.show(imageView: self.msgImage!, url:
             "https://2ab9pu2w8o9xpg6w26xnz04d-wpengine.netdna-ssl.com/wp-content/uploads/staticmaps/s/373149-static-lounge/static-lounge-map-large.png") { (lazyError) in
                        }
            actionBtn?.isHidden = false
        }else{
            actionBtn?.isHidden = true
            msg.lazyImage.setCacheSize(self.msgImage?.frame.size)
            self.msg.lazyImage.show(imageView: self.msgImage!, url: self.msg.mediaUrl) { (lazyError) in
        }
    }
        
    }
    
    @IBAction func openMaps(){
      if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app

        if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(String(describing: msg.latitude)),\(String(describing: msg.langtude))&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])
           }
      else {
             //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(String(describing: msg.latitude)),\(String(describing: msg.langtude))&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
               }
            }
        }
    }
    
   override func prepareForReuse() {
          self.msg = b_BasicMessage()
          self.msgImage?.image = nil
      }
}
