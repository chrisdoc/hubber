
import XCTest
@testable import Hubber
class UserTests: XCTestCase {
    
    lazy var userDictionary = {
        return [ "login": "chrisdoc", "id": 9047291, "avatar_url": "https://avatars.githubusercontent.com/u/9047291?v=3", "gravatar_id": "", "url": "https://api.github.com/users/chrisdoc", "html_url": "https://github.com/chrisdoc", "followers_url": "https://api.github.com/users/chrisdoc/followers", "following_url": "https://api.github.com/users/chrisdoc/following{/other_user}", "gists_url": "https://api.github.com/users/chrisdoc/gists{/gist_id}", "starred_url": "https://api.github.com/users/chrisdoc/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/chrisdoc/subscriptions", "organizations_url": "https://api.github.com/users/chrisdoc/orgs", "repos_url": "https://api.github.com/users/chrisdoc/repos", "events_url": "https://api.github.com/users/chrisdoc/events{/privacy}", "received_events_url": "https://api.github.com/users/chrisdoc/received_events", "type": "User", "site_admin": false, "score": 46.493988 ] as [String : Any]
 
    }()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserDeserialization() {
        if let user = User.parseUser(userDictionary) {
            XCTAssertEqual(user.username, "chrisdoc")
            XCTAssertEqual(user.avatar, "https://avatars.githubusercontent.com/u/9047291?v=3")
        } else {
            XCTFail("could not parse user")
        }
    }
}
