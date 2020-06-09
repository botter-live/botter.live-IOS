//
//  GradientView.swift
//  MyLexus
//
//  Created by Nora Sayed on 7/22/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class GradientView: UIView {
    @IBInspectable
    public var startColor: UIColor = .clear {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var endColor: UIColor = .clear {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
@IBDesignable
public class GradientHView: UIView {
    private func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    private var gradient: CAGradientLayer?

    @IBInspectable
    public var color1: UIColor? {
        didSet {
            updateColors()
        }
    }

    @IBInspectable
    public var color2: UIColor? {
        didSet {
            updateColors()
        }
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        gradient = createGradient()
        updateColors()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        gradient = createGradient()
        updateColors()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradient?.frame = bounds
    }

    private func updateColors() {
        guard
            let color1 = color1,
            let color2 = color2
        else {
            return
        }

        gradient?.colors = [color1.cgColor, color2.cgColor]
    }
}
extension UIView {
    func insertHorizontalGradient(_ color1: UIColor, _ color2: UIColor) -> GradientHView {
        let gradientView = GradientHView(frame: bounds)
        gradientView.color1 = color1
        gradientView.color2 = color2
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.tag = 101
        if let prev = self.viewWithTag(101){
            prev.removeFromSuperview()
        }
        self.insertSubview(gradientView, at: 0)
        return gradientView
    }
}
