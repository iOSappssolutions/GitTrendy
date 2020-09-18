//
//  GitHubUser.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

struct GitHubUser: Decodable {
    let name: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}
