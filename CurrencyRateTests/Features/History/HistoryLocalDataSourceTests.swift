//
//  HistoryLocalDataSourceTests.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import XCTest

@testable import CurrencyRate

final class HistoryLocalDataSourceTests: XCTestCase {
    let dataSource = HistoryLocalDataSourceMock()
    
    func testGetHistories() {
        dataSource.getHistories { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testGetLatestRates() {
        dataSource.getLatestRates(currencies: []) { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.isEmpty)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
}
