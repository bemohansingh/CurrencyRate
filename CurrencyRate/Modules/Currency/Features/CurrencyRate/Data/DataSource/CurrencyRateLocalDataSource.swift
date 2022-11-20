//
//  CurrencyRateLocalDataSourse.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation
import CoreData

protocol CurrencyRateLocalDataSourceProtocol {
    func saveCurrencies(currencies: CurrencyResponseEntity) -> [CurrencyModel]
    func getCurrencies() -> [CurrencyModel]
    func saveCurrencyRates(currencyRates: CurrencyRateResponseEntity) -> [CurrencyRateModel]
    func saveCurrencyRateSearchHistory()
    func getCurrencyRateUpdatedDate() -> Date?
    func getCurrencyRate(fromSybol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void)
}

struct CurrencyRateLocalDataSource: CurrencyRateLocalDataSourceProtocol {
    private let localStorage: LocalStorage
    
    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }
    
    func saveCurrencies(currencies: CurrencyResponseEntity) -> [CurrencyModel] {
        var currencyModels: [CurrencyModel] = []
        let object = localStorage.managedContext
        currencies.symbols.forEach { key, value in
            let currencyModel = CurrencyModel(context: object)
            currencyModel.name = value
            currencyModel.symbol = key
            currencyModels.append(currencyModel)
        }
        localStorage.saveContext()
        
        return currencyModels
    }
    
    func getCurrencies() -> [CurrencyModel] {
        let currencyFetchRequest: NSFetchRequest<CurrencyModel> = CurrencyModel.fetchRequest()
        
        do {
            let managedContext = localStorage.managedContext
            let results = try managedContext.fetch(currencyFetchRequest)
            return results
        } catch let error as NSError {
            print(error)
            return []
        }
    }
    
    func saveCurrencyRates(currencyRates: CurrencyRateResponseEntity) -> [CurrencyRateModel] {
        var currencyRateModels: [CurrencyRateModel] = []
        let object = localStorage.managedContext
        currencyRates.rates.forEach { key, value in
            let currencyRateModel = CurrencyRateModel(context: object)
            currencyRateModel.symbol = key
            currencyRateModel.rate = value
            currencyRateModel.isBase = currencyRates.base == key
            currencyRateModels.append(currencyRateModel)
        }
        localStorage.saveContext()
        
        return currencyRateModels
    }
    
    func saveCurrencyRateSearchHistory() {
        
    }
    
    func getCurrencyRate(fromSybol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void) {
        var fromRate: Double
        var toRate: Double
        switch getRate(symbol: fromSybol, isFrom: true) {
        case .success(let rate):
            fromRate = rate.rate
        case .failure(let error):
            onComplete(.failure(error))
            return
        }
        
        switch getRate(symbol: toSymbol, isFrom: false) {
        case .success(let rate):
            toRate = rate.rate
        case .failure(let error):
            onComplete(.failure(error))
            return
        }
        
        onComplete(.success(toRate/fromRate))
    }
    
    /// Get Base Currency Rate
    private func getBaseRate() -> Result<CurrencyRateModel, Error> {
        let currencyFetchRequest: NSFetchRequest<CurrencyRateModel> = CurrencyRateModel.fetchRequest()
        currencyFetchRequest.predicate = NSPredicate(format: "isBase == %@", true)
        do {
            let managedContext = localStorage.managedContext
            if let result = try managedContext.fetch(currencyFetchRequest).first {
                return .success(result)
            } else {
                return .failure(AppError.custom("Unable to find base rate."))
            }
        } catch let error as NSError {
            return .failure(error)
        }
    }
    
    private func getRate(symbol: String, isFrom: Bool) -> Result<CurrencyRateModel, Error> {
        let currencyFetchRequest: NSFetchRequest<CurrencyRateModel> = CurrencyRateModel.fetchRequest()
        currencyFetchRequest.predicate = NSPredicate(format: "symbol == %@", symbol)
        do {
            let managedContext = localStorage.managedContext
            if let result = try managedContext.fetch(currencyFetchRequest).first {
                return .success(result)
            } else {
                return .failure(AppError.custom(isFrom ? "invalid from symbol." : "invalid to symbol."))
            }
        } catch let error as NSError {
            return .failure(error)
        }
    }
    
    func getCurrencyRateUpdatedDate() -> Date? {
        return Date()
    }
}
