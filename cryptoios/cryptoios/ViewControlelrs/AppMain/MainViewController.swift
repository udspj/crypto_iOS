
import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: IBActions
    @IBAction func tapSanguo(_ sender: Any) {
        
        let vc = SanguoMainViewController();
        
        navigationController?.pushViewController(vc, animated: true);
        
    }
    @IBAction func tapIdol(_ sender: Any) {
        let vc = IdolLinkMainViewController();
        
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapShuihu(_ sender: Any) {
        let vc = ShuihuMainViewController();
        
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapMoe(_ sender: Any) {
        let vc = MoeMainViewController();
        
        navigationController?.pushViewController(vc, animated: true);
    }
    
    
    @IBAction func TapMe(_ sender: Any) {
        let vc = MeMainViewController();
        
        navigationController?.pushViewController(vc, animated: true);
        
    }
    

}
