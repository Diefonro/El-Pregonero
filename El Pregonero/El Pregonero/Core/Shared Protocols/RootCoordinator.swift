//
//  RootCoordinator.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

class RootCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let tabBarScreen = UIStoryboard(name: TabBarScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: TabBarScreenVC.identifier) as? TabBarScreenVC {
            var controller: UIViewController & Coordinating = tabBarScreen
            controller.coordinator = self
            navigationController?.setViewControllers([controller], animated: false)
        }
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}
