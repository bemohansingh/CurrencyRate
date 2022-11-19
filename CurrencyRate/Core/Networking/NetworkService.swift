//
//  NetworkService.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

struct NetworkResponse {
    let statusCode: Int
    let data: Data
}

protocol NetworkService {
    func execute(api: RequestApi, onCompletetion: @escaping(NetworkResponse) -> Void, onError: @escaping(APIError) -> Void)
}
