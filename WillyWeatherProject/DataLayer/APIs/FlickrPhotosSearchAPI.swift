import Foundation

struct FlickrPhotosSearchAPI: FlickrPhotoSearchUseCase {
    func query(request: FlickrRequest, completion: @escaping (HTTPResult) -> Void) {
        var r = HTTPRequest()
        r.scheme = "https"
        r.host = APIConfiguration.baseURL
        r.path = "/services/rest/"
        r.setQueryParams(params: request)
    
        URLSession.shared.load(request: r) { (result) in
            print(result.response?.status)
            completion(result)
        }
    }
    
    
    
    
}
