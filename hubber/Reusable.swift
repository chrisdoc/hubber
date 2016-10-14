protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        // I like to use the class's name as an identifier
        // so this makes a decent default value.
        return String(describing: Self.self)
    }
}
