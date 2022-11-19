//
//  GetCurrencyRateUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation


protocol GetCurrencyRateUseCaseProtocol {
    func execute(onComplete: @escaping (Result<Bool, Error>) -> Void)
}

struct GetCurrencyRateUseCase: GetCurrencyRateUseCaseProtocol {
    let currencyRateRepository: CurrencyRateRepositoryProtocol
    
    func execute(onComplete: @escaping (Result<Bool, Error>) -> Void) {
        currencyRateRepository.getCurrencies { result in
            
        }
    }
}
