//
//  UIScrollView.swift
//  PayNas
//
//  Created by Nora on 4/17/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView{
    
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}
