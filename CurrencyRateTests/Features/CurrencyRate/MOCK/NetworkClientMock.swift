//
//  NetworkClientMock.swift
//  CurrencyRateTests
//
//  Created by Mohan Singh Thagunna on 20/11/2022.
//

import Foundation

class NetworkClientMock: NetworkService {
    func execute(api: RequestApi, onCompletetion: @escaping(NetworkResponse) -> Void, onError: @escaping(APIError) -> Void) {
        onCompletetion(NetworkResponse(statusCode: 200, data: Data()))
    }
}
