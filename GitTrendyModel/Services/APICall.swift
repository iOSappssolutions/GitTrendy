//
//  APICall.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    func body() throws -> Data?
}

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case noInternet
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .noInternet: return "No Internet Connection"
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        var request: URLRequest
        if let queryItems = queryItems {
            guard var urlComponents = URLComponents(string: baseURL + path) else {
               throw APIError.invalidURL
            }
            urlComponents.queryItems = queryItems
            
            guard let calculatedUrl = urlComponents.url else {
               throw APIError.invalidURL
            }
            request = URLRequest(url: calculatedUrl)
        } else {
            guard let url = URL(string: baseURL + path) else {
                throw APIError.invalidURL
            }
            request = URLRequest(url: url)
        }
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
