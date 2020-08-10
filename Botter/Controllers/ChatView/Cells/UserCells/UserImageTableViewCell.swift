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
        self.msgImage?.image = UIImage()
        msg.lazyImage.setCacheSize(self.msgImage?.frame.size)
        DispatchQueue.main.async {
            self.msg.lazyImage.show(imageView: self.msgImage!, url: self.msg.mediaUrl) { (lazyError) in
                //            print(lazyError?.localizedDescription)
            }
        }
        
    }
    
    override func prepareForReuse() {
        self.msg = b_BasicMessage()
        self.msgImage?.image = nil
    }
}
