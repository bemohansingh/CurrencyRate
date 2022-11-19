//
//  CurrencyRateRemoteDataSource.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 19/11/2022.
//

import Foundation

protocol CurrencyRateRemoteDataSourceProtocol {
    func getCurrencies(onComplete: @escaping(Result<CurrencyResponseEntity, Error>) -> Void)
    func gerCurrencyRate(defaultCurrency: String, onComplete: @escaping(Result<CurrencyRateResponseEntity, Error>) -> Void)
}

struct CurrencyRateRemoteDataSource: CurrencyRateRemoteDataSourceProtocol {
    
    let networkClient: NetworkService
    
    init(networkClient: NetworkService) {
        self.networkClient = networkClient
    }
    
    func getCurrencies(onComplete: @escaping(Result<CurrencyResponseEntity, Error>) -> Void) {
        networkClient.execute(api: CurrencyRateApis.getCurrencies) { response in
            if let currencyEntity = try? JSONDecoder().decode(CurrencyResponseEntity.self, from: response.data) {
                onComplete(.success(currencyEntity))
            } else {
                onComplete(.failure(APIError.parseError(response.statusCode, "Parse Error")))
            }
        } onError: { error in
            onComplete(.failure(error))
        }
    }
    
    func gerCurrencyRate(defaultCurrency: String, onComplete: @escaping(Result<CurrencyRateResponseEntity, Error>) -> Void) {
        networkClient.execute(api: CurrencyRateApis.getCurrencyRate) { response in
            if let currencyEntity = try? JSONDecoder().decode(CurrencyRateResponseEntity.self, from: response.data) {
                onComplete(.success(currencyEntity))
            } else {
                onComplete(.failure(APIError.parseError(response.statusCode, "Parse Error")))
            }
        } onError: { error in
            onComplete(.failure(error))
        }
    }
    
}
