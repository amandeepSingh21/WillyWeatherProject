
import Foundation

public typealias HTTPResult = Result<HTTPResponse,HTTPError>

extension HTTPResult {
    
    public var request: HTTPRequest {
        switch self {
        case .success(let response): return response.request
        case .failure(let error): return error.request
        }
    }
    
    public var response: HTTPResponse? {
        switch self {
        case .success(let response): return response
        case .failure(let error): return error.response
        }
    }
    
}

extension HTTPResult {
    
    init(request: HTTPRequest, responseData: Data?, response: URLResponse?, error: Error?) {
        var httpResponse: HTTPResponse?
        if let r = response as? HTTPURLResponse {
            httpResponse = HTTPResponse(request: request, response: r, body: responseData ?? Data())
        }
        
        if let e = error as? URLError {
            let code: HTTPError.Code
            switch e.code {
            case .badURL,.unsupportedURL,.cannotFindHost: code = .invalidRequest
            case .cancelled: code = .cancelled
            case .notConnectedToInternet,.cannotConnectToHost,.networkConnectionLost: code = .cannotConnect
            case .timedOut: code = .timedOut
            case .appTransportSecurityRequiresSecureConnection: code = .insecureConnection
            default: code = .unknown
            }
            self = .failure(HTTPError(code: code, request: request, response: httpResponse, underlyingError: e))
        } else if let someError = error {
            
            self = .failure(HTTPError(code: .unknown, request: request, response: httpResponse, underlyingError: someError))
        } else if let r = httpResponse {
            self = .success(r)
        } else {
            self = .failure(HTTPError(code: .invalidResponse, request: request, response: nil, underlyingError: error))
        }
    }
}
