
import UIKit

class MoeMainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let cellIdentifier = "Cell"
    let headerIdentifier = "headerView"
    var cards : [String:Any]!;
    
    var moe:Moeking = Moeking()
    var moelist:[(owner: String, nowprice: Double, nextprice: Double, freedate: String)] = []
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "以太萌王"
        
        let collectionView = view as! UICollectionView
        
        collectionView.register(UINib(nibName:"MoeCardCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UINib(nibName: "MoeMainHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        let asset = NSDataAsset(name:"cards",bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        cards = json as? [String:Any]
        
        
        var cardlimit = 0
        var itemids:[Int] = []
        
        let queue = OperationQueue()
        let operationA = BlockOperation {[weak self] () -> Void in
            cardlimit = self?.moe.getTotalSupply() ?? 0
        }
        let operationB = BlockOperation {[weak self] () -> Void in
            itemids = self?.moe.getItemIds(limit: cardlimit) ?? []
        }
        let operationC = BlockOperation {[weak self] () -> Void in
            let types = itemids.map { token -> (owner: String, nowprice: Double, nextprice: Double, freedate: String) in
                let type = self?.moe.getItemInfo(itemid: token)
                return type ?? ("",0.0,0.0,"")
            }
            print(types)
            self?.moelist = types
            OperationQueue.main.addOperation({ () -> Void in
                collectionView.reloadData()
            })
        }
        operationB.addDependency(operationA)
        operationC.addDependency(operationB)
        queue.addOperation(operationA)
        queue.addOperation(operationB)
        queue.addOperation(operationC)
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
        var ownerAddr = "=="
        var priceETH = "=="
        if(moelist.count > 0){
            ownerAddr = moelist[indexPath.item].0
            priceETH = String(format:"%.5f", moelist[indexPath.item].1)
        }
        cell.ownerLabel.text = "拥有者：\(ownerAddr)"
        cell.priceLabel.text = "\(priceETH)eth"
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! MoeMainHeadView
//        view.delegate = self;
        return view;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.cards[String(indexPath.item+1)] as! [String:Any]
        
        let vc = MoeCardDetailViewController();
        
        vc.cardObj = obj
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let pad = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
        
        let ratio : CGFloat = 190.0 / 420.0
        let width = (viewSize.width - pad - flowLayout.minimumInteritemSpacing)/2;
        let height = width / ratio
        
        return CGSize(width: width, height: height)
    }
}
