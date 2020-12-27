import Foundation
import UIKit

final class PhotoCell : UITableViewCell {
    //MARK: - Properties
    static let id = "cell"
    

    private let imageCache:ImageCache = KingFisherImageCache()
    
    var movie : Movie? {
        didSet {
            if let url = URL(string: movie?.poster ?? "") {
                imageCache.setImage(for: self.photoImageView, url: url)
            }
            titleLabel.text = movie?.title
            
        }
    }
    
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    private let textBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
    
    //MARK: - Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(photoImageView)
        photoImageView.addSubview(textBackgroundView)
        textBackgroundView.addSubview(titleLabel)
        setupConstraints()
        isAccessibilityElement = true
        self.contentView.backgroundColor = .black
    }
    
    private func setupConstraints() {
        photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        
        textBackgroundView.leadingAnchor.constraint(equalTo: self.photoImageView.leadingAnchor, constant: 0).isActive = true
        textBackgroundView.trailingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: 0).isActive = true
        textBackgroundView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textBackgroundView.bottomAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: 0).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.textBackgroundView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.textBackgroundView.trailingAnchor, constant: -16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.textBackgroundView.centerYAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.textBackgroundView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

