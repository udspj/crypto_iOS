
import UIKit

protocol IdolLinkMainHeaderDelegate : AnyObject {
    func OnTapDrawCard(_ header: IdolLinkMainHeader)
    func OnTapRank(_ header: IdolLinkMainHeader)
    func OnTapShare(_ header: IdolLinkMainHeader)
    func OnTapCollection(_ header: IdolLinkMainHeader)
}
class IdolLinkMainHeader: UICollectionReusableView {
    weak var delegate: IdolLinkMainHeaderDelegate?
    @IBOutlet var cardcount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tapDrawCard(_ sender: Any) {
        delegate?.OnTapDrawCard(self);
    }
    
    @IBAction func tapRank(_ sender: Any) {
        delegate?.OnTapRank(self);
    }
    
    @IBAction func tapShare(_ sender: Any) {
        delegate?.OnTapShare(self);
    }
    
    @IBAction func tapCollection(_ sender: Any) {
        delegate?.OnTapCollection(self);
    }
    
    
}
