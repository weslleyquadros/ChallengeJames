//
//  EpisodeModel.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 28/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

struct ListEpisodes: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

extension Episode {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate        = "air_date"
        case episode
        case characters
        case url
        case created
    }
}
