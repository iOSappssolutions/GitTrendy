//
//  RepositoryDetails.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit
import GitTrendyModel
import Combine

class RepositoryDetails: UIViewController {
    
    private let repositoryDetailsViewModel: GithubRepositoryDetailsViewModel
    let scrollView: RepositoryScrollView!
    
    init(repositoryDetailsViewModel: GithubRepositoryDetailsViewModel) {
        self.scrollView = RepositoryScrollView(repository: repositoryDetailsViewModel.repository)
        self.repositoryDetailsViewModel = repositoryDetailsViewModel
        super.init(nibName: nil, bundle: nil)
        self.setupStreams()
        self.navigationItem.title = repositoryDetailsViewModel.repository.name
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "secondaryTextColor")!]
        
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "secondaryTextColor")!]
        appearance.buttonAppearance = buttonAppearance
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        UINavigationBar.appearance().tintColor = UIColor(named: "secondaryTextColor")!
        
        self.view.backgroundColor = UIColor(named: "primaryColor")
        self.addSubviews()
        self.addConstraints()
        self.repositoryDetailsViewModel.getReadme()
    }
    
    func addSubviews() {
        self.view.addSubview(scrollView)
    }
    
    func addConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollViewLeading = scrollView.leadingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        
        let scrollViewTrailing = scrollView.trailingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        
        let scrollViewTop = scrollView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        let scrollViewBottom = scrollView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            scrollViewLeading,
            scrollViewTrailing,
            scrollViewTop,
            scrollViewBottom,
        ])
    }
    
    private var alertMessage: String? {
        didSet{
            guard let message = alertMessage else { return }
            self.showAlert(title: "", message: message)
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            if(isLoading) {
                spinner = RepositoriesViewController.displaySpinner()
            } else {
                guard let spinner = spinner else { return }
                RepositoriesViewController.removeSpinner(spinner: spinner)
            }
        }
    }
    
    private var spinner: UIView?
    
    private var subscriptions = Set<AnyCancellable>()
    
    private func setupStreams() {
        
//        repositoryDetailsViewModel.$alertMessage
//        .map({ $0?.message })
//        .assign(to: \.alertMessage, on: self)
//        .store(in: &subscriptions)
        
        repositoryDetailsViewModel.$isLoading
        .assign(to: \.isLoading, on: self)
        .store(in: &subscriptions)
        
        repositoryDetailsViewModel.$readme
        .sink { [weak self] (readme) in
            self?.scrollView.setReadme(text: readme)
        }
        .store(in: &subscriptions)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
