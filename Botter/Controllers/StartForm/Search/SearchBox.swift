//
//  SearchBox.swift
//  Botter
//
//  Created by Nora on 7/21/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class SearchBox: AllSidsCardView {
    @IBOutlet weak var mainStackView : UIStackView!
    @IBOutlet weak var searchStackView : UIStackView!
    @IBOutlet weak var firstQuestionStackView : UIStackView!
    @IBOutlet weak var secondQuestionStackView : UIStackView!
    @IBOutlet weak var searchTextField : UITextField!
    @IBOutlet weak var searchAboutLabel : UILabel!
    @IBOutlet weak var firstResultQuestionLabel : UILabel!
    @IBOutlet weak var firstResultAnswerLabel : UILabel!
    @IBOutlet weak var secondResultQuestionLabel : UILabel!
    @IBOutlet weak var secondResultAnswerLabel : UILabel!
    @IBOutlet weak var noResultLabel : UILabel!
    @IBOutlet weak var btnStack : UIStackView!
    
    var faqsList = [FaqData]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareStackView()
    }
    
    var cParent = StartFormViewController()
    
    func prepareStackView(){
           let tap1 = UITapGestureRecognizer(target: self, action: #selector(firstFaqsTapped))
           let tap2 = UITapGestureRecognizer(target: self, action: #selector(secondFaqsTapped))
           mainStackView.arrangedSubviews[1].addGestureRecognizer(tap1)
           mainStackView.arrangedSubviews[2].addGestureRecognizer(tap2)
       }
    
    
    @objc func firstFaqsTapped(){
        let vc =  FaqsDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Forms)
        vc.faqItem = faqsList[0]
        cParent.present(vc, animated: true, completion: nil)
    }
    
    @objc func secondFaqsTapped(){
        let vc =  FaqsDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Forms)
        vc.faqItem = faqsList[1]
        cParent.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func searchClicked(_ sender : UIButton){
        
        if searchTextField.text?.count ?? 0 > 0 {
            cParent.view.endEditing(true)
            searchAboutLabel.text = "Search results for \(searchTextField.text ?? "")"
            cParent.presenter.getFaqsData(searchText: searchTextField.text ?? "")

        }
        searchStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[4].isHidden = true
    }
    
    @IBAction func showMoreDetailsClicked(_ sender : UIButton){
        let vc =  FaqsListViewController.instantiateFromStoryBoard(appStoryBoard: .Forms)
        vc.faqsList = self.faqsList
        cParent.present(vc, animated: true, completion: nil)
    }
    
    func setFaqsData(faqsData: [FaqData]) {
        self.faqsList = faqsData
        if faqsList.count == 0 {
            setupEmptyQuestionView()
            cParent.updateFooterHeight(height: 285)
        }else if faqsList.count == 1 {
            setupFirstQuestionView(faqsData: faqsList)
            cParent.updateFooterHeight(height: 285 + Int(mainStackView.arrangedSubviews[1].frame.height))
        }else if faqsList.count == 2 {
            setAllQuestions(faqsData: faqsData)
            setupSecondQuestionView(faqsData: faqsList)
            cParent.updateFooterHeight(height: 310 + Int(mainStackView.arrangedSubviews[1].frame.height) + Int(mainStackView.arrangedSubviews[2].frame.height))
            
        }else{
            setAllQuestions(faqsData: faqsList)
            setupAllQuestionView(faqsData: faqsList)
            cParent.updateFooterHeight(height: 375 + Int(mainStackView.arrangedSubviews[1].frame.height) + Int(mainStackView.arrangedSubviews[2].frame.height) )
        }
        
        
    }
    
    
    func setAllQuestions(faqsData: [FaqData]){
        firstResultAnswerLabel.text = faqsData[0].body.answer
        firstResultQuestionLabel.text = faqsData[0].body.question
        secondResultAnswerLabel.text = faqsData[1].body.answer
        secondResultQuestionLabel.text = faqsData[1].body.question
    }
    
    func setupEmptyQuestionView(){
        noResultLabel.text = "No result for \(searchTextField.text ?? "")"
        mainStackView.arrangedSubviews[1].isHidden = true
        mainStackView.arrangedSubviews[2].isHidden = true
        mainStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[5].isHidden = true
        searchStackView.arrangedSubviews[3].isHidden = false
        searchStackView.arrangedSubviews[4].isHidden = false
        searchStackView.arrangedSubviews[2].isHidden = true
    }
    
    
    func setupFirstQuestionView(faqsData: [FaqData]){
        firstResultAnswerLabel.text = faqsData[0].body.answer
        firstResultQuestionLabel.text = faqsData[0].body.question
        mainStackView.arrangedSubviews[1].isHidden = false
        mainStackView.arrangedSubviews[2].isHidden = true
        mainStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[5].isHidden = false
        searchStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[4].isHidden = true
        searchStackView.arrangedSubviews[2].isHidden = false
        firstQuestionStackView.arrangedSubviews[2].isHidden = true
        mainStackView.layoutIfNeeded()
    }
    
    
    func setupSecondQuestionView(faqsData: [FaqData]){
        mainStackView.arrangedSubviews[1].isHidden = false
        mainStackView.arrangedSubviews[2].isHidden = false
        mainStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[3].isHidden = false
        searchStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[4].isHidden = true
        searchStackView.arrangedSubviews[5].isHidden = false
        searchStackView.arrangedSubviews[2].isHidden = false
        firstQuestionStackView.arrangedSubviews[2].isHidden = false
        secondQuestionStackView.arrangedSubviews[2].isHidden = true
        mainStackView.layoutIfNeeded()
    }
    
    func setupAllQuestionView(faqsData: [FaqData]){
        mainStackView.arrangedSubviews[1].isHidden = false
        mainStackView.arrangedSubviews[2].isHidden = false
        mainStackView.arrangedSubviews[3].isHidden = false
        btnStack.isHidden = false
        searchStackView.arrangedSubviews[3].isHidden = false
        searchStackView.arrangedSubviews[2].isHidden = false
        firstQuestionStackView.arrangedSubviews[2].isHidden = false
        secondQuestionStackView.arrangedSubviews[2].isHidden = false
        searchStackView.arrangedSubviews[3].isHidden = true
        searchStackView.arrangedSubviews[4].isHidden = true
        searchStackView.arrangedSubviews[5].isHidden = false
        mainStackView.layoutIfNeeded()
        
    }
    
}
