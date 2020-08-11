//
//  NotifyTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/20/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class NotifyTableViewCell: UITableViewCell {

    @IBOutlet weak var textLbl : b_BasicRegularLbl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(text : String){
        textLbl?.text = text
    }
    
}
