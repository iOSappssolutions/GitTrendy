//
//  GithubAPI.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

public protocol GithubAPI: WebRepository {
    
    func fetchTrendingRepositories(keyword: String?, page: Int) -> AnyPublisher<GithubSearchResponse, Error>
    
    func getReadme(url: String) -> AnyPublisher<RepositoryReadmeResponse, Error>
    
    func downloadReadme(url: String) -> AnyPublisher<Data, Error>
    
}

extension GithubAPI {
    
    func fetchTrendingRepositories(keyword: String? = nil, page: Int = 1) -> AnyPublisher<GithubSearchResponse, Error> {
        return self.fetchTrendingRepositories(keyword: keyword, page: page)
    }
    
}
