//
//  DessertImageView.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import SwiftUI

struct DessertImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
        }
    }
}

#Preview {
    DessertImageView(url: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
}
