//
//  IdolLinkCell.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/30.
//  Copyright © 2018 udspj. All rights reserved.
//

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
