//
//  GithubAPIImplementation.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

struct GithubAPIImplementation: GithubAPI {
    
    var session: URLSession = URLSession.configuredURLSession()
    
    var baseURL: String = C.baseURL
    
    func fetchTrendingRepositories() -> AnyPublisher<GithubSearchResponse, Error> {
        return call(endpoint: API.fetchTrendingRepositories)
    }
    
    func getReadme(url: String) -> AnyPublisher<String, Error> {
        return call(endpoint: API.getReadme(url: url))
    }
    
}

extension GithubAPIImplementation {
    
    enum API {
        case fetchTrendingRepositories
        case getReadme(url: String)
    }
    
}

extension GithubAPIImplementation.API: APICall {
    var path: String {
        switch self {
        case .fetchTrendingRepositories:
            return C.searchRepositories
        case .getReadme:
            return C.getReadme
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "accept": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchTrendingRepositories:
            return [URLQueryItem(name: "sort", value: "stars"),
                    URLQueryItem(name: "order", value: "desc"),
                    URLQueryItem(name: "q", value: "created:>2020-09-10"),
                    URLQueryItem(name: "page", value: "1")]
        case .getReadme:
            return nil
        }
    }
    
    func body() throws -> Data? {
        nil
    }
    
    
}
