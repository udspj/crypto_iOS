import UIKit

class AssetDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var product:Products?
    
    var source: Linkidol?
    var myCards : [Int]?
    var cardsDb : [String:Any]?
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var collectionView: UICollectionView!
    var spinner: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的资产";
        
        self.collectionView.register(UINib(nibName:NibName(), bundle: nil), forCellWithReuseIdentifier: CellIdentifier())
        
        flowLayout.itemSize = CGSize(width: 192, height: 192)
        
        spinner = UIViewController.displaySpinner(onView: self.view)
        
        switch product! {
        case .IdolLink:
            LoadLinkIdol()

        default:
            break

        }
        
    }
    
    
    func LoadLinkIdol() {
        
        flowLayout.itemSize = CGSize(width: 192, height: 200)
        
        let asset = NSDataAsset(name:"girl_cards",bundle:Bundle.main);
        let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
        cardsDb = json as? [String:Any]
        
        source = Linkidol()
        
        DispatchQueue.global().async {
            self.myCards = self.source?.getMyCards()
            
            DispatchQueue.main.async {
                if self.spinner != nil {
                    UIViewController.removeSpinner(spinner: self.spinner!)
                }
                
                self.collectionView.reloadData()
            }
            
        }
    }
    
    func NibName() -> String {
//        return "AssetCell"

        switch product! {
        case .Shuihu: return "TujianCell"
        case .Sanguo: return "SanguoStoreKapaiCell"
        case .Moe: return "MoeCardCell"
        case .IdolLink: return "IdolLinkCell"
        }
    }
    
    func CellIdentifier() -> String {
        switch product! {
        case .Shuihu: return "Cell"
        case .Sanguo: return "Cell"
        case .Moe: return "Cell"
        case .IdolLink: return "IdolCell"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier(), for: indexPath)
        
        
        switch product! {
        
        case .IdolLink:
            let c = cell as! IdolLinkCell
            ConfigIdolLink(cell: c, indexPath: indexPath)
        default:break
        }
        

        //ConfigCell(cell:cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let pad = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
        
        let ratio : CGFloat = 190.0 / 355.0
        let width = (viewSize.width - pad - flowLayout.minimumInteritemSpacing)/2;
        let height = width / ratio
        
        return CGSize(width: width, height: height)
    }
    
    func ConfigIdolLink(cell:IdolLinkCell, indexPath:IndexPath) {
        let cardId = myCards?[indexPath.row]
        let obj = cardsDb?[String(cardId!)] as! [String:Any]
        let img = (obj["img"] as! NSString).lastPathComponent
        let name = "girdcards/\(img)"
        
        let image = UIImage(named: name)
        
        cell.cardImageView.image = image;
        
        cell.titleLabel.text = obj["name"] as? String
        
        let color = UIColor.FromHexString (hex: obj["color"] as! String)
        let textcolor = UIColor.FromHexString (hex: obj["textcolor"] as! String)
        
        cell.titleLabel.backgroundColor = color;
        cell.titleLabel.textColor = textcolor;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cardId = myCards?[indexPath.row]
        let obj = cardsDb?[String(cardId!)] as! [String:Any]
        
        let vc = IdolDetailViewController();
        vc.cardObj = obj
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func ConfigCell(cell:AssetCell) {
        
        cell.imageView.image = GetImage()
    }
    
    func GetImage() -> UIImage? {
        
        var name:String?
        
        switch product! {
        case .Shuihu:
            let heroId = 1
            name = "shuihu/heros_new/\(heroId)"
        case .Sanguo:
            let image_name = ""//hero["image_name"] as! String
            name = "sanguo/heroes/\(image_name)"
        case .Moe:
            let cardId = 1
            name = "moe_cards/\(cardId)"
        case .IdolLink:
            let img = ""// (obj["img"] as! NSString).lastPathComponent
            name = "girdcards/\(img)"
        }
        
        return UIImage(named: name!)
    }
    
    
}

extension UIColor {
    class func FromHexString(hex:String) -> UIColor {
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

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.layer.cornerRadius = 10
        
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        ai.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            
            
            ai.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor).isActive = true
            ai.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor).isActive = true
            
            
            spinnerView.centerXAnchor.constraint(equalTo: onView.centerXAnchor).isActive = true
            spinnerView.centerYAnchor.constraint(equalTo: onView.centerYAnchor).isActive = true
            spinnerView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            spinnerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
