
import UIKit

class MoeCardDetailViewController: UIViewController {
    var cardObj : [String:Any]?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cardId = cardObj?["id"] as! Int;
        
        let image = UIImage.init(named: "moe_cards/\(cardId)")
        cardImageView.image = image;
        
        let nickname = cardObj?["nickname"] as! String
        let name = cardObj?["name"] as! String
        nameLabel.text = "\(nickname)*\(name)"
        
        priceLabel.text = "0 ETH"
//        notifyButton.setTitle("", for: .normal)
        
        moePointLabel.text = cardObj?["moe_point"] as? String
        
        ownerLabel.text = ""
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
