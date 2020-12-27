import Foundation
import UIKit
import Kingfisher

class KingFisherImageCache: ImageCache {
    
    func setImage(for imageView: UIImageView,url:URL) {
       
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
             
            }
        }
        
    }
    
    
}

