//
//  IdolDetailTableViewCell.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/11/7.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class IdolDetailTableViewCell: UITableViewCell {

    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        leftLabel.layer.cornerRadius = 5;
        leftLabel.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
