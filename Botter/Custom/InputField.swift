//
//  inputField.swift
//  Shezlong
//
//  Created by George Naiem on 8/6/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//

import UIKit

protocol InputFeildDelegate {
    func shouldBeginEditing(inputFeild : InputField)
    func didEndEditing(inputFeild : InputField)
    func didBeginEditing(inputFeild : InputField)
    func shouldReturn(inputFeild : InputField)
    func edittingChanged(inputFeild : InputField)
}

struct inputFeildColors {
    static var textColor : UIColor = UIColor.init(codeString: "#2E332F")
    static var textPlaceHolder : UIColor = UIColor.init(codeString: "#2E332F").withAlphaComponent(0.5)
    static var normalLineColor : UIColor = UIColor.init(codeString: "#9099a6").withAlphaComponent(0.8)
    static var edittingLineColor : UIColor = UIColor.init(codeString: "#2f79f2")
    static var errorLineColor : UIColor = UIColor.init(codeString: "#D6122A")
    
}

class InputField: BaseNibLoader  {
    
    public enum feildType : String{
        case email = "email"
        case password = "password"
        case phoneNumber = "phoneNumber"
        case number = "number"
        case name = "name"
        case userName = "userName"
        case regular = "regular"
        case action = "action"
        case nationalID = "nationalID"
    }
   
   
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var actionBtn : UIButton!
    @IBOutlet weak var passBtn : UIButton!
    @IBOutlet weak var lineView : UIView!
    @IBOutlet weak var nextFeild : InputField!
    
    var actionHandler: ((Any)->Void)?
    var type : feildType = .regular{
        didSet{
            setTextFeildSpecs()
        }
    }
    
    var delegate : InputFeildDelegate!
    var optional = false
    
    @IBInspectable  var feildTitle : String = ""{
        didSet{
            titleLbl.text = feildTitle
        }
    }
    @IBInspectable var errorMsg = ""{
        didSet{
            errorLabel.text = errorMsg
        }
    }
    @IBInspectable  var feildPlaceHolder : String = ""{
        didSet{
            field.placeholder = feildPlaceHolder
            field.placeHolderColor = inputFeildColors.textPlaceHolder
        }
    }
    
    func setLineColor(color : UIColor){
        if lineView != nil{
            lineView.borderColor = color
            passBtn.tintColor = color
        }
    }
    
    func setTextFeildSpecs(){
        
    }
    
    @IBAction func buttonPressed(_ sender : Any){
        if actionHandler != nil{
            actionHandler!(sender)
        }
    }

    
   var textColor = inputFeildColors.textColor

  
    func reSet(){
        setText(text: "")
        field.leftView = UIView()
        normal()
    }

    override func awakeFromNib() {
        if appIsArabic(){
            field.textAlignment = .right
        }
      
        if nextFeild != nil{
            field.returnKeyType = .next
        }else{
            field.returnKeyType = .done
        }
//       textColor = field.textColor!
        field.textColor = textColor
        field.delegate = self
        if errorMsg == "" && !optional{
            errorMsg = "برجاء ادخال".localize() + " " + feildTitle.lowercased()
        }
        self.field.addTarget(self, action: #selector(textFeildChanged), for: .editingChanged)
        self.normal()
    }
    
    func invalid(error: String) {
        field.isEnabled = true
        errorLabel.text = error
        errorLabel.isHidden = false
        errorLabel.textColor = inputFeildColors.errorLineColor
        setLineColor(color: inputFeildColors.errorLineColor)
    }
 
    func dim() {
        field.isEnabled = false
    }
    
    func normal() {
        field.isEnabled = true
        field.textColor = textColor
        errorLabel.isHidden = true
        errorLabel.text = ""
        field.placeHolderColor = inputFeildColors.textPlaceHolder
        setLineColor(color: inputFeildColors.normalLineColor)
    }
    
    func getText() -> String {
        return field.text!
    }
    func setText(text: String){
        field.text = text
        self.normal()
    }
    
    func isEmptyAndNotOptional()->Bool{
        return self.getText().trim().isEmpty && !optional
    }
    
    
    func validate()->Bool{
        var isValid = true
        switch type {
        case .email:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "برجاء ادخال البريد الالكتروني".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidEmail(text: self.getText().trim()){
                        isValid = false
                        self.invalid(error: "برجاء ادخال بريد الكترونى صحيح".localize())
                    }
                }
            }
            break
        case .password:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "برجاء ادخال كلمة السر".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPassword(text: self.getText()) {
                        isValid = false
                        self.invalid(error: "كلمة السر غير صحيحة".localize())
                    }
                }
            }
            break
        case .phoneNumber:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "برجاء ادخال رقم الهاتف".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPhoneNumber(text: self.getText().trim()) {
                        isValid = false
                        self.invalid(error: "برجاء ادخال رقم هاتف صحيح".localize())
                    }
                }
            }
            break
        case .number:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (errorMsg != "") ?
                    errorMsg :
                    "الحقل اجبارى".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.textHasOnlyNumbers(self.getText().trim()) {
                        isValid = false
                        self.invalid(error: "برجاء ادخال رقم صحيح".localize())
                    }
                }
            }
            break
        case .nationalID :
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (errorMsg != "") ?
                    errorMsg :
                    "برجاء ادخال الرقم القومى".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.textHasOnlyNumbers(self.getText().trim()) ||  self.getText().trim().count != 14 {
                        isValid = false
                        self.invalid(error: "برجاء ادخال رقم قومى صحيح".localize())
                    }
                }
            }
            break
        case .regular , .action:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (errorMsg != "") ?
                    errorMsg :
                     "الحقل اجبارى".localize())
            }
            break
        case .name:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "برجاء ادخال \(feildTitle)".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidName(string: getText()) {
                        isValid = false
                        self.invalid(error: "الاسم يجب ان يكون اكبر من حرفين ولا يحتوي ارقام او رموز".localize())
                    }
                }
            }
            case .userName:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "برجاء ادخال \(feildTitle)".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidUserName(string: getText()) {
                        isValid = false
                        self.invalid(error: "اسم المستخدم غير صحيح".localize())
                    }
                }
            }
        }
        return isValid
    }
}

extension InputField : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate != nil{
            delegate.didBeginEditing(inputFeild: self)
        }
        self.normal()
        setLineColor(color: inputFeildColors.edittingLineColor)
    }
    
    @objc func textFeildChanged(_ sender : UITextField){
        if delegate != nil{
            delegate.edittingChanged(inputFeild: self)
        }
        if type != .password{
            setText(text: getText().updateToEngNum())
        }
        if type == .name {
            sender.text = sender.text?.capitalized
        }
        setLineColor(color: inputFeildColors.edittingLineColor)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if delegate != nil{
            delegate.shouldBeginEditing(inputFeild: self)
        }
        self.normal()
        setLineColor(color: inputFeildColors.edittingLineColor)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if delegate != nil{
            delegate.shouldReturn(inputFeild: self)
        }
        if nextFeild != nil{
            if nextFeild.type != .action{
                nextFeild.field.becomeFirstResponder()
            }else{
                self.field.resignFirstResponder()
                nextFeild.actionBtn.sendActions(for: .touchUpInside)
            }
        }else{
            self.field.resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setLineColor(color: inputFeildColors.normalLineColor)
        let _ = validate()
        if delegate != nil{
            delegate.didEndEditing(inputFeild: self)
        }
    }
}
