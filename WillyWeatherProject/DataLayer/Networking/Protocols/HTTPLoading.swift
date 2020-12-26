import Foundation

public protocol HTTPLoading {
    func load(request: HTTPRequest, completion: @escaping HTTPHandler)
}

