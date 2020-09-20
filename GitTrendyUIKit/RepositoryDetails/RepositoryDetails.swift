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
    
    // MARK: - Properties
    private let repositoryDetailsViewModel: GithubRepositoryDetailsViewModel
    
    let scrollView: RepositoryScrollView!
    
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
    
    // MARK: - Methods
    init(repositoryDetailsViewModel: GithubRepositoryDetailsViewModel) {
        self.scrollView = RepositoryScrollView(repository: repositoryDetailsViewModel.repository)
        self.repositoryDetailsViewModel = repositoryDetailsViewModel
        super.init(nibName: nil, bundle: nil)
        self.setup()
        self.addSubviews()
        self.addConstraints()
        
        self.repositoryDetailsViewModel.getReadme()
    }
    
    private func setup() {
        self.setupStreams()
        self.setupNavigationBar()
        self.view.backgroundColor = UIColor(named: "primaryColor")
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = repositoryDetailsViewModel.repository.name
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "secondaryTextColor")!]
        
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "secondaryTextColor")!]
        appearance.buttonAppearance = buttonAppearance
        navigationItem.standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        UINavigationBar.appearance().tintColor = UIColor(named: "secondaryTextColor")!
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
    
    private func setupStreams() {
        
        repositoryDetailsViewModel.$isLoading
        .sink { [weak self] (isLoading) in
            self?.isLoading = isLoading
        }
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
