//
//  IdolDrawCardViewController.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/10/27.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

class IdolDrawCardViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var btn: UIButton!
    var cardCount:Int = 0
    var linkidol:Linkidol = Linkidol()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "幸运抽卡"
//        let num = 2099999;
        let price = 0.001
        label1.text = "目前卡池可抽数量：\(self.cardCount)张，卡牌限量，先到先得"
        label2.text = "目前抽卡费：\n\(price) ETH/张"
        
        loadingLabel.text = ""
    }
    
    @IBAction func drawCard(_ sender: Any) {
        btn.isEnabled = false
        loadingLabel.text = "正在抽卡……请勿操作关闭应用"
        let queue = OperationQueue()
        queue.addOperation {[unowned self] () -> Void in
            let res = self.linkidol.drawCard(password: "")
            OperationQueue.main.addOperation({[unowned self] () -> Void in
                self.btn.isEnabled = true
                if(res == "success"){
                    self.loadingLabel.text = "抽卡成功，稍后可在我的收藏里查看"
                }else{
                    self.loadingLabel.text = res
                }
            })
        }
    }
    
}
