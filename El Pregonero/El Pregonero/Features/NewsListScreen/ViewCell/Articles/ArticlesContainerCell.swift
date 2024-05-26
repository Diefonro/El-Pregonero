//
//  ArticlesContainerCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class ArticlesContainerCell: UICollectionViewCell {
    
    @IBOutlet weak var newsLetterImageView: UIImageView!
    @IBOutlet weak var newsLetterNameLabel: UILabel!
    @IBOutlet weak var collectionViewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
