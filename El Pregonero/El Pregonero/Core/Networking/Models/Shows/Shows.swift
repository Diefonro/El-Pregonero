//
//  Shows.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import Foundation

// MARK: - Shows
struct Shows: Codable {
    let shows: [Show]?
    let hasMore: Bool
    let nextCursor: String
    
    func getShows() -> [Show] {
        guard let shows = shows, !shows.isEmpty else {
            return []
        }

        return shows
    }
}

// MARK: - Show
struct Show: Codable {
    let itemType: ItemType
    let showType: ShowType
    let id, imdbID, tmdbID, title: String
    let overview: String
    let releaseYear: Int?
    let originalTitle: String
    let genres: [Genre]
    let directors: [String]?
    let cast: [String]
    let rating: Int
    let imageSet: ShowImageSet
    let streamingOptions: StreamingOptions
    let firstAirYear, lastAirYear: Int?
    let creators: [String]?
    let seasonCount, episodeCount: Int?

    enum CodingKeys: String, CodingKey {
        case itemType, showType, id
        case imdbID = "imdbId"
        case tmdbID = "tmdbId"
        case title, overview, releaseYear, originalTitle, genres, directors, cast, rating, imageSet, streamingOptions, firstAirYear, lastAirYear, creators, seasonCount, episodeCount
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id, name: String
}

// MARK: - ShowImageSet
struct ShowImageSet: Codable {
    let verticalPoster: Vertical
    let horizontalPoster: Horizontal
    let verticalBackdrop: Vertical?
    let horizontalBackdrop: Horizontal?
}

// MARK: - Horizontal
struct Horizontal: Codable {
    let w360, w480, w720, w1080: String
    let w1440: String
}

// MARK: - Vertical
struct Vertical: Codable {
    let w240, w360, w480, w600: String
    let w720: String
}

enum ItemType: String, Codable {
    case show = "show"
}

enum ShowType: String, Codable {
    case movie = "movie"
    case series = "series"
}

// MARK: - StreamingOptions
struct StreamingOptions: Codable {
    let us: [Me]
}

// MARK: - Me
struct Me: Codable {
    let service: Addon
    let type: TypeEnum
    let link: String
    let quality: Quality?
    let audios: [Audio]
    let subtitles: [Subtitle]
    let price: Price?
    let expiresSoon: Bool
    let availableSince: Int
    let videoLink: String?
    let expiresOn: Int?
    let addon: Addon?
}

// MARK: - Addon
struct Addon: Codable {
    let id, name: String
    let homePage: String
    let themeColorCode: String
    let imageSet: AddonImageSet
}

// MARK: - AddonImageSet
struct AddonImageSet: Codable {
    let lightThemeImage, darkThemeImage, whiteImage: String
}

// MARK: - Audio
struct Audio: Codable {
    let language: String
    let region: Region?
}

enum Region: String, Codable {
    case usa = "USA"
}

// MARK: - Price
struct Price: Codable {
    let amount: String
    let currency: Currency
    let formatted: String
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Quality: String, Codable {
    case hd = "hd"
    case sd = "sd"
    case uhd = "uhd"
}

// MARK: - Subtitle
struct Subtitle: Codable {
    let closedCaptions: Bool
    let locale: Audio
}

enum TypeEnum: String, Codable {
    case addon = "addon"
    case buy = "buy"
    case free = "free"
    case rent = "rent"
    case subscription = "subscription"
}
