//
//  RadioCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class RadioCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var BGView : UIView!
    @IBOutlet weak var iconImg : AccentImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(text : String , selected : Bool){
        titleLbl.text = text
        BGView.b_borderColor = selected ? BotterSettingsManager.AccentColor.withAlphaComponent(0.7) : UIColor.black.withAlphaComponent(0.5)
        titleLbl.textColor = selected ? BotterSettingsManager.AccentColor : UIColor.black
        
        let selectedImage = UIImage(named: "ic_radiobutton_selected", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        let unSelectedImage = UIImage(named: "noun_Checkbox_60245", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        
        iconImg.image = selected ? selectedImage : unSelectedImage
        BGView.backgroundColor = selected ? BotterSettingsManager.AccentColor.withAlphaComponent(0.1) : UIColor.white
    }
    
}
