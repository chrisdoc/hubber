//
//  ViewController.swift
//  testable
//
//  Created by Christoph Kieslich on 12/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import UIKit

class UserSearchViewController: UITableViewController {
    
    lazy var searchBar: UISearchBar = {
        [unowned self] in
        let bar = UISearchBar(frame: CGRect(x: 0.0, y: 64, width: 320, height: 44))
        bar.delegate = self
        return bar
        }()
    
    lazy var apiClient: GitHubApi = GitHubApiClient()
    
    var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        // Setup the Scope Bar
        tableView.tableHeaderView = searchBar
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UISearchBarDelegate
extension UserSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            print("nil searchterm \(searchBar.text)")
            return
        }
        apiClient.searchUsers(searchTerm) { [unowned self] (users, error) in
            if let unwrappedUsers = users {
                self.users = unwrappedUsers
            } else {
                print(error)
            }
        }
    }
}

extension UserSearchViewController {
    // MARK: - UITableView UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier) as? UserCell else {
            fatalError("no repo cell found")
        }
        userCell.bind(users[indexPath.row])
        return userCell
    }
}

extension UserSearchViewController {
    // MARK: - UITableView UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


