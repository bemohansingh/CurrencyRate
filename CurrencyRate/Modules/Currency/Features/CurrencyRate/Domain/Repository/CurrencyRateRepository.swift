//
//  CurrencyRateRepository.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

protocol CurrencyRateRepositoryProtocol {
    func getCurrencies(onComplete: @escaping(Result<[CurrencyModel], Error>) -> Void)
    func saveCurrenciesToLocalStorage(currencies: CurrencyResponseEntity) -> [CurrencyModel]
    func getCurrencyRate(defaulrCurrency: String)
}

struct CurrencyRateRepository: CurrencyRateRepositoryProtocol {
    let currencyRateLocalDataSource: CurrencyRateLocalDataSourceProtocol
    let currencyRateRemoteDataSource: CurrencyRateRemoteDataSourceProtocol
    
    func getCurrencies(onComplete: @escaping(Result<[CurrencyModel], Error>) -> Void) {
         let currenciesFromLocal = currencyRateLocalDataSource.getCurrencies()
        if !currenciesFromLocal.isEmpty {
            return onComplete(.success(currenciesFromLocal))
        }
        
        currencyRateRemoteDataSource.getCurrencies { result in
            switch result {
            case .success(let entity):
               let currencies = saveCurrenciesToLocalStorage(currencies: entity)
                onComplete(.success(currencies))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func saveCurrenciesToLocalStorage(currencies: CurrencyResponseEntity) -> [CurrencyModel] {
        return currencyRateLocalDataSource.saveCurrencies(currencies: currencies)
    }
    
    func getCurrencyRate(defaulrCurrency: String) {
        
    }
}
