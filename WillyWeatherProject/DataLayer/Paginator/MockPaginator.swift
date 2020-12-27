import Foundation

class MockPaginator: Paginator {
  
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
                    self.dataSource = self.dataSource + entity.results
                    
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
        
    }
    
  
   
}
