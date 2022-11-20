//
//  CurrencyRateRepositoryTest.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import XCTest

@testable import CurrencyRate
final class CurrencyRateRepositoryTests: XCTestCase {
    
    let currencyRepoMock = CurrencyRateRepositoryMock()
    
    func testGetCurrencies() {
        currencyRepoMock.getCurrencies { result in
            switch result {
            case .success(let entity):
                XCTAssertTrue(entity.count == 0)
            case .failure:
                break
            }
        }
    }
    
    func testSaveCurrencies() {
        let models = currencyRepoMock.saveCurrenciesToLocalStorage(currencies: CurrencyResponseEntity(symbols: [:], success: true))
        XCTAssertTrue(models.isEmpty)
    }
    
    func testGetCurrencyRate() {
        currencyRepoMock.getCurrencyRate(fromSymbol: "USD", toSymbol: "USD") { result in
            switch result {
            case .success(let entity):
                XCTAssertTrue(entity == 1.23)
            case .failure:
                break
            }
        }
    }
    
    func testSaveCurrencyRates() {
        currencyRepoMock.saveCurrencyRatesFromRemote(baseCurrencySymbol: "USD") { result in
            switch result {
            case .success(let entity):
                XCTAssertTrue(entity)
            case .failure:
                break
            }
        }
    }
    
    func testSaveHistory() {
        currencyRepoMock.saveHistory(fromSymbol: "USD", toSymbol: "NPR", rate: 1.23) { result in
            switch result {
            case .success(let entity):
                XCTAssertTrue(entity)
            case .failure:
                break
            }
        }
    }
}
