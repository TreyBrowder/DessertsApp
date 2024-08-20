//
//  DessertsViewModelTests.swift
//  DessertsAppTests
//
//  Created by Trey Browder on 8/19/24.
//

import XCTest
@testable import DessertsApp

final class DessertsViewModelTests: XCTestCase {
    
    var dessertsVM: DessertsViewModel!
    var mockService: MockDessertDataService!
    
    override func setUpWithError() throws {
        mockService = MockDessertDataService()
        dessertsVM = DessertsViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        dessertsVM = nil
    }
    
    func testInit(){
        XCTAssertNotNil(dessertsVM, "The view model object should NOT be nil")
    }
    
    func testSuccessfulDessertsFetch() async {
        await dessertsVM.getDessertData()
        print("meal count: \(dessertsVM.dessertMeals.count)")
        XCTAssertTrue(dessertsVM.dessertMeals.count > 0)
    }
    
    func testDessertFetchWIthInvalidJSONData() async {
        mockService.mockData = testInvalidDessertData
        
        await dessertsVM.getDessertData()
        
        XCTAssertTrue(dessertsVM.dessertMeals.isEmpty)
        XCTAssertNotNil(dessertsVM.errorMessage)
    }
    
    func testThrowInvalidDataError() async throws {
        mockService.mockError = DessertAPIError.invalidData
        
        let dessertsVM = DessertsViewModel(service: mockService)
        await dessertsVM.getDessertData()
        
        XCTAssertNotNil(dessertsVM.errorMessage)
        XCTAssertEqual(dessertsVM.errorMessage, DessertAPIError.invalidData.description)
    }
}
