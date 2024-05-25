//
//  NewsEndpoint.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

enum NewsEndpoint {
    case news
}

extension NewsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .news:
            return "/posts"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .news:
            return nil
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .news:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .news:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .news:
            return nil
        }
    }
}
