//
//  CurrencyRateRemoteDataSourceTests.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//


import XCTest

@testable import CurrencyRate

final class CurrencyRateRemoteDataSourceTests: XCTestCase {
    
    func testGetCurrenciesSuccess() {
        let dataSource = CurrencyRateRemoteDataSourceMock()
        dataSource.getCurrencies { result in
            switch result {
            case .success(let entity):
                XCTAssertTrue(entity.success)
            case .failure:
                break
            }
        }
    }
    
    func testGetCurrencyRateSuccess() {
        let dataSource = CurrencyRateRemoteDataSourceMock()
        dataSource.gerCurrencyRate(defaultCurrency: "USD") { result in
            switch result {
            case .success(let entity):
                XCTAssertTrue(entity.success)
            case .failure:
                break
            }
        }
    }
    
}
