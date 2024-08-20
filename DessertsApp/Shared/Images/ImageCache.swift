//
//  ImageCache.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    ///Function to set image in memory in cache by key
    func set(image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    ///Function to get image by key from in memory cache
    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
