
import Foundation

public struct HTTPRequest {
    private var components: URLComponents = URLComponents()
    
    public let headers: [String: String]
    public let body: Data?
    
}

extension HTTPRequest {
    
    public var scheme: String  { components.scheme ?? "https" }
    
    public var path: String {
        get { self.components.path }
        set { self.components.path = newValue }
    }
    
    public var host: String? {
        get { self.components.host }
        set { self.components.host = newValue }
    }
}
