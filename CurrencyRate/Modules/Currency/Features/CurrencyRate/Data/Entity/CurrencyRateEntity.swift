//
//  CurrencyRateEntity.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

struct CurrencyRateResponseEntity: Decodable {
    let rates: [String: Double]
    let success: Bool
    let base: String
    let date: String
}
