//
//  GithubSearchResponse.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

struct GithubSearchResponse: Decodable {
    let totalCount: Int
    let repositories: [GitHubRepository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositories = "items"
    }
}
