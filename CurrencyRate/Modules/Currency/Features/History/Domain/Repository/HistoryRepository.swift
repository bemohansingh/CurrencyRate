//
//  HistoryRepository.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

protocol HistoryRepositoryProtocol {
    func getHistories(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void)
    func getLatestRates(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void)
}

struct HistoryRepository: HistoryRepositoryProtocol {
    private let historyLocalDataSource: HistoryLocalDataSourceProtocol
    
    init(historyLocalDataSource: HistoryLocalDataSourceProtocol) {
        self.historyLocalDataSource = historyLocalDataSource
    }
    
    func getHistories(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void) {
        historyLocalDataSource.getHistories { result in
            onComplete(result)
        }
    }
    
    func getLatestRates(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void) {
        historyLocalDataSource.getLatestRates(currencies: currencies) { result in
            onComplete(result)
        }
    }
}
