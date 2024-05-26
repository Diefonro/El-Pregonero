//
//  ArticleCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    @IBOutlet weak var newsAuthorImageView: UIImageView!
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var publishedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
