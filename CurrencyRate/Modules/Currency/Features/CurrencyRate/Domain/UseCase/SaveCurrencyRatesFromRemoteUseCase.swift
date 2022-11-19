//
//  SaveCurrencyRatesUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

protocol SaveCurrencyRatesFromRemoteUseCaseProtocol {
    func execute(baseCurrencySymbol: String, onComplete: @escaping (Result<Bool, Error>) -> Void)
}

struct SaveCurrencyRatesFromRemoteUseCase: SaveCurrencyRatesFromRemoteUseCaseProtocol {
    let currencyRateRepository: CurrencyRateRepositoryProtocol
    
    func execute(baseCurrencySymbol: String, onComplete: @escaping (Result<Bool, Error>) -> Void) {
        currencyRateRepository.saveCurrencyRatesFromRemote(baseCurrencySymbol: baseCurrencySymbol, onComplete: { result in
            return onComplete(result)
        })
    }
}
