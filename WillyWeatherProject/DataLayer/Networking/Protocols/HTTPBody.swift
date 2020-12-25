import Foundation

public protocol HTTPBody {
    func encode() throws -> Data
    var isEmpty: Bool { get }
    var additionalHeaders: [String: String] { get }
}

extension HTTPBody {
    public var isEmpty: Bool { false }
    public var additionalHeaders: [String:String] { [:] }

}
