
import Foundation
@testable import WillyWeatherProject

struct MockData {
    static var responseBody: Data {
        
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
    
    static var getEmpty: OMDBModel {
        return  OMDBModel(results: [], totalResults: "0", response: "True")
    }
    
    static var getNonEmpty: OMDBModel {
        return  OMDBModel(results: [Movie(title: "Cool", year: "2018", imdbID: "123", type: .game, poster: "dummy_data")], totalResults: "1", response: "True")
        
    }

    
}
