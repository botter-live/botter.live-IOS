//
//  TimeInputTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TimeInputTableViewCell: DateIntputTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func setData(input: FormInput , parent : UIViewController) {
        super.setData(input: input , parent: parent)
         textFeild.placeholder = "hh:mm"
    }
    
    override func openPicker() {
        DatePickerPopViewController.open(in: self.parent, mode:  .time ) { (selected) in
            self.textFeild.text = selected
        }
    }
}
