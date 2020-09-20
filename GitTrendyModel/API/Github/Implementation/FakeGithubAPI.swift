//
//  FakeGithubAPI.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

class FakeGithubAPI: GithubAPI {
    
    public var baseURL: String = C.baseURL
    
    public var session: URLSession = URLSession.configuredURLSession()
    
    func fetchTrendingRepositories() -> AnyPublisher<GithubSearchResponse, Error> {
        return Empty<GithubSearchResponse, Error>().eraseToAnyPublisher()
    }
    
    func getReadme(url: String) -> AnyPublisher<RepositoryReadmeResponse, Error> {
        return Empty<RepositoryReadmeResponse, Error>().eraseToAnyPublisher()
    }
    
    func downloadReadme(url: String) -> AnyPublisher<Data, Error> {
        return Empty<Data, Error>().eraseToAnyPublisher()
    }
    
}
