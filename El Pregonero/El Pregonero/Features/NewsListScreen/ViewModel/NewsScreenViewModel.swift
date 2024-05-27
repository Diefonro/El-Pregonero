//
//  NewsScreenViewModel.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

class NewsScreenViewModel {
    
    let newsServices = NewsServices()
    let showsServices = ShowsServices()
    
    func getJPNews(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await newsServices.getJPNews()
            switch result {
            case .success(let news):
                DataManager.newsJPData = news
                print("JP DATA: \(news)")
                print("JP DATA END")
                completion()
            case .failure(let error):
                AppError.handle(error: error)
                completion()            }
        }
    }

    func getTNNews(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await newsServices.getTNNews()
            switch result {
            case .success(let news):
                let data = news.getNews()
                DataManager.newsTNData = data
                print("TN DATA: \(news)")
                print("TN DATA END")
                completion()
            case .failure(let error):
                AppError.handle(error: error)
                completion()
            }
        }
    }

    func getDJNews(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await newsServices.getDJNews()
            switch result {
            case .success(let news):
                let data = news.getNews()
                DataManager.newsDJData = data
                print("DJ DATA: \(news)")
                print("DJ DATA END")
                completion()
            case .failure(let error):
                AppError.handle(error: error)
                completion()
            }
        }
    }
    
    func getShows(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await showsServices.getShows()
            switch result {
            case .success(let shows):
                let data = shows.getShows()
                DataManager.showsData = data
                completion()
            case .failure(let error):
                AppError.handle(error: error)
            }
        }
    }

}
