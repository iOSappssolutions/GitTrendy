//
//  GithubAPI.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

protocol GithubAPI: WebRepository {
    
    func fetchTrendingRepositories() -> AnyPublisher<GithubSearchResponse, Error>
    
    func getReadme(url: String) -> AnyPublisher<String, Error>
    
}
