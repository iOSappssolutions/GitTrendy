//
//  GitHubRepositoriesViewModel.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

public class GithubRepositoriesViewModel: ObservableObject {
    
    @Published public var isLoading: Bool = false
    @Published public var alertMessage: Message? = nil
    @Published public var repositories: [GitHubRepository] = []
    private var currentPage = 0
    private var keyword: String? = nil
    
    private let api: GithubAPI
    private var subscriptions = Set<AnyCancellable>()
    
    
    public init(api: GithubAPI = GithubAPIImplementation()) {
        self.api = api
    }
    
    public func loadTrendingRepositories(forPage: Int = 1) {
        isLoading = true
        if(forPage > currentPage ) {
            currentPage = forPage
        } else {
            return
        }

        api.fetchTrendingRepositories(keyword: keyword, page: currentPage)
        .retry(1)
        .sink { [weak self] in
            if case .failure(let error) = $0 {
                self?.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            self?.isLoading = false
        } receiveValue: { [weak self] in
            guard let self = self else { return }

            if(self.currentPage > 1) {
                self.repositories.append(contentsOf: $0.repositories)
            } else {
                self.repositories = $0.repositories
            }
        }
        .store(in: &subscriptions)
    }
    
    public func filterRepositories(keyword: String?) {
        self.currentPage = 0
        self.keyword = keyword
        self.loadTrendingRepositories()
    }
}
