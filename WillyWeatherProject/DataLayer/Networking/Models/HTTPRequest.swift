import Foundation

public struct HTTPRequest {
    private var components: URLComponents = URLComponents()
    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]
    public var body: HTTPBody = NoBody()
   
    public init() {
        self.scheme = "https"
        self.host = APIConfiguration.baseURL
    }
    
}

public extension HTTPRequest {
    
    var scheme: String  {
        get { components.scheme ?? "https" }
        set { components.scheme = newValue }
        
    }
    
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
    
    mutating func setQueryParams(params: Encodable) {
        
        self.components.setQueryItems(with: params.dictionary as! [String : String])
    }
    
    var params: [URLQueryItem]? {
        self.components.queryItems
    }
    
}
