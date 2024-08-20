//
//  MockDessertDataService.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import Foundation

final class MockDessertDataService: DessertServiceProtocol {
    
    var mockData: Data?
    var mockError: DessertAPIError?
    
    func fetchDesserts() async throws -> Dessert {
        if let mockError { throw mockError }
        
        do {
            let dessserts = try JSONDecoder().decode(Dessert.self, from: mockData ?? testDessertData)
            return dessserts
        } catch {
            throw DessertAPIError.jsonParseFail
        }
    }
    
    func fetchDessertDetails(id: String) async throws -> DessertDetails {
        let details = try JSONDecoder().decode(DessertDetails.self, from: testDessertDetails)
        return details
    }
}
