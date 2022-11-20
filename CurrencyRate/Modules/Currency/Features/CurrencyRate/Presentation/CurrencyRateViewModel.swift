//
//  CurrencyRateViewModel.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class CurrencyRateViewModel: BaseViewModel {
    
    let getCurrenciesUseCase: GetCurrenciesUseCaseProtocol
    let saveCurrencyRates: SaveCurrencyRatesFromRemoteUseCaseProtocol
    let getCurrencyRate: GetCurrencyRateUseCaseProtocol
    
    let hideCurrencyInput = BehaviorRelay<Bool>(value: true)
    let fromCurrency = BehaviorRelay<String?>(value: nil)
    let toCurrency = BehaviorRelay<String?>(value: nil)
    
    let inputCurrency = BehaviorRelay<Double>(value: 1)
    let outputCurrency = BehaviorRelay<Double>(value: 0)
    var exchaneRateFactor: Double?
    
    let currencies = BehaviorRelay<[CurrencyModel]>(value: [])
    let errorFound = PublishSubject<String>()
    var isCurrenciesFetching = false
    var isRateFetching = false
    
    init(getCurrenciesUseCase: GetCurrenciesUseCaseProtocol, saveCurrencyRates: SaveCurrencyRatesFromRemoteUseCaseProtocol, getCurrencyRate: GetCurrencyRateUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
        self.saveCurrencyRates = saveCurrencyRates
        self.getCurrencyRate = getCurrencyRate
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
        
        inputCurrency.subscribe(onNext: {[weak self] inputValue in
            guard let self = self else {return}
            let outPutRate = (self.exchaneRateFactor ?? 0) * inputValue
            
            self.outputCurrency.accept(round(outPutRate * 100000) / 100000)
        }).disposed(by: bag)
    }
    
    func updateInputCurrency(amount: Double) {
        inputCurrency.accept(amount)
        convertCurrency()
    }
    
    func convertCurrency() {
        if let fromValue = fromCurrency.value, let toValue = toCurrency.value {
            getCurrencyRate(fromSymbol: fromValue, toSymbol: toValue)
        }
    }
    
    func switchCurrency() {
        let toCurrencyTemp = toCurrency.value
        toCurrency.accept(fromCurrency.value)
        fromCurrency.accept(toCurrencyTemp)
        if let rate = exchaneRateFactor, rate > 0 {
            exchaneRateFactor = 1 / rate
            inputCurrency.accept(1)
        }
       
        convertCurrency()
    }
    
    func getCurrencies() {
        if isCurrenciesFetching {
            return
        }
        isCurrenciesFetching = true
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
    
    func getCurrencyRates(baseCurrencySymbol: String) {
        if isRateFetching {
            return
        }
        isRateFetching = true
        saveCurrencyRates.execute(baseCurrencySymbol: baseCurrencySymbol) { [weak self] result in
            guard let self = self else {return}
            self.isRateFetching = false
            switch result {
            case .failure(let error):
                self.errorFound.onNext(error.localizedDescription)
            case .success:
                break
            }
        }
    }
    
    func getCurrencyRate(fromSymbol: String, toSymbol: String) {
        getCurrencyRate.execute(fromSymbol: fromSymbol, toSymbol: toSymbol, onComplete: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let rate):
                self.exchaneRateFactor = rate
                self.inputCurrency.accept(1)
            case .failure(let error):
                self.errorFound.onNext(error.localizedDescription)
            }
        })
    }
}
