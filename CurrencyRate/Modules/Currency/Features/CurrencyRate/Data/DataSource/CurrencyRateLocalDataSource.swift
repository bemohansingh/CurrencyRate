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
    func saveCurrencyRateSearchHistory(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping (Result<Bool, Error>) -> Void)
    func getCurrencyRateUpdatedDate() -> Date?
    func getCurrencyRate(fromSymbol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void)
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
        } catch {
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
        UserDefaults.standard.setValue(Date(), forKey: "sync_date")
        UserDefaults.standard.synchronize()
        return currencyRateModels
    }
    
    func saveCurrencyRateSearchHistory(fromSymbol: String, toSymbol: String, rate: Double, onComplete: @escaping (Result<Bool, Error>) -> Void) {
        let object = localStorage.managedContext
        let history = HistoryModel(context: object)
        history.toSymbol = toSymbol
        history.fromSymbol = fromSymbol
        history.toRate = rate
        history.createdAt = Date()
        localStorage.saveContext()
        
        return onComplete(.success(true))
    }
    
    func getCurrencyRate(fromSymbol: String, toSymbol: String, onComplete: @escaping(Result<Double, Error>) -> Void) {
        var fromRate: Double
        var toRate: Double
        switch getRate(symbol: fromSymbol, isFrom: true) {
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
        return UserDefaults.standard.value(forKey: "sync_date") as? Date
    }
}
