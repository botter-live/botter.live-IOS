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
        textFeild.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        refreshTextAlignment()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(input: b_FormInput) {
        super.setData(input: input)
        textFeild.font = BotterSettingsManager.Font.getRegularFontForFeild(feild: textFeild)
        textFeild.delegate = self
        textFeild.tintColor = BotterSettingsManager.AccentColor
        textFeild.placeholder = input.label
        refreshTextAlignment()
        
    }

    override func evaluateRegex() -> Bool {
        return evaluateRegex(text: textFeild.text?.b_trim() ?? "")
    }
    
    override func getAnswer() -> Any {
        self.answer = textFeild.text?.b_trim() ?? ""
        return textFeild.text?.b_trim() ?? ""
       }
    
    func refreshTextAlignment(){
        if textFeild.text == ""{
            textFeild.textAlignment = BotterSettingsManager.language == .arabic ? .right : .left
        }else{
            textFeild.textAlignment = .natural
        }
    }
}
extension TextInputTableViewCell : UITextFieldDelegate{
    @objc func editingChanged(_ textFeild : UITextField){
        errorLbl.isHidden = true
        refreshTextAlignment()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        errorLbl.isHidden = true
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let _ = evaluateRegex()
    }
}
