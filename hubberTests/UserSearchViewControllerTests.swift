//
//  UserSearchViewControllerTests.swift
//  Hubber
//
//  Created by Christoph Kieslich on 12/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import XCTest
@testable import Hubber
class UserSearchViewControllerTests: XCTestCase {
    
    var sut: UserSearchViewController!
    let apiClient = MockGithubApiClient()
    override func setUp() {
        super.setUp()
        sut = UserSearchViewController()
        sut.apiClient = apiClient
    }
    
    func testThatApiIsCalledWithSearchBarText() {
        let searchBar = UISearchBar()
        let searchTerm = "chrisdoc"
        searchBar.text = searchTerm
        sut.searchBarSearchButtonClicked(searchBar)
        XCTAssertEqual(apiClient.searchTerm, searchTerm)
    }
}

extension UserSearchViewControllerTests {
    class MockGithubApiClient: GitHubApi {
        var searchTerm: String?
        func searchUsers(_ searchTerm: String, completion: @escaping ([User]?, Error?) -> ()) {
            self.searchTerm = searchTerm
            completion([User(username: "chrisdoc", avatar: "http://i.pravatar.cc/300")], nil)
        }
    }
}
