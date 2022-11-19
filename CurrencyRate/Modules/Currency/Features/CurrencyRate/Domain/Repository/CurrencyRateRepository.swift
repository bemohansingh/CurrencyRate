//
//  CurrencyRateRepository.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

protocol CurrencyRateRepositoryProtocol {
    func getCurrencies(onComplete: @escaping(Result<[CurrencyModel], Error>) -> Void)
    func saveCurrencies()
    func getCurrencyRate(defaulrCurrency: String)
}

struct CurrencyRateRepository: CurrencyRateRepositoryProtocol {
    let currencyRateLocalDataSource: CurrencyRateLocalDataSourceProtocol
    let currencyRateRemoteDataSource: CurrencyRateRemoteDataSourceProtocol
    
    func getCurrencies(onComplete: @escaping(Result<[CurrencyModel], Error>) -> Void) {
        currencyRateRemoteDataSource.getCurrencies { result in
            switch result {
            case .success(let entity):
                var currencyModels: [CurrencyModel] = []
                entity.symbols.forEach { key, value in
                    currencyModels.append(CurrencyModel(name: value, symbol: key))
                }
                onComplete(.success(currencyModels))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func saveCurrencies() {
        
    }
    
    func getCurrencyRate(defaulrCurrency: String) {
        
    }
}
