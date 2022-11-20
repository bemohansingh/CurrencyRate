//
//  HistoryLocalDataSourceMock.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

class HistoryLocalDataSourceMock: HistoryLocalDataSourceProtocol {
    func getHistories(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void) {
        onComplete(.success([]))
    }
    
    func getLatestRates(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void) {
        onComplete(.success([]))
    }
    
    
}
