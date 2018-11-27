
import UIKit

class ShuihuWikiViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    var cards : [String:Any]!;
    
    var cardsAll : [String]!;
    var cardsHave : [String]!;
    var cardsNoHave : [String]!;
    
    var heroStatus : [String:Any]!;
    
    var segIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "图鉴"

        self.collectionView.register(UINib(nibName: "TujianCell", bundle: nil), forCellWithReuseIdentifier:"Cell")
        
        
        cards = loadData(name: "shuihu/cards")
        cardsAll = Array(cards.keys).sorted()
        cardsNoHave = cardsAll
        
        cardsHave = [cardsNoHave![0]]
        cardsNoHave.remove(at: 0)
        
        heroStatus = loadData(name: "shuihu/herostatu")
    }
    
    func loadData(name:String) -> [String:Any]? {
        
        let asset = NSDataAsset(name:name,bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        return json as? [String:Any]
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        let seg = sender as! UISegmentedControl
        segIdx = seg.selectedSegmentIndex
        
        self.collectionView.reloadData()
    }
    
    func selectedData() -> [String]!{
        switch segIdx {
        case 0:
            return self.cardsAll
        case 1:
            return self.cardsHave
        case 2:
            return self.cardsNoHave
            
        default:
            return self.cardsAll
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedData()!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TujianCell
        let heroId = selectedData()![indexPath.item]
        
        let obj = self.cards[heroId] as! [String:Any]
        let name = obj["name"] as! String
        let nickname = obj["nickname"] as! String
        cell.titleLabel.text = "\(nickname):\(name)"
        cell.imageView.image = UIImage(named: "shuihu/heros_new/\(heroId)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let heroId = selectedData()![indexPath.item]
        let obj = self.cards[heroId] as! [String:Any]
        let status = self.heroStatus[heroId] as! [String:Any]
        
        let vc = ShuihuCardDetailViewController()
        vc.obj = obj
        vc.status = status
        vc.heroId = String(indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let pad = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
        
        let ratio : CGFloat = 160.0 / 260.0
        let width = (viewSize.width - pad - flowLayout.minimumInteritemSpacing)/2;
        let height = width / ratio
        
        return CGSize(width: width, height: height)
    }
}
