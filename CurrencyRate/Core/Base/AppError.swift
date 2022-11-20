//
//  AppError.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

enum AppError: Error {
    case custom(String)
}

extension Error {
    func getMessage() -> String {
        if let error = self as? APIError {
            switch error {
            case .serverError(_, let msg):
                return msg ?? ""
            case .badRequest(_, let msg):
                return msg ?? ""
            case .parseError(_, let msg):
                return msg ?? ""
            case .unknown(let msg):
                return msg
            }
        } else if let error = self as? AppError {
            switch error {
            case .custom(let msg):
                return msg
            }
        } else {
            return self.localizedDescription
        }
    }
}
