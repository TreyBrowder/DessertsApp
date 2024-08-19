//
//  DessertDataService.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

class DessertDataService {
    
    private let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    ///Asychronous function to retreive dessert data from API
    func fetchDesserts() async throws -> Dessert {
        guard let url = URL(string: urlString) else {
            throw DessertAPIError.requestFailed(description: "Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DessertAPIError.requestFailed(description: "Request Failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw DessertAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            let desserts = try JSONDecoder().decode(Dessert.self, from: data)
            return desserts
        } catch {
            print("DEBUG - Service ERROR: \(error)")
            throw error as? DessertAPIError ?? .unknownError(error: error)
        }
    }
    
    ///Asychronous function to retreive dessert details data from API
    func fetchDessertDetails(id: String) async throws -> DessertDetails {
        
        let detailsUrlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        guard let url = URL(string: detailsUrlString) else {
            throw DessertAPIError.requestFailed(description: "Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DessertAPIError.requestFailed(description: "Request Failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw DessertAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            let details = try JSONDecoder().decode(DessertDetails.self, from: data)
            return details
        } catch {
            print("DEBUG - Service ERROR: \(error)")
            throw error as? DessertAPIError ?? .unknownError(error: error)
        }
    }
}
