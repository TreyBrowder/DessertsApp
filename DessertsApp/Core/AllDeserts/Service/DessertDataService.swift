//
//  DessertDataService.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation


protocol DataDownloaderProtocol {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension DataDownloaderProtocol {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
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
            return try JSONDecoder().decode(type, from: data)
           
        } catch {
            print("DEBUG - Service ERROR: \(error)")
            throw error as? DessertAPIError ?? .unknownError(error: error)
        }
    }
}

class DessertDataService: DataDownloaderProtocol {
    
    private let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    ///Asychronous function to retreive dessert data from API
    func fetchDesserts() async throws -> Dessert {
        return try await fetchData(as: Dessert.self, endpoint: urlString)
        
    }
    
    ///Asychronous function to retreive dessert details data from API
    func fetchDessertDetails(id: String) async throws -> DessertDetails {
        let detailsUrlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        return try await fetchData(as: DessertDetails.self, endpoint: detailsUrlString)
    }
    
}
