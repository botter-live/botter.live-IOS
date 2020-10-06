//
//  RateTableViewCell.swift
//  HiveSurvey
//
//  Created by Nora on 2/27/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class RateTableViewCell: BasicFormTableViewCell  {

//    @IBOutlet weak var rateView : RateView!
    @IBOutlet weak var titleLbl : b_BasicRegularLbl!
    
    var rate : Int? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        rateView.step = 1
//        rateView.canRate = true
//        rateView.starNormalColor = .clear
//        rateView.starBorderColor = .lightGray
//        rateView.delegate = self
//        rateView.starFillColor = SurveyManager.shared.appearance.accentColor ?? UIColor.init(codeString: "#0075BE")
    }
    
    override func setData(input: b_FormInput) {
        super.setData(input: input)
        self.answer = "\(rate ?? 5)"
        refreshViews()
    }
    
    
    func refreshViews(){
        for index in 1...5{
            if let btn = self.viewWithTag(index) as? UIButton{
                btn.isSelected = index <= (rate ?? 5)
            }
        }
    }
   
    
    @IBAction func changeRate(_ sender : UIButton){
        rate = sender.tag
        self.answer = "\(rate ?? 5)"
        refreshViews()
    }
    
//    override func validate() -> Bool {
//        errorLbl.isHidden = true
//        let valid = self.question.answer.NumberResponse > 0
//        if !valid{
//            invalid(msg: "Invalid Answer".getLocalizedString())
//        }
//        return valid || !question.IsRequired
//    }
    
}

