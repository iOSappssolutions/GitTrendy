//
//  Repository.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

public struct GitHubRepository: Decodable {
    public let name: String
    public let starsCount: Int
    public let forksCount: Int
    public let description: String?
    public let contentsUrl: String
    public let user: GitHubUser
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case starsCount = "stargazers_count"
        case forksCount = "forks_count"
        case description = "description"
        case contentsUrl = "contents_url"
        case user = "owner"
    }
}
