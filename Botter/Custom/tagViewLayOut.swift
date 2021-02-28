//
//  tagViewLayOut.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class b_tagViewLayOut: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        // use a value to keep track of left margin
        var leftMargin: CGFloat = self.sectionInset.left;
        var oldY : CGFloat = 0.0
        for attributes in attributesForElementsInRect! {
            let refAttributes = attributes
            // assign value if next row
            if oldY == 0{
                oldY = refAttributes.frame.origin.y
            }
            if (refAttributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            }else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            
            if refAttributes.frame.maxX > rect.maxX {
//                print("offLimit")
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = self.sectionInset.left
                refAttributes.frame = newLeftAlignedFrame
                
                leftMargin = self.sectionInset.left
            }
            
            if oldY != refAttributes.frame.origin.y && refAttributes.frame.origin.x != self.sectionInset.left{
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = self.sectionInset.left
                refAttributes.frame = newLeftAlignedFrame
                
                leftMargin = self.sectionInset.left
            }
            
            leftMargin += refAttributes.frame.size.width +  self.sectionInset.right
            oldY = refAttributes.frame.origin.y
            
            
            newAttributesForElementsInRect.append(refAttributes)
        }
        return newAttributesForElementsInRect
    }
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        var attributesForElementsInRect =
//    }
    
}

class selectionViewLayOut: UICollectionViewFlowLayout {
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
//        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
//        // use a value to keep track of left margin
//        var leftMargin: CGFloat = 0.0;
//        for attributes in attributesForElementsInRect! {
//            let refAttributes = attributes
//            // assign value if next row
//            if (refAttributes.frame.origin.x == self.sectionInset.left) {
//                leftMargin = self.sectionInset.left
//            } else {
//                // set x position of attributes to current margin
//                var newLeftAlignedFrame = refAttributes.frame
//                newLeftAlignedFrame.origin.x = leftMargin
//                refAttributes.frame = newLeftAlignedFrame
//            }
//            // calculate new value for current margin
//            leftMargin += refAttributes.frame.size.width + 8
//            newAttributesForElementsInRect.append(refAttributes)
//        }
//        return newAttributesForElementsInRect
//    }
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        var attributesForElementsInRect =
//    }
    
}
