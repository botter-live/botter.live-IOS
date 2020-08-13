//
//  UserChatTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/3/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {

    @IBOutlet weak var textLbl : b_PaddedUILabel!
    @IBOutlet weak var BGView : UIView!
    
    var msg = b_BasicMessage()
    var resendAction:((b_BasicMessage)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if textLbl != nil{
            textLbl.textAlignment = .right
        }
        self.setText(tView: self.contentView)
    }
    
    func setText(tView  : UIView){
        for v in tView.subviews{
            if let lbl = v as? UILabel{
                let str = BotterSettingsManager.language == .arabic ? CommonActions.loadText(for: lbl.text ?? "") : lbl.text
                lbl.text =  str
            }
            if let btn = v as? UIButton{
                let str = btn.title(for: .normal)?.b_localize()
                btn.setTitle(str, for: .normal)
            }
            
            if !(tView is UICollectionView){
                setText(tView: v)
            }
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(msg : b_BasicMessage , showIcon : Bool = false){
        self.msg = msg
        if textLbl != nil{
            textLbl.text = msg.text
            textLbl.attributedText = TextFormater.shared.formatText(text: msg.text)
        }
        
        if BGView != nil{
            BGView.clipsToBounds = true
            BGView.layer.cornerRadius = 6
            if msg.isBotMsg{
                BGView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner , .layerMaxXMaxYCorner]
            }else{
                BGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner , .layerMaxXMaxYCorner]
            }
        }
    }
    
    @IBAction func resend(){
        if resendAction != nil{
            resendAction(self.msg)
        }
    }

}
