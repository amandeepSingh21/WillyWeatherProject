import Foundation

public struct HTTPError: Error {
    public let code :Code
    public let request: HTTPRequest
    public let response: HTTPResponse?
    public let underlyingError: Error?
    
    public enum Code {
        case invalidRequest
        case cancelled
        case cannotConnect
        case insecureConnection
        case invalidResponse
        case unknown
        case encodingFailure
        case timedOut
        
        var message: String {
            switch self {
            case .invalidRequest: return "Invalid Request"
            case .cancelled: return "Request Cancelled"
            case .cannotConnect: return "Please check your internet connection"
            case .insecureConnection: return "Insecure connection"
            case .invalidResponse: return "Invalid response"
            case .unknown,.encodingFailure: return "Something went wrong"
            case .timedOut: return "Request timed out"
                
            }
        }
    }
}

public extension HTTPError {
    
    init(request: HTTPRequest, code: Code) {
        self.code = code
        self.request = request
        self.response = nil
        self.underlyingError = nil
    }
}
