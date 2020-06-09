//
//  VideoBotTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/4/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class VideoBotTableViewCell: ImageBotTableViewCell {
    
    var openVideo : ((String)->())!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playVideoClicked(){
        if openVideo != nil{
            openVideo(msg.mediaUrl)
        }
    }

}
