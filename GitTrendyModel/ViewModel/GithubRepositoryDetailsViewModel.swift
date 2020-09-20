//
//  GithubRepositoryDetailsViewModel.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import Foundation
import Combine

public class GithubRepositoryDetailsViewModel: ObservableObject {
    
    @Published public var isLoading: Bool = false
    @Published public var alertMessage: Message? = nil
    @Published public var readme: String = ""
    
    public let repository: GitHubRepository
    private let api: GithubAPI
    private var subscriptions = Set<AnyCancellable>()
    
    public init(repository: GitHubRepository, api: GithubAPI = GithubAPIImplementation()) {
        self.api = api
        self.repository = repository
    }
    
    public func getReadme() {
        self.isLoading = true
        api.getReadme(url: String(repository.contentsUrl.dropLast(7)))
        .flatMap { [unowned self] in
            self.api.downloadReadme(url: $0.downloadUrl!)
        }
        .sink { [unowned self] in
            if case .failure(let error) = $0 {
                self.alertMessage = Message(id: 0, message: error.localizedDescription)
            }
            self.isLoading = false
        } receiveValue: { [unowned self] in
            print($0)
            self.readme = String(data: $0, encoding: .utf8)!
        }
        .store(in: &subscriptions)
    }
    
}
