//
//  IdolDrawCardViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class IdolDrawCardViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    
    @IBOutlet var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "幸运抽卡"
        let num = 2099999;
        let price = 0.009
        label1.text = "目前卡池可抽数量：\(num)张，卡牌限量，先到先的"
        label2.text = "目前抽卡费：\n\(price) NAS/张"
    }
}
