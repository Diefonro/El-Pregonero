//
//  UserPicture.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import Foundation

struct Results: Decodable {
    var results: [UsersPics]?
    
    func getResults() -> [UsersPics] {
        guard let results = results, !results.isEmpty else {
            return []
        }
        return results
    }
}

struct UsersPics: Decodable {
    var picture: Picture
}

struct Picture: Decodable {
    var large: String
}

typealias Pictures = [Picture]
