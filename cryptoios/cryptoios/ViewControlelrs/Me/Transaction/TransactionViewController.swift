
import UIKit
import web3swift
import CryptoSwift
import BigInt

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var product:Products?
    
    @IBOutlet var tableView: UITableView!
    let uri = "https://api.etherscan.io/api?module=account&address=0x8d12a197cb00d4747a1fe03395095ce2a5cc6819&offset=100&page=1&sort=asc&apikey=FYFY6687BY19QA9TEF7NU2NAHQW6AFS5AN&action=txlist"
    
    var records :[ [String:Any] ]?
    let format: DateFormatter = DateFormatter.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "最近交易记录";
        
        tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 30
        LoadData()
        format.dateStyle = .short
        format.timeStyle = .short
       
    }
    
    func LoadData()  {
        let sp = UIViewController.displaySpinner(onView: self.view)
        
        let request = URLRequest(url: URL(string: uri)!)
        let task = URLSession.shared.dataTask(with: request) {
            data,response,error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let result = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                guard "1" == result["status"] as? String else {
                    print("api resoponse error \(result["message"]!)")
                    return
                }
                
                self.records = result["result"] as? [ [String:Any] ]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIViewController.removeSpinner(spinner: sp)
                }
                
            } catch {
                print("error trying to convert data to JSON")
                return
            }
            
        }
        
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionCell
        
        let obj = self.records![indexPath.row]
        
        let owner = (obj["to"] as? String)?.sha3(SHA3.Variant.sha256)
        let r = Range(NSRange(location: 2, length: 8), in: owner!)
        cell.ownerLabel?.text = String(owner![r!])
        
        let gasPrice = Double(obj["gasPrice"] as! String)!
        let gasUsed = Double(obj["gasUsed"] as! String)!
        let price = gasPrice * gasUsed / pow(Double(10), Double(18))
        cell.priceLabel?.text = "\(price) ETH"
        
        let t = TimeInterval(obj["timeStamp"] as! String)
        let d = Date.init(timeIntervalSince1970: t!)
        cell.timestampLabel?.text = format.string(from: d)
        
        
        return cell
    }
}
