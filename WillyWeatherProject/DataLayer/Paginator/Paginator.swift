import Foundation

protocol Paginator {
    associatedtype PaginatedItem
    associatedtype Request
    var dataSource: [PaginatedItem] { get set }
    var page: Int { get set }
    var totalItems: Int { get set }
    var isLoading: Bool { get set }
    var request: Request { get }
    func fetchData()
    
}

extension Paginator {
    var shouldPaginate:Bool {
        return self.dataSource.count <= self.totalItems
    }
}
