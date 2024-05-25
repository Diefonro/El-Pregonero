//
//  TabBarScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

class TabBarScreenVC: UITabBarController, StoryboardInfo, Coordinating {
    var coordinator: (any Coordinator)?
    
    static var storyboard = "TabBarScreen"
    static var identifier = "TabBarScreenVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureControllers()
    }
    
    func configureControllers() {
        //MARK: Here you must add new controllers for tabbar items
        if let newsScreen = UIStoryboard(name: NewsListScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: NewsListScreenVC.identifier) as? NewsListScreenVC,
           let usersScreen = UIStoryboard(name: UsersListScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: UsersListScreenVC.identifier) as? UsersListScreenVC {
            newsScreen.title = "News"
            usersScreen.title = "Users"
            
            newsScreen.setViewModel(viewModel: NewsScreenViewModel())
            viewControllers = [newsScreen, usersScreen]
        }
    }

}
