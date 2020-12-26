import Foundation

struct OMDBModel: Codable {
    var results: [Movie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case response = "Response"
    }
    var totalCount: Int{
        return Int(totalResults) ?? 0
    }

}

struct Movie: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    var posterURL:URL? {
        return URL(string: poster)
    }

}

enum TypeEnum: String, Codable {
    case game = "game"
    case movie = "movie"
    case series = "series"


}

