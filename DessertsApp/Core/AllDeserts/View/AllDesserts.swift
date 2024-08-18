//
//  ContentView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/16/24.
//

import SwiftUI

struct AllDesserts: View {
    
    @StateObject var dessertsVM = DessertsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dessertsVM.dessertMeals) { meal in
                    NavigationLink(value: meal) {
                        HStack {
                            Image(systemName: "person.circle")
                            
                            Text(meal.mealName)
                                .fontWeight(.heavy)
                        }
                    }
                }
            }
            .navigationDestination(for: Meal.self, destination: { meal in
                DessertDetailsView(meal: meal)
            })
            .overlay {
                if let error = dessertsVM.errorMessage {
                    VStack(alignment: .center, spacing: 6) {
                        Image(systemName: "exclamationmark.octagon")
                        
                        Text(error)
                    }
                }
            }
        }
    }
}

#Preview {
    AllDesserts()
}
