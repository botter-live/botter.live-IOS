//
//  BasicInvoiceItemTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class BasicInvoiceItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var detailsLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(title : String = "" , details : String = ""){
        if titleLbl != nil{
            titleLbl.text = title
        }
        if detailsLbl != nil{
            detailsLbl.text = details
        }
    }

}

