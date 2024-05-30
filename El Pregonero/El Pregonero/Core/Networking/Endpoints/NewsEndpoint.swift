//
//  NewsEndpoint.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

enum NewsEndpoint {
    case newsJP
    case newsTN(page: Int)
    case newsDJ
}

extension NewsEndpoint: Endpoint {
    
    var host: String {
        switch self {
        case .newsJP:
            return "jsonplaceholder.org"
        case .newsTN:
            return "api.thenewsapi.com"
        case .newsDJ:
            return "dummyjson.com"
        }
    }
    
    var path: String {
        switch self {
        case .newsJP, .newsDJ:
            return "/posts"
        case .newsTN:
            return "/v1/news/tops"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .newsJP, .newsDJ:
            return nil
        case .newsTN(let page):
            let token = "renXuXDhdiG9AyAMDBYS8l2dYp2j24R2MYExdkWz"
            return [
                URLQueryItem(name: "api_token", value: token),
                URLQueryItem(name: "locale", value: "ar"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .newsJP, .newsDJ, .newsTN:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .newsJP, .newsDJ, .newsTN:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .newsJP, .newsDJ, .newsTN:
            return nil
        }
    }
}
