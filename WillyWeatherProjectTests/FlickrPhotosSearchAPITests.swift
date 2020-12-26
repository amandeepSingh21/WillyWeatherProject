import XCTest
@testable import WillyWeatherProject

class FlickrPhotosSearchAPITests: XCTestCase {
    
    let mock = MockLoader()
    
    lazy var mockAPI: FlickrPhotoSearchUseCase = { FlickrPhotosSearchAPI(loader: mock) }()
    lazy var realAPI: FlickrPhotoSearchUseCase = { FlickrPhotosSearchAPI() }()
    
    
    
    //MARK:- Mock
    func test_200_OK_WithNoBody() {
        var result: HTTPResult?
        let expectation = self.expectation(description: "200 status")
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: nil)))
        }
        mockAPI.query(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(result?.response?.status, HTTPStatus.success)
    }
    
    
    func test_200_OK_WithValidResponseBody() {
        var result: HTTPResult?
        let expectation = self.expectation(description: "Valid body")
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: self.responseBody)))
        }
        mockAPI.query(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(result?.response?.body, self.responseBody)
    }
    
    func test_Request_With_Body_Not_Throws() {
        var result: HTTPResult?
        let expectation = self.expectation(description: "Not throws")
        
        
        
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: self.responseBody)))
        }
        var r = self.request
        r.body = JSONBody(FlickrRequest(text: "batman", page: 1))
        mockAPI.query(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNoThrow(try result?.get())
        
        
    }
    
    
    func test_Request_With_Body_Throws() {
        var result: HTTPResult?
        let expectation = self.expectation(description: "Throws")
        
        
        var r = self.request
        r.body = JSONBody(ThrowAbleBody())
        realAPI.query(request: r) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertThrowsError(try result?.get())
        
    }
    

    //MARK:- Real
    func test_Request_Fails_With_Invalid_URL() {
        var result: HTTPResult?
        let expectation = self.expectation(description: "Fails: Invalid URL")
        
        
        var r = self.request
        r.path = "this.will.fail.com"
        realAPI.query(request: r) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertThrowsError(try result?.get())
        
        
        
    }
    
    func test_Request_Success_With_Headers() {
        var result: HTTPResult?
        let expectation = self.expectation(description: "Success: with headers")
        
        
        
        var r = self.request
        r.headers = ["Key": "Value"]
        
        realAPI.query(request: r) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result?.request.headers, r.headers)

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
        r.path = "/services/rest/"
        r.setQueryParams(params: FlickrRequest(text: "bat", page: 1))
        return r
    }
    
    private var responseBody: Data {
        let json = """
            {
            "name" : "amandeep",
            "title": iOS Dev
            }
            """
        return Data(json.utf8)
    }
  
    
}


