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
    func saveCurrencyRatesFromRemote(baseCurrencySymbol: String, onComplete: @escaping(Result<Bool, Error>) -> Void)
    func getCurrencyRate(fromSymbol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void)
    func saveHistory(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping(Result<Bool, Error>) -> Void)
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
    
    func saveCurrencyRatesFromRemote(baseCurrencySymbol: String, onComplete: @escaping(Result<Bool, Error>) -> Void) {
        if let date = currencyRateLocalDataSource.getCurrencyRateUpdatedDate() {
           
            if let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff < 16 {
                onComplete(.success(true))
                print(diff)
                return
                }
            
        }
        currencyRateRemoteDataSource.gerCurrencyRate(defaultCurrency: baseCurrencySymbol) { result in
            switch result {
            case .success(let entity):
                _ = currencyRateLocalDataSource.saveCurrencyRates(currencyRates: entity)
                onComplete(.success(true))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func getCurrencyRate(fromSymbol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void) {
        currencyRateLocalDataSource.getCurrencyRate(fromSymbol: fromSymbol, toSymbol: toSymbol) { result in
            onComplete(result)
        }
    }
    
    func saveHistory(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping (Result<Bool, Error>) -> Void) {
        currencyRateLocalDataSource.saveCurrencyRateSearchHistory(fromSymbol: fromSymbol, toSymbol: toSymbol, rate: rate, onComplete: {result in
            onComplete(result)
        })
    }
}
