import Foundation

public enum HTTPStatus: Int {
    case movedPermanently = 301
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case methodNotAllowed = 405
    case timedOut = 408
    case internalServerError = 500
    case unknown
    case success
    
    public init(rawValue: Int) {
        switch rawValue {
        case 301: self = .movedPermanently
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 405: self = .methodNotAllowed
        case 408: self = .timedOut
        case 500: self = .internalServerError
        case 200...299: self = .success
        default: self = .unknown
            
        }
    }
}
