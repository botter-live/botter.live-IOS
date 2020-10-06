//
//  TextInputCardTableViewCell.swift
//  Botter
//
//  Created by Nora on 9/6/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TextInputCardTableViewCell: BotChatTableViewCell {
    
    @IBOutlet weak var dimLayer : UIView!
    @IBOutlet weak var answerView : UIView!
    @IBOutlet weak var textFeild : UITextField!
    @IBOutlet weak var errorLbl : UILabel!
    @IBOutlet weak var arrowBtn : UIButton!

    var submitAnswer : ((String)->())!
    var answerChanged : ((b_BasicMessage)->())!
    var regex = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        errorLbl.isHidden = true
        textFeild.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(msg : b_BasicMessage , showIcon : Bool , completion:@escaping((String)->())){
        super.setData(msg: msg, showIcon: showIcon)
        let answered = msg.prompt.answered
        textLbl.text = msg.text
        errorLbl.text = msg.prompt.errorMessage
        self.regex = msg.prompt.regex
        textFeild.delegate = self
        textFeild.textColor = answered ? .gray : .black
        dimLayer.backgroundColor = answered ? .gray : BotterSettingsManager.AccentColor
        answerView.b_borderWidth = 0.5
        answerView.b_borderColor = dimLayer.backgroundColor?.withAlphaComponent(0.8)
        self.isUserInteractionEnabled = !answered
        let img = answered ? UIImage(named: "checkCircle", in: MyFrameworkBundle.bundle , compatibleWith: nil)! : UIImage(named: "arrowRight", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        arrowBtn.setImage(img , for: .normal)
        if answered {
            textFeild.text = self.msg.prompt.answerText
        }else{
            textFeild.text = self.msg.prompt.tempAnswer
        }
        submitAnswer = { answer in
            if answer != ""{
                completion(answer)
            }
        }
        
    }
    
    @IBAction func submitAnswerClicked(){
       let validAnswer = evaluateRegex()
//        errorLbl.isHidden = validAnswer
        if validAnswer{
            // submit the answer
            if submitAnswer != nil {
                submitAnswer(textFeild.text?.b_trim() ?? "")
            }
        }
    }
    
    func evaluateRegex()->Bool{
        if regex != ""{
            let testCase = NSPredicate(format:"SELF MATCHES %@", self.regex)
            let isValid = testCase.evaluate(with: textFeild.text?.b_trim())
            errorLbl.isHidden = isValid
            return isValid
        }else{
            let isValid = textFeild.text?.b_trim() != ""
            errorLbl.isHidden = isValid
            return isValid
        }
    }
    
    override func prepareForReuse() {
        self.msg = b_BasicMessage()
        
    }
}

extension TextInputCardTableViewCell : UITextFieldDelegate{
    @objc func editingChanged(_ textFeild : UITextField){
        errorLbl.isHidden = true
        if answerChanged != nil{
            self.msg.prompt.tempAnswer = textFeild.text ?? ""
            answerChanged(self.msg)
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        errorLbl.isHidden = true
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let _ = evaluateRegex()
    }
}
