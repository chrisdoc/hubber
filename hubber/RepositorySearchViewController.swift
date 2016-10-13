//
//  RepositorySearchViewController.swift
//  Hubber
//
//  Created by Christoph Kieslich on 13/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import UIKit

class RepositorySearchViewController: UITableViewController {
    var apiClient: GitHubApi = GitHubApiClient()
    
    lazy var searchBar: UISearchBar = {
        [unowned self] in
        let bar = UISearchBar(frame: CGRect(x: 0.0, y: 64, width: 320, height: 44))
        bar.delegate = self
        return bar
        }()
    
    var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        definesPresentationContext = true
        // Setup the Scope Bar
        tableView.tableHeaderView = searchBar
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            return
        }
        apiClient.searchRepositories(searchTerm) {
            (repositories, error) in
            if let repos = repositories {
                self.repositories = repos
            }
        }
    }
}

extension RepositorySearchViewController {
    // MARK: - UITableView UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "blah")
        cell.textLabel?.text = repositories[indexPath.row].fullName
        return cell
    }
}

extension RepositorySearchViewController {
    // MARK: - UITableView UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
