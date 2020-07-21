//
//  FaqCell.swift
//  Botter
//
//  Created by SherifShokry on 7/21/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit


class FaqCell : UITableViewCell {
    
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var answerLabel : UILabel!
    
    
    func setData(faqItem : FaqsItem){
        questionLabel.text = faqItem.question
        answerLabel.text = faqItem.answer
    }
    
    
}
