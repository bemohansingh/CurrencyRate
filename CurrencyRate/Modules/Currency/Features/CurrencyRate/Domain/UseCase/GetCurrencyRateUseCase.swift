//
//  GetCurrencyRateUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

protocol GetCurrencyRateUseCaseProtocol {
    func execute(fromSymbol: String, toSymbol: String, onComplete: @escaping (Result<Double, Error>) -> Void)
}

struct GetCurrencyRateUseCase: GetCurrencyRateUseCaseProtocol {
    let currencyRateRepository: CurrencyRateRepositoryProtocol
    
    func execute(fromSymbol: String, toSymbol: String, onComplete: @escaping (Result<Double, Error>) -> Void) {
        currencyRateRepository.getCurrencyRate(fromSybol: fromSymbol, toSymbol: toSymbol) { result in
            onComplete(result)
        }
    }
}
