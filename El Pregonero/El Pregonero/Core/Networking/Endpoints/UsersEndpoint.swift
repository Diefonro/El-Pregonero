//
//  UsersEndpoint.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import Foundation

enum UsersEndpoint {
    case users
    case pictures
}

extension UsersEndpoint: Endpoint {
    var host: String {
        switch self {
        case .users:
            return "jsonplaceholder.org"
        case .pictures:
            return "randomuser.me"
        }
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        case .pictures:
            return "/api"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .users:
            return nil
        case .pictures:
            return [URLQueryItem(name: "results", value: "15")]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .users, .pictures:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .users, .pictures:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .users, .pictures:
            return nil
        }
    }
}
