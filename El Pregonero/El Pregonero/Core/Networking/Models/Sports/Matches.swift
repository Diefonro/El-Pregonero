//
//  Matches.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 27/05/2024.
//

import Foundation

// MARK: - MatchList
struct MatchList: Codable {
    let matches: [MatchElement]?
    
    func getMatches() -> [MatchElement] {
        guard let matches = matches, !matches.isEmpty else {
            return []
        }
        return matches
    }
}

// MARK: - MatchElement
struct MatchElement: Codable {
    let competition: String
    let utcDate: String
    let homeTeam, awayTeam: Team
    let score: Score
    let referee, status: String
    let news: [News]?
    
    func getNews() -> [News] {
        guard let news = news, !news.isEmpty else {
            return []
        }
        return news
    }
}

// MARK: - Team
struct Team: Codable {
    let name, nameShort: String
    let crest: String
}

// MARK: - News
struct News: Codable {
    let source: String
    let author, title, description: String
    let urlImage: String
    let publishedAt: String
}

// MARK: - Score
struct Score: Codable {
    let winner: String
    let home, away: Int
}

typealias Matches = [MatchList]
