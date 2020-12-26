import Foundation

struct OMDBFetchMoviesAPI: OMDBFetchMoviesUseCase {
    
    let jsonStore: JSONStore<OMDBModel> = JSONStore(storageType: .permanent, filename: "movies.json")
    let loader: HTTPLoading
    
    init(loader: HTTPLoading = URLSession.shared) {
        self.loader = loader
    }
    

    
    func fetch(request: HTTPRequest, completion: @escaping OMDBResultHandler) {
       
        if let movies = self.jsonStore.storedValue(at: cacheName(request: request)) {
            completion(.success(movies))
            return
        }
        
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
            
            self.jsonStore.save(decoded, filename: cacheName(request: response.request))
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
    
    private func cacheName(request: HTTPRequest) -> String {
        var page = ""
        var term = ""
        request.params?.forEach({ (item) in
            if item.name == "s" {
                term = "term=\(item.value ?? "")"
            }
            if item.name == "page" {
                page = "page=\(item.value ?? "")"
            }
        })
        
        return term + "&" + page
    }
    
}



