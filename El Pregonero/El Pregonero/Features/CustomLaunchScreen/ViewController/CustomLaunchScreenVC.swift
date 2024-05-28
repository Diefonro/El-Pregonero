//
//  CustomLaunchScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class CustomLaunchScreenVC: UIViewController, StoryboardInfo, Coordinating {
    
    var coordinator: Coordinator?

    static var storyboard = "CustomLaunchScreen"
    static var identifier = "CustomLaunchScreenVC"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        self.coordinator?.hideNavigationBar(animated: true)
        self.coordinator?.disableDragPopGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 3.0) {
            self.imageView.alpha = 1
            self.imageView.showScaleEffectAnimated()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.pushToTabBar()
        }
    }
    
    func pushToTabBar() {
        UIView.animate(withDuration: 3.0) {
            self.imageView.alpha = 0.1
        } completion: { _ in
            if let tabBarScreen = UIStoryboard(name: TabBarScreenVC.storyboard, bundle: nil)
                .instantiateViewController(withIdentifier: TabBarScreenVC.identifier) as? TabBarScreenVC {
                tabBarScreen.setCoordinator(coordinator: self.coordinator)
                self.coordinator?.push(viewController: tabBarScreen, animated: true)
            }
        }
    }
}
