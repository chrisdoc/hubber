
import XCTest
@testable import Hubber
class GithubApiClientTests: XCTestCase {
    var sut: GitHubApi!
    override func setUp() {
        super.setUp()
        sut = GitHubApiClient()
    }
    
    func testSearchingUsersWithName_chrisdoc() {
        let userExp = expectation(description: "User completion")
        sut.searchUsers("chrisdoc") {
            (users, error) in
            if let unwrappedUsers = users {
                XCTAssertEqual(unwrappedUsers.count, 6)
                XCTAssertEqual(unwrappedUsers[0].username, "chrisdoc")
            } else {
                XCTFail("No users have been returned")
            }
            userExp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
