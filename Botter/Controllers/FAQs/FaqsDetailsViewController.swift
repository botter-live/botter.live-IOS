//
//  FaqsDetailsViewController.swift
//  Botter
//
//  Created by SherifShokry on 7/21/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit


class b_FaqsDetailsViewController : b_LocalizableViewController {
    
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var answerLabel : UILabel!
    @IBOutlet weak var createdAtLabel : UILabel!
    var faqItem = b_FaqData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFaqsDetailsData()
       
    }
    
    
    func  setFaqsDetailsData() {
        questionLabel.text = faqItem.body.question
        answerLabel.text = faqItem.body.answer
        let date = faqItem.createdAt.b_toDate()
        createdAtLabel.text = "Updated over " + date.b_timeAgoDisplay()
    }

}
