//
//  RoundedView.swift
//  GID
//
//  Created by Nora on 4/29/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func draw(_ rect: CGRect) {
        self.cornerRadius = self.frame.size.height / 2.0
    }

}
