//
//  HistoryViewModel.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HistoryViewModel: BaseViewModel {
    let getHistoryUseCase: GetHistoryUseCaseProtocol
    let getLatestUseCase: GetLatestRateUseCaseProtocol
    let histories = BehaviorRelay<[HistoryModel]>(value: [])
    let latestRates = BehaviorRelay<[LatestRate]>(value: [])
    
    init(getHistoryUseCase: GetHistoryUseCaseProtocol, getLatestUseCase: GetLatestRateUseCaseProtocol) {
        self.getHistoryUseCase = getHistoryUseCase
        self.getLatestUseCase = getLatestUseCase
    }
    
    func getHistories() {
        getHistoryUseCase.execute { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let histories):
                self.histories.accept(histories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getLatestRates() {
        getLatestUseCase.execute(currencies: ["USD:AUD", "USD:INR", "USD:NPR", "INR:NPR"]) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let rates):
                self.latestRates.accept(rates)
            case .failure(let error):
                print(error)
            }
        }
    }
}
