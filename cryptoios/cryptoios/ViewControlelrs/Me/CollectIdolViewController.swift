//
//  CollectIdolViewController.swift
//  cryptoios
//
//  Created by sunpeijia on 2018/11/27.
//  Copyright © 2018年 udspj. All rights reserved.
//
import UIKit

class CollectIdolViewController: UIViewController {
    
    var linkidol:Linkidol = Linkidol()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "链接偶像"
        let mycards = linkidol.getMyCards()
        print(mycards)
    }
    
}
