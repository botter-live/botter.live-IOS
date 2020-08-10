//
//  TableViewExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//
import UIKit

public extension UITableView {
    
    func b_registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.b_className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func b_registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.b_className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func b_registerHeaderFooterViewClass(_ viewClass: AnyClass) {
        let identifier = String.b_className(viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func b_registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String.b_className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
}
