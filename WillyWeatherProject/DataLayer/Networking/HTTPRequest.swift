import Foundation

public struct HTTPRequest {
    private var components: URLComponents = URLComponents()
    public var method: HTTPMethod
    public let headers: [String: String]
    public let body: HTTPBody = NoBody()
    
}

public extension HTTPRequest {
    
    var scheme: String  { components.scheme ?? "https" }
    
    var path: String {
        get { self.components.path }
        set { self.components.path = newValue }
    }
    
    var host: String? {
        get { self.components.host }
        set { self.components.host = newValue }
    }
    
    var url: URL? {
        get { self.components.url }
    }
}
