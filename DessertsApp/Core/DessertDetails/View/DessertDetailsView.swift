//
//  DessertDetailsView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import SwiftUI

struct DessertDetailsView: View {
    
    let meal: Meal
    
    var body: some View {
        Text(meal.mealName)
    }
}

//#Preview {
//    DessertDetailsView()
//}
