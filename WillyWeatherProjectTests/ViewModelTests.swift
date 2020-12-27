import XCTest
@testable import WillyWeatherProject

class ViewModelTests: XCTestCase {
    let mockLoader = MockLoader()
    var mockCache = MockJSONStore<OMDBModel>(storageType: .cache)
    
    
    lazy var mockAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI(loader: mockLoader,cacheLoader: mockCache ) }()
  
    
    lazy var viewModel = OMDBViewModel(repository: mockAPI)
    
    
    func test_viewstate_loading() {
        XCTAssertEqual(viewModel.viewState.value, ViewState.loading)
    }
    
    func test_viewstate_loaded() {
        var result: OMDBResult?
        
        let expectation = self.expectation(description: "Valid pagenumber")
        
        mockLoader.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.responseBody)))
        }
        
       
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        self.viewModel.fetch()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(viewModel.viewState.value, ViewState.loaded)
    }
    
    func test_viewstate_NO_Results_FOund() {
        var result: OMDBResult?
        
        let expectation = self.expectation(description: "Valid pagenumber")
        
        mockLoader.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: MockData.getEmptyData)))
        }
        
        
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        self.viewModel.fetch()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(viewModel.viewState.value, ViewState.noResultsFound)
    }
    
    
    func test_viewstate_Error() {
        var result: OMDBResult?
        
        let expectation = self.expectation(description: "Valid pagenumber")
        
        mockLoader.then { request, handler in
            handler(.failure(HTTPError.init(request: request, code: .timedOut)))
        }
        
        
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        self.viewModel.fetch()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        
        if case  ViewState.error(error: _) = viewModel.viewState.value {
            
        } else {
            XCTFail()
        }
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
