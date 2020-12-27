import Foundation

enum ViewState {
    case loading
    case noResultsFound
    case loaded
    case error(error: RemoteAPIError)
    
    var message: String {
        switch self {
        case .noResultsFound:
            return "No results found."
        case .loading:
            return "Loading results...."
        case .error(let error):
            return error.message
        default:
            return ""
        }
    }
    
}

extension ViewState: Equatable {
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.loaded, .loaded): return true
        case (.error(_), .error(_)): return true
        case (.noResultsFound, .noResultsFound): return true
        default: return false
        }
    }
    
}
