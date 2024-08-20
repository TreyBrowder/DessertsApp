//
//  DataDownloader.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import Foundation

protocol DataDownloaderProtocol {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

//provides a default implementation to the fetchData function in the DataDownloaderProtocol
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
