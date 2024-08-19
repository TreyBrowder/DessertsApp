//
//  DessertsViewModelTests.swift
//  DessertsAppTests
//
//  Created by Trey Browder on 8/19/24.
//

import XCTest
@testable import DessertsApp

class DessertsViewModelTests: XCTestCase {
    func testInit(){
        let mockService = MockDessertDataService()
        let dessertVM = DessertsViewModel(service: mockService)
        
        XCTAssertNotNil(dessertVM, "The view model object should NOT be nil")
    }
    
    func testSuccessfulDessertsFetch() async {
        let mockService = MockDessertDataService()
        let dessertsVM = DessertsViewModel(service: mockService)
        
        await dessertsVM.getDessertData()
        print("meal count: \(dessertsVM.dessertMeals.count)")
        XCTAssertTrue(dessertsVM.dessertMeals.count > 0)
    }
    
    func testDessertFetchWIthInvalidJSONData() async {
        let mockService = MockDessertDataService()
        mockService.mockData = testInvalidDessertData
        
        let dessertsVM = DessertsViewModel(service: mockService)
        await dessertsVM.getDessertData()
        
        XCTAssertTrue(dessertsVM.dessertMeals.isEmpty)
        XCTAssertNotNil(dessertsVM.errorMessage)
    }
    
    func testThrowInvalidDataError() async throws {
        let mockService = MockDessertDataService()
        mockService.mockError = DessertAPIError.invalidData
        
        let dessertsVM = DessertsViewModel(service: mockService)
        await dessertsVM.getDessertData()
        
        XCTAssertNotNil(dessertsVM.errorMessage)
        XCTAssertEqual(dessertsVM.errorMessage, DessertAPIError.invalidData.description)
    }
}
