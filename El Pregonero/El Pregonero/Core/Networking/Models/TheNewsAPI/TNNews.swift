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
    let uuid, title, description, keywords: String
    let snippet: String
    let url: String
    let imageURL: String
    let language, publishedAt, source: String
    let categories: [String]
    let relevanceScore: String?
    let locale: String

    enum CodingKeys: String, CodingKey {
        case uuid, title, description, keywords, snippet, url
        case imageURL = "image_url"
        case language
        case publishedAt = "published_at"
        case source, categories
        case relevanceScore = "relevance_score"
        case locale
    }
}
