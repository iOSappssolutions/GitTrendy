//
//  Repository.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

struct GitHubRepository: Decodable {
    let name: String
    let starsCount: Int
    let forksCount: Int
    let description: String
    let contentsUrl: String
    let user: GitHubUser
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case starsCount = "stargazers_count"
        case forksCount = "forks"
        case description = "description"
        case contentsUrl = "contents_url"
        case user = "owner"
    }
}
