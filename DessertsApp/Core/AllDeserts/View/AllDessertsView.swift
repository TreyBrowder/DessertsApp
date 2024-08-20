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
                ForEach(dessertsVM.filteredMeals) { meal in
                    NavigationLink(value: meal) {
                        HStack {
                            //Image(systemName: "person.circle")
                            DessertImageView(url: meal.mealImage)
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                            
                            Text(meal.mealName)
                                .fontWeight(.heavy)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .navigationTitle("DESSERTS")
            .navigationDestination(for: Meal.self, destination: { meal in
                DessertDetailsView(meal: meal, service: service)
            })
            .searchable(text: $dessertsVM.searchedText)
            .overlay {
                if let error = dessertsVM.errorMessage {
                    VStack(alignment: .center, spacing: 6) {
                        Image(systemName: "exclamationmark.octagon")
                        
                        Text(error)
                    }
                    .background(Color(.darkGray))
                }
            }
        }
        .task {
            await dessertsVM.getDessertData()
        }
    }
}

#Preview {
    AllDessertsView(service: MockDessertDataService())
}
