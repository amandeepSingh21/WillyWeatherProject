//
//  WillyWeatherProjectUITests.swift
//  WillyWeatherProjectUITests
//
//  Created by Toppr on 28/12/20.
//  Copyright © 2020 amandeep. All rights reserved.
//

import XCTest

class WillyWeatherProjectUITests: XCTestCase {
    
    
    
    func test_Detail_Screen_Navigation() throws {
        
        let app = XCUIApplication()
        app.launch()
        let mainNavBar = app.navigationBars["OMDB"]
        let element  = app.tables.children(matching: .cell).element(boundBy: 0)
        let _ = element.waitForExistence(timeout: 2)
        print(element.debugDescription)
        element.tap()
        
        let detailNavBar = app.navigationBars["Detail"]
       
        
        XCTAssertTrue(detailNavBar.exists)
        XCTAssertFalse(mainNavBar.exists)
    }
    
    
    func test_Detail_Screen_back_navigation() throws {
        
        let app = XCUIApplication()
        app.launch()
        let mainNavBar = app.navigationBars["OMDB"]

                
        let element  = app.tables.children(matching: .cell).element(boundBy: 0)
        let _ = element.waitForExistence(timeout: 2)
        print(element.debugDescription)
        element.tap()
        
        let detailNavBar = app.navigationBars["Detail"]
        detailNavBar.buttons["OMDB"].tap()
       
        
        XCTAssertFalse(detailNavBar.exists)
        XCTAssertTrue(mainNavBar.exists)
    }

    
    
}

