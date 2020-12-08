//
//  Favorites.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 29/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

class Favorites: ObservableObject {
    private var characters: Set<String>
    let defaults = UserDefaults.standard
    
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: "Favorites") as? Data {
            let taskData = try? decoder.decode(Set<String>.self, from: data)
            self.characters = taskData ?? []
        } else {
            self.characters = []
        }
    }
    
    func getFavoritesIds() -> Set<String> {
        return self.characters
    }
    
    func isEmpty() -> Bool {
        characters.count < 1
    }
    
    func contains(_ character: Character) -> Bool {
        characters.contains("\(character.id)")
    }
    
    func add(_ character: Character) {
        objectWillChange.send()
        characters.insert("\(character.id)")
        save()
    }
    
    func remove(_ character: Character) {
        objectWillChange.send()
        characters.remove("\(character.id)")
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(characters) {
            defaults.set(encoded, forKey: "Favorites")
        }
    }
}
