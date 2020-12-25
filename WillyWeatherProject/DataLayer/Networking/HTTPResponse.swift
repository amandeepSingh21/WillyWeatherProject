import Foundation

public struct HTTPResponse {
    private  let response: HTTPURLResponse
    public let body: Data?
    public let request: HTTPRequest
    
    public init(request: HTTPRequest, response: HTTPURLResponse, body: Data?) {
        self.request = request
        self.body = body
        self.response = response
    }
    
    
    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }
    
    public var headers: [AnyHashable: Any] { response.allHeaderFields }
    
    public var status: HTTPStatus { HTTPStatus(rawValue: self.response.statusCode) }
}
