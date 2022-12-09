//
//  Movie.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation
import CoreData

// MARK: - Welcome
struct MoviesList: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Film]
}

// MARK: - Result
struct Film: Codable {
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }

    @discardableResult
    func toEntity(context: NSManagedObjectContext) -> Movie {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newMovie = Movie(context: context)
        var idFilm = url
        idFilm.removeLast()
        newMovie.id = Int16(String(idFilm.last ?? "0")) ?? 0
        newMovie.title = title
        newMovie.director = director
        newMovie.producer = producer
        newMovie.openingCrawl = openingCrawl
        newMovie.episodeId = Int16(episodeID)
        let charactersIds = characters.map { char in
            var charUrl = char
            charUrl.removeLast()
            return String(charUrl[(charUrl.index(after: charUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: charUrl)))...])
        }
        let planetsIds = planets.map { plan in
            var platUrl = plan
            platUrl.removeLast()
            return String(platUrl[(platUrl.index(after: platUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: platUrl)))...])
        }
        let speciesIds = species.map { spe in
            var specUrl = spe
            specUrl.removeLast()
            return String(specUrl[(specUrl.index(after: specUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: specUrl)))...])
        }
        let vehiclesIds = vehicles.map { veh in
            var vehiUrl = veh
            vehiUrl.removeLast()
            return String(vehiUrl[(vehiUrl.index(after: vehiUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: vehiUrl)))...])
        }
        let starshipsIds = starships.map { char in
            var specUrl = char
            specUrl.removeLast()
            return String(specUrl[(specUrl.index(after: specUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: specUrl)))...])
        }
        newMovie.charactersIds = MovieManagerLocal.getStringFromIds(idList: charactersIds)
        newMovie.planetsIds = MovieManagerLocal.getStringFromIds(idList: planetsIds)
        newMovie.speciesIds = MovieManagerLocal.getStringFromIds(idList: speciesIds)
        newMovie.starshipsIds = MovieManagerLocal.getStringFromIds(idList: starshipsIds)
        newMovie.vehiclesIds = MovieManagerLocal.getStringFromIds(idList: vehiclesIds)
        newMovie.releaseDate = dateFormatter.date(from: releaseDate) ?? Date()
        newMovie.createdAt = Date()
        newMovie.updatedAt = Date()
        return newMovie
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self,
                                             DecodingError.Context(codingPath: decoder.codingPath,
                                                                   debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
