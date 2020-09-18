//
//  FakeGithubAPI.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

class FakeGithubAPI: XPubAPI {
    
    public var baseURL: String = C.baseURL
    
    public var session: URLSession = URLSession.configuredURLSession()
    
    func fetchTrendingRepositories() -> AnyPublisher<GithubSearchResponse, Error> {
        return Empty<GithubSearchResponse, Error>().eraseToAnyPublisher()
    }
    
    func getReadme(url: String) -> AnyPublisher<String, Error> {
        return Empty<String, Error>().eraseToAnyPublisher()
    }
    
}
