//
//  BotChatTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import LazyImage

class BotChatTableViewCell: UserChatTableViewCell {
    
    @IBOutlet weak var botIcon : UIView!

    var msg = BasicMessage()
    var lazyImage = LazyImage()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(msg : BasicMessage , showIcon : Bool = false){
        super.setData(msg : msg , showIcon: showIcon)
        self.msg = msg
        botIcon.isHidden = !showIcon
    }

}
