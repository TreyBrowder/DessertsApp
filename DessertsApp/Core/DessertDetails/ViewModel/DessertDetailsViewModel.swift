//
//  DessertDetailsViewModel.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

class DessertDetailsViewModel: ObservableObject {
    
    private let service = DessertDataService()
    private let dessertId: String
    
    init(dessertId: String) {
        self.dessertId = dessertId
        
        Task { await getDessertDetails() }
    }
    
    func getDessertDetails() async {
        do {
            let details = try await service.fetchDessertDetails(id: dessertId)
            
            print("DEBUG - LOG: Details: \(details)")
        } catch {
            //handle errors here
            print("DEBUG - ERROR: \(error.localizedDescription)")
        }
    }
}
