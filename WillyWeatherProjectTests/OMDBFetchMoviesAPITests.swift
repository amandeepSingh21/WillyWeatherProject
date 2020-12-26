import XCTest
@testable import WillyWeatherProject

class OMDBFetchMoviesAPITests: XCTestCase {
    
    let mock = MockLoader()
    
    lazy var mockAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI(loader: mock) }()
    lazy var realAPI: OMDBFetchMoviesUseCase = { OMDBFetchMoviesAPI() }()
    
    
    
    //MARK:- Mock
    func test_200_OK_WithNoBody() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "200 status")
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: Data())))
        }
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertThrowsError(try result?.get())
      
    }
    
    
    func test_200_OK_WithValidResponseBody() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Valid body")
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: self.responseBody)))
        }
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
         XCTAssertNoThrow(try result?.get())
    }
    
    func test_Request_With_Body_Not_Throws() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Not throws")
        
        
        
        
        mock.then { request, handler in
            handler(.success(HTTPResponse(request: request, response: self.responseForTesting(request: request, statusCode: 200) , body: self.responseBody)))
        }
        var r = self.request
        r.body = JSONBody(OMDBRequest(text: "batman", page: 1))
        mockAPI.fetch(request: self.request) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNoThrow(try result?.get())
        
        
    }
    
    
    func test_Request_With_Body_Throws() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Throws")
        
        
        var r = self.request
        r.body = JSONBody(ThrowAbleBody())
        realAPI.fetch(request: r) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertThrowsError(try result?.get())
        
    }
    

    //MARK:- Real
    func test_Request_Fails_With_Invalid_URL() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Fails: Invalid URL")
        
        
        var r = self.request
        r.path = "this.will.fail.com"
        realAPI.fetch(request: r) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertThrowsError(try result?.get())
        
        
        
    }
    
    func test_Request_Success_With_Headers() {
        var result: OMDBResult?
        let expectation = self.expectation(description: "Success: with headers")
        
        
        
        var r = self.request
        //r.headers = ["Key": "Value"]
        
        realAPI.fetch(request: r) { (res) in
            result = res
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
         XCTAssertNoThrow(try result?.get())

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
    
   
    
    private var responseBody: Data {
        
        let json = """
                {
                "Search": [
                    {
                        "Title": "Bat in Black",
                        "Year": "2018",
                        "imdbID": "tt7656454",
                        "Type": "movie",
                        "Poster": "https://m.media-amazon.com/images/M/MV5BN2UzZDExZTEtM2IxZS00YmI3LThiNWQtN2Y5ZGZjNzI4ODBjXkEyXkFqcGdeQXVyNzM2NzgxOQ@@._V1_SX300.jpg"
                    },
                ],
                "totalResults": "183",
                "Response": "True"
            }
            """
        return Data(json.utf8)
    }
    
  

  
    
}


