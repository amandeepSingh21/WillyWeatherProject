import Foundation


protocol FlickrPhotoSearchUseCase {
    func query(request: FlickrRequest, completion: @escaping (HTTPResult) -> Void)
}
