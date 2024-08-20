//
//  DessertDataService.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

protocol DessertServiceProtocol {
    func fetchDesserts() async throws -> Dessert
    func fetchDessertDetails(id: String) async throws -> DessertDetails
}

class DessertDataService: DessertServiceProtocol, DataDownloaderProtocol {
    
//MARK: - URL Retated variables/functions
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = "/api/json/v1/1/"
        
        return components
    }
    
    private var allDessertsUrlString: String? {
        var components = baseUrlComponents
        components.path += "filter.php"
        
        components.queryItems = [
            .init(name: "c", value: "Dessert")
        ]
        
        return components.url?.absoluteString
    }
    
    private func dessertDetailsUrlString(id: String) -> String? {
        var components = baseUrlComponents
        components.path += "/lookup.php"
        
        components.queryItems = [
            .init(name: "i", value: "\(id)")
        ]
        
        return components.url?.absoluteString
    }
    
//MARK: - Fetch Data Methods
    
    ///Asychronous function to retreive dessert data from API
    func fetchDesserts() async throws -> Dessert {
        guard let endpoint = allDessertsUrlString else {
            throw DessertAPIError.requestFailed(description: "Invalid URL")
        }
        
        return try await fetchData(as: Dessert.self, endpoint: endpoint)
    }
    
    ///Asychronous function to retreive dessert details data from API
    func fetchDessertDetails(id: String) async throws -> DessertDetails {
        if let cached = DessertDetailsCache.shared.get(key: id) {
            return cached
        }
        
        guard let endpoint = dessertDetailsUrlString(id: id) else {
            throw DessertAPIError.requestFailed(description: "Invalid URL")
        }
        
        let details = try await fetchData(as: DessertDetails.self, endpoint: endpoint)
        DessertDetailsCache.shared.set(dessertDetails: details, key: id)
        return details
    }
}
