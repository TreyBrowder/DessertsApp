//
//  DessertsAppApp.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/16/24.
//

import SwiftUI

@main
struct DessertsApp: App {
    var body: some Scene {
        WindowGroup {
            AllDessertsView(service: DessertDataService())
        }
    }
}
