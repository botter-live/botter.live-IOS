//
//  PickerCell.swift
//  MyLexus
//
//  Created by Nora on 6/25/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage

class PickerCell : UITableViewCell{
    
    @IBOutlet weak var carImage : UIImageView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var selectedImageIcon : UIImageView!
    @IBOutlet weak var container : UIView!
    @IBOutlet weak var carImageWidth : NSLayoutConstraint!

    
  
    
    func setData(title : String  , selected : Bool){
        titleLbl.text = title
        titleLbl.textColor = selected ? Colors.appPrimeryColor : Colors.dimmed
        
    }
    
    
    
}
