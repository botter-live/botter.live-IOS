//
//  TextAreaInputTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TextAreaInputTableViewCell: BasicFormTableViewCell {
    
    @IBOutlet weak var textArea : b_TextBoxFeild!

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
        textArea.field.font = BotterSettingsManager.Font.getRegularFontForTextArea(feild: textArea.field)
        textArea.field.tintColor = BotterSettingsManager.AccentColor
        textArea.placeHolder = input.label
    }
    
    override func evaluateRegex() -> Bool {
        return evaluateRegex(text: textArea.getText().b_trim())
    }
    
    override func getAnswer() -> Any {
        self.answer = textArea.getText()
        return textArea.getText()
    }
}
