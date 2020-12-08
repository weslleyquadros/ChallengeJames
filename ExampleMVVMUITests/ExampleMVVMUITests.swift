//
//  ExampleMVVMUITests.swift
//  ExampleMVVMUITests
//
//  Created by Weslley Quadros on 08/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import XCTest

class ExampleMVVMUITests: XCTestCase {
    var app = XCUIApplication()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFlowListAndDetails() {
        let tableView = app.tables["HomeTable"]
        
        XCTAssertTrue(tableView.cells.count > 0)
        
        let firstCell = tableView.cells.element(boundBy: 4)
        firstCell.tap()
        
        let buttonSeeMore = app.buttons["ButtonSeeMore"]
        
        XCTAssertTrue(buttonSeeMore.exists, "The buttonSeeMore exists")
        
        buttonSeeMore.tap()
        sleep(3)
        
        let tableViewListEpisodes = app.tables["ListEpisodeTable"]
        
        XCTAssertTrue(tableViewListEpisodes.exists, "The tableViewListEpisodes exists")
        tableViewListEpisodes.swipeUp()
        
        
        let navBarList = app.navigationBars["ListEpisodeNavigatioBar"]
        XCTAssertTrue(navBarList.exists, "The ListEpisodeNavigatioBar exists")
        
        XCTAssertTrue(navBarList.buttons["ListEpisodeButtonClose"].exists, "The ListEpisodeButtonClose exists")
        navBarList.buttons["ListEpisodeButtonClose"].tap()
        sleep(3)
        
        let navBarDetails = app.navigationBars["DetailsNavigationBar"]
        XCTAssertTrue(navBarDetails.exists, "The DetailsNavigationBar exists")
        
        let navBackButton = navBarDetails.buttons.element(boundBy: 0)
        XCTAssertTrue(navBackButton.exists, "The backButton exists")
        navBackButton.tap()
        sleep(1)
        
        app.swipeUp()
    }
    
    func testFlowListAndFavorites() {
        let tableView = app.tables["HomeTable"]
        XCTAssertTrue(tableView.exists)
        tableView.swipeUp()
        sleep(3)
        
        let navBarList = app.navigationBars["HomeNavigationBar"]
        XCTAssertTrue(navBarList.exists, "The HomeNavigationBar exists")
        
        XCTAssertTrue(navBarList.buttons["FavoritesButtonNavigation"].exists, "The FavoritesButtonNavigation exists")
        navBarList.buttons["FavoritesButtonNavigation"].tap()
        sleep(3)
        
        let navBarFavorites = app.navigationBars["NavigationBarFavorites"]
        XCTAssertTrue(navBarFavorites.exists, "The NavigationBarFavorites exists")
        
        let navBackButton = navBarFavorites.buttons.element(boundBy: 0)
        XCTAssertTrue(navBackButton.exists, "The backButton exists")
        navBackButton.tap()
        sleep(1)
        
        app.swipeDown()
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
