//
//  CurrencyRateRemoteDataSourceMock.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation
@testable import CurrencyRate

struct CurrencyRateRemoteDataSourceMock: CurrencyRateRemoteDataSourceProtocol {
    func getCurrencies(onComplete: @escaping(Result<CurrencyResponseEntity, Error>) -> Void) {
        onComplete(.success(CurrencyResponseEntity(symbols: [:], success: true)))
    }
    
    func gerCurrencyRate(defaultCurrency: String, onComplete: @escaping(Result<CurrencyRateResponseEntity, Error>) -> Void) {
        onComplete(.success(CurrencyRateResponseEntity(rates: [:], success: true, base: defaultCurrency, date: "20/11/2022")))
    }
}
