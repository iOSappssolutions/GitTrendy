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
    
    private func registerCells() {
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: repositoryCellID)
    }
    
    private func setupStreams() {
        
        repositoriesViewModel.$alertMessage
        .map({ $0?.message })
        .assign(to: \.alertMessage, on: self)
        .store(in: &subscriptions)
        
        repositoriesViewModel.$isLoading
        .assign(to: \.isLoading, on: self)
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        headerView.xPubViewModel = self.xPubViewModel
//        return headerView
//
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        self.view.endEditing(true)
//        let presentVC = TransactionDetailsViewController(transaction: transaction)
//        self.present(presentVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

