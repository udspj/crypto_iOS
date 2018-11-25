//
//  SanguoWikiViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class SanguoWikiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var heros : [String:Any]?
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "武将百科"
        let asset = NSDataAsset(name:"sanguo/new_heroes",bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        heros = json as? [String:Any]
        
        tableView.register(UINib(nibName: "SanguoWikiTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SanguoWikiTableViewCell
        let hero = heros?[String(indexPath.row+1)] as! [String:Any]
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.white : UIColor.lightGray
        cell.titleLabel.text = hero["姓名"] as? String
        
        cell.sumLabel.text = String(hero["综合"] as! Int)
        cell.powLabel.text = String(hero["武力"] as! Int)
        cell.intLabel.text = String(hero["智力"] as! Int)
        cell.polLabel.text = String(hero["政治"] as! Int)
        cell.chrLabel.text = String(hero["魅力"] as! Int)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = heros?[String(indexPath.row+1)] as! [String:Any]
        
        let vc = SanguoHeroDetailViewController()
        vc.hero = hero
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
