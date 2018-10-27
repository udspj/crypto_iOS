//
//  MoeMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class MoeMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "以太萌王"

    }

    @IBAction func tapCard(_ sender: Any) {
        let vc = MoeCardDetailViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
}
