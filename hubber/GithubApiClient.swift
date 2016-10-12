import Foundation

protocol GitHubApi {
    func loadUsers(_ userName: String, completion: @escaping ([User]?, Error?) -> ())
}

struct GitHubApiClient : GitHubApi {
    let baseUrl = "https://api.github.com"
    enum GitHubError: Error {
        case urlError
    }
    
    let downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func loadUsers(_ userName: String, completion: @escaping ([User]?, Error?) -> ()) {
        guard let url = URL(string: "\(baseUrl)/search/users?q=\(userName)") else {
            completion(nil, GitHubError.urlError)
            return
        }
        
        downloadsSession.dataTask(with: url) { (data, response, error) in
            guard let unwrappeData = data else {
                completion(nil, error)
                return
            }
            let users = unwrappeData.deserializeDictionary().map{ User.parseUsers($0) }
            completion(users, GitHubError.urlError)
        }.resume()
    }
}

extension Data {
    func deserializeDictionary() -> [String : Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: [])
        return json as? [String : Any]
    }
}
