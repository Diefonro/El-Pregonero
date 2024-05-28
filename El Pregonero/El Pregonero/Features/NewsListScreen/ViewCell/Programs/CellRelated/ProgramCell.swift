//
//  ProgramCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class ProgramCell: UICollectionViewCell, CellInfo{
    
    static var reuseIdentifier = "ProgramCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(with data: Show) {
        if let imageUrl = URL(string: data.getImageSet().getVerticalPoster().on720()) {
            self.imageView.setImage(from: imageUrl)
        } else {
            self.imageView.image = UIImage(named: "movieclapper.fill")
        }
        self.showNameLabel.text = data.title
    }
}
