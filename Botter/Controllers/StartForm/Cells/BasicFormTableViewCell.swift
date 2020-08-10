//
//  BasicFormTableViewCell.swift
//  Alamofire
//
//  Created by Nora on 7/16/20.
//

import UIKit

class BasicFormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var errorLbl : UILabel!
    
    var input = b_FormInput()
    var answer = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        errorLbl.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(input : b_FormInput){
        self.input = input
        errorLbl.text = self.input.errorMessage
    }
    
    func  validateFormInput()->Bool{
       var isValid = true
        let _ = getAnswer()
        if answer.isEmpty && input.required{
            isValid = false
            errorLbl.text = "Answer is required"
        }else if !answer.isEmpty && !input.regex.isEmpty{
            isValid = evaluateRegex()
            if !isValid{
                errorLbl.text = input.errorMessage
            }
        }
        errorLbl.isHidden = isValid
        return isValid
    }
    
    func evaluateRegex()->Bool{
        return evaluateRegex(text: "")
    }
    
    func evaluateRegex(text : String)->Bool{
//        let regex = input.regex.trimmingCharacters(in: CharacterSet.init(charactersIn: "/"))
        let testCase = NSPredicate(format:"SELF MATCHES %@", input.regex)
        let isValid = testCase.evaluate(with: text)
        return isValid
    }
    
    
    func getAnswer()->Any{
        return ""
    }
}


