import Foundation

public struct JSONBody: HTTPBody {
    public var isEmpty = false
    public var additionalHeaders = [
        "ContentType" : "application/json; charset=utf_8"
    ]
    private let encodeClosure: () throws -> Data
    
    public init<T: Encodable>(_ value: T, encoder: JSONEncoder = JSONEncoder()) {
        self.encodeClosure = { try encoder.encode(value) }
    }
    
    public func encode() throws -> Data { try self.encodeClosure() }
    
    
}
