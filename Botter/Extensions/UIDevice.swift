//
//  UIDevice.swift
//  Shezlong
//
//  Created by Nora on 5/30/18.
//  Copyright © 2018 Bluecrunch. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
}
