//
//  TNNews.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import Foundation

// MARK: - TNNews
struct TNNews: Codable {
    let data: [Datum]?
    
    func getNews() -> [Datum] {
        guard let data = data, !data.isEmpty else {
            return []
        }

        return data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let title, description: String
    let url: String
    let imageURL: String
    let publishedAt, source: String

    enum CodingKeys: String, CodingKey {
        case title, description, url
        case imageURL = "image_url"
        case publishedAt = "published_at"
        case source
    }
}
