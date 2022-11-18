//
//  NetworkClient.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import Foundation

class NetworkClient: NetworkService {
    private let networkConfiguration: NetworkConfiguration
    
    init(config: NetworkConfiguration) {
        self.networkConfiguration = config
    }
    
    func execute(api: RequestApi, onCompletetion: @escaping(URLResponse) -> Void, onError: @escaping(APIError) -> Void) {
        let url = networkConfiguration.baseUrl.appending(path: api.path)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("8QfAvzmFP9d8KZ6tHzd2XcazAx2R36xm", forHTTPHeaderField: "apikey")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                    print(data)
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
        }

        task.resume()
    }
}
