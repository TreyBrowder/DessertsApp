//
//  DessertsAppUITests.swift
//  DessertsAppUITests
//
//  Created by Trey Browder on 8/16/24.
//

import XCTest
@testable import DessertsApp

final class DessertsAppUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testAllDessertListTitleExists() {
        let listTitle = app.staticTexts["DESSERTS"]
        
        XCTAssertTrue(listTitle.exists)
    }
    
    func testNavigationFlow() {
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Apam balik"]/*[[".cells",".buttons[\"Apam balik\"].staticTexts[\"Apam balik\"]",".staticTexts[\"Apam balik\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let mealTitle = app.staticTexts["Instructions"]
        
        XCTAssertTrue(mealTitle.exists)
        
        app.navigationBars.buttons["DESSERTS"].tap()
        let listItem = app.collectionViews.staticTexts["Battenberg Cake"]
        
        XCTAssertTrue(listItem.exists)
    }
    
    func testSearchBarExists() {
        let searchBar = app.navigationBars["DESSERTS"].searchFields["Search"]
        
        XCTAssertTrue(searchBar.exists)
    }
    
    func testSearchBarFlow() {
        let searchBar = app.navigationBars["DESSERTS"].searchFields["Search"]
        
        searchBar.tap()
        searchBar.typeText("Bakewell")
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Bakewell tart"]/*[[".cells",".buttons[\"Bakewell tart\"].staticTexts[\"Bakewell tart\"]",".staticTexts[\"Bakewell tart\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let bakewellImage = app.images.element
        
        XCTAssertTrue(bakewellImage.exists)
    }
}
