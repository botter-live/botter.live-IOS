//
//  TextInputTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TextInputTableViewCell: BasicFormTableViewCell {
    
    @IBOutlet weak var textFeild : UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(input: b_FormInput) {
        super.setData(input: input)
        textFeild.font = BotterSettingsManager.Font.getRegularFontForFeild(feild: textFeild)
        textFeild.tintColor = BotterSettingsManager.AccentColor
        textFeild.placeholder = input.label
        
    }

    override func evaluateRegex() -> Bool {
        return evaluateRegex(text: textFeild.text?.b_trim() ?? "")
    }
    
    override func getAnswer() -> Any {
        self.answer = textFeild.text?.b_trim() ?? ""
        return textFeild.text?.b_trim() ?? ""
       }
}
