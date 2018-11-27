
import UIKit

class SanguoWikiTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var powLabel: UILabel!
    @IBOutlet var intLabel: UILabel!
    @IBOutlet var polLabel: UILabel!
    @IBOutlet var chrLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
