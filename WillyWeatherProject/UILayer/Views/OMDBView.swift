import Foundation
import UIKit


protocol OMDBViewViewSelectionDelegate: class {
    func didSelectItem(item: Movie)
}

class OMDBView: NiblessView {
    
    // MARK: - Properties
    private let viewModel: OMDBViewModel
    private let refreshControl = UIRefreshControl()
    weak var delegate: OMDBViewViewSelectionDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.id)
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        return tableView
    }()
    
    // MARK: - Methods
    init(viewModel: OMDBViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        addRefreshControl()
        
        viewModel.indexPathsToReload.bind(listener: { [weak self] (indexPaths) in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            //let visibleRow = self.tableView.visibleIndexPathsToReload(intersecting: indexPaths) ?? [IndexPath]()
            if self.viewModel.paginator?.page ?? 0 < 3 {
                self.tableView.reloadData()
            } else {
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        })
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    //MARK:- Private Methods
    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc private func refreshData(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        self.viewModel.refresh()
        
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return (indexPath.row >= viewModel.entity.count-1) && (viewModel.paginator?.shouldPaginate ?? false)
    }
}

//MARK: - Datasource
extension OMDBView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.entity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.id) as! PhotoCell
        cell.movie = viewModel.entity[indexPath.row]
        return cell
        
    }
    
}
//MARK:- Delegate
extension OMDBView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(item: self.viewModel.entity[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadingCell(for: indexPath) {
            let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            self.viewModel.queryMore()
        } else {
            self.tableView.tableFooterView?.isHidden = true
        }
        
    }
    
    
    
    
}

