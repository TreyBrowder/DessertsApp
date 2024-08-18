//
//  DessertDetailsView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @ObservedObject var detailsVM: DessertDetailsViewModel
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
        self.detailsVM = DessertDetailsViewModel(dessertId: meal.id)
    }
    
    var body: some View {
        Text(meal.mealName)
    }
}

//#Preview {
//    DessertDetailsView()
//}
