//
//  IngredientsView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/20/24.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var detailsVM: DessertDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color(.systemGray2))
            
            ForEach(detailsVM.ingredientMeasurements) { item in
                HStack(){
                    Text(item.measurement)
                    Text("-")
                    Text(item.ingredient)
                }
                .font(.headline)
                .fontWeight(.semibold)
            }
        }
        .padding(.bottom, 16)
    }
}


#Preview {
    IngredientsView(detailsVM: DessertDetailsViewModel(dessertId: "52893", service: MockDessertDataService()))
}
