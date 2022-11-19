//
//  NetworkError.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation
/// Enum of API Errors
enum APIError: Error {
    /// No data received from the server.
    case noData(Int)
    /// The server response was invalid (unexpected format).
    case invalidResponse(Int)
    /// The request was rejected: 400-499
    case badRequest(Int, String?)
    /// Encoutered a server error.
    case serverError(Int, String?)
    /// There was an error parsing the data.
    case parseError(Int, String?)
    /// Unknown error.
    case unknown
}
