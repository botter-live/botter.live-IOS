//
//  DatePickerPopViewController.swift
//  MyLexus
//
//  Created by Nora on 7/9/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit
//import ContentSheet

class b_DatePickerPopViewController: UIViewController {
    
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var subTitleLbl : UILabel!
    
    var doneActionHandler: ((Any)->Void)?
    var selectedDate = Date()
    var date = ""
    var max : Date?
    var min : Date?
    var mode : UIDatePicker.Mode = .date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = mode
        if mode == .time {
           titleLbl.text = titleLbl.text?.replacingOccurrences(of: "Date", with: "Time")
//            subTitleLbl.text = subTitleLbl.text!.replacingOccurrences(of: "day", with: time)
            subTitleLbl.text = subTitleLbl.text
        }
        if date == ""{
            datePicker.setDate(selectedDate, animated: true)
        }
        if min != nil{
            datePicker.minimumDate = min
        }
        if max != nil{
            datePicker.maximumDate = max
        }
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }

    @objc func datePickerValueChanged(sender: UIDatePicker){
        selectedDate = sender.date
    }

    @IBAction func doneButtonPressed(_ sender : Any){
        if doneActionHandler != nil{
            doneActionHandler!(sender)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func close (_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return 440
    }
    
    static func open(in parent:UIViewController , mode : UIDatePicker.Mode , completion:@escaping((String)->())){
        let content: ContentSheetContentProtocol
        let vc = b_DatePickerPopViewController.b_instantiateFromStoryBoard(appStoryBoard: .Main)
//        vc.modalPresentationStyle = .overCurrentContext
        vc.mode = mode
        vc.selectedDate = Date()
        vc.doneActionHandler = { action in
            let selected = mode == .date ? vc.selectedDate.b_toString() : vc.selectedDate.b_toTimeString()
            completion(selected)
        }
        let contentController = vc
        content = contentController
        let contentSheet = ContentSheet(content: content)
        contentSheet.blurBackground = false
        contentSheet.showDefaultHeader = false
    
        parent.present(contentSheet, animated: true, completion: nil)
        
    }
    
    
}
