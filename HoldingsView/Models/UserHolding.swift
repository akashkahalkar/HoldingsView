//
//  UserHolding.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import Foundation
import SwiftData
import SwiftUI


struct UserHoldingData: Codable {
    
    let userHolding: [UserHolding]
    
    // Calculate total current value, total investment value, and total P&L
    var totalCurrentValue: Double {
        userHolding.reduce(0.0) { result, holding in
          result + holding.ltp * holding.quantity
        }
    }
    
    var totalInvestmentValue: Double {
        userHolding.reduce(0.0) { result, holding in
            result + holding.avgPrice * holding.quantity
        }
    }
   
    var totalPL: Double {
        userHolding.reduce(0.0) { result, holding in
            result + holding.individualPL
        }
    }
    
    // Calculate today's P&L
    var todaysPL: Double {
        userHolding.reduce(0.0) { result, holding in
            result + (holding.close - holding.ltp) * holding.quantity
        }
    }
    
    init() {
        userHolding = []
    }
}

final class UserHolding: Codable, Identifiable {
    
    let id: String = UUID().uuidString
    let symbol: String
    let quantity: Double
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    var formattedQuantity: String {
        String(Int(quantity))
    }

    // Calculate individual P&L
    var individualPL: Double {
        return (ltp * quantity) - (avgPrice * quantity)
    }
    
    init(symbol: String, quantity: Double, ltp: Double, avgPrice: Double, close: Double) {
        self.symbol = symbol
        self.quantity = quantity
        self.ltp = ltp
        self.avgPrice = avgPrice
        self.close = close
    }
}

extension Double {
    func getFormattedAmount() -> LocalizedStringKey {
        return "₹ \(self, specifier: "%.2f")"
    }
}
