//
//  IdolDetailViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class IdolDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cardObj : [String:Any]?
   
    let orderedKeys = ["creater","birthday","consensus", "maxprice","story"]
    let displayMap = [
        "creater" : "创造者",
        "birthday" : "诞生日",
        "consensus" : "共识算法",
        "maxprice" : "最高价格",
        "story" : "诞生经历",
    ]
   /*
     {
     "id": 0,
     "name": "质数币",
     "code": "XPM",
     "color": "#ebe5b0",
     "textcolor": "#b8a909",
     "img": "../../static/assets/girlcards/card_xpm.png",
     "idforapi": 42,
     "creater": "Sunny King",
     "birthday": "2013年07月12日",
     "consensus": "工作量证明 | Proof-of-Work（POW）",
     "maxprice": "7.27美元",
     "detailimg": "../../static/assets/girlcards/detail_xpm.jpg",
     "story": "质数币就是作为让计算机寻找新质数的奖励。”质数币“是第一个基于科学计算的加密货币。它的“工作量证明算法”是独一无二的，并且百分百保留“去中心化”的特性。质数币的出现意味着加密货币可以产生其他的科学计算价值，这是很大的突破。"
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableview = self.view as! UITableView;
        tableview.register(UINib(nibName: "IdolDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        let imgName = (cardObj?["img"] as! NSString).lastPathComponent;
        let detailImgName = (cardObj?["detailimg"] as! NSString).lastPathComponent;
        
        
        
        let header = UIImageView(image: UIImage(named: detailImgName))
        let displayWidth = self.view.bounds.width;
        let height = displayWidth / header.image!.size.width * header.image!.size.height;
        header.frame = CGRect(x:0.0,y:0.0, width: self.view.bounds.width, height:height);
        header.contentMode = UIView.ContentMode.scaleAspectFit;
        tableview.tableHeaderView = header
        
        let footer = UIImageView(image: UIImage(named: imgName))
        footer.contentMode = UIView.ContentMode.scaleAspectFit;
        footer.frame = CGRect(x:0.0,y:0.0, width: self.view.bounds.width, height:400.0);
        tableview.tableFooterView = footer
        
        
        
        
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IdolDetailTableViewCell
        
        let key = orderedKeys[indexPath.row]
        let text = cardObj?[key] as! String;
        
        cell.leftLabel?.text = displayMap[key];
        cell.rightLabel?.text = text;
        
        return cell
    }

}
