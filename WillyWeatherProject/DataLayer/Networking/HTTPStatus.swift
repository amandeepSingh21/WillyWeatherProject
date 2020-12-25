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
}
