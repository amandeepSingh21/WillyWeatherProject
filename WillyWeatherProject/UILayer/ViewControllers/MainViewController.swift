import UIKit


final class MainViewController: NiblessViewController {
    
    //MARK: - Child View Controller
    let intermediateViewController: IntermediateViewController
    
    //MARK: - Properties
    var rootView: OMDBView
    let viewModel: OMDBViewModel
    
    //MARK: - Methods
    init(viewModel:OMDBViewModel) {
        self.viewModel = viewModel
        self.intermediateViewController = IntermediateViewController(message: viewModel.viewState.value.message)
        
        rootView = OMDBView(viewModel: viewModel, frame: .zero)
        super.init()
        rootView.delegate = self
        
        
        
    }
    
    
    override func loadView() {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OMDB"
        viewModel.fetch()
        setUpBindings()
      
        
    }
    
 
    private func setUpBindings() {
        self.viewModel.viewState.bind { [weak self] state in
            guard let self = self else { return }
            self.intermediateViewController.message = state.message
            switch state {
            case .loading,.noResultsFound:
                self.addFullScreen(childViewController: self.intermediateViewController)
            case .error(let error):
                self.remove(childViewController: self.intermediateViewController)
                self.present(errorMessage: error.message)
            case .loaded:
                self.remove(childViewController: self.intermediateViewController)
                
            }
        }
        
    }
    
    
}

extension MainViewController: OMDBViewViewSelectionDelegate {
    func didSelectItem(item: Movie) {
        let vc = DetailViewController(viewModel: OMDBDetailViewModel(movie: item))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
