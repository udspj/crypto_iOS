//
//  ShuihuCardDetailViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class ShuihuCardDetailViewController: UIViewController {
    var obj : [String:Any]?
    var status : [String:Any]?
    var heroId : String?
    
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = obj?["name"] as! String
        let nickname = obj?["nickname"] as! String
        title = "\(nickname):\(name)"
        
        leftImageView.image = UIImage(named: "shuihu/heros_new/\(heroId!)")
        rightImageView.image = UIImage(named: "shuihu/backs_new/\(heroId!)")
        
        let s = status!
        descLabel.text =
        "攻击力： \(s["attack"])\n攻击范围：\(s["range"])\n防御力：\(s["star"])\n星宿：\(s["attack"])\n职位：\(s["position"])\n武器：\(s["arms"]) \n必杀技：\(s["skills"]) 唯一编号：拥有者：是否兑奖：价格："
        
        
        
    }
}
