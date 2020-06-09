//
//  TextBoxFeild.swift
//  A3maly
//
//  Created by Nora Sayed on 10/9/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

protocol TextBoxDelegate {
    func textBoxDidChange(textBox : TextBoxFeild)
    func shouldChangeTextInRange(textBox : TextBoxFeild)
    func textBoxDidBeginEditing(textBox : TextBoxFeild)
    func textBoxDidEndEditing(textBox : TextBoxFeild)
    func textBoxShouldBeginEditing(textBox : TextBoxFeild)
    func textBoxShouldEndEditing(textBox : TextBoxFeild)
}

class TextBoxFeild: UIView {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var field: UITextView!

    
    var actionHandler: ((Any)->Void)?
    var optional = true
    var diffrence : CGFloat = 0
    var max : CGFloat  = 90
    
    @IBInspectable  var feildTitle : String = ""{
        didSet{
            if titleLbl != nil{
                titleLbl.text = feildTitle
            }
        }
    }
    @IBInspectable var errorMsg = ""{
        didSet{
            if errorLabel != nil{
                errorLabel.text = errorMsg
            }
        }
    }
    @IBInspectable  var placeHolder : String = ""{
        didSet{
//            field.placeholder = placeHolder
//            refreshText()
        }
    }
    
    
    var placeHolderColor = UIColor.lightGray.withAlphaComponent(0.5){
        didSet{
//            refreshText()
        }
    }
    var textColor = UIColor.init(codeString: "#2E332F"){
        didSet{
//            refreshText()
        }
    }
    var delegate : TextBoxDelegate!

    
    
    @IBAction func buttonPressed(_ sender : Any){
        if actionHandler != nil{
            actionHandler!(sender)
        }
    }
    
    func reSet(){
        field.tag = 0
        self.refreshText()
        normal()
    }
    
    func refreshText(){
        if field != nil {
            if field.tag == 0 || field.text == "" || field.text == placeHolder {
                field.text =  placeHolder
                field.tag = 0
                field.textColor = placeHolderColor
            }else{
                field.textColor = textColor
                field.tag = 1
            }
        }
    }
    
    override func awakeFromNib() {
        if appIsArabic(){
            field.textAlignment = .right
        }
        if errorLabel != nil{
            if errorLabel.text != "" || errorLabel.text != "Label" {
                errorMsg = errorLabel.text!
            }
        }
        field.delegate = self
        diffrence = self.frame.size.height - field.frame.size.height
        
        self.normal()
    }
    
    func invalid(error: String) {
        if errorLabel != nil{
            errorLabel.text = error
            errorLabel.isHidden = false
            errorLabel.textColor = Colors.red
        }
    }
    
    func normal() {
        self.refreshText()
        if errorLabel != nil{
            errorLabel.isHidden = true
            errorLabel.text = ""
        }
    }
    func getText() -> String {
        if field.tag == 0{
            return ""
        }else{
            return field.text!
        }
    }
    func setText(text: String){
        field.text = text
        if field.text.length == 0  {
            field.text =  placeHolder
            field.tag = 0
            field.textColor = placeHolderColor
            
        }else{
            field.textColor = textColor
            field.tag = 1
        }
    }
    
    func isEmptyAndNotOptional()->Bool{
        return self.getText().trim().isEmpty && !optional
    }
    
    func validate()->Bool{
        var isValid = true
        normal()
        if isEmptyAndNotOptional(){
            isValid = false
            self.invalid(error: (errorMsg != "") ?
                errorMsg :
                "Feild can't be empty".localize())
        }
        return isValid
    }
}
extension TextBoxFeild : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if delegate != nil{
            delegate.textBoxDidChange(textBox: self)
        }
        normal()
        if textView.text.length == 0  {
            textView.text =  placeHolder
            textView.tag = 0
            textView.textColor = placeHolderColor
            
        }else{
            textView.textColor = textColor
            textView.tag = 1
        }
        
//        if textView.contentSize.height >= 90
//        {
//            textView.isScrollEnabled = true
//        }
//        else
//            {
//            textView.frame.size.height = textView.contentSize.height
//                self.frame.size.height = textView.frame.size.height + diffrence
//            textView.isScrollEnabled = false
//        }
    }
    
   
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if delegate != nil{
            delegate.shouldChangeTextInRange(textBox: self)
        }
        normal()
        if textView.tag == 0 {
            textView.text = ""
            textView.tag = 1
            return true
        }
        else{
            
            return true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if delegate != nil{
            delegate.textBoxDidBeginEditing(textBox: self)
        }
        normal()
        if textView.tag == 0 {
            textView.text = ""
            textView.textColor = self.textColor
            textView.tag = 1
        }else{
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if delegate != nil{
            delegate.textBoxDidEndEditing(textBox: self)
        }
        _ = validate()
        if textView.tag == 1{
            if textView.text.trim() == ""
            {
                textView.text = self.placeHolder
                textView.textColor = self.placeHolderColor
                textView.tag = 0
            }
        }
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if delegate != nil{
            delegate.textBoxShouldBeginEditing(textBox: self)
        }
        return actionHandler == nil
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        _ = validate()
        if delegate != nil{
            delegate.textBoxShouldEndEditing(textBox: self)
        }
        return true
    }

}
