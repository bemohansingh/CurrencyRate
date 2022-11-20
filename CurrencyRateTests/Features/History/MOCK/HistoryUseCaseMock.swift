//
//  HistoryUseCaseMock.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation


class GetHistoryUseCaseMock: GetHistoryUseCaseProtocol {
    func execute(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void) {
        onComplete(.success([]))
    }
}

class GetLatestRateUseCaseMock: GetLatestRateUseCaseProtocol {
    func execute(currencies: [String], onComplete: @escaping (Result<[LatestRate], Error>) -> Void) {
        onComplete(.success([]))
    }
    
}
