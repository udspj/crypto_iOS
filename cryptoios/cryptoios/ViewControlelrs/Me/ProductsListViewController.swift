
import UIKit

enum Products {
    case Shuihu, Sanguo, Moe, IdolLink
    
    var name : String {
        switch  self {
        case .Shuihu: return "水浒"
        case .Sanguo: return "三国"
        case .Moe: return "萌王"
        case .IdolLink: return "链接偶像"
        }
    }
    
}

class ProductsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    enum DetailTarget {
        case Assets, Transaction
        
    }
    
    let sections = [Products.Shuihu,.Sanguo,.Moe,.IdolLink];
    var Target : DetailTarget?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Target! {
        case .Assets:
            title = "我的资产";
        case .Transaction:
            title = "最近交易记录";
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let s = sections[indexPath.row]
        cell.textLabel?.text = s.name;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let s = sections[indexPath.row]
        
        var vc:UIViewController
        
        switch Target! {
        case .Assets:
            let detail = AssetDetailViewController()
            detail.product = s
            vc = detail
        case .Transaction:
            let detail = TransactionViewController()
            detail.product = s
            vc = detail
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
