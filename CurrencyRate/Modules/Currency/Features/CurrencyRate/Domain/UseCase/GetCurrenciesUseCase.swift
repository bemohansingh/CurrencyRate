//
//  CurrencyRateUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

protocol GetCurrenciesUseCaseProtocol {
    func execute(onComplete: @escaping (Result<[CurrencyModel], Error>) -> Void)
}

struct GetCurrenciesUseCase: GetCurrenciesUseCaseProtocol {
    let currencyRateRepository: CurrencyRateRepositoryProtocol
    
    func execute(onComplete: @escaping (Result<[CurrencyModel], Error>) -> Void) {
        currencyRateRepository.getCurrencies { result in
            onComplete(result)
        }
    }
}
