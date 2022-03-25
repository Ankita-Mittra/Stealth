//
//  UIViewCustomGradientClass.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 23/03/2022.
//

import Foundation
import UIKit

@IBDesignable
class UIViewCustomGradientClass: UIView {

@IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
@IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
@IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
@IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
@IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
@IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

override class var layerClass: AnyClass { return CAGradientLayer.self }

var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

func updatePoints() {
    if horizontalMode {
        
        
        gradientLayer.startPoint = CGPoint(x: -0.4, y: -0.6)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.5)
//
//        gradientLayer.startPoint = CGPoint(x: -0.8, y: -0.8)
//        gradientLayer.endPoint = CGPoint(x: 0.6, y: 0.8)
//
//             gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
//             gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
    } else {
        
        gradientLayer.startPoint = CGPoint(x: -0.4, y: -0.6)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.5)
        
//        gradientLayer.startPoint = CGPoint(x: -0.8, y: -0.8)
//        gradientLayer.endPoint = CGPoint(x: 0.6, y: 0.8)
        
//             gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
//             gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
    }
}
func updateLocations() {
    gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
}
func updateColors() {
    gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
}

override func layoutSubviews() {
    super.layoutSubviews()
    updatePoints()
    updateLocations()
    updateColors()
}
}
