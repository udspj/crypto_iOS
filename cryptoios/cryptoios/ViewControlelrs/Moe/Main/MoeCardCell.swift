
import UIKit

class MoeCardCell: UICollectionViewCell {
    
    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                
        self.layer.cornerRadius = 5
    }
    
    

}
