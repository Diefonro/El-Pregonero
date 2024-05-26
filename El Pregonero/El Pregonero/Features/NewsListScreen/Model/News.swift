//
//  News.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation

// MARK: - NewsElement
struct NewsElement: Codable {
    let slug: String
    let url: String
    let title, content: String
    let image, thumbnail: String
    let publishedAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case url, title, content, image, thumbnail, publishedAt, updatedAt, slug
    }
}

typealias News = [NewsElement]
