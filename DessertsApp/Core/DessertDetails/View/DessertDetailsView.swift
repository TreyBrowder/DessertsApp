//
//  DessertDetailsView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import SwiftUI

struct DessertDetailsView: View {
    @StateObject var detailsVM: DessertDetailsViewModel
    let meal: Meal
    
    init(meal: Meal, service: DessertServiceProtocol) {
        self.meal = meal
        self._detailsVM = StateObject(wrappedValue: DessertDetailsViewModel(dessertId: meal.id, service: service)) 
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
                
                IngredientsView(detailsVM: detailsVM)
                
                InstructionsView(detailsVM: detailsVM)
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
