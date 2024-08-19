//
//  DessertsViewModel.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

class DessertsViewModel: ObservableObject {
    
    @Published var dessertMeals = [Meal]()
    @Published var errorMessage: String?
    
    private let service: DessertServiceProtocol
    
    init(service: DessertServiceProtocol){
        self.service = service
        
        Task { await getDessertData() }
    }
    
    @MainActor
    func getDessertData() async {
        do {
            let dessertsFromService = try await service.fetchDesserts()
            for meal in dessertsFromService.meals {
                dessertMeals.append(meal)
            }
        } catch {
            guard let error = error as? DessertAPIError else { return }
            self.errorMessage = error.description
        }
    }
}
