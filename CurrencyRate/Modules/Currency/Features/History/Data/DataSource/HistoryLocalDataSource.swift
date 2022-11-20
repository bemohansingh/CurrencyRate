//
//  HistoryDataSource.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation
import CoreData

protocol HistoryLocalDataSourceProtocol {
    func getHistories(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void)
    func getLatestRates(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void)
}

struct HistoryLocalDataSource: HistoryLocalDataSourceProtocol {
    private let localStorage: LocalStorage
    
    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }
    
    func getHistories(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void) {
        let historyFetchRequest: NSFetchRequest<HistoryModel> = HistoryModel.fetchRequest()
        
        do {
            let managedContext = localStorage.managedContext
            var finalResults: [HistoryModel] = []
            let results = try managedContext.fetch(historyFetchRequest)
            results.forEach { history in
                let days = Calendar.current.numberOfDaysBetween(fromDate: history.createdAt ?? Date(), toDate: Date())
                if days > 3 {
                    managedContext.delete(history)
                } else {
                    finalResults.append(history)
                }
            }
            onComplete(.success(finalResults))
        } catch let error as NSError {
            onComplete(.failure(error))
        }
    }
    
    func getLatestRates(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void) {
        let ratesRequest: NSFetchRequest<CurrencyRateModel> = CurrencyRateModel.fetchRequest()
        
        do {
            let managedContext = localStorage.managedContext
            let results = try managedContext.fetch(ratesRequest)
            var finalRates: [LatestRate] = []
            currencies.forEach { currency in
                let cyrrencyToandFrom = currency.split(separator: ":")
                if let fromSymbol = cyrrencyToandFrom.first, let toSymbol = cyrrencyToandFrom.last {
                    if let fromCurrency = results.first(where: {$0.symbol! == fromSymbol}), let toCurrency = results.first(where: {$0.symbol! == toSymbol}) {
                        finalRates.append(LatestRate(fromSymbol: fromCurrency.symbol!, toSymbol: toCurrency.symbol!, rate: toCurrency.rate / fromCurrency.rate))
                    }
                }
            }
            onComplete(.success(finalRates))
        } catch let error as NSError {
            onComplete(.failure(error))
        }
    }
}
