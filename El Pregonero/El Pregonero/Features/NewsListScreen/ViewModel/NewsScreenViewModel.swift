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
    
    //MARK: NewsAPI's
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

    //MARK: Sections Dummy Data
    struct NewsCellData {
        let newsTitle: String
        let newsImage: String
    }

    let newsArray: [NewsCellData] = [
        NewsCellData(newsTitle: "Politics", newsImage: "https://wwd.com/wp-content/uploads/2020/10/political-story-main.jpg"),
        NewsCellData(newsTitle: "Economy", newsImage: "https://hmarkets.com/wp-media/2022/11/Background-screen-saver-on-economic-news-compressed-1024x614.jpg"),
        NewsCellData(newsTitle: "Technology", newsImage: "https://miro.medium.com/v2/resize:fit:554/1*vuJHrhjlkx5H9XxB4zcwtA.jpeg"),
        NewsCellData(newsTitle: "Health", newsImage: "https://domf5oio6qrcr.cloudfront.net/medialibrary/12031/e8e80fe7-0a4a-40f2-9163-b773c86e52e4.jpg"),
        NewsCellData(newsTitle: "Science", newsImage: "https://play-lh.googleusercontent.com/gh3LvP3YXG1Bh5QwQ9r1jXdBcealicPNDqqmyv1JTs_tFkGkb70ltIVlUfZmosF3DA"),
        NewsCellData(newsTitle: "Environment", newsImage: "https://cdn.outsideonline.com/wp-content/uploads/2019/05/02/good-news-environment_h.jpg"),
        NewsCellData(newsTitle: "Education", newsImage: "https://static01.nyt.com/images/2023/07/13/multimedia/13a2_ITT-gpvk/13a2_ITT-gpvk-articleLarge.jpg?quality=75&auto=webp&disable=upscale"),
        NewsCellData(newsTitle: "Sports", newsImage: "https://blog.feedspot.com/wp-content/uploads/2017/11/sports.jpg?x30630"),
        NewsCellData(newsTitle: "Entertainment", newsImage: "https://cdn.cnn.com/cnnnext/dam/assets/221206144523-handler-jones-leguizamo-split-large-tease.jpg"),
        NewsCellData(newsTitle: "World", newsImage: "https://media.cnn.com/api/v1/images/stellar/prod/240526184946-rafah-airstrike-052624-dle-card.jpg?c=16x9&q=h_438,w_780,c_fill")
    ]

}

extension Notification.Name {
    static let didUpdateDJNewsData = Notification.Name("didUpdateDJNewsData")
    static let didUpdateJPNewsData = Notification.Name("didUpdateJPNewsData")
    static let didUpdateTNNewsData = Notification.Name("didUpdateTNNewsData")
}
