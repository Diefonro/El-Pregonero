//
//  ShowsEndpoint.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

enum ShowsEndpoint {
    case shows
}

extension ShowsEndpoint: Endpoint {
    var host: String {
        switch self {
        case .shows:
            return "streaming-availability.p.rapidapi.com"
        }
    }
    
    var path: String {
        switch self {
        case .shows:
            return "/shows/search/filters"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .shows:
            return [URLQueryItem(name: "country", value: "us"), URLQueryItem(name: "cursor", value: "240855:'Neath Canadian Skies")]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .shows:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .shows:
            let token = "63ff6c1525msh99771ce8dac8c28p17daa8jsnfd24d469184a"
            return [
                "x-rapidapi-key": token,
                "x-rapidapi-host" : self.host
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .shows:
            return nil
        }
    }
}
