
struct User {
    let username: String
    let avatar: String
}

extension User {
    static func parseUsers(_ json: [String: Any]) -> [User] {
        if let items = json["items"] as? [[String: Any]] {
            return items.map{ parseUser($0) }.flatMap { $0 }
        }
        return []
    }
    
    static func parseUser(_ dict: [String: Any]) -> User? {
        if let username = dict["login"] as? String, let avatar = dict["avatar_url"] as? String{
            return User(username: username, avatar: avatar)
        } else {
            return nil
        }
    }
}
