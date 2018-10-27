//
//  SanguoMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class SanguoMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "以太三国"
    }
    
    
    @IBAction func tapStore(_ sender: Any) {
        let vc = SanguoStoreViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    
    @IBAction func tapWiki(_ sender: Any) {
        let vc = SanguoWikiViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapDrawCard(_ sender: Any) {
        let vc = SanguoDrawCardViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapTrans(_ sender: Any) {
        let vc = SanguoTransViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
}
