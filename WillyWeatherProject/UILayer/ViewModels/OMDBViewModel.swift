import Foundation

class OMDBViewModel {
    //MARK:- Properties
     //MARK: Controller bindings
    var viewState: Bindable<ViewState> =  Bindable(ViewState.loading)
   
    
    //MARK: View bindings
    var indexPathsToReload: Bindable<[IndexPath]> = Bindable([IndexPath(item: 0, section: 0)])
    var paginator: OMDBPaginator?
     var entity: [Movie] = [Movie]()
    private let repository: OMDBFetchMoviesUseCase
   
    
    //MARK:- Methods
    init(repository: OMDBFetchMoviesUseCase) {
        self.repository = repository
    }
    
    
    //MARK: Search
    func fetch() {
        self.paginator =  OMDBPaginator(repository: self.repository)
        self.paginator?.delegate = self
        self.viewState.value = .loading
        self.paginator?.fetchData()
    }
    
    //MARK: Paginate
    func queryMore() {
        self.paginator?.fetchData()
    }
    
    //MARK: TableView RefreshControl
    func refresh() {
        self.paginator?.dataSource.removeAll()
        self.paginator?.page = 1
        self.paginator?.fetchData()
    }
    
    
}

//MARK:- Delegate
extension OMDBViewModel: OMDBPaginatorDelegate {
    func didFinishFetching(result: [Movie], indexPaths: [IndexPath]) {
        entity = result
        self.indexPathsToReload.value = indexPaths
        
        if result.isEmpty {
            self.viewState.value = .noResultsFound
        } else {
            self.viewState.value = .loaded
        }
        
    }
    
   
    func didThrowError(error: RemoteAPIError) {
        self.viewState.value = .error(error: error)
    }
}
