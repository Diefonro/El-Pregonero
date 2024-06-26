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
    
    func pushToProgramDetail(with data: Show, navTitle: String) {
        if let detailScreen = UIStoryboard(name: ProgramDetailScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: ProgramDetailScreenVC.identifier) as? ProgramDetailScreenVC {
            detailScreen.data = data
            detailScreen.navTitle = navTitle
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }
    
    func pushToJPNewsDetail(with jpData: NewsElement, navTitle: String) {
        if let detailScreen = UIStoryboard(name: NewsDetailScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: NewsDetailScreenVC.identifier) as? NewsDetailScreenVC {
            detailScreen.jpData = jpData
            detailScreen.navTitle = navTitle
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }
    
    func pushToJPNewsExtended(with jpData: NewsElement, with navTitle: String, with cellIndex: Int, with newsCoordinator: NewsScreenCoordinator) {
        if let detailScreen = UIStoryboard(name: NewsExtendedScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: NewsExtendedScreenVC.identifier) as? NewsExtendedScreenVC {
            detailScreen.navTitle = navTitle
            detailScreen.cellIndex = cellIndex
            detailScreen.coordinator = newsCoordinator
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }

    func pushToTNNewsDetail(with tnData: Datum, navTitle: String) {
        if let detailScreen = UIStoryboard(name: NewsDetailScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: NewsDetailScreenVC.identifier) as? NewsDetailScreenVC {
            detailScreen.tnData = tnData
            detailScreen.navTitle = navTitle
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }

    func pushToDJNewsDetail(with djData: Post, navTitle: String) {
        if let detailScreen = UIStoryboard(name: NewsDetailScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: NewsDetailScreenVC.identifier) as? NewsDetailScreenVC {
            detailScreen.djData = djData
            detailScreen.navTitle = navTitle
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }

    func pushToMatchDetail(with data: News, with matchData: MatchElement, navTitle: String) {
        if let detailScreen = UIStoryboard(name: MatchDetailScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: MatchDetailScreenVC.identifier) as? MatchDetailScreenVC {
            detailScreen.matchData = matchData
            detailScreen.data = data
            detailScreen.navTitle = navTitle
            self.coordinator?.push(viewController: detailScreen, animated: true)
        }
    }
    
    
}
