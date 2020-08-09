//
//  Double.swift
//  PayNas
//
//  Created by Nora on 4/18/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import Foundation

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

