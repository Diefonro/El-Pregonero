//
//  TabBarScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

class TabBarScreenVC: UITabBarController, StoryboardInfo, Coordinating {
    
    var coordinator: Coordinator?
    
    static var storyboard = "TabBarScreen"
    static var identifier = "TabBarScreenVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coordinator?.showNavigationBar(animated: true)
        self.navigationItem.title = "El Pregonero"
        self.navigationItem.hidesBackButton = true
        addNavBarImage()
    }
    
    func setCoordinator(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    func addNavBarImage() {
        var imageView = UIImageView(image: UIImage())
        if let originalImage = UIImage(named: "ElPregoneroLogo") {
            let targetSize = CGSize(width: 150, height: 35)
            if let resizedImage = originalImage.resized(to: targetSize) {
                imageView = UIImageView(image: resizedImage)
            }
        }
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func configureControllers() {
        
        if let newsScreen = UIStoryboard(name: NewsListScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: NewsListScreenVC.identifier) as? NewsListScreenVC,
           let usersScreen = UIStoryboard(name: UsersListScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: UsersListScreenVC.identifier) as? UsersListScreenVC {
            
            newsScreen.title = "News"
            newsScreen.tabBarItem.image = UIImage(systemName: "newspaper.fill")
            usersScreen.title = "Users"
            usersScreen.tabBarItem.image = UIImage(systemName: "person.fill")
            
            newsScreen.setCoordinator(coordinator: NewsScreenCoordinator(coordinator: self.coordinator))
            newsScreen.setViewModel(viewModel: NewsScreenViewModel())
            viewControllers = [newsScreen, usersScreen]
        }
    }
}
