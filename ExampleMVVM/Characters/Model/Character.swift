//
//  Character.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 27/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

struct ListCharacter: Codable {
    var results: [Character]
}

struct Character: Codable {
    var id: Int
    var name: String
    var status: Status
    var species: Species
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var formatToLabel: String {
        switch self {
        case .alive:
            return NSLocalizedString("statusAlive", comment: "")
        case .dead:
            return NSLocalizedString("statusDead", comment: "")
        default:
            return NSLocalizedString("statusDefault", comment: "")
        }
    }
}

enum Species: String, Codable {
    case human = "Human"
    case alien = "Alien"
    
    var formatToLabel: String {
        switch self {
        case .human:
            return NSLocalizedString("speciesHuman", comment: "")
        case .alien:
            return NSLocalizedString("speciesAlien", comment: "")
        }
    }
}
