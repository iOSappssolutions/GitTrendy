//
//  RepositoryDetails.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import SwiftUI
import GitTrendyModel
import UIKit
struct RepositoryDetails: View {
  
    @ObservedObject var githubRepositoryDetailsViewModel: GithubRepositoryDetailsViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                URLImage(url: self.githubRepositoryDetailsViewModel.repository.user.avatarUrl ?? "")
                    .clipped()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                    .padding(.top)
                
                HStack {
                    Spacer()
                    Text(githubRepositoryDetailsViewModel.repository.user.name)
                        .foregroundColor(Color("orange"))
                    Spacer()
                }
                
                Rectangle()
                    .frame(width: 30, height: 2)
                    .foregroundColor(Color("searchBarColor"))
                    .padding([.top, .bottom])
                
                HStack {
                    Spacer()
                    Text(githubRepositoryDetailsViewModel.repository.description ?? "")
                    Spacer()
                }
                .padding(.bottom)
                
                HStack(spacing: 5) {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .renderingMode(.template)
                            .foregroundColor(Color("secondaryTextColor"))
                        
                        Text(String(githubRepositoryDetailsViewModel.repository.starsCount) + " Stars")
                            .foregroundColor(Color("secondaryTextColor"))
                            .fontWeight(.bold)
                            .padding([.top, .bottom])
                        
                        Spacer()
                    }
                    .frame(width: 149)
                    
                    Rectangle()
                        .frame(width: 2, height: 50)
                        .foregroundColor(Color("searchBarColor"))
                    
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 0) {
                            
                            VStack(spacing: 0) {
                                Spacer()
                                
                                Circle()
                                    .frame(width: 7, height: 7)
                                    .foregroundColor(Color("secondaryTextColor"))
                                    .padding(.bottom, 3)
                                
                            }
                            
                            VStack(spacing: 3) {
                                
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color("secondaryTextColor"))
                                
                                Circle()
                                    .frame(width: 4, height: 4)
                                    .foregroundColor(Color("secondaryTextColor"))
                       
                            }
                        }
                        .frame(height: 16)
                        
                        Text(String(githubRepositoryDetailsViewModel.repository.forksCount) + " Forks")
                            .foregroundColor(Color("secondaryTextColor"))
                            .fontWeight(.bold)
                            .padding([.top, .bottom])
                        
                        Spacer()
                    }
                    .frame(width: 149)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("searchBarColor"), lineWidth: 2)
                )
                .frame(width: 300)

                HStack {
                    Text("Readme.md")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                
                TextView(githubRepositoryDetailsViewModel: githubRepositoryDetailsViewModel)
                    .padding()
                    
            }
            .navigationBarTitle(githubRepositoryDetailsViewModel.repository.name)
        }
        .alert(item: $githubRepositoryDetailsViewModel.alertMessage) { message in
            Alert(title: Text(message.message), dismissButton: .cancel())
        }
        .loading(isLoading: $githubRepositoryDetailsViewModel.isLoading)
        .onAppear(perform: {
            githubRepositoryDetailsViewModel.getReadme()
        })
        
    }
}


