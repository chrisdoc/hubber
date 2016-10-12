
import XCTest
@testable import Hubber
class GithubApiClientTests: XCTestCase {
    var sut: GitHubApi!
    override func setUp() {
        super.setUp()
        sut = GitHubApiClient()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingUsersWithName_chrisdoc() {
        let userExp = expectation(description: "User completion")
        sut.loadUsers("chrisdoc") {
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
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
