
import UIKit

class SanguoStoreViewController: UIViewController {

    @IBOutlet var view1: UIView!
    
    @IBOutlet var sectionView1: UIView!
    @IBOutlet var sectionView2: UIView!
    @IBOutlet var sectionView3: UIView!
    
    @IBOutlet var kaipaiSource: SanguoStoreKapai!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for v in [sectionView1, sectionView2, sectionView3] {
            v!.layer.borderWidth = 1
            v!.layer.borderColor = UIColor.white.cgColor
        }
        
        changeToSection(idx: 0)
        
        kaipaiSource.viewDidLoad()
        
    }
    
    @IBAction func tapDrawCard(_ sender: Any) {
        
        let vc = SanguoDrawCardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func sectionChanged(_ sender: Any) {
        let seg = sender as! UISegmentedControl
        
        let idx = seg.selectedSegmentIndex
        changeToSection(idx: idx)
    }
    
    func changeToSection(idx:Int)  {
        sectionView1.isHidden = idx != 0
        sectionView2.isHidden = idx != 1
        sectionView3.isHidden = idx != 2
    }
}
