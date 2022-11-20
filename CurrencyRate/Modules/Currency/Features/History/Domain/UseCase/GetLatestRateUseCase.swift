//
//  GetLatestRateUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

protocol GetLatestRateUseCaseProtocol {
    func execute(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void)
}

struct GetLatestRateUseCase: GetLatestRateUseCaseProtocol {
    let historyRepository: HistoryRepositoryProtocol
    
    func execute(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void) {
        historyRepository.getLatestRates(currencies: currencies, onComplete: { result in
            onComplete(result)
        })
    }
}
