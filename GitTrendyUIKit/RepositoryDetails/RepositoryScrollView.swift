//
//  RepositoryScrollView.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit
import GitTrendyModel

class RepositoryScrollView: UIScrollView {
    
    // MARK: - Properties
    private var repository: GitHubRepository
    
    lazy private var scrollContainerView = RepositoryContentView(repository: repository)
    
    // MARK: - Methods
    init(repository: GitHubRepository) {
        self.repository = repository
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(scrollContainerView)

    }
    
    func setReadme(text: String) {
        scrollContainerView.setReadme(text: text)
    }
    
    private func addConstraints() {
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollContainerViewLeading = scrollContainerView.leadingAnchor
            .constraint(equalTo: leadingAnchor)
        
        let scrollContainerViewTop = scrollContainerView.topAnchor
            .constraint(equalTo: topAnchor)
        
        let scrollContainerViewBottom = scrollContainerView.bottomAnchor
            .constraint(equalTo: bottomAnchor)
        
        let scrollContainerViewTrailing = scrollContainerView.trailingAnchor
                   .constraint(equalTo: trailingAnchor)
        
        let scrollContainerViewWidth = scrollContainerView.widthAnchor
            .constraint(equalTo: widthAnchor)
        
        
        NSLayoutConstraint.activate([
            scrollContainerViewLeading,
            scrollContainerViewTop,
            scrollContainerViewBottom,
            scrollContainerViewTrailing,
            scrollContainerViewWidth
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

