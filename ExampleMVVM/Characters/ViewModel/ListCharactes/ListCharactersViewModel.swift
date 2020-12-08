//
//  ListCharactersViewModel.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 28/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

class ListCharactersViewModel {
    // MARK: - Initialization
    init(model: [Character]? = nil) {
        if let inputModel = model {
            listCharacter = inputModel
        }
    }
    
    var listCharacter = [Character]()
    var listFavoriteSeach = [Character]()
    var character: Character?
    var favListArray: NSMutableArray = []
    
    //For test VM
    func verifyEmptyStatus(list: [Character]) -> Bool {
        var isEmpty = Bool()
        if list.count == 0 {
            isEmpty = true
        } else {
            isEmpty = false
        }
        return isEmpty
    }
}

extension ListCharactersViewModel {
    func fetchCharacters(completion: @escaping (Result<ListCharacter, Error>) -> Void) {
        ApiServices.sharedInstance.get(urlString: ConstantsApiType.character.callApi, completionBlock: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    completion(.success(try decoder.decode(ListCharacter.self, from: dta)))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        })
    }
    
    func getFavoritesList() {
        if UserDefaults.standard.object(forKey: "favList") != nil {
            favListArray = NSMutableArray.init(array: UserDefaults.standard.object(forKey: "favList") as? [Int] ?? [Int]())
        }
    }
}
