//
//  CurrencyRateUseCaseTests.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import XCTest

@testable import CurrencyRate
open class GetCurrenciesUseCaseTests: XCTest {
    let getCurrenciesUseCase = GetCurrenciesUseCaseMock()
    
    func testGetCurrenciesUseCase() {
        getCurrenciesUseCase.execute { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    let saveCurrencyUseCase = SaveCurrencyRatesFromRemoteUseCaseMock()
    
    func testSaveCurrencyUseCase() {
        saveCurrencyUseCase.execute(baseCurrencySymbol: "USD") { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    let saveHistoryUseCase = SaveHistoryUseCaseMock()
    
    func testSaveHistoryUseCase() {
        saveHistoryUseCase.execute(fromSymbol: "USD", toSymbol: "NPR", rate: 1.23) { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    let getCurrencyRateUseCase = GetCurrencyRateUseCaseMock()
    func testGetCurrencyRateUseCase() {
        getCurrencyRateUseCase.execute(fromSymbol: "USD", toSymbol: "NPR") { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res == 1.23)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
}
