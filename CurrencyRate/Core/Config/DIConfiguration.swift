//
//  DIConfiguration.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

// TODO:- App Dependency Container.
struct DIContainer {
    static let shared = DIContainer()
    private init() {}
    
     let networkConfiguration = NetworkConfiguration(baseUrl: URL(string: "https://api.apilayer.com/")!)
     let localStorage: LocalStorage = .init(modelName: "CurrencyStorage")
    
    func getNeworkService() -> NetworkService {
            return NetworkClient(config: networkConfiguration)
    }
    
    func getCurrencyRemoteDataSource() -> CurrencyRateRemoteDataSourceProtocol {
        return CurrencyRateRemoteDataSource(networkClient: getNeworkService())
    }
    
    func getCurrencyRateRepository() -> CurrencyRateRepositoryProtocol {
        return CurrencyRateRepository(currencyRateLocalDataSource: CurrencyRateLocalDataSource(localStorage: localStorage), currencyRateRemoteDataSource: getCurrencyRemoteDataSource()) // swiftlint:disable:this line_length
    }
    
    func getCurrencyRateViewModel() -> BaseViewModel {
        let getCurrencyUseCase = GetCurrenciesUseCase(currencyRateRepository: getCurrencyRateRepository())
        let saveCurrencyRates = SaveCurrencyRatesFromRemoteUseCase(currencyRateRepository: getCurrencyRateRepository())
        let getCurrencyRate = GetCurrencyRateUseCase(currencyRateRepository: getCurrencyRateRepository())
        let saveHistoryUseCase = SaveHistoryUseCase(currencyRateRepository: getCurrencyRateRepository())
        return CurrencyRateViewModel(getCurrenciesUseCase: getCurrencyUseCase, saveCurrencyRates: saveCurrencyRates, getCurrencyRate: getCurrencyRate, saveHistoryUseCase: saveHistoryUseCase) // swiftlint:disable:this line_length
    }
    
    func getHistoryViewModel() -> BaseViewModel {
        return HistoryViewModel()
    }
}
