//
//  SaveHistoryUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

protocol SaveHistoryUseCaseProtocol {
    func execute(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping (Result<Bool, Error>) -> Void)
}

struct SaveHistoryUseCase: SaveHistoryUseCaseProtocol {
    let currencyRateRepository: CurrencyRateRepositoryProtocol
    
    func execute(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping (Result<Bool, Error>) -> Void) {
        currencyRateRepository.saveHistory(fromSymbol: fromSymbol, toSymbol: toSymbol, rate: rate, onComplete: { result in
            onComplete(result)
        })
    }
}
