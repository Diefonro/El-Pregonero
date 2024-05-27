//
//  NewsScreenViewModel.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import UIKit

class NewsScreenViewModel {
    
    let newsServices = NewsServices()
    let showsServices = ShowsServices()
    
    //MARK: JSONPlaceholder functions
    func getJPName() -> String {
        return "JSONPlaceholder News"
    }
    
    func getJPImageURL() -> String {
        let url: String? = "https://t4.ftcdn.net/jpg/04/90/12/03/360_F_490120385_ItvA6z5uXYx1x89dpWBgK0wTEHrMWO78.jpg"

        if let imageURL = url {
            return imageURL
        }
        
        return ""
    }

    //MARK: TheNewsAPI functions
    func getTNName() -> String {
        return "TheNewsAPI News"
    }
    
    func getTNImageURL() -> String {
        let url: String? = "https://cdn-images-1.medium.com/max/1200/1*On6A3Q86PMCZYgv8qYzqiA.jpeg"

        if let imageURL = url {
            return imageURL
        }
        
        return ""
    }

    //MARK: DummyJSON functions
    func getDJName() -> String {
        return "DummyJSON News"
    }
    
    func getDJImageURL() -> String {
        let url: String? = "https://media.licdn.com/dms/image/D4D0BAQFoGJnV8KPtyg/company-logo_200_200/0/1716490112820/dummyjson_logo?e=1724889600&v=beta&t=qQnRGJ2-AazQCU5QLYgS-P8bsU5WrYsf34TPzX_yMwk"

        if let imageURL = url {
            return imageURL
        }
        
        return ""
    }
    
    //MARK: ShowsAPI
    func getShows(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let result = await showsServices.getShows()
            switch result {
            case .success(let shows):
                let data = shows.getShows()
                DataManager.showsData = data
                print("SHOWS DATA: \(DataManager.showsData.count), \(DataManager.showsData)")
                completion()
            case .failure(let error):
                AppError.handle(error: error)
            }
        }
    }

    func getNews(completion: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            async let jpNewsResult = newsServices.getJPNews()
            async let tnNewsResult = newsServices.getTNNews()
            async let djNewsResult = newsServices.getDJNews()
            
            let jpNewsOutcome = await jpNewsResult
            let tnNewsOutcome = await tnNewsResult
            let djNewsOutcome = await djNewsResult
            
            switch jpNewsOutcome {
            case .success(let news):
                DataManager.newsJPData = news
                NotificationCenter.default.post(name: .didUpdateJPNewsData, object: nil)
            case .failure(let error):
                AppError.handle(error: error)
            }
            
            switch tnNewsOutcome {
            case .success(let news):
                DataManager.newsTNData = news.getNews()
                NotificationCenter.default.post(name: .didUpdateJPNewsData, object: nil)
            case .failure(let error):
                AppError.handle(error: error)
            }
            
            switch djNewsOutcome {
            case .success(let news):
                DataManager.newsDJData = news.getNews()
                NotificationCenter.default.post(name: .didUpdateDJNewsData, object: nil)
            case .failure(let error):
                AppError.handle(error: error)
            }
            completion()
        }
    }
}

extension Notification.Name {
    static let didUpdateDJNewsData = Notification.Name("didUpdateDJNewsData")
    static let didUpdateJPNewsData = Notification.Name("didUpdateJPNewsData")
    static let didUpdateTNNewsData = Notification.Name("didUpdateTNNewsData")
}
