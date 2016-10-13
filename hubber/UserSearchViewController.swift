//
//  ViewController.swift
//  testable
//
//  Created by Christoph Kieslich on 12/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.backgroundColor = UIColor.brown
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        [unowned self] in
        let bar = UISearchBar()
        bar.delegate = self
        return bar
    }()
    
    lazy var apiClient: GitHubApi = GitHubApiClient()
    
    var users: [User] = [] {
        didSet {
            reloadUsers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        [searchBar, scrollView].forEach { [unowned self] (component: UIView) in
            component.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(component)
        }
        
        scrollView.addSubview(stackView)
        
        let constraints = [searchBarLayoutConstraints(), scrollViewLayoutConstraints()]
        NSLayoutConstraint.activate(constraints.flatMap {$0})
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func reloadUsers() {
        users.forEach { [unowned self] user in
            let userLabel = UILabel()
            userLabel.textColor = UIColor.blue
            userLabel.text = user.username
            DispatchQueue.main.async {
                self.stackView.addArrangedSubview(userLabel)
            }
        }
    }

}

extension UserSearchViewController {
    fileprivate func searchBarLayoutConstraints() -> [NSLayoutConstraint] {
        let horizontalLeftConstrain = NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let horizontalRightConstrain = NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let pinTop = NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal,
                                        toItem: view, attribute: .top, multiplier: 1.0, constant: 20)
        return [horizontalLeftConstrain, horizontalRightConstrain, pinTop]
    }
    
    fileprivate func scrollViewLayoutConstraints() -> [NSLayoutConstraint] {
        let horizontalLeftConstrain = NSLayoutConstraint(item: scrollView, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let horizontalRightConstrain = NSLayoutConstraint(item: scrollView, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let pinTop = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal,
                                        toItem: searchBar, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let pinBottom = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal,
                                           toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        return [horizontalLeftConstrain, horizontalRightConstrain, pinTop, pinBottom]
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


