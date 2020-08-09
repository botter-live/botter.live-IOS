//
//  SemiRoundedInputFeild.swift
//  GID
//
//  Created by Nora on 4/19/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit

class SemiRoundedInputFeild: InputField {

    
    override func draw(_ rect: CGRect) {
        self.cornerRadius = self.frame.size.height / 2.0
    }
    
   
}
