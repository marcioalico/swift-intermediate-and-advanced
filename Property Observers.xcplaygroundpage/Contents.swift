import Foundation

struct Website {
    
    init(url: String) {
        // MARK: defer
        /// will be called when the initializer is going to exit. it will makes that the didSet properties be executed
        /// defer could be used on any type of functions
        defer { self.url = url }
        self.url = url
    }
    
    var url: String {
        // MARK: didSet
        // didSet properties's closures are not going to get called when
        // are set on the initializers (creating an instance).
        didSet {
            url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        }
    }
}

var website = Website(url: "www.movies.com/?search= Lord of the Rings")
print(website)
website.url = "www.movies.com/?search= Lord of the Rings"
print(website)
