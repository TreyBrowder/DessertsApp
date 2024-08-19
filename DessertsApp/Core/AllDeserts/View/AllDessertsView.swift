//
//  ContentView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/16/24.
//

import SwiftUI

struct AllDessertsView: View {
    @StateObject var dessertsVM: DessertsViewModel
    private let service: DessertServiceProtocol
    
    init(service: DessertServiceProtocol) {
        self.service = service
        self._dessertsVM = StateObject(wrappedValue: DessertsViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dessertsVM.dessertMeals) { meal in
                    NavigationLink(value: meal) {
                        HStack {
                            //Image(systemName: "person.circle")
                            DessertImageView(url: meal.mealImage)
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                            
                            Text(meal.mealName)
                                .fontWeight(.heavy)
                        }
                        .padding(.vertical, 6)
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
                    .background(Color(.darkGray))
                }
            }
            .navigationTitle("DESERTS")
        }
        .task {
            await dessertsVM.getDessertData()
        }
    }
}

#Preview {
    AllDessertsView(service: MockDessertDataService())
}
