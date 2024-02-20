//
//  ErrorConstant.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import Foundation



enum Errors {
    enum Network: Error {
        case invalidURL(String)
        case requestFailed(Error)
        case invalidResponseCode(Int)
        case invalidResponse
    }

    enum Parsing: Error {
        case failedToParse(Error)
    }
}
