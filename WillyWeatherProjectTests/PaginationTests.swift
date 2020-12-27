import XCTest
@testable import WillyWeatherProject

class PaginationTests: XCTestCase {
    let mockLoader = MockLoader()
    var mockCache = MockJSONStore<OMDBModel>(storageType: .cache)
    
    
    lazy var mockAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI(loader: mockLoader,cacheLoader: mockCache ) }()
    // lazy var realAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI(loader: mock,cacheLoader: realCache ) }()
    
    lazy var paginator: MockPaginator = { MockPaginator(repository: mockAPI) }()
    
    
    
    
    func test_pagination() {
        var result: OMDBResult?
        
        let expectation = self.expectation(description: "Valid pagenumber")
        
        mockLoader.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
        }
        
       
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        self.paginator.fetchData()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(paginator.page, 2)
    }
    
    func test_pagination_fails_when_isLoading_true() {
        var result: OMDBResult?
        
        let expectation = self.expectation(description: "Valid pagenumber")
        
        mockLoader.then { request, handler in
            
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
  
        }
        
        
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        self.paginator.isLoading = true
        self.paginator.fetchData()
      
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(paginator.page, 1)
    }
    
    private var request: HTTPRequest {
        
        var r = HTTPRequest()
        
        r.setQueryParams(params: OMDBRequest(text: "batman", page: 1))
        return r
    }
    
    private func responseForTesting(request: HTTPRequest,statusCode:Int) -> HTTPURLResponse {
        HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "2.0", headerFields: nil)!
    }
    
}
