//
//  GithubAPIImplementation.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

public struct GithubAPIImplementation: GithubAPI {
    
    public var session: URLSession = URLSession.configuredURLSession()
    
    public var baseURL: String
    
    public init(baseURL: String = C.baseURL) {
        self.baseURL = baseURL
    }
    
    public func fetchTrendingRepositories(keyword: String?, page: Int) -> AnyPublisher<GithubSearchResponse, Error> {
        return call(endpoint: API.fetchTrendingRepositories(keyword: keyword, page: page))
    }
    
    public func getReadme(url: String) -> AnyPublisher<RepositoryReadmeResponse, Error> {
        return call(endpoint: API.getReadme(url: url))
    }
    
    public func downloadReadme(url: String) -> AnyPublisher<Data, Error> {
        return call(endpoint: API.downloadReadme(url: url))
    }
    
}

extension GithubAPIImplementation {
    
    enum API {
        case fetchTrendingRepositories(keyword: String?, page: Int)
        case getReadme(url: String)
        case downloadReadme(url: String)
    }
    
}

extension GithubAPIImplementation.API: APICall {
    
    var baseUrl: String {
        switch self {
        case .fetchTrendingRepositories:
            return C.baseURL
        case let .getReadme(url: url):
            return url
        case let .downloadReadme(url: url):
            return url
        }
    }
    
    
    var path: String {
        switch self {
        case .fetchTrendingRepositories:
            return C.searchRepositories
        case .getReadme:
            return C.getReadme
        case .downloadReadme:
            return ""
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
        case let .fetchTrendingRepositories(keyword, page):
            return [URLQueryItem(name: "sort", value: "stars"),
                    URLQueryItem(name: "order", value: "desc"),
                    URLQueryItem(name: "q", value: self.getQuery(keyword: keyword)),
                    URLQueryItem(name: "page", value: String(page))]
        case .getReadme, .downloadReadme:
            return nil
        
        }
    }
    
    func body() throws -> Data? {
        nil
    }
    
}

extension GithubAPIImplementation.API {
    
    private func getQuery(keyword: String?) -> String {
        var query = ""
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let startDateFormatted = queryDateFromatter.string(from: startDate!)
        let dateQuery = "created:>\(startDateFormatted)"
        if let keyword = keyword {
            query = "\(keyword)+\(dateQuery)"
        } else {
            query = dateQuery
        }
        
        return query
        
    }
    
}
