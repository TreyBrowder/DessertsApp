//
//  ImageLoader.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?
    
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        
        Task { try await loadImage() }
    }
    
    @MainActor
    private func loadImage() async throws {
        
        if let cached = ImageCache.shared.get(key: urlString) {
            print("DEBUG - LOG: Got image from cache")
            self.image = Image(uiImage: cached)
            return
        }
        guard let url = URL(string: urlString) else { return }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        do {
            guard let httpResponse = response as? HTTPURLResponse else {
                throw DessertAPIError.requestFailed(description: "Request Failed")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw DessertAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
            }
            
            guard let uiImage = UIImage(data: data) else { return }
            ImageCache.shared.set(image: uiImage, key: urlString)
            self.image = Image(uiImage: uiImage)
        } catch {
            print("DEBUG - ERROR: Failed to fetch image with error \(error)")
        }
    }
}
