struct Repository {
    var id: Int
    var name: String
    var fullName: String
    var starCount: Int
    var description: String
}

extension Repository {
    static func parseRepositories(_ dictionary: [String: Any]) -> [Repository] {
        guard let items = dictionary["items"] as? [[String: Any]] else {
            return []
        }
        return items.flatMap{ parseRepository($0) }
    }
    
    static func parseRepository(_ dictionary: [String: Any]) -> Repository? {
        if let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let fullName = dictionary["full_name"] as? String,
            let starCount = dictionary["stargazers_count"] as? Int,
            let description = dictionary["description"] as? String {
            return Repository(id: id, name: name, fullName: fullName, starCount: starCount, description: description)
            
        }
        return nil
    }
}
