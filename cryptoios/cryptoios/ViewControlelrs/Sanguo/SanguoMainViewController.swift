
import UIKit

class SanguoMainViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "以太三国"
        
    }
    
    
    @IBAction func tapStore(_ sender: Any) {
        let vc = SanguoStoreViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    
    @IBAction func tapWiki(_ sender: Any) {
        let vc = SanguoWikiViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapDrawCard(_ sender: Any) {
        let vc = SanguoDrawCardViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapTrans(_ sender: Any) {
        let vc = TransactionViewController()
        navigationController?.pushViewController(vc, animated: true);
    }
}
