
//
//  CustomPickerView.swift
//  Feed
//
//  Created by Nora on 5/14/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit

class CustomPickerView : NSObject {
    var doneBtnTitle = "Done"
    var cancelBtnTitle = "Cancel"
    var btnsFontColor = UIColor.white
    var primaryColor = UIColor.white
    var listTextColor = UIColor.black
    var accentColor = UIColor.red
    var cancelBtnColor = UIColor.lightGray
    var cancelBtnFontColor = UIColor.white
    var titleText = ""
    var subTitleText = ""
    var titleTextColor = UIColor.white
    var listSource = [String]()
    var listImages = [String]()
    var myPicker : PickerView!
    var doneSelectingAction : ((Int)->Void)?
    var selectedIndex = -1

    override init() {
        super.init()
        myPicker = Bundle.main.loadNibNamed("PickerView", owner: self , options: nil)?.first as? PickerView
    }
    
    func show(){
        setPickerSpec()
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            topController.addChild(myPicker)
            myPicker.view.frame = topController.view.frame
            topController.view.addSubview(myPicker.view)
            myPicker.didMove(toParent: topController)
        }
        
      
    }
    
    func setPickerSpec(){
        myPicker.accentColor = accentColor
        myPicker.doneBtnTitle = doneBtnTitle
        myPicker.cancelBtnTitle = cancelBtnTitle
        myPicker.btnsFontColor = btnsFontColor
        myPicker.primaryColor = primaryColor
        myPicker.listTextColor = listTextColor
        myPicker.cancelBtnFontColor = cancelBtnFontColor
        myPicker.cancelBtnColor = cancelBtnColor
        myPicker.titleText = titleText
        myPicker.subTitleText = subTitleText
        myPicker.titleTextColor = titleTextColor
        myPicker.listSource = listSource
        myPicker.listImages = listImages
        myPicker.pickerDelegate = self
        myPicker.selectedIndex = selectedIndex
        myPicker.setCustomizations()
    }
}
extension CustomPickerView : PickerViewDelegate{
    func doneSelecting(index: Int) {
        if doneSelectingAction != nil{
            doneSelectingAction!(index)
        }
    }
}
