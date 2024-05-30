//
//  ProgramCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit
import Lottie

class ProgramCell: UICollectionViewCell, CellInfo{
    
    static var reuseIdentifier = "ProgramCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var lottieView: NLottieAnimation!
    @IBOutlet weak var noInfoView: NoInfoView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lottieView.changeLottie(lottieName: "ShowLottie")
    }
    
    func setupCell(with data: Show) {
        self.imageView.setImage(from: URL(string: data.getImageSet().getVerticalPoster().on720())!)
        self.showNameLabel.text = data.title
    }
    
    func updateUIWithData() {
        self.lottieView.isHidden = true
        self.showNameLabel.isHidden = false
    }
    
    func updateUIWithNoData() {
        self.lottieView.isHidden = true
        self.noInfoView.isHidden = false
        self.showNameLabel.isHidden = true
    }
}
