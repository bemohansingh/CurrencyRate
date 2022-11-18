//
//  RequestApi.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

/// HTTP request methods.
enum HTTPMethod: String {
    /// HTTP GET
    case get = "GET"
    /// HTTP POST
    case post = "POST"
    /// HTTP PUT
    case put = "PUT"
    /// HTTP PATCH
    case patch = "PATCH"
    /// HTTP DELETE
    case delete = "DELETE"
}

/// Type alias used for HTTP request headers.
typealias ReaquestHeaders = [String: String]
/// Type alias used for HTTP request parameters. Used for query parameters for GET requests and in the HTTP body for POST, PUT and PATCH requests.
typealias RequestParameters = [String: Any?]

/// Protocol to which the HTTP requests must conform.
protocol RequestApi {

    /// The path that will be appended to API's base URL.
    var path: String { get }

    var method: HTTPMethod { get }

    var headers: ReaquestHeaders? { get }

    /// The request parameters used for query parameters for GET requests and in the HTTP body for POST, PUT and PATCH requests.
    var parameters: RequestParameters? { get }

}
