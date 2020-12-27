import Foundation
import UIKit



class OMDBDetailView: NiblessView {
    
    // MARK: - Properties
    private let viewModel: OMDBDetailViewModel
    private let imageCache:ImageCache =  KingFisherImageCache()
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    
    private let yearLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    private let typeLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    
    private let textBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    private let photoImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    
    
    // MARK: - Methods
    init(viewModel: OMDBDetailViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
        addViews()
        setupConstraints()
        render()

    }
    
    private func addViews() {
        self.backgroundColor = .black
        self.addSubview(self.photoImageView)
        self.photoImageView.addSubview(self.yearLabel)
        self.addSubview(self.textBackgroundView)
        self.textBackgroundView.addSubview(self.titleLabel)
        self.textBackgroundView.addSubview(self.typeLabel)
    }
    
    private func render() {
        
        if let url = URL(string:  self.viewModel.movie.poster) {
            imageCache.setImage(for: self.photoImageView, url: url)
        }
        titleLabel.text = self.viewModel.movie.title
        yearLabel.text = self.viewModel.movie.year
        typeLabel.text = self.viewModel.movie.type.rawValue.capitalized
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    

    private func setupConstraints() {
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
    
        textBackgroundView.leadingAnchor.constraint(equalTo: self.photoImageView.leadingAnchor, constant: 0).isActive = true
        textBackgroundView.trailingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: 0).isActive = true
        textBackgroundView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
        textBackgroundView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        textBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.textBackgroundView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.textBackgroundView.trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.textBackgroundView.topAnchor, constant: 16).isActive = true
        
        typeLabel.leadingAnchor.constraint(equalTo: self.textBackgroundView.leadingAnchor, constant: 16).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: self.textBackgroundView.trailingAnchor, constant: -16).isActive = true
        typeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        
       
               yearLabel.trailingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: -16).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: -16).isActive = true
        
    }
}






