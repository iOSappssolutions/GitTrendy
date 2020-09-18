//
//  URLSession+extension.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

extension URLSession {
    static func configuredURLSession() -> URLSession {
       let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 60
       configuration.timeoutIntervalForResource = 120
       configuration.waitsForConnectivity = true
       configuration.httpMaximumConnectionsPerHost = 5
       return URLSession(configuration: configuration)
    }
}
