//
//  ListFavoritesViewModel.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 30/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

class ListFavoritesViewModel {
    
    // MARK: - Initialization
    init(model: NSMutableArray? = nil) {
        if let inputModel = model {
            favListArray = inputModel
        }
    }
    
    var favListArray: NSMutableArray = []
    var listCharacter = [Character]()
    var character: Character?
    
    
    //MARK: - For Cell
    var listCharacterCell = [Character]()
    var listFavoriteSeach = [Character]()
}
