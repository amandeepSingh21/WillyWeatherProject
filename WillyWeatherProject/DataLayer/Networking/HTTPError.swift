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
    }
}
