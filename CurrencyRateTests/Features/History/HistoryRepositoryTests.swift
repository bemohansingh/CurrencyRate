//
//  HistoryRepositoryTests.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import XCTest

@testable import CurrencyRate
final class HistoryRepositoryTests: XCTestCase {
    let repo = HistoryRepositoryMock()
    
    func testGetHistories() {
        repo.getHistories { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testGetLatestRates() {
        repo.getLatestRates(currencies: []) { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
}
