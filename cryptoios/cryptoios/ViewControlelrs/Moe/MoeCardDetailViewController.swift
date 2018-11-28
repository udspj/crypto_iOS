
import UIKit

class MoeCardDetailViewController: UIViewController {
    var cardObj : [String:Any]?
    var cardid:Int = 1
    
    @IBOutlet var cardImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var notifyButton: UIButton!
    
    @IBOutlet var moePointLabel: UILabel!
    
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var birthPlaceLabel: UILabel!
    @IBOutlet var cpLabel: UILabel!
    @IBOutlet var eyeColorLabel: UILabel!
    @IBOutlet var hairColorLabel: UILabel!
    @IBOutlet var HeightLabel: UILabel!
    @IBOutlet var WeightLabel: UILabel!
    @IBOutlet var SloganLabel: UILabel!
    
    @IBOutlet var buyButtons: [UIButton]!
    
    var moe:Moeking = Moeking()
    
    var moeinfo:(owner: String, nowprice: Double, nextprice: Double, freedate: String) = ("",0.0,0.0,"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardid = cardObj?["id"] as! Int
        
        setupUI()
        
        let queue = OperationQueue()
        queue.addOperation {[unowned self] () -> Void in
            self.moeinfo = self.moe.getItemInfo(itemid: self.cardid)
            OperationQueue.main.addOperation({[unowned self] () -> Void in
                self.updateUI()
            })
        }
        
    }
    
    func updateUI() {
        priceLabel.text = "\(String(format:"%.8f", moeinfo.1)) ETH"
        notifyButton.setTitle("\(moeinfo.3)后，卡的拥有者可以修改此卡价格", for: .normal)
        ownerLabel.text = moeinfo.0
    }
    
    func setupUI() {
        let image = UIImage.init(named: "moe_cards/\(cardid)")
        cardImageView.image = image;
        
        let nickname = cardObj?["nickname"] as! String
        let name = cardObj?["name"] as! String
        nameLabel.text = "\(nickname)*\(name)"
        
        priceLabel.text = "0 ETH"
        moePointLabel.text = cardObj?["moe_point"] as? String
        
        birthPlaceLabel.text = cardObj?["birth_place"] as? String
        cpLabel.text = cardObj?["cp"] as? String
        eyeColorLabel.text = cardObj?["eye_color"] as? String
        hairColorLabel.text = cardObj?["hair_color"] as? String
        HeightLabel.text = cardObj?["height"] as? String
        WeightLabel.text = cardObj?["weight"] as? String
        SloganLabel.text = ""
        
        //        cardObj?["historical_prototype"] as! String
        //        cardObj?["idol_point"] as! String
        //        cardObj?["introduce"] as! String
        //        cardObj?["role_base"] as! String
        //        cardObj?["Neta"] as! String
        
        for b in buyButtons {
            b.layer.borderWidth = 1
            b.layer.borderColor = b.tintColor?.cgColor
            b.layer.cornerRadius = 5
            b.layer.masksToBounds = true
            
        }
    }

}
