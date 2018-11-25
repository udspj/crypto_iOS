//
//  IdolLinkMainViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class IdolLinkMainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, IdolLinkMainHeaderDelegate
{
    @IBOutlet var collectionView: UICollectionView!
    let cellIdentifier = "IdolCell"
    let headerIdentifier = "headerView"
    var cards : [String:Any]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "链接偶像"
        
        self.collectionView.register(UINib(nibName:"IdolLinkCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.register(UINib(nibName: "IdolLinkMainHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        
        let asset = NSDataAsset(name:"girl_cards",bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        cards = json as? [String:Any]
        
    }

    func OnTapDrawCard(_ header: IdolLinkMainHeader) {
        let vc = IdolDrawCardViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func OnTapRank(_ header: IdolLinkMainHeader) {
        let vc = IdolRankViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func OnTapShare(_ header: IdolLinkMainHeader) {
        let vc = IdolShareViewController();
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards!.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IdolLinkCell
        let obj = self.cards[String(indexPath.item)] as! [String:Any]
        
        let img = (obj["img"] as! NSString).lastPathComponent
        let imgPath = "girdcards/\(img)"
        let image = UIImage.init(named: imgPath)
        cell.cardImageView.image = image;
        
        cell.titleLabel.text = obj["name"] as? String
        
        let color = hexStringToUIColor (hex: obj["color"] as! String)
        let textcolor = hexStringToUIColor (hex: obj["textcolor"] as! String)
        
        cell.titleLabel.backgroundColor = color;
        cell.titleLabel.textColor = textcolor;
        
        

        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! IdolLinkMainHeader
        view.delegate = self;
        return view;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.cards[String(indexPath.item)] as! [String:Any]
        
        let vc = IdolDetailViewController();
        vc.cardObj = obj
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
