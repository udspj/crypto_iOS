//
//  IdolLinkMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class IdolLinkMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "链接偶像"

    }

    @IBAction func tapDrawCard(_ sender: Any) {
        let vc = IdolDrawCardViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapRank(_ sender: Any) {
        let vc = IdolRankViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapShare(_ sender: Any) {
        let vc = IdolShareViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapCard(_ sender: Any) {
        let vc = IdolDetailViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
}
