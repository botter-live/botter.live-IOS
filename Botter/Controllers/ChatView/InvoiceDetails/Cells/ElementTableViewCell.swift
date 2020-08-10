//
//  ElementTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elementView : InvoiceItemView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item : b_InvoiceElement ){
        elementView.setData(item: item)
    }

}
