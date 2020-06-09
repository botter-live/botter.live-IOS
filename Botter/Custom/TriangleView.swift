//
//  TriangleView.swift
//  Loreal Medical
//
//  Created by Nora on 3/27/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit

class TriangleView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
//        context!.setFillColor(UIColor.white as! CGColor)
//        context!.fill(rect)
        // Imagine a triangle resting on the bottom of the container with the base as the width of the rectangle, and the apex of the triangle at the top center of the container
        // The co-ordinates of the rectangle will look like
        // Left = (x: 0 - origin , y:half of Container Height)
        // Top Right = (x: Container Width , y: 0 )
        // Bottom Right = (x: Container Width, y: Container Height)
        
        // Create path for drawing a triangle
        let trianglePath = UIBezierPath()
        // First move to the Right point
        trianglePath.move(to: CGPoint(x: 0.0 , y: self.bounds.height/2))
        // Add line to Top Right
        trianglePath.addLine(to: CGPoint(x: self.bounds.width, y: 0.0))
        // Add line to Bottom Left
        trianglePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        // Complete path by drawing path to the Top
        trianglePath.addLine(to: CGPoint(x: 0.0 , y: self.bounds.height/2))
        
        trianglePath.close()
//        trianglePath.stroke()
        // Set the fill color
        context!.setFillColor(UIColor.white.cgColor)
        // Fill the triangle path
        trianglePath.fill()
//        CGContextFillPath(CGContext?)  // Fills the path using the context parameters
//        CGContextStrokePath(CGContext?) // Draws/strokes the path using the context parameters
    }

}
