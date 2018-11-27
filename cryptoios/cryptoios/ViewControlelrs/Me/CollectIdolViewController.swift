
import UIKit

class CollectIdolViewController: UIViewController {
    
    var linkidol:Linkidol = Linkidol()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "链接偶像"
        let mycards = linkidol.getMyCards()
        print(mycards)
    }
    
}
