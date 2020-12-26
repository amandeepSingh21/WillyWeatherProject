import Foundation

typealias OMDBResult = Result<OMDBModel,RemoteAPIError>
typealias OMDBResultHandler = (Result<OMDBModel,RemoteAPIError>) -> Void
protocol OMDBFetchMoviesUseCase {
    func fetch(request: HTTPRequest, completion: @escaping OMDBResultHandler)
}
