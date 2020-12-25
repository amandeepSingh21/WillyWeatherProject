import Foundation

public struct HTTPResponse {
    private  let response: HTTPURLResponse
    public let body: Data?
    public let request: HTTPRequest
    
    
    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }
    
    public var headers: [AnyHashable: Any] { response.allHeaderFields }
    
    
}
