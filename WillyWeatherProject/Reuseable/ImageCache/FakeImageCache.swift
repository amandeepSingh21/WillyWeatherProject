import Foundation
import UIKit

class FakeImageCache: ImageCache {
    
    func setImage(for imageView: UIImageView,url:URL) {
        imageView.image =  UIImage(named: "placeholder")

    }
    
}

