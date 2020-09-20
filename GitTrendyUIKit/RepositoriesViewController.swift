//
//  ViewController.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit
import Combine
import GitTrendyModel

class RepositoriesViewController: UITableViewController {
    
    private var repositoriesViewModel = GithubRepositoriesViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private let repositoryCellID = "repositoryCellID"
    private var spinner: UIView?
    private let searchContainer = SearchBarContainer()
    
    private var repositories: [GitHubRepository] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var alertMessage: String? {
        didSet{
            guard let message = alertMessage else { return }
            self.showAlert(title: "", message: message)
        }
    }
    
    private func registerCells() {
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: repositoryCellID)
    }
    
    private func setupStreams() {
        
        repositoriesViewModel.$alertMessage
        .map({ $0?.message })
        .assign(to: \.alertMessage, on: self)
        .store(in: &subscriptions)
        
        repositoriesViewModel.$repositories
        .sink { [weak self] (repositories) in
            self?.repositories = repositories
        }
        .store(in: &subscriptions)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setupStreams()
        self.registerCells()
        self.navigationItem.title = "GIthub Trends"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "secondaryTextColor")!]
        UINavigationBar.appearance().tintColor = UIColor(named: "secondaryTextColor")!
        navigationItem.standardAppearance = appearance
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        searchContainer.searchBar.delegate = self
        tableView.tableHeaderView = searchContainer
        tableView.layoutIfNeeded()
        tableView.showsVerticalScrollIndicator = false
        searchContainer.backgroundColor = UIColor(named: "searchBarColor")
        searchContainer.frame.size.height = 60
        
        
        tableView.backgroundColor = UIColor(named: "primaryColor")
        view.backgroundColor = UIColor(named: "primaryColor")
        
        repositoriesViewModel.loadTrendingRepositories()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellID, for: indexPath)

        if let reposCell = cell as? RepositoryCell {
            reposCell.setCell(repository: repositories[indexPath.row])
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let repositoryDetails = RepositoryDetails(repositoryDetailsViewModel: RepositoriesViewModelFactory.makeGithubRepositoriesDetailsViewModel(repository: repositories[indexPath.row]))
        self.navigationController?.pushViewController(repositoryDetails, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if(index == repositoriesViewModel.repositories.count - 9) {
            let page = (repositoriesViewModel.repositories.count / 30) + 1
            self.repositoriesViewModel.loadTrendingRepositories(forPage: page)
        }
    }


}

extension RepositoriesViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //getRepertoire(pageIndex: "1", searchTitle: searchBar.text ?? "")
        repositoriesViewModel.filterRepositories(keyword: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0) {
            repositoriesViewModel.filterRepositories(keyword:
                                                "")
        }
    }
}
