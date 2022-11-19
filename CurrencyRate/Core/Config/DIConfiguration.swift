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
    
    func getNeworkService() -> NetworkService {
            return NetworkClient(config: networkConfiguration)
    }
    
    func getCurrencyRateViewModel() -> BaseViewModel {
        return CurrencyRateViewModel(getCurrenciesUseCase: GetCurrenciesUseCase(currencyRateRepository: CurrencyRateRepository(currencyRateLocalDataSource: CurrencyRateLocalDataSource(), currencyRateRemoteDataSource: CurrencyRateRemoteDataSource(networkClient: getNeworkService()))))
    }
}
