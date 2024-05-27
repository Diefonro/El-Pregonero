//
//  NewsScreenCoordinator.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class NewsScreenCoordinator: Coordinating {
    var coordinator: (any Coordinator)?
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    func showNavigationBar(animated: Bool = false) {
        self.coordinator?.showNavigationBar(animated: animated)
    }
    
    func hideNavigationBar(animated: Bool = false) {
        self.coordinator?.hideNavigationBar(animated: animated)
    }
    
    func popToRootController(animated: Bool) {
        self.coordinator?.popToRootController(animated: animated)
    }
    
    func pop(animated: Bool) {
        self.coordinator?.pop(animated: animated)
    }
    
    func enableDragPopGesture() {
        self.coordinator?.enableDragPopGesture()
    }
    
    func disableDragPopGesture() {
        self.coordinator?.disableDragPopGesture()
    }
    
    func pushToSubcategoryDetail() {
        if let subcategoryDetailController = UIStoryboard(name: UsersListScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: UsersListScreenVC.identifier) as? UsersListScreenVC {
            self.coordinator?.push(viewController: subcategoryDetailController, animated: true)
        }
    }
}
