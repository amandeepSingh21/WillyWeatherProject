import Foundation


struct OMDBRequest: Encodable {
    //MARK:- Properties
    
    private let apiKey: String
    private let text: String
    private let page: String
    
    //MARK:- Keys
    enum CodingKeys: String, CodingKey {
        case apiKey = "apikey"
        case text = "s"
        case page = "page"
    }
    
    //MARK:- Init
    init(apiKey:String = APIConfiguration.apiKey,
         text:String,
         page: Int) {
        self.apiKey = apiKey
        self.text = text
        self.page = String(page)
    }
    
}
