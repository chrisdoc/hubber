import Foundation

protocol GitHubApi {
    func searchUsers(_ searchTerm: String, completion: @escaping ([User]?, Error?) -> ())
    func searchRepositories(_ searchTerm: String, completion: @escaping ([Repository]?, Error?) -> ())
}

struct GitHubApiClient : GitHubApi {
    let baseUrl = "https://api.github.com"
    enum GitHubError: Error {
        case urlError
    }
    
    enum SearchType: String {
        case users
        case repositories
    }
    
    let downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func searchUsers(_ searchTerm: String, completion: @escaping ([User]?, Error?) -> ()) {
        self.search(searchTerm, searchType: .users) {
            (dict, error) in
            if let users = dict.map({ User.parseUsers($0) }) {
                completion(users, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func searchRepositories(_ searchTerm: String, completion: @escaping ([Repository]?, Error?) -> ()) {
        self.search(searchTerm, searchType: .repositories) {
            (dict, error) in
            if let repos = dict.map({ Repository.parseRepositories($0) }) {
                completion(repos, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    private func search(_ searchTerm: String, searchType: SearchType, completion: @escaping ([String: Any]?, Error?) ->()) {
        guard let url = URL(string: "\(baseUrl)/search/\(searchType.rawValue)?q=\(searchTerm)") else {
            completion(nil, GitHubError.urlError)
            return
        }
        
        downloadsSession.dataTask(with: url) { (data, response, error) in
            guard let unwrappeData = data else {
                completion(nil, error)
                return
            }
            completion(unwrappeData.deserializeDictionary(), nil)
        }.resume()
    }
}

extension Data {
    func deserializeDictionary() -> [String : Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: [])
        return json as? [String : Any]
    }
}
