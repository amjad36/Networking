//
//  NetworkError.swift
//  
//
//  Created by Amjad on 11/12/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "The provided URL is invalid."
        case .requestFailed(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "The server returned an invalid response."
        case .decodingFailed(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .unknown:
            return "An unknown network error occurred."
        }
    }
}
