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

@IBDesignable extension UIView: DesignableCorner {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
