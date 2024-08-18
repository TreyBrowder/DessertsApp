//
//  DessertDataService.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

class DessertDataService {
    
    private let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func fetchDesserts() async throws {
        guard let url = URL(string: urlString) else { return }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let dataString = String(data: data, encoding: .utf8) else { return }
        print("DEBUG - LOG: Data: \(dataString)")
        
    }
}
