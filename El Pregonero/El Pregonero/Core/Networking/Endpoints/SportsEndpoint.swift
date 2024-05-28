//
//  SportsEndpoint.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 27/05/2024.
//

import UIKit

enum SportsEndpoint {
    case matches
}

extension SportsEndpoint: Endpoint {
    var host: String {
        switch self {
        case .matches:
            return "apigenerator.dronahq.com"
        }
    }
    
    var path: String {
        switch self {
        case .matches:
            return "/api/_JQH5H6a/matchesData"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .matches:
            return nil
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .matches:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .matches:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .matches:
            return nil
        }
    }
}
