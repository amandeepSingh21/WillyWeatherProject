import Foundation

struct OMDBFetchMoviesAPI: OMDBFetchMoviesUseCase {
    
    
    let loader: HTTPLoading
    init(loader: HTTPLoading = URLSession.shared) {
        self.loader = loader
    }
    
    
    func fetch(request: HTTPRequest, completion: @escaping OMDBResultHandler) {
        self.loader.load(request: request) { (result) in
            switch result {
            case .success(let response):
                if response.status == .success {
                    self.handleSuccessCase(response: response, completion: completion)
                } else {
                    completion(.failure(RemoteAPIError.statusError(status: response.status)))
                }
            case .failure(let error):
                completion(.failure(RemoteAPIError.httpError(error: error)))
            }
            
        }
        
    }
    
    private func handleSuccessCase(response: HTTPResponse, completion: @escaping OMDBResultHandler ) {
        
        let decoder = JSONDecoder()
        do {
            let decoded  = try decoder.decode(OMDBModel.self, from: response.body!) //safe
            completion(.success(decoded))
        } catch {
            do {
                let decoded  = try decoder.decode(OMDBAPIError.self, from: response.body!)
                completion(.failure(RemoteAPIError.OMDBAPIError(message: decoded.Error)))
            } catch {
                completion(.failure(RemoteAPIError.decoding))
            }
        }
    }
    
}



