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
    
    init(meal: Meal, service: DessertServiceProtocol) {
        self.meal = meal
        self.detailsVM = DessertDetailsViewModel(dessertId: meal.id, service: service)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(meal.mealName)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.bottom, 16)
                
                
                
                HStack {
                    Spacer()
                    DessertImageView(url: meal.mealImage)
                        .frame(width: 212, height: 212)
                        .clipShape(Circle())
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
    DessertDetailsView(meal: Meal(id: "5432",
                                  mealName: "Donuts",
                                  mealImage: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"),
                       service: MockDessertDataService())
}
