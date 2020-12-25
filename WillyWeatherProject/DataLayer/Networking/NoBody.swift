import Foundation

public struct NoBody: HTTPBody {
    public var isEmpty = true
    public func encode() throws -> Data { Data() }
}

