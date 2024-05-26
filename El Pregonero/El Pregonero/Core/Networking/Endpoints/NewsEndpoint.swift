//
//  NewsEndpoint.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

enum NewsEndpoint {
    case newsJP
    case newsTN
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
            return "/v1/news/top"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .newsJP, .newsDJ:
            return nil
        case .newsTN:
            let token = "7ei0SMjmSgIGEtYaM1KiTzNL3inQ9QYPz2Iij0qj"
            return [URLQueryItem(name: "api_token", value: token), URLQueryItem(name: "locale", value: "ar"), URLQueryItem(name: "page", value: "1")]
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
