//
//  ItunesModel.swift
//  ItunesSearcher
//
//  Created by AH MARWAN  on 29/05/21.
//

import Foundation

struct ItunesModel : Codable {
    
	var resultCount : Int?
	var results : [Result]?
    
	enum CodingKeys: String, CodingKey {
		case resultCount = "resultCount"
		case results = "results"
	}
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
		results = try values.decodeIfPresent([Result].self, forKey: .results)
	}

}
