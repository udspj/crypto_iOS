
import UIKit

class SanguoStoreKapai: NSObject,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var heros : [String:Any]?
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override init() {
        super.init()
        
        loadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadData()
    }
    
    func viewDidLoad()  {
        
        collectionView.register(UINib(nibName: "SanguoStoreKapaiCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }
    
    func loadData() {
        if heros == nil {
            let asset = NSDataAsset(name:"sanguo/new_heroes",bundle:Bundle.main);
            let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
            heros = json as? [String:Any]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SanguoStoreKapaiCell
        let hero = heros?[String(indexPath.row+1)] as! [String:Any]
        
        cell.nameLabel.text = hero["姓名"] as? String
        let image_name = hero["image_name"] as! String
        cell.imageView.image = UIImage(named: "sanguo/heroes/\(image_name)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = collectionView.bounds.size
        let pad = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
        
        let ratio : CGFloat = 195.0 / 270.0
        let width = (viewSize.width - pad - flowLayout.minimumInteritemSpacing)/2;
        let height = width / ratio
        
        return CGSize(width: width, height: height)
    }
    

}
