
import UIKit

class ShuihuCardDetailViewController: UIViewController {
    var obj : [String:Any]?
    var status : [String:Any]?
    var heroId : String?
    
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    
    @IBOutlet var attackBar: UILabel!
    @IBOutlet var attBarLayout: NSLayoutConstraint!
    @IBOutlet var attackNumLabel: UILabel!
    
    @IBOutlet var attRangeBar: UILabel!
    @IBOutlet var attRangeNumLabel: UILabel!
    @IBOutlet var attRangeWidth: NSLayoutConstraint!
    
    @IBOutlet var defBar: UILabel!
    @IBOutlet var defBarWidth: NSLayoutConstraint!
    @IBOutlet var defNumLabel: UILabel!
    
    @IBOutlet var xingxiuLabel: UILabel!
    @IBOutlet var zhiweiLabel: UILabel!
    @IBOutlet var waponLabel: UILabel!
    
    @IBOutlet var killSkillLabel: UILabel!
    
    @IBOutlet var idLabel: UILabel!
    
    @IBOutlet var ownerLabel: UILabel!
    
    @IBOutlet var duijiangLabel: UILabel!
    @IBOutlet var priceField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = obj?["name"] as! String
        let nickname = obj?["nickname"] as! String
        title = "\(nickname):\(name)"
        
        leftImageView.image = UIImage(named: "shuihu/heros_new/\(heroId!)")
        rightImageView.image = UIImage(named: "shuihu/backs_new/\(heroId!)")
        
        let s = status!
        
        let att = s["attack"] as! Int
        let range = s["range"] as! Int
        let defence = s["defence"] as! Int
        
        attackNumLabel.text = String(att)
        attBarLayout.constant = CGFloat(att)
        
        attRangeNumLabel.text = String(range)
        attRangeWidth.constant = CGFloat(range)
        
        defBarWidth.constant = CGFloat(defence)
        defNumLabel.text = String(defence)
        
        xingxiuLabel.text = s["star"] as? String
        zhiweiLabel.text = s["position"] as? String
        
        let arms = s["arms"] as? [String]
        waponLabel.text = arms?.joined(separator: ",")
        
        let skills = s["skills"] as? [String]
        killSkillLabel.text = skills?.joined(separator: ",")
        
        idLabel.text = heroId
        ownerLabel.text = ""
        duijiangLabel.text = "否"
        priceField.text = "100"
    }
    
    @IBAction func tapBuy(_ sender: Any) {
    }
}
