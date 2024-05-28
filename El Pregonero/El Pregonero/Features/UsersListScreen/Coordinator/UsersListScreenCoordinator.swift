//
//  UsersListScreenCoordinator.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class UsersListScreenCoordinator: Coordinating {
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
    
    func pushToUserMap(with data: User, showAllUsers: Bool = false) {
        if let detailScreen = UIStoryboard(name: UserListMapScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: UserListMapScreenVC.identifier) as? UserListMapScreenVC {
            detailScreen.data = data
            detailScreen.showAllUsers = showAllUsers
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }
}
