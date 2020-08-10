//
//  TypingTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/14/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TypingIndicatorTableViewCell: BotChatTableViewCell {
    
    @IBOutlet weak var typing : b_TypingIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(msg: b_BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        typing.isHidden = !showIcon
        typing.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner , .layerMaxXMaxYCorner]
    }
    
}
