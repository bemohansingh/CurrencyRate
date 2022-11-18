//
//  NetworkService.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

protocol NetworkService {
    func execute(api: RequestApi, onCompletetion: @escaping(URLResponse) -> Void, onError: @escaping(APIError) -> Void)
}
