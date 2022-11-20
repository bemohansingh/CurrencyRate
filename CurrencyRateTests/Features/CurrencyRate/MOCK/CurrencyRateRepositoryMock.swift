//
//  CurrencyRateRepositoryMock.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

class CurrencyRateRepositoryMock: CurrencyRateRepositoryProtocol {
    func getCurrencies(onComplete: @escaping(Result<[CurrencyModel], Error>) -> Void) {
        onComplete(.success([]))
    }
    
    func saveCurrenciesToLocalStorage(currencies: CurrencyResponseEntity) -> [CurrencyModel] {
        return []
    }
    
    func saveCurrencyRatesFromRemote(baseCurrencySymbol: String, onComplete: @escaping(Result<Bool, Error>) -> Void) {
        onComplete(.success(true))
    }
    
    func getCurrencyRate(fromSymbol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void) {
        onComplete(.success(1.23))
    }
    
    func saveHistory(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping(Result<Bool, Error>) -> Void) {
        onComplete(.success(true))
    }
}
