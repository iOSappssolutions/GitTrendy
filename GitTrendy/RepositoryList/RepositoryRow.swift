//
//  RepositoryRow.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import SwiftUI
import GitTrendyModel

struct RepositoryRow: View {
    
    let repository: GitHubRepository
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(repository.name)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack {
                Image(systemName: "star")
                    .renderingMode(.template)
                    .foregroundColor(Color("starColor"))
                Text(String(repository.starsCount))
                    .fontWeight(.semibold)
                Spacer()
            }
            HStack {
                Text(repository.description ?? "")
                    .foregroundColor(Color(.lightGray))
                Spacer()
            }
            
            Spacer()
            
           // Divider()
        }
    }
}

