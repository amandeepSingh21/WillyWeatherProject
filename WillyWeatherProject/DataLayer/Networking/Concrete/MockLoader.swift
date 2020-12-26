
import Foundation

public class MockLoader: HTTPLoading {
    // typealiases help make method signatures simpler
    
    public typealias ResponseCustomizationHandler = (HTTPRequest, HTTPHandler) -> Void
    
    private var responseCustomizationHandler: ResponseCustomizationHandler?
    
    public func load(request: HTTPRequest, completion: @escaping HTTPHandler) {
        if let handler = responseCustomizationHandler {
            handler(request, completion)
        } else {
            let error = HTTPError(code: .cannotConnect, request: request, response: nil, underlyingError: nil)
            completion(.failure(error))
        }
    }
    
    
    public func then(_ handler: @escaping ResponseCustomizationHandler) {
        responseCustomizationHandler = handler
        
    }
}
