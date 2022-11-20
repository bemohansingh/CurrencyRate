//
//  NetworkClientTests.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import XCTest

@testable import CurrencyRate
open class NetworkClientTests: XCTest {
    let networkService = NetworkClientMock()
    
    func testNetworkService() {
        networkService.execute(api: RequestApiMock()) { res in
            XCTAssertTrue(res.statusCode == 200)
        } onError: { error in
            XCTAssertTrue(false)
        }
    }
}

class RequestApiMock: RequestApi {
    var path: String = "test"
    
    var method: HTTPMethod = .get
    
    var headers: ReaquestHeaders? = [:]
    
    var parameters: RequestParameters? = [:]
}
