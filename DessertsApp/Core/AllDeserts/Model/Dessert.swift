//
//  DessertData.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

struct Dessert: Codable {
    let meal: [Meal]
}

struct Meal: Codable, Identifiable {
    let id: Int
    let mealName: String
    let mealImage: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case mealName = "strMeal"
        case mealImage = "strMealThumb"
    }
}
