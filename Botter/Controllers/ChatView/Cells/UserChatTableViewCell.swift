//
//  UserChatTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {

    @IBOutlet weak var textLbl : PaddedUILabel!
    @IBOutlet weak var BGView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(msg : BasicMessage , showIcon : Bool = false){
        if textLbl != nil{
            textLbl.text = msg.text
        }
        
        if BGView != nil{
            BGView.clipsToBounds = true
            BGView.layer.cornerRadius = 6
            if msg.isBotMsg{
                BGView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner , .layerMaxXMaxYCorner]
            }else{
                BGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner , .layerMaxXMaxYCorner]
            }
        }
    }

}
