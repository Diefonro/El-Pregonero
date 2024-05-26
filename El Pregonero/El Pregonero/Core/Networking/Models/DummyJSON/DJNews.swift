//
//  DJNews.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import Foundation

// MARK: - DJNews
struct DJNews: Codable {
    let posts: [Post]?
    let total, skip, limit: Int
    
    func getNews() -> [Post] {
        guard let posts = posts, !posts.isEmpty else {
            return []
        }

        return posts
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let title, body: String
    let tags: [String]
    let reactions: Reactions
    let views, userID: Int

    enum CodingKeys: String, CodingKey {
        case id, title, body, tags, reactions, views
        case userID = "userId"
    }
}

// MARK: - Reactions
struct Reactions: Codable {
    let likes, dislikes: Int
}
