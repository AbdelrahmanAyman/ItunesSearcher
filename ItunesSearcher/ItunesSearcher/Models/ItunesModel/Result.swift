//
//  Result.swift
//  ItunesSearcher
//
//  Created by AH MARWAN  on 29/05/21.
//

import Foundation

struct Result : Codable {

    var artistId : Int?
    var artistName : String?
    var artworkUrl100 : String?
    var collectionName : String?
    var currency : String?
    var releaseDate : String?
    var trackName : String?
    var trackPrice : Float?
    
    enum CodingKeys: String, CodingKey {
        case artistId = "artistId"
        case artistName = "artistName"
        case artworkUrl100 = "artworkUrl100"
        case collectionName = "collectionName"
        case currency = "currency"
        case releaseDate = "releaseDate"
        case trackName = "trackName"
        case trackPrice = "trackPrice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        trackPrice = try values.decodeIfPresent(Float.self, forKey: .trackPrice)
    }

}
