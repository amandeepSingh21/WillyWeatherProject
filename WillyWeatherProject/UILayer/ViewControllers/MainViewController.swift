import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let api = FlickrPhotosSearchAPI()
        var r = HTTPRequest()
        r.path = "/services/rest/"
        r.setQueryParams(params: FlickrRequest(text: "bat", page: 1))
        api.query(request: r ) { (res) in
            
        }
    }


}

