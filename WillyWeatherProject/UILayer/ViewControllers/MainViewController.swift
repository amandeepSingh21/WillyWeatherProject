import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let api = OMDBFetchMoviesAPI()
        var r = HTTPRequest()
        
        r.setQueryParams(params: OMDBRequest(text: "batman", page: 1))
        api.fetch(request: r) { (res) in
            
        }
       
    }


}

