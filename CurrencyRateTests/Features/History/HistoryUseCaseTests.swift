//
//  HistoryUseCaseTests.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import XCTest

@testable import CurrencyRate
final class GetHistoryUseCaseTests: XCTestCase {
    let useCase = GetHistoryUseCaseMock()
    
    func testGetHistoryUseCase() {
        useCase.execute { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
}

final class GetLatestRateUseCaseTests: XCTestCase {
    let useCase = GetLatestRateUseCaseMock()
    
    func testGetLatestRateUseCaseTests() {
        useCase.execute(currencies: []) { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
}
