//
//  ViewController.swift
//  testable
//
//  Created by Christoph Kieslich on 12/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = UIColor.brown
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        [unowned self] in
        let bar = UISearchBar()
        bar.delegate = self
        return bar
    }()
    
    lazy var apiClient: GitHubApi = GitHubApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        [searchBar,stackView].forEach { [unowned self] (component: UIView) in
            component.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(component)
        }
        let constraints = [searchBarLayoutConstraints(), stackViewLayoutConstraints()]
        NSLayoutConstraint.activate(constraints.flatMap {$0})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    fileprivate func searchBarLayoutConstraints() -> [NSLayoutConstraint] {
        let horizontalLeftConstrain = NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let horizontalRightConstrain = NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let pinTop = NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal,
                                        toItem: view, attribute: .top, multiplier: 1.0, constant: 20)
        return [horizontalLeftConstrain, horizontalRightConstrain, pinTop]
    }
    
    fileprivate func stackViewLayoutConstraints() -> [NSLayoutConstraint] {
        let horizontalLeftConstrain = NSLayoutConstraint(item: stackView, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let horizontalRightConstrain = NSLayoutConstraint(item: stackView, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let pinTop = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal,
                                        toItem: searchBar, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let pinBottom = NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal,
                                           toItem: view, attribute: .bottom, multiplier: 1.0, constant: 20)
        return [horizontalLeftConstrain, horizontalRightConstrain, pinTop, pinBottom]
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            print("nil searchterm \(searchBar.text)")
            return
        }
        
//       _ = apiClient.loadUsers(searchTerm)
    }
}


