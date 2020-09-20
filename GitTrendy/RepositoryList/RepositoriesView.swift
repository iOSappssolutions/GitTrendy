//
//  ContentView.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 18/09/2020.
//

import SwiftUI
import GitTrendyModel

struct RepositoriesView: View {
    
    @ObservedObject var githubRepositoriesViewModel = GithubRepositoriesViewModel()
    
    var body: some View {
        List {
            SearchBar { keyword in
                githubRepositoriesViewModel.filterRepositories(keyword: keyword)
            }
            .listRowInsets(EdgeInsets())
            ForEach(0..<githubRepositoriesViewModel.repositories.count, id: \.self) { index in
                NavigationLink(destination: RepositoryDetails(githubRepositoryDetailsViewModel: RepositoriesViewModelFactory
                                                                                                .makeGithubRepositoriesDetailsViewModel(repository: githubRepositoriesViewModel.repositories[index]))) {
                    RepositoryRow(repository: githubRepositoriesViewModel.repositories[index])
                    .onAppear(perform: {
                        if(index == githubRepositoriesViewModel.repositories.count - 9) {
                            let page = (githubRepositoriesViewModel.repositories.count / 30) + 1
                            self.githubRepositoriesViewModel.loadTrendingRepositories(forPage: page)
                        }
                    })
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .alert(item: $githubRepositoriesViewModel.alertMessage) { message in
            Alert(title: Text(message.message), dismissButton: .cancel())
        }
        .navigationBarTitle("Github Trends", displayMode: .inline)
        .onAppear(perform: {
            self.githubRepositoriesViewModel.loadTrendingRepositories()
        })
    }
}


