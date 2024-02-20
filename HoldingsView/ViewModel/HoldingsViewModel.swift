//
//  HoldingsViewModel.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import Foundation

@Observable
final class UserHoldingsViewModel {
    
    var isLoadingData = false
    var errorMessage: String = ""
    var holdingsData: UserHoldingData = .init()
    var showSheet: Bool = false
    var sheetHeight: CGFloat = .zero
    
    private var service: UserHoldingService
    
    init(service: UserHoldingService) {
        self.service = service
    }
    
    func fetchHoldingsData() async {
        
        do {
            isLoadingData = true
            showSheet = false
            errorMessage = ""
            let holdings = try await service.fetchHoldings()
            self.holdingsData = holdings
            isLoadingData = false
            showSheet = true
        } catch {
            print(error.localizedDescription)
            errorMessage = "Somthing Went Wrong !!!"
            isLoadingData = false
            showSheet = false
        }
    }
}
