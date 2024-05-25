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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getNews()
    }

    func setViewModel(viewModel: NewsScreenViewModel) {
        self.viewModel = viewModel
    }
    
}

