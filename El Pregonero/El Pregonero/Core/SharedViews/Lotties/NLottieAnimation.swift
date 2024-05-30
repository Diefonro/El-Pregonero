//
//  NLottieAnimation.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 29/05/2024.
//

import UIKit
import Lottie

class NLottieAnimation: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var lottieView: LottieAnimationView!
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           initSubviews()
       }

       override init(frame: CGRect) {
           super.init(frame: frame)
           initSubviews()
       }

       func initSubviews() {
           let nib = UINib(nibName: "NLottieAnimation", bundle: nil)
           nib.instantiate(withOwner: self, options: nil)
           contentView.frame = bounds
           addSubview(contentView)
           lottieView.loopMode = .loop
           changeLottie(lottieName: "NLoadingLottie")
       }
       
       func changeLottie(lottieName: String) {
           lottieView.animation = LottieAnimation.named(lottieName)
           lottieView.play()
       }

}
