//
//  PickerView.swift
//  Feed
//
//  Created by Nora on 5/14/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit

protocol PickerViewDelegate {
    func doneSelecting(index : Int)
}

class PickerView: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var titleView : UIView!
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var subTitleLbl : UILabel!
    @IBOutlet weak var doneBtn : UIButton!
    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var hConst : NSLayoutConstraint!
    
    var cellIdentifer = "PickerCell"
    var doneBtnTitle = ""
    var cancelBtnTitle = ""
    var cancelBtnColor = UIColor.lightGray
    var cancelBtnFontColor = UIColor.white
    var btnsFontColor = UIColor.white
    var primaryColor = UIColor.white
    var listTextColor = UIColor.black
    var accentColor = UIColor.red
    var titleText = ""
    var subTitleText = ""
    var titleTextColor = UIColor.white
    var listSource = [String](){
        didSet{
            fixHeight()
        }
    }
    var listImages = [String]()
    var selectedIndex = -1
    var pickerDelegate : PickerViewDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixHeight()
        tableView.tableFooterView = UIView()
        let nib = UINib.init(nibName: cellIdentifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
        setCustomizations()
        showAnimate()
        
    }
    
    func fixHeight(){
        let firstConst = UIScreen.main.bounds.height * 0.6
        
        let totalReal : CGFloat = CGFloat(listSource.count * 50 + 80) + 40
        
        if totalReal <= firstConst{
            hConst.constant = totalReal
        }else{
            hConst.constant = firstConst
        }
        
    }
    
    func setCustomizations(){
//        if !doneBtnTitle.isEmpty{
//            doneBtn.setTitle(doneBtnTitle, for: .normal)
//        }
//        if !cancelBtnTitle.isEmpty{
//            cancelBtn.setTitle(cancelBtnTitle, for: .normal)
//        }
        titleLbl.text = titleText
        subTitleLbl.text = subTitleText
//        titleLbl.textColor = titleTextColor
//        doneBtn.setTitleColor(btnsFontColor, for: .normal)
//        cancelBtn.setTitleColor(accentColor, for: .normal)
//        cancelBtn.backgroundColor = UIColor.white
//        cancelBtn.borderColor = accentColor
//        cancelBtn.borderWidth = 1
//        cardView.backgroundColor = primaryColor
//        titleView.backgroundColor = .clear
//        bottomView.backgroundColor = .clear
        tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender : Any){
        if pickerDelegate != nil && selectedIndex != -1 {
            pickerDelegate.doneSelecting(index: selectedIndex)
        }
        removeAnimate()
    }
    
    @IBAction func cancelButtonPressed(_ sender : Any){
        removeAnimate()
    }
    
    
    func showAnimate()
    {
        fixHeight()
        let orignalFrame = self.cardView.frame
        let oldframe = CGRect.init(x: 0, y: self.view.frame.height , width: self.view.frame.height , height: cardView.frame.height)
        cardView.frame = oldframe
        UIView.animate(withDuration: 0.5 , delay: 0.1 , options: .transitionFlipFromBottom, animations: {
            self.view.alpha = 1.0
            self.cardView.frame = orignalFrame
        }) { (finished : Bool) in
            if(finished)
            {
                
            }
        }
    }
    
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.5 , delay: 0.1 , options: [.beginFromCurrentState , .transitionFlipFromTop], animations: {
            self.view.alpha = 0.0
            self.cardView.layer.frame = CGRect.init(x: 0, y: self.view.frame.height , width: self.view.frame.height , height: self.cardView.frame.height)
        }) { (finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }

    }
    

}
extension PickerView : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? PickerCell
        cell?.setData(title: listSource[indexPath.row] , selected: selectedIndex == indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        doneButtonPressed(self)
        tableView.reloadData()
    }
}
