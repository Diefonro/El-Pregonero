//
//  NewsServices.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

protocol NewsServiceable {
    func getJPNews() async -> Result<JPNews, RequestError>
    func getTNNews(page: Int) async -> Result<TNNews, RequestError>
    func getDJNews() async -> Result<DJNews, RequestError>
}

class NewsServices: HTTPClient, NewsServiceable {
    func getJPNews() async -> Result<JPNews, RequestError> {
        return await sendRequest(endpoint: NewsEndpoint.newsJP, responseModel: JPNews.self)
    }
    
    func getTNNews(page: Int) async -> Result<TNNews, RequestError> {
        return await sendRequest(endpoint: NewsEndpoint.newsTN(page: page), responseModel: TNNews.self)
    }
    
    func getDJNews() async -> Result<DJNews, RequestError> {
        return await sendRequest(endpoint: NewsEndpoint.newsDJ, responseModel: DJNews.self)
    }
}
