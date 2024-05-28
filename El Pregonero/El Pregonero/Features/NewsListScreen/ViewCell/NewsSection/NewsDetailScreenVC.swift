//
//  NewsDetailScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class NewsDetailScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "NewsDetailScreen"
    static var identifier = "NewsDetailScreenVC"
    
    var navTitle = ""
    var data: NewsElement?
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsStatusLabel: UILabel!
    @IBOutlet weak var goToNewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = navTitle
        setupData(with: data!)
    }
    
    func setupData(with data: NewsElement) {
        self.newsImageView.setImage(from: URL(string: data.image)!)
        self.newsTitleLabel.text = data.title
        self.newsAuthorLabel.text = "Written by: \(data.slug)"
        self.newsContentLabel.text = data.content
        self.newsDateLabel.text = data.publishedAt
        self.newsStatusLabel.text = "Status: \(data.status)"
        self.goToNewButton.setTitle("Go to site!", for: .normal)
        self.goToNewButton.accessibilityHint = data.url

        let dateString = data.publishedAt
        if let date = dateString.toDate() {
            newsDateLabel.text = "Published at \(date.formattedPublishedDate())."
        }
    }
    
    @IBAction func goToNewButtonAction(_ sender: UIButton) {
        if let link = sender.accessibilityHint, let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}
