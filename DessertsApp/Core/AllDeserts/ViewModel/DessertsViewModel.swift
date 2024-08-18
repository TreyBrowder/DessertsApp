//
//  DessertsViewModel.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

class DessertsViewModel: ObservableObject {
    
    @Published var dessertMeals = [Dessert]()
    @Published var errorMessage: String?
    
    private let service = DessertDataService()
    
    init(){
        Task { await getDessertData() }
    }
    
    func getDessertData() async {
        do {
            print("DEBUG - LOG: Calling data service...")
            try await service.fetchDesserts()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
