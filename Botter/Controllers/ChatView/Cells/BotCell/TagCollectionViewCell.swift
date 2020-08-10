//
//  TagCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 6/4/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var BGView : UIView!
    @IBOutlet weak var maxWidth : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.maxWidth.constant = UIScreen.main.bounds.width - 10 * 2 - 10 * 2
    }

    func setData(action : b_Action){
        titleLbl.text = action.title
        BGView.b_borderColor = BotterSettingsManager.AccentColor
        titleLbl.textColor = BotterSettingsManager.AccentColor
    }
}
