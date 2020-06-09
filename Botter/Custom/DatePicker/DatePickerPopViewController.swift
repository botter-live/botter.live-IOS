//
//  DatePickerPopViewController.swift
//  MyLexus
//
//  Created by Nora on 7/9/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit
//import ContentSheet

class DatePickerPopViewController: UIViewController {
    
    @IBOutlet weak var datePicker : UIDatePicker!
    
    var doneActionHandler: ((Any)->Void)?
    var selectedDate = Date()
    var date = ""
    var max : Date?
    var min : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 350
    }
}
