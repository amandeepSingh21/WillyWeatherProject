import Foundation

import UIKit


class DetailViewController: NiblessViewController {
    
    //MARK: - Properties
    var rootView: OMDBDetailView
    let viewModel: OMDBDetailViewModel
    
    //MARK: - Methods
    init(viewModel:OMDBDetailViewModel) {
        self.viewModel = viewModel
        rootView = OMDBDetailView(viewModel: viewModel, frame: .zero)
        super.init()
    }
    
    
    override func loadView() {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        
    }
    
}

