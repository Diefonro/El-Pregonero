//
//  UIImageView+Extension.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func showScaleEffectAnimated() {
        UIView.animate(withDuration: 3.0, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: nil)
    }
    
    func setImage(from url: URL) {
        self.kf.setImage(with: url)
    }
}
