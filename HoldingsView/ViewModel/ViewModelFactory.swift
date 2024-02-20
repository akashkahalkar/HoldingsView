//
//  ViewModelFactory.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import Foundation

protocol ViewModelFactoryProtocol {
    func getUserHoldingViewModel() -> UserHoldingsViewModel
}

// can mock this if need to inject dummy data
final class DefaultViewModelFactory: ViewModelFactoryProtocol {
    
    static let shared = DefaultViewModelFactory()
    
    private init() {}
    
    func getUserHoldingViewModel() -> UserHoldingsViewModel {
        let manager = DefaultManager.shared
        let userHoldingService = UserHoldingServiceImpl(manager: manager)
        return UserHoldingsViewModel(service: userHoldingService)
    }
}
