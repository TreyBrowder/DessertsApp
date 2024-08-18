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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    AllDesserts()
}
