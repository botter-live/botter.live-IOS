//
//  GifTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/14/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import SwiftyGif

class GifTableViewCell: ImageBotTableViewCell  {

    @IBOutlet weak var gifIcon : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(msg: BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        self.msgImage?.setGifFromURL(URL.init(string: msg.mediaUrl)!, manager: SwiftyGifManager.defaultManager , loopCount: 0, levelOfIntegrity: GifLevelOfIntegrity(5), showLoader: true)
        msgImage?.contentMode = .scaleAspectFill
    }
    
    @IBAction func btnPressed(){
        if msgImage?.isAnimatingGif() ?? false{
            msgImage?.stopAnimatingGif()
            gifIcon.isHidden = false
        }else{
            gifIcon.isHidden = true
            msgImage?.loopCount = -1
            msgImage?.startAnimatingGif()
        }
        
    }

}
