//
//  InstructionsView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/20/24.
//

import SwiftUI

struct InstructionsView: View {
    @ObservedObject var detailsVM: DessertDetailsViewModel
    
    var body: some View {
        Text("Instructions")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(Color(.systemGray2))
        
        if let instructions = detailsVM.mealInstructions {
            Text(instructions)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    InstructionsView(detailsVM: DessertDetailsViewModel(dessertId: "52893", service: MockDessertDataService()))
}
