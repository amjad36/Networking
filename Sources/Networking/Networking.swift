//
//  Networking.swift
//
//
//  Created by Amjad on 11/12/25.
//

import Foundation

public class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}
    
    /// Performs a network request and decodes the response into a Decodable type.
    /// - Parameters:
    ///   - url: The URL for the network request.
    ///   - type: The Decodable type to decode the response into.
    /// - Returns: An instance of the specified Decodable type.
    /// - Throws: A `NetworkError` if the request fails or decoding is unsuccessful.
    public func fetchData<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust as needed
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
    
    /// Performs a network request with a custom URLRequest and decodes the response.
    /// - Parameters:
    ///   - request: The `URLRequest` to perform.
    ///   - type: The Decodable type to decode the response into.
    /// - Returns: An instance of the specified Decodable type.
    /// - Throws: A `NetworkError` if the request fails or decoding is unsuccessful.
    public func performRequest<T: Decodable>(request: URLRequest, as type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
