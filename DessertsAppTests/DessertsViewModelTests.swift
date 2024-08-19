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
        let service = MockDessertDataService()
        let viewModel = DessertsViewModel(service: service)
        
        await viewModel.getDessertData()
        print("meal count: \(viewModel.dessertMeals.count)")
        XCTAssertTrue(viewModel.dessertMeals.count > 0)
    }
    
    func testDestFetchWIthInvalidJSONData() async {
        
    }
    
    func throwInvalidDataError() async throws {
        
    }
}
