//
//  RepositoryContentResponse.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation

struct RepositoryReadmeResponse: Decodable {
    let downloadUrl: String
    let content: String
    let encoding: String
    
    enum CodingKeys: String, CodingKey {
        case downloadUrl = "download_url"
        case content = "content"
        case encoding = "encoding"
    }
}
