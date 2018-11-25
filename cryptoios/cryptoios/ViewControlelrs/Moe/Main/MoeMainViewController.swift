//
//  MoeMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class MoeMainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    let cellIdentifier = "Cell"
    let headerIdentifier = "headerView"
    var cards : [String:Any]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "以太萌王"
        let collectionView = view as! UICollectionView
        
        collectionView.register(UINib(nibName:"MoeCardCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UINib(nibName: "IdolLinkMainHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        let asset = NSDataAsset(name:"cards",bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        cards = json as? [String:Any]
    }

    @IBAction func tapCard(_ sender: Any) {
        
        let vc = MoeCardDetailViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards!.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoeCardCell
        let obj = self.cards[String(indexPath.item+1)] as! [String:Any]
        
        let image = UIImage.init(named: "moe_cards/\(indexPath.item+1)")
        cell.cardImageView.image = image;
        
        let nickname = obj["nickname"] as! String
        let name = obj["name"] as! String
        cell.titleLabel.text = "\(nickname)|\(name)"
        cell.descLabel.text = obj["introduce"] as?String
        let ownerAddr = "FDAC"
        cell.ownerLabel.text = "拥有者：\(ownerAddr)"
        
        do { // shadow
            cell.contentView.layer.cornerRadius = 2.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true;
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false;
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        }
        return cell;
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! IdolLinkMainHeader
//        view.delegate = self;
//        return view;
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.cards[String(indexPath.item+1)] as! [String:Any]
        
        let vc = MoeCardDetailViewController();
        
        vc.cardObj = obj
        navigationController?.pushViewController(vc, animated: true);
    }
}
