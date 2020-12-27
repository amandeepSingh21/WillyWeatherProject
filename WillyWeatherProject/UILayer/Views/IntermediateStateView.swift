import Foundation
import UIKit

class IntermediateStateView: UIView {
    
    // MARK: - Properties
    var message: String {
        didSet {
            self.messageLabel.text = message
        }
    }
    
    private let messageLabel : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .black
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.font = UIFont.boldSystemFont(ofSize: 16)
           lbl.textAlignment = .center
           return lbl
       }()
    
    // MARK: - Methods
    init(message: String, frame: CGRect = .zero) {
        self.message = message
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(messageLabel)
        
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

