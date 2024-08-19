//
//  ContentView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/16/24.
//

import SwiftUI

struct AllDesserts: View {
    @StateObject var dessertsVM: DessertsViewModel
    private let service: DessertDataService
    
    init(service: DessertDataService) {
        self.service = service
        self._dessertsVM = StateObject(wrappedValue: DessertsViewModel(service: service))
    }
    
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
                DessertDetailsView(meal: meal, service: service)
            })
            .overlay {
                if let error = dessertsVM.errorMessage {
                    VStack(alignment: .center, spacing: 6) {
                        Image(systemName: "exclamationmark.octagon")
                        
                        Text(error)
                    }
                }
            }
            .navigationTitle("DESERTS")
        }
    }
}

#Preview {
    AllDesserts(service: DessertDataService())
}
