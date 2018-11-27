
import UIKit

class IdolRankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var IndicatorView : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "排行榜"
        let tableview = view as! UITableView;
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        SetupLoading()
    }
    
    func SetupLoading() {
        let tableview = view as! UITableView;

        
        let foot = UIView()
        var f = view.bounds
        f.size.height = 100
        foot.frame = f
        tableview.tableFooterView = foot
        
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        foot.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: foot.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: foot.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        IndicatorView = indicator
        
        DispatchQueue.main.asyncAfter(deadline: .now()+10.0, execute: {
            self.IndicatorView?.stopAnimating()
            
            let label = UILabel()
            label.textAlignment = .center
            label.frame = f
            label.text = "Timed out!"
            label.translatesAutoresizingMaskIntoConstraints = false
            foot.addSubview(label)
            
            label.topAnchor.constraint(equalTo: foot.topAnchor).isActive = true
            label.leftAnchor.constraint(equalTo: foot.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: foot.rightAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: foot.bottomAnchor).isActive = true
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

}
