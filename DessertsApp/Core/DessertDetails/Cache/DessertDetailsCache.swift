//
//  DessertDetailsCache.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/19/24.
//

import Foundation

class DessertDetailsCache {
    
    static let shared = DessertDetailsCache()
    
    private let cache = NSCache<NSString, NSData>()
    
    private init() { }
    
    func set(dessertDetails: DessertDetails, key: String) {
        guard let data = try? JSONEncoder().encode(dessertDetails) else { return }
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func get(key: String) -> DessertDetails? {
        guard let data = cache.object(forKey: key as NSString) as? Data else { return nil }
        return try? JSONDecoder().decode(DessertDetails.self, from: data)
    }
}
