//
//  CharacterDetailsViewModel.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 30/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation

class CharacterDetailsViewModel {
    var character: Character?
    var episode: Episode?
    var listEpisodes = [Episode]()
}

extension CharacterDetailsViewModel {
    func fetchEpisode(completion: @escaping (Result<Episode, Error>) -> Void) {
        guard let url = character?.episode.first else {return}
        ApiServices.sharedInstance.get(urlString: url, completionBlock: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    completion(.success(try decoder.decode(Episode.self, from: dta)))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        })
    }
    
    func fetchListEpisodes(completion: @escaping (Result<Episode, Error>) -> Void) {
        self.character?.episode.forEach { episodeUrl in
            ApiServices.sharedInstance.get(urlString: episodeUrl, completionBlock: { result in
                switch result {
                case .failure(let error):
                    print ("failure", error)
                case .success(let dta) :
                    let decoder = JSONDecoder()
                    do
                    {
                        completion(.success(try decoder.decode(Episode.self, from: dta)))
                    } catch let jsonError {
                        completion(.failure(jsonError))
                    }
                }
            })
        }
    }
}
