//
//  CurrencyRateApis.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

enum CurrencyRateApis: RequestApi {
    case getCurrencies
    case getCurrencyRate
    
    var path: String {
        switch self {
        case .getCurrencies:
            return "fixer/symbols"
        case .getCurrencyRate:
            return "fixer/latest"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: ReaquestHeaders? {
        return [:]
    }
    
    var parameters: RequestParameters? {
        return [:]
    }
    
}
