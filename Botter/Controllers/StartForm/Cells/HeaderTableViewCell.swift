//
//  HeaderTableViewCell.swift
//  Botter
//
//  Created by Nora on 9/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var continueSessionView : b_AllSidsCardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if ChatSessionManager.shared.hasActiveSession(){
//            updateHeaderHeight(height: 400)
            continueSessionView.isHidden = false
        }else{
//            updateHeaderHeight(height: 268)
            continueSessionView.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
