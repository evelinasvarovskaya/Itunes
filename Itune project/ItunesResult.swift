//
//  ItunesResult.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 05.01.2023.
//

import Foundation

// MARK: - ItunesResult
struct ItunesResult: Codable {
    let resultCount: Int
    let results: [Results]
}

// MARK: - Result
struct Results: Codable {
    let wrapperType: WrapperType
    let kind: Kind
    let artistID, collectionID, trackID: Int?
    let trackName,artistName: String
    let collectionName: String?
        let collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
//    let releaseDate: Date?
    let collectionExplicitness, trackExplicitness: Explicitness?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: Country?
    let currency: Currency?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistID: Int?
    let collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
    }
}

enum Explicitness: String, Codable {
    case explicit
    case notExplicit
    case cleaned
}

enum Country: String, Codable {
    case rus = "RUS"
}

enum Currency: String, Codable {
    case rub = "RUB"
}

enum Kind: String, Codable {
    case musicVideo = "music-video"
    case song = "song"
}

enum WrapperType: String, Codable {
    case track = "track"
}
