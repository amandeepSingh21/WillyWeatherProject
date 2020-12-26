import XCTest
@testable import WillyWeatherProject

class OMDBCacheMoviesTests: XCTestCase {
    
    let mock = MockLoader()
    var mockCache = MockJSONStore<OMDBModel>(storageType: .cache)
    var realCache = JSONStore<OMDBModel>(storageType: .cache)
    
    lazy var mockAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI(loader: mock,cacheLoader: mockCache ) }()
    lazy var realAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI(loader: mock,cacheLoader: realCache ) }()
  
  

    
    func test_response_cached_successfully_if_caching_is_on() {
        var result: OMDBResult?
        
        let expectation = self.expectation(description: "Valid body")
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
        }
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(mockCache.cache.count > 0)
    }
    
    
    func test_response_not_cached_if_caching_is_off() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Valid body")
        mockCache.isCachingEnabled = false
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
        }
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(mockCache.cache.count == 0)
    }
    
    //Make 2 calls for same request -> one will return from the cache
    func test_response_returned_from_cache() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Valid body")
        mockCache.isCachingEnabled = true
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
        }
        mockAPI.fetch(request: self.request) { (res) in
            self.mock.then { request, handler in
                handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
            }
            self.mockAPI.fetch(request: self.request) { (res) in
                result = res
                expectation.fulfill()
                
            }
            
        }
        
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(mockCache.isReturnedFromCache)
    }
    
    func test_response_returned_from_prod_cache() {
       
        var result: OMDBResult?
        var isFromCache = true
      
        let expectation = self.expectation(description: "Valid body")
        realCache.isCachingEnabled = true
        mock.then { request, handler in
            print("-----1")
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
        }
        realAPI.fetch(request: self.request) { (res) in
            self.mock.then { request, handler in
                print("-----2")
                isFromCache = false
                handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
            }
            self.realAPI.fetch(request: self.request) { (res) in
                result = res
                expectation.fulfill()
                
            }
            
        }
        
        
        waitForExpectations(timeout: 5, handler: nil)
         realCache.cleanup()
        XCTAssertTrue(isFromCache)
    }

    
   
    
    
    
    //MARK:- Helpers
    struct ThrowAbleBody:Encodable {
        func encode(to encoder: Encoder) throws {
            throw NSError.init()
        }
    }
    
    
    private func responseForTesting(request: HTTPRequest,statusCode:Int) -> HTTPURLResponse {
        HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "2.0", headerFields: nil)!
    }
    
    private var request: HTTPRequest {
        
        var r = HTTPRequest()
     
        r.setQueryParams(params: OMDBRequest(text: "batman", page: 1))
        return r
    }

}




