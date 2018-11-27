
import UIKit

class IdolShareViewController: UIViewController {
    
    @IBOutlet var refLinkField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "推荐好友"
        refLinkField.text = "http://stackoverflow.com";
    }
    
    @IBAction func tapShare(_ sender: Any) {
        
        if let linkToShare = URL(string: refLinkField.text!) {
            let objs = [linkToShare] as [Any]
            let avc = UIActivityViewController(activityItems: objs, applicationActivities: nil)
            self.present(avc, animated: true, completion: nil)
        }
    }
    
}
