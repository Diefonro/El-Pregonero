//
//  UIView+Extension.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

protocol DesignableCorner {
    var cornerRadius: CGFloat { get set }
}

extension UIView {
    func addCircularGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0.1, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradientLayer)
    }
}

@IBDesignable extension UIView: DesignableCorner {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
