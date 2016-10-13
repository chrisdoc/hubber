
import XCTest
@testable import Hubber
class UserTests: XCTestCase {
    
    var userDictionary: [String: Any]!
    var usersDictionary: [String: Any]!
    override func setUp() {
        super.setUp()
        userDictionary = [ "login": "chrisdoc", "id": 9047291, "avatar_url": "https://avatars.githubusercontent.com/u/9047291?v=3", "gravatar_id": "", "url": "https://api.github.com/users/chrisdoc"] as [String : Any]
        
        let users = [userDictionary, userDictionary, userDictionary]
        usersDictionary = ["items": users]
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserDeserializationWithValidData() {
        if let user = User.parseUser(userDictionary) {
            XCTAssertEqual(user.username, "chrisdoc")
            XCTAssertEqual(user.avatar, "https://avatars.githubusercontent.com/u/9047291?v=3")
        } else {
            XCTFail("could not parse user")
        }
    }
    
    func testUserDeserializationWithInvalidData() {
        XCTAssertNil(User.parseUser(["user": "chrisdoc"]))
    }
    
    func testUsersDeserializationWithValidData() {
        let users = User.parseUsers(usersDictionary)
        XCTAssertEqual(users.count, 3)
        XCTAssertEqual(users[2].username, "chrisdoc")
        XCTAssertEqual(users[2].avatar, "https://avatars.githubusercontent.com/u/9047291?v=3")
    }
    
    func testUsersDeserializationWithInvalidDataReturnsEmptyArray() {
        let users = User.parseUsers(["Items":[userDictionary, userDictionary]])
        XCTAssertEqual(users.count, 0)
    }
    
}
