import Foundation


protocol OMDBPaginatorDelegate:class {
    func didThrowError(error: RemoteAPIError)
    func didFinishFetching(result: [Movie],indexPaths:[IndexPath])
}

class OMDBPaginator: Paginator {
  
    //MARK:- Private Properties
    var totalItems: Int = 0
    var isLoading: Bool = false
    let searchTerm: String = "batman"
    var page: Int = 1
    let repository: OMDBFetchMoviesUseCase
    var dataSource: [Movie] = []
    var request: HTTPRequest {
         var r = HTTPRequest()
        r.setQueryParams(params: OMDBRequest(text: self.searchTerm, page: self.page))
        return r
    }
    
    //MARK:- Public Property
    weak var delegate: OMDBPaginatorDelegate?
    
    
    //MARK:- Methods
    init(repository:OMDBFetchMoviesUseCase) {
        self.repository = repository
    }
    
    func fetchData() {
        if !self.isLoading && self.shouldPaginate {
            self.isLoading = true
            repository.fetch(request: self.request) { [weak self] (result) in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let entity):
                    self.page += 1
                    self.totalItems = entity.totalCount
                    let startindex = self.dataSource.count
                    self.dataSource = self.dataSource + entity.results
                    let endIndex = self.dataSource.count
                    let indexPaths = (startindex..<endIndex).map{ IndexPath(row: $0, section: 0) }
                    self.delegate?.didFinishFetching(result: self.dataSource, indexPaths: indexPaths)
                    
                case .failure(let error):
                    self.handleError(error)
                    
                }
            }
        }
        
    }
    
  
   
    private func handleError(_ error: RemoteAPIError) {
        self.delegate?.didThrowError(error: error)
    }
}
