//
//  LineArticleCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class LineArticleCell: UICollectionViewCell, CellInfo {
    static var reuseIdentifier = "LineArticleCell"
    

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    @IBOutlet weak var newsAuthorImageView: UIImageView!
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var publishedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupJPCell(with data: NewsElement) {
        self.newsHeadlineLabel.text = data.title
        self.articleImageView.setImage(from: URL(string: data.image)!)
        self.newsAuthorNameLabel.text = data.slug
    }
    
    func setupTNCell(with data: Datum) {
        self.newsHeadlineLabel.text = data.title
        self.articleImageView.setImage(from: URL(string: data.imageURL)!)
        self.newsAuthorNameLabel.text = data.source
    }
    
    func setupDJCell(with data: Post) {
        self.newsHeadlineLabel.text = data.title
        self.articleImageView.image = UIImage(systemName: "newspaper")
        self.newsAuthorNameLabel.text = String(data.userID)
    }

}
