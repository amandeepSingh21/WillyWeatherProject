
import Foundation

extension URLSession: HTTPLoading {
    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        
        guard let url = request.url else {
              completion(.init(request: request, responseData: nil, response: nil, error: HTTPError(request: request, code: .invalidRequest)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        for (header,value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        if !request.body.isEmpty {
            for (header, value) in request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }
            do {
                urlRequest.httpBody = try request.body.encode()
            } catch {
                completion(.init(request: request, responseData: nil, response: nil, error: HTTPError(request: request, code: .encodingFailure)))
                return
            }
        }
        
        let dataTask = self.dataTask(with: urlRequest) { (data, response, error) in
            completion(.init(request: request, responseData: data, response: response, error: error))
        }
        dataTask.resume()
    }
    
    
}
