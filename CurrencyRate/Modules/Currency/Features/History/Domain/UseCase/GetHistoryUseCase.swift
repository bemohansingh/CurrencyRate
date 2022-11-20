//
//  GetHistoryUseCase.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation
protocol GetHistoryUseCaseProtocol {
    func execute(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void)
}

struct GetHistoryUseCase: GetHistoryUseCaseProtocol {
    let historyRepository: HistoryRepositoryProtocol
    
    func execute(onComplete: @escaping (Result<[HistoryModel], Error>) -> Void) {
        historyRepository.getHistories { result in
            onComplete(result)
        }
    }
}
