//
//  RoundedCardView.swift
//  Masters
//
//  Created by Nora on 3/7/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import UIKit

class b_RoundedCardView: b_RoundedView {

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = b_cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: b_cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}
