//
//  DateIntputTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class DateIntputTableViewCell: TextInputTableViewCell {
    
    @IBOutlet weak var titleLbl : BasicRegularLbl!
    var parent = UIViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(input: FormInput , parent : UIViewController) {
        super.setData(input:input)
        self.parent = parent
        textFeild.placeholder = "DD/MM/YYYY"
        titleLbl.text = input.label
    }
    
    @IBAction func openPicker(){
        DatePickerPopViewController.open(in: parent, mode:  .date ) { (selected) in
            self.textFeild.text = selected
        }
    }
    
   
}
