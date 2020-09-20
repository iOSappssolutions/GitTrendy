//
//  SearchBar.swift
//  GitTrendy
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import SwiftUI
import GitTrendyModel

struct SearchBar: View {

    @State var keyword = ""
    @State var isEditing: Bool = false
    var onCommit: (String)->()
    
    var body: some View {
        ZStack {
            Rectangle()
            .foregroundColor(Color("searchBarColor"))
            
            HStack {
                Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .foregroundColor(Color("searchBarColor"))
                .padding(.leading, 10)
                
                TextField("Search", text: $keyword, onCommit:  {
                    self.isEditing = false
                    self.onCommit(keyword)
                })
                .padding(8)
                .onTapGesture {
                    self.isEditing = true
                }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.keyword = ""
                        self.onCommit(keyword)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(Color("searchBarColor"))
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            .background(Color("primaryColor"))
            .cornerRadius(10)
            .padding()
            
        }
    }
}


