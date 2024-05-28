//
//  NewsSectionCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class NewsSectionCell: UICollectionViewCell, CellInfo {
    
    static var reuseIdentifier = "NewsSectionCell"
    
    @IBOutlet weak var newsSectionImageView: UIImageView!
    @IBOutlet weak var newsSectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsSectionImageView.addCircularGradient()
    }
    
    func setupCellH(image: String?, sport: String?) {
        self.newsSectionImageView.setImage(from: URL(string: image!)!)
        self.newsSectionNameLabel.text = sport
    }

}
