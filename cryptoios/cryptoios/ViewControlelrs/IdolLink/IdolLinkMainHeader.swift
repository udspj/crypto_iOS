//
//  IdolLinkMainHeader.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/11/7.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

protocol IdolLinkMainHeaderDelegate : AnyObject {
    func OnTapDrawCard(_ header: IdolLinkMainHeader)
    func OnTapRank(_ header: IdolLinkMainHeader)
    func OnTapShare(_ header: IdolLinkMainHeader)
}
class IdolLinkMainHeader: UICollectionReusableView {
    weak var delegate: IdolLinkMainHeaderDelegate?
    
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
    
    
}
