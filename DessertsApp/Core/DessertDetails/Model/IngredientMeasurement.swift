//
//  IngredientMeasurement.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

struct IngredientMeasurement: Identifiable {
    let id = UUID()
    let ingredient: String
    let measurement: String
}
