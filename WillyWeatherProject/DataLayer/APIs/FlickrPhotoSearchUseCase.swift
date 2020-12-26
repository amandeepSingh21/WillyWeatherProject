import Foundation


protocol FlickrPhotoSearchUseCase {
    func query(request: HTTPRequest, completion: @escaping HTTPHandler)
}
