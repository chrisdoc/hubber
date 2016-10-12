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
        XCTAssertEqual(apiClient.userName, searchTerm)
    }
}

extension UserSearchViewControllerTests {
    class MockGithubApiClient: GitHubApi {
        var userName: String?
        func loadUsers(_ userName: String, completion: @escaping ([User]?, Error?) -> ()) {
            self.userName = userName
        }
    }
}
