//
//  ExampleMVVMTests.swift
//  ExampleMVVMTests
//
//  Created by Weslley Quadros on 08/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import XCTest
@testable import ExampleMVVM

class ExampleMVVMTests: XCTestCase {
    var characterViewModel: ListCharactersViewModel!
    var detailsViewModel: CharacterDetailsViewModel!
    var listCharacter = [Character]()
    var listEpisodes = [Episode]()
    override func setUp() {
        super.setUp()
        characterViewModel = ListCharactersViewModel()
        detailsViewModel = CharacterDetailsViewModel()
        self.initLists()
    }
    
    override func tearDown() {
        characterViewModel = nil
        super.tearDown()
    }
    
    //Check if there is a favorite character
    func testThereAreFavorites() {
        characterViewModel.getFavoritesList()
        //Assert
        XCTAssertTrue(characterViewModel.favListArray.count > 0)
    }
    
    //MARK: - Tests funcs Favorites (UDefaults)
    func testSearchFavorite() {
        var id = Int()
        characterViewModel.getFavoritesList()
        
        characterViewModel.favListArray.add(100)
        
        characterViewModel.favListArray.forEach { idFav in
            id = idFav as! Int
        }
        //Assert
        XCTAssertEqual(id, 100)
    }
    
    func testRemoveFavorite() {
        var id = Int()
        characterViewModel.getFavoritesList()
        
        characterViewModel.favListArray.remove(100)
        
        characterViewModel.favListArray.forEach { idFav in
            id = idFav as! Int
        }
        //Assert
        XCTAssertTrue(id != 100)
    }
    //check that the list is not empty
    func testNotIsEmptyListCharacter() {
        let isEmpty = characterViewModel.verifyEmptyStatus(list: self.listCharacter)
        XCTAssertFalse(isEmpty)
    }
    
    //check if the list is empty
    func testIsEmptyListCharacter() {
        self.listCharacter.removeAll()
        let isEmpty = characterViewModel.verifyEmptyStatus(list: self.listCharacter)
        XCTAssertTrue(isEmpty)
    }
}

extension ExampleMVVMTests {
    //initialize lists
    private func initLists() {
        self.measure {
            characterViewModel.fetchCharacters { result in
                switch result {
                case .success(let data):
                    self.listCharacter = data.results
                default: break
                }
            }
            
            detailsViewModel.fetchListEpisodes{ result in
                switch (result) {
                case .success(let list):
                    self.listEpisodes.append(list)
                default: break
                }
            }
        }
        
    }
}
