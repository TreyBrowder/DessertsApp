//
//  DessertDetailsViewModel.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

class DessertDetailsViewModel: ObservableObject {
    
    @Published var ingredientMeasurements = [IngredientMeasurement]()
    @Published var mealInstructions: String?
    var mealIngredients = [String]()
    var mealMeasurements = [String]()
    
    private let service = DessertDataService()
    private let dessertId: String
    
    init(dessertId: String) {
        self.dessertId = dessertId
        
        Task { await getDessertDetails() }
    }
    
    func getDessertDetails() async {
        do {
            let result = try await service.fetchDessertDetails(id: dessertId)
            let dessetDetails = result.meals[0]
            await transformData(dessertDetails: dessetDetails)
        } catch {
            //handle errors here
            print("DEBUG - ERROR: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func transformData(dessertDetails: MealDetails) {
        let ingredients: [String?] = [
            dessertDetails.ingredient1, dessertDetails.ingredient2, dessertDetails.ingredient3, dessertDetails.ingredient4, dessertDetails.ingredient5, dessertDetails.ingredient6, dessertDetails.ingredient7, dessertDetails.ingredient8, dessertDetails.ingredient9, dessertDetails.ingredient10, dessertDetails.ingredient11, dessertDetails.ingredient12, dessertDetails.ingredient13, dessertDetails.ingredient14, dessertDetails.ingredient15, dessertDetails.ingredient16, dessertDetails.ingredient17, dessertDetails.ingredient18, dessertDetails.ingredient19, dessertDetails.ingredient20
        ]
        
        let measures: [String?] = [
            dessertDetails.measure1, dessertDetails.measure2, dessertDetails.measure3, dessertDetails.measure4, dessertDetails.measure5, dessertDetails.measure6, dessertDetails.measure7, dessertDetails.measure8, dessertDetails.measure9, dessertDetails.measure10, dessertDetails.measure11, dessertDetails.measure12, dessertDetails.measure13, dessertDetails.measure14, dessertDetails.measure15, dessertDetails.measure16, dessertDetails.measure17, dessertDetails.measure18, dessertDetails.measure19, dessertDetails.measure20
        ]
        
        mealIngredients = ingredients.compactMap {
            $0?.replacingOccurrences(of: " ", with: "").isEmpty == false ? $0 : nil
        }
        mealMeasurements = measures.compactMap {
            $0?.replacingOccurrences(of: " ", with: "").isEmpty == false ? $0 : nil
        }
        
        ingredientMeasurements = zip(mealIngredients, mealMeasurements).map {
            IngredientMeasurement(ingredient: $0, measurement: $1)
        }
        
        mealInstructions = dessertDetails.instructions
        
//        print("DEBUG - LOG: INGREDIENTS ARRAY:")
//        print(mealIngredients)
//        print(" *** ")
//        print("DEBUG - LOG: MEASUREMENTS ARRAY:")
//        print(mealMeasurements)
//        print(" *** ")
//        print("DEBUG - LOG: INSTRUCTIONS:")
//        print(mealInstructions ?? "N/A")
//        print("DEBUG - LOG: INGREDIENTS MEASUREMENTS ARRAY:")
//        print(ingredientMeasurements)
    }
    
    private func formatInstructions(instructions: String) -> String {
        return ""
    }

}
