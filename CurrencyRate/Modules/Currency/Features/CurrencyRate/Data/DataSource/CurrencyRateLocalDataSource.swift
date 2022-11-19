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
    func saveCurrencyRates()
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
    
    func saveCurrencyRates() {
        
    }
    
    func saveCurrencyRateSearchHistory() {
        
    }
    
    func getCurrencyRate(fromSymbol: String, toSymbol: String) {
        
    }

}
