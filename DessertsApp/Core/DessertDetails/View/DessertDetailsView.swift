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
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding(.trailing, 16)
                    
                    Text(meal.mealName)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    
                }
                .padding(.bottom, 16)
                
                
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
                
                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.systemGray2))
                
                if let instructions = detailsVM.mealInstructions {
                    Text(instructions)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
               
                
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .task {
            await detailsVM.getDessertDetails()
        }
    }
}

#Preview {
    DessertDetailsView(meal: Meal(id: "5432", mealName: "Donuts", mealImage: ""))
}
