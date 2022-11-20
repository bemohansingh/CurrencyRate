//
//  GetCurrenciesUseCaseMock.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

struct GetCurrenciesUseCaseMock: GetCurrenciesUseCaseProtocol {
    func execute(onComplete: @escaping (Result<[CurrencyModel], Error>) -> Void) {
        onComplete(.success([]))
    }
}

struct SaveCurrencyRatesFromRemoteUseCaseMock: SaveCurrencyRatesFromRemoteUseCaseProtocol {
    func execute(baseCurrencySymbol: String, onComplete: @escaping (Result<Bool, Error>) -> Void) {
        onComplete(.success(true))
    }
}

struct SaveHistoryUseCaseMock: SaveHistoryUseCaseProtocol {
    func execute(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping (Result<Bool, Error>) -> Void) {
        onComplete(.success(true))
    }
}

struct GetCurrencyRateUseCaseMock: GetCurrencyRateUseCaseProtocol {
    func execute(fromSymbol: String, toSymbol: String, onComplete: @escaping (Result<Double, Error>) -> Void) {
        onComplete(.success(1.23))
    }
}
