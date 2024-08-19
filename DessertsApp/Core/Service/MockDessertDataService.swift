//
//  MockDessertDataService.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import Foundation

class MockDessertDataService: DessertServiceProtocol {
    func fetchDesserts() async throws -> Dessert {
        let dessserts = try JSONDecoder().decode(Dessert.self, from: testDessertData)
        return dessserts
    }
    
    func fetchDessertDetails(id: String) async throws -> DessertDetails {
        let details = try JSONDecoder().decode(DessertDetails.self, from: testDessertDetails)
        return details
    }
}
