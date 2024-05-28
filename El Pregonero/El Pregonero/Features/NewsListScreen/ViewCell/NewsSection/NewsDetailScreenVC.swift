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
    var jpData: NewsElement?
    var tnData: Datum?
    var djData: Post?
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsStatusLabel: UILabel!
    @IBOutlet weak var goToNewButton: UIButton!
    @IBOutlet weak var retrievedFromLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = navTitle
        if let jpData = jpData {
            setupJPData(with: jpData)
        }
        if let tnData = tnData {
            setupTNData(with: tnData)
        }
        if let djData = djData {
            setupDJData(with: djData)
        }
    }
    
    func setupJPData(with jpData: NewsElement) {
        newsImageView.setImage(from: URL(string: jpData.image)!)
        newsTitleLabel.text = jpData.title
        newsAuthorLabel.text = "Written by: \(jpData.slug)"
        newsContentLabel.text = jpData.content
        newsDateLabel.text = jpData.publishedAt
        newsStatusLabel.text = "Status: \(jpData.status.capitalized)"
        goToNewButton.setTitle("Go to site!", for: .normal)
        goToNewButton.accessibilityHint = jpData.url
        
        if let date = jpData.publishedAt.toDate() {
            newsDateLabel.text = "Published at \(date.formattedPublishedDate())."
        }
    }
    
    func setupTNData(with tnData: Datum) {
        newsImageView.setImage(from: URL(string: tnData.imageURL)!)
        newsTitleLabel.text = tnData.title
        newsAuthorLabel.text = "Written by: \(tnData.source)"
        newsContentLabel.text = tnData.description
        goToNewButton.setTitle("Go to site!", for: .normal)
        goToNewButton.accessibilityHint = tnData.url
        
        if let date = tnData.publishedAt.toDate() {
            newsDateLabel.text = "Published at \(date.formattedPublishedDate())."
        }
    }
    
    func setupDJData(with djData: Post) {
        newsImageView.image = UIImage(systemName: "newspaper")
        newsTitleLabel.text = djData.title
        newsAuthorLabel.text = "Likes: \(djData.reactions.likes)"
        newsContentLabel.text = djData.body
        retrievedFromLabel.text = "Dislikes: \(djData.reactions.dislikes)"
        goToNewButton.isHidden = true
    }
    
    
    @IBAction func goToNewButtonAction(_ sender: UIButton) {
        if let link = sender.accessibilityHint, let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}
