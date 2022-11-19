//
//  CurrencyRateViewModel.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation
import RxCocoa
import RxSwift

class CurrencyRateViewModel: BaseViewModel {
    
    let getCurrenciesUseCase: GetCurrenciesUseCaseProtocol
    
    let hideCurrencyInput = BehaviorRelay<Bool>(value: true)
    let fromCurrency = BehaviorRelay<String?>(value: nil)
    let toCurrency = BehaviorRelay<String?>(value: nil)
    
    let inputCurrency = BehaviorRelay<Double>(value: 1)
    let outputCurrency = BehaviorRelay<Double>(value: 0)
    
    let currencies = BehaviorRelay<[CurrencyModel]>(value: [])
    let errorFound = PublishSubject<String>()
    
    init(getCurrenciesUseCase: GetCurrenciesUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
        super.init()
        self.observeEvents()
    }
    
    func observeEvents() {
        fromCurrency.subscribe(onNext: {[weak self] fromCurremcy in
            guard let self = self else {return}
            self.hideCurrencyInput.accept(fromCurremcy == nil || self.toCurrency.value == nil)
            if !self.hideCurrencyInput.value {
                self.convertCurrency()
            }
        }).disposed(by: bag)
        
        toCurrency.subscribe(onNext: {[weak self] toCurrency in
            guard let self = self else {return}
            self.hideCurrencyInput.accept(toCurrency == nil || self.fromCurrency.value == nil)
            if !self.hideCurrencyInput.value {
                self.convertCurrency()
            }
        }).disposed(by: bag)
    }
    
    func updateInputCurrency(amount: Double) {
        inputCurrency.accept(amount)
        convertCurrency()
    }
    
    func convertCurrency() {
        outputCurrency.accept(inputCurrency.value)
    }
    
    func switchCurrency() {
        let toCurrencyTemp = toCurrency.value
        toCurrency.accept(fromCurrency.value)
        fromCurrency.accept(toCurrencyTemp)
        convertCurrency()
    }
    
    func getCurrencies() {
        getCurrenciesUseCase.execute {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let currencies):
                self.currencies.accept(currencies)
            case .failure(let error):
                self.errorFound.onNext(error.localizedDescription)
            }
        }
    }
}
