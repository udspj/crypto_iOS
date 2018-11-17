//
//  ShuihuWikiViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class ShuihuWikiViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    var cards : [String:Any]!;
    var heroStatus : [String:Any]!;

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "TujianCell", bundle: nil), forCellWithReuseIdentifier:"Cell")
        
        
        cards = loadData(name: "shuihu/cards")
        heroStatus = loadData(name: "shuihu/herostatu")
    }
    
    func loadData(name:String) -> [String:Any]? {
        
        let asset = NSDataAsset(name:name,bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        return json as? [String:Any]
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TujianCell
        
        let heroId = String(indexPath.item)
        let obj = self.cards[heroId] as! [String:Any]
        let name = obj["name"] as! String
        let nickname = obj["nickname"] as! String
        cell.titleLabel.text = "\(nickname):\(name)"
        cell.imageView.image = UIImage(named: "shuihu/heros_new/\(heroId)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroId = String(indexPath.item)
        let obj = self.cards[heroId] as! [String:Any]
        let status = self.heroStatus[heroId] as! [String:Any]
        
        let vc = ShuihuCardDetailViewController()
        vc.obj = obj
        vc.status = status
        vc.heroId = String(indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
