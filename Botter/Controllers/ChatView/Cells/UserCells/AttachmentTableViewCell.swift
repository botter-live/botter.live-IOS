//
//  AttachmentTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/29/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class AttachmentTableViewCell: UserChatTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(msg: b_BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg)
        self.msg = msg
        let urlComponents = self.msg.mediaUrl.components(separatedBy: "/")
        if urlComponents.count > 0{
            textLbl.text = urlComponents[urlComponents.count - 1]
        }else{
            textLbl.text = ""
        }
    }
    
}
