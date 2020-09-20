//
//  RepositoriesViewModelFactory.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import SwiftUI

public class RepositoriesViewModelFactory {
    
    public init() {}
    
    static func makeGithubAPI() -> GithubAPI {
        #if test
            return FakeGithubAPI()
        #else
            return GithubAPIImplementation()
        #endif
    }
    
    public static func makeGithubRepositoriesViewModel() -> GithubRepositoriesViewModel {
        return GithubRepositoriesViewModel(api: makeGithubAPI())
    }
    
    public static func makeGithubRepositoriesDetailsViewModel(repository: GitHubRepository) -> GithubRepositoryDetailsViewModel {
        return GithubRepositoryDetailsViewModel(repository: repository, api: makeGithubAPI())
    }
        
}
