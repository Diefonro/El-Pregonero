//
//  NewsScreenViewModel.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

class NewsScreenViewModel {
    
    let newsServices = NewsServices()
    
    func getNews() {
        Task(priority: .userInitiated) {
            let result = await newsServices.getNews()
            switch result {
            case .success(let news):
                print("NEWS DATA: \(news)")
            case .failure(let error):
                AppError.handle(error: error)
            }
        }
    }
}
