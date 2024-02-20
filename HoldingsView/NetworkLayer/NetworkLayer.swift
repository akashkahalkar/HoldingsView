//
//  NetworkLayer.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import Foundation
import SwiftUI

protocol NetworkManager {
    func getData(from url: String) async throws -> Data
}

final class DefaultManager: NetworkManager {
    
    static let shared = DefaultManager()
    
    private init() {}
    
    func getData(from url: String) async throws -> Data {
        
        guard let url = URL(string: url) else {
            throw Errors.Network.invalidURL(url)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // basic validation to check for success
        guard let response = response as? HTTPURLResponse else {
            throw Errors.Network.invalidResponse
        }
        
        let statusCode = response.statusCode
        guard (200...299).contains(statusCode) else {
            throw Errors.Network.invalidResponseCode(statusCode)
        }
        
        return data
    }
}
