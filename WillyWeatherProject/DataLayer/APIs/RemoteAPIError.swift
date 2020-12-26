enum RemoteAPIError: Error {
    case statusError(status: HTTPStatus)
    case httpError(error: HTTPError)
    case decoding
    case OMDBAPIError(message: String)
    
    var message: String {
        switch self {
        case .OMDBAPIError(let message):
            return message
        case .statusError(let status):
            return "Request failed with code: \(status.rawValue)"
        case .httpError:
            return "Server error!"
        case .decoding:
            return "Decoding error!"
        }
    }
}
