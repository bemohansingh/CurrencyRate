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
    func getCurrencyRate(fromSymbol: String, toSymbol: String)
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
    
    func getCurrencyRate(fromSymbol: String, toSymbol: String) {
        
    }

}
