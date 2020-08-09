//
//  SelectCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var BGView : UIView!
    @IBOutlet weak var iconImg : AccentImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(text : String , selected : Bool){
        titleLbl.text = text
        BGView.borderColor = selected ? BotterSettingsManager.AccentColor.withAlphaComponent(0.7) : UIColor.black.withAlphaComponent(0.5)
        titleLbl.textColor = selected ? BotterSettingsManager.AccentColor : UIColor.black
        
        let selectedImage = UIImage(named: "ic_checkbox_selcted", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        let unSelectedImage = UIImage(named: "ic_checkbox_unselcted", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        
        iconImg.image = selected ? selectedImage : unSelectedImage
        
        BGView.backgroundColor = selected ? BotterSettingsManager.AccentColor.withAlphaComponent(0.1) : UIColor.white
    }

}
