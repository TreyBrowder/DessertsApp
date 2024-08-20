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
    @Published var searchedText: String = ""
    
    private let service: DessertServiceProtocol
    
    var filteredMeals: [Meal] {
        guard !searchedText.isEmpty else { return dessertMeals }
        return dessertMeals.filter { meal in
            meal.mealName.lowercased().contains(searchedText.lowercased())
        }
    }
    
    init(service: DessertServiceProtocol){
        self.service = service
    }
    
    @MainActor
    func getDessertData() async {
        do {
            let dessertsFromService = try await service.fetchDesserts()
            for meal in dessertsFromService.meals {
                dessertMeals.append(meal)
            }
            
            dessertMeals = dessertMeals.sorted { $0.mealName.lowercased() < $1.mealName.lowercased() }
        } catch {
            guard let error = error as? DessertAPIError else { return }
            self.errorMessage = error.description
        }
    }
}
