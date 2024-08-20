//
//  DessertAPIError.swift
//  DessertsApp
//
//  Created by Trey Browder on 8/18/24.
//

import Foundation

enum DessertAPIError: Error {
    case invalidData
    case jsonParseFail
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var description: String {
        switch self {
        case .invalidData:
            "Invalid data was returned"
        case .jsonParseFail:
            "Failed to parse the data"
        case let .requestFailed(description):
            "Request FAILED: \(description)"
        case let .invalidStatusCode(statusCode):
            "Invalid status code: \(statusCode)"
        case let .unknownError(error):
            "Unknown error occurred: \(error.localizedDescription)"
        }
    }
}
