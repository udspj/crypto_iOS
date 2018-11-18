//
//  SanguoWikiViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class SanguoWikiViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    var heros : [String:Any]?
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "武将百科"
        let asset = NSDataAsset(name:"sanguo/new_heroes",bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        heros = json as? [String:Any]
        
        collectionView.register(UINib(nibName: "SanguoWikiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SanguoWikiCollectionViewCell
        let hero = heros?[String(indexPath.item+1)] as! [String:Any]
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.white : UIColor.lightGray
        cell.titleLabel.text = hero["姓名"] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heros?[String(indexPath.item+1)] as! [String:Any]
        
        let vc = SanguoHeroDetailViewController()
        vc.hero = hero
        navigationController?.pushViewController(vc, animated: true)
    }
}
