//
//  CurrencyEntity.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

struct CurrencyResponseEntity: Decodable {
    let symbols: [String: String]
    let success: Bool
}
