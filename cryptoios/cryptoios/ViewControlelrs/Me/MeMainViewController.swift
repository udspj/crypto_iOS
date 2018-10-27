//
//  MeMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class MeMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func tapTrans(_ sender: Any) {
        let vc = TransactionViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapAsset(_ sender: Any) {
        let vc = AssetsViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
}
