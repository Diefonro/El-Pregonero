//
//  NewsServices.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

protocol NewsServiceable {
    func getNews() async -> Result<News, RequestError>
}

class NewsServices: HTTPClient, NewsServiceable {
    func getNews() async -> Result<News, RequestError> {
        return await sendRequest(endpoint: NewsEndpoint.news, responseModel: News.self)
    }
}
