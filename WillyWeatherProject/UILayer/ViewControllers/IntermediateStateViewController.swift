import Foundation
import UIKit

class IntermediateViewController: NiblessViewController {
    
    private var rootView: IntermediateStateView
    
    var message: String {
        didSet {
            self.rootView.message = message
        }
    }
    
    init(message:String) {
        self.message = message
        self.rootView = IntermediateStateView(message: message, frame: .zero)
        super.init()
    }
    
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

