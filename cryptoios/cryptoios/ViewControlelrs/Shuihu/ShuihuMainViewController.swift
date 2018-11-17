//
//  ShuihuMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class ShuihuMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tapWiki(_ sender: Any) {
        let vc = ShuihuWikiViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapDrawCard(_ sender: Any) {
//        let vc = ShuihuDrawCardViewController();
        let vc = IdolDrawCardViewController()
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapTrans(_ sender: Any) {
        let vc = ShuihuTransViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapShare(_ sender: Any) {
        let vc = ShuihuShareViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func tapRank(_ sender: Any) {
        let vc = ShuihuRankViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
}
