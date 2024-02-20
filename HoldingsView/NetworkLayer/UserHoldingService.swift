//
//  UserHoldingService.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import Foundation

protocol UserHoldingService {
    func fetchHoldings() async throws -> UserHoldingData
}

final class UserHoldingServiceImpl: UserHoldingService {
    
    private var manager: NetworkManager

    init(manager: NetworkManager) {
        self.manager = manager
    }
    
    func fetchHoldings() async throws -> UserHoldingData {
        
        // base url can be constructed using config injection approach if needed
        // to configure based on enviroment or other aspects
        let holdingsUrl = "https://run.mocky.io/v3/bde7230e-bc91-43bc-901d-c79d008bddc8"
        
        do {
            let data = try await manager.getData(from: holdingsUrl)
            return try JSONDecoder().decode(UserHoldingData.self, from: data)
        } catch {
            throw Errors.Parsing.failedToParse(error)
        }
    }
}
