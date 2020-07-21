//
//  FaqsDetailsViewController.swift
//  Botter
//
//  Created by SherifShokry on 7/21/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit


class FaqsDetailsViewController : UIViewController {
    
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var answerLabel : UILabel!
    var faqItem = FaqsItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFaqsDetailsData()
    }
    
    
    func  setFaqsDetailsData() {
        questionLabel.text = faqItem.question
        answerLabel.text = faqItem.answer
    }

}
