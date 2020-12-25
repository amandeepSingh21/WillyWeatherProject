import Foundation


struct FlickrRequest: Encodable {
    //MARK:- Properties
    private let method: String
    private let apiKey: String
    private let format: String
    private let noJSONCallback:String
    private let text: String
    private let perPage:String
    private let page: String
    
    //MARK:- Keys
    enum CodingKeys: String, CodingKey {
        case method = "method"
        case apiKey = "api_key"
        case format = "format"
        case noJSONCallback = "nojsoncallback"
        case text = "text"
        case page = "page"
        case perPage = "per_page"
    }
    
    //MARK:- Init
    init(method:String = "flickr.photos.search",
         apiKey:String = APIConfiguration.apiKey,
         format:String = "json",
         noJSONCallback:String = "1",
         text:String,
         page: Int,
         perPage:Int = APIConfiguration.perPage
         ) {
        self.method = method
        self.apiKey = apiKey
        self.format = format
        self.noJSONCallback = noJSONCallback
        self.text = text
        self.perPage = String(perPage)
        self.page = String(page)
    }
    
}

