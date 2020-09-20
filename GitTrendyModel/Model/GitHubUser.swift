//
//  GitHubUser.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

public struct GitHubUser: Decodable {
    public let name: String
    public let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}
