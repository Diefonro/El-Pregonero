//
//  NewsListScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 24/05/2024.
//

import UIKit

class NewsListScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "NewsListScreen"
    static var identifier = "NewsListScreenVC"
    
    var viewModel: NewsScreenViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getNews {
            DispatchQueue.main.async {
                self.titleLabel.text = DataManager.newsData.first?.title ?? "not available"
            }
        }
    }

    func setViewModel(viewModel: NewsScreenViewModel) {
        self.viewModel = viewModel
    }
    
}

