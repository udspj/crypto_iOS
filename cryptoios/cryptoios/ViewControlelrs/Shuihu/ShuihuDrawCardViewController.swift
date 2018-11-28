
import UIKit

class ShuihuDrawCardViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var btn: UIButton!
    var cardCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "幸运抽卡"
        let price = 0.001
        label2.text = "目前抽卡费：\n\(price) ETH/张"
        
        loadingLabel.text = ""
    }
    
    @IBAction func drawCard(_ sender: Any) {
        btn.isEnabled = false
        loadingLabel.text = "正在抽卡……请勿操作关闭应用"
//        let queue = OperationQueue()
//        queue.addOperation {[unowned self] () -> Void in
//            let res = self.linkidol.drawCard(password: "")
//            OperationQueue.main.addOperation({[unowned self] () -> Void in
//                self.btn.isEnabled = true
//                if(res == "success"){
//                    self.loadingLabel.text = "抽卡成功，稍后可在图鉴里查看"
//                }else{
//                    self.loadingLabel.text = res
//                }
//            })
//        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
