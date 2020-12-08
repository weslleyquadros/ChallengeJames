//
//  ConstantsApi.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 03/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

let baseUrl : String = "https://rickandmortyapi.com/api"

enum ConstantsApiType {
    case character
    case episodes(id: Int)
    
    public var callApi: String {
        switch self {
        case .character:
            return baseUrl + "/character"
        case .episodes(let id):
            return baseUrl + "/episode/\(id)"
        }
    }
}
