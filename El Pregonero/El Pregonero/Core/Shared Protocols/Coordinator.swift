//
//  Coordinator.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func push(viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func showNavigationBar(animated: Bool)
    func hideNavigationBar(animated: Bool)
    func disableDragPopGesture()
}

extension Coordinator {
    func push(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func showNavigationBar(animated: Bool = false) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigationBar(animated: Bool = false) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func disableDragPopGesture() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
