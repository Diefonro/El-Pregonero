//
//  ArticleCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class ArticleCell: UICollectionViewCell, CellInfo {
    
    static var reuseIdentifier = "ArticleCell"
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    @IBOutlet weak var newsAuthorImageView: UIImageView!
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var publishedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with data: News) {
        self.newsAuthorImageView.image = UIImage(systemName: "newspaper")
        self.articleImageView.setImage(from: URL(string: data.urlImage)!)
        self.newsHeadlineLabel.text = data.title
        self.newsAuthorNameLabel.text = data.author
        
        let dateString = data.publishedAt
        if let date = dateString.toDate() {
            self.publishedTimeLabel.text = "Published \(date.timeAgoSinceNow())."
        }
    }

}
