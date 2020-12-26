import Foundation

struct OMDBFetchMoviesAPI: OMDBFetchMoviesUseCase {
    
   
    let loader: HTTPLoading
    let cacheLoader: JSONCache<OMDBModel>
    
    
    init(loader: HTTPLoading = URLSession.shared,
         cacheLoader: JSONCache<OMDBModel> = JSONStore<OMDBModel>(storageType: .cache)) {
        self.loader = loader
        self.cacheLoader = cacheLoader
        
    }
    

    
    func fetch(request: HTTPRequest, completion: @escaping OMDBResultHandler) {
       
        if let movies = self.cacheLoader.storedValue(at: self.cacheName(request: request) ) {
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
            
            self.cacheLoader.save(decoded, uniquieIdentifier: cacheName(request: response.request))
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
    
     func cacheName(request: HTTPRequest) -> String {
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



