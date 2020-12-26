import Foundation

struct FlickrPhotosSearchAPI: FlickrPhotoSearchUseCase {
    let loader: HTTPLoading
    init(loader: HTTPLoading = URLSession.shared) {
        self.loader = loader
    }
    
    
    func query(request: HTTPRequest, completion: @escaping HTTPHandler) {
       
    
        loader.load(request: request) { (result) in
            print(result.response?.status)
            completion(result)
        }
    }
    
    
    
    
}
