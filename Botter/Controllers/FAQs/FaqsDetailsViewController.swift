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
    @IBOutlet weak var createdAtLabel : UILabel!
    var faqItem = FaqData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFaqsDetailsData()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func  setFaqsDetailsData() {
        questionLabel.text = faqItem.body.question
        answerLabel.text = faqItem.body.answer
        let date = faqItem.createdAt.toDate()
        createdAtLabel.text = "Updated over " + date.timeAgoDisplay()
    }

}
